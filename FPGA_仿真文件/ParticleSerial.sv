`timescale 1ns/1ps
// Both ports share the same inference-event sequence. A pending latest-value slot
// bounds storage if inference outruns UART; sequence gaps expose skipped events.
module ParticlePacketEncoder(
    input wire clk, rst_n, result_valid,
    input wire [1:0] class_id,
    input wire no_particles, background_enabled,
    output reg [63:0] packet,
    output reg packet_valid
);
    reg [7:0] sequence_number;
    wire [7:0] result_code = no_particles ? 8'd0 : {6'd0,class_id}+8'd1;
    wire [7:0] flags = {6'd0,no_particles,background_enabled};
    function [7:0] crc_byte(input [7:0] previous, data);
        reg [7:0] c; integer i;
        begin
            c=previous^data;
            for(i=0;i<8;i=i+1) c=c[7] ? (c<<1)^8'h07 : c<<1;
            crc_byte=c;
        end
    endfunction
    wire [7:0] crc = crc_byte(crc_byte(crc_byte(crc_byte(0,8'h02),sequence_number),result_code),flags);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin packet<=0; packet_valid<=0; sequence_number<=0; end
        else begin
            packet_valid<=result_valid;
            if(result_valid) begin
                packet<={8'h0d,crc,flags,result_code,sequence_number,8'h02,8'h5a,8'ha5};
                sequence_number<=sequence_number+1'b1;
            end
        end
    end
endmodule

// enable permits starting/caching packets, never interrupts an active packet.
module ParticlePacketBytes(
    input wire clk, rst_n, enable,
    input wire [63:0] packet,
    input wire packet_valid, uart_busy, uart_done,
    output reg [7:0] data,
    output reg trig,
    output wire active
);
    localparam IDLE=2'd0, SEND=2'd1, WAIT_BYTE=2'd2;
    reg [1:0] state;
    reg [63:0] current_packet, newest_packet;
    reg pending;
    reg [2:0] byte_index;
    assign active=(state!=IDLE);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state<=IDLE; current_packet<=0; newest_packet<=0;
            pending<=0; byte_index<=0; data<=0; trig<=0;
        end else begin
            trig<=0;
            if(!enable) pending<=0;
            else if(packet_valid) begin newest_packet<=packet; pending<=1; end
            case(state)
                IDLE: if(enable && (packet_valid || pending) && !uart_busy) begin
                    current_packet<=packet_valid ? packet : newest_packet;
                    byte_index<=0; pending<=0; state<=SEND;
                end
                SEND: if(!uart_busy) begin
                    data<=current_packet[byte_index*8 +: 8]; trig<=1; state<=WAIT_BYTE;
                end
                WAIT_BYTE: if(uart_done) begin
                    if(byte_index==7) state<=IDLE;
                    else begin byte_index<=byte_index+1'b1; state<=SEND; end
                end
                default: state<=IDLE;
            endcase
        end
    end
endmodule

module ParticleSerial #(
    parameter integer CLK_FREQ=100_000_000,
    parameter integer BAUD_RATE=115200,
    parameter integer DEBOUNCE_CYCLES=CLK_FREQ/100,
    parameter integer NUM_OF_CHANNEL=32
)(
    input wire clk, rst_n, sw6, frame_done,
    input wire [15:0] spectrum_data,
    output wire [15:0] spectrum_ordinal,
    input wire [1:0] class_id,
    input wire result_valid, no_particles, background_enabled,
    input wire pc_rx,
    output wire [7:0] rx_data,
    output wire pc_tx, stm_tx,
    output reg result_mode
);
    localparam integer DB_WIDTH=(DEBOUNCE_CYCLES>1)?$clog2(DEBOUNCE_CYCLES):1;
    (* ASYNC_REG="TRUE" *) reg sw_meta, sw_sync;
    reg requested_mode;
    reg [DB_WIDTH-1:0] debounce_count;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin sw_meta<=0; sw_sync<=0; requested_mode<=0; debounce_count<=0; end
        else begin
            sw_meta<=sw6; sw_sync<=sw_meta;
            if(sw_sync==requested_mode) debounce_count<=0;
            else if(debounce_count==DEBOUNCE_CYCLES-1) begin
                requested_mode<=sw_sync; debounce_count<=0;
            end else debounce_count<=debounce_count+1'b1;
        end
    end
    wire [63:0] packet;
    wire packet_valid;
    ParticlePacketEncoder encoder(clk,rst_n,result_valid,class_id,no_particles,background_enabled,packet,packet_valid);

    wire pc_busy, pc_done, spec_trig, spec_active, result_trig, result_active;
    wire [7:0] spec_data, result_data;
    reg spectrum_owned, spec_active_d;
    // Ownership includes the start pipeline and final stop bit. Mode changes
    // take priority over starting any new frame, even in inter-byte gaps.
    wire spec_start=frame_done && !result_mode && !requested_mode && !spectrum_owned && !pc_busy;
    wire tx_trig=result_mode ? result_trig : spec_trig;
    wire [7:0] tx_data=result_mode ? result_data : spec_data;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin result_mode<=0; spectrum_owned<=0; spec_active_d<=0; end
        else begin
            spec_active_d<=spec_active;
            if(spec_start) spectrum_owned<=1;
            else if(spec_active_d && !spec_active && !pc_busy) spectrum_owned<=0;
            if(!spectrum_owned && !spec_start && !result_active && !pc_busy && !tx_trig)
                result_mode<=requested_mode;
        end
    end
    Uart_data_ready #(.DATA_WIDTH(16),.NUM_OF_CHANNEL(NUM_OF_CHANNEL)) spectrum (
        .ipClk(clk),.ipRst_(rst_n),.i_start_pulse(spec_start),
        .i_uart_busy(pc_busy),.i_uart_done(pc_done && !result_mode),
        .o_uart_trig(spec_trig),.o_uart_data(spec_data),
        .i_data(spectrum_data),.o_ordinal(spectrum_ordinal),.o_transmitting(spec_active));
    ParticlePacketBytes pc_results (
        .clk(clk),.rst_n(rst_n),.enable(result_mode && requested_mode),
        .packet(packet),.packet_valid(packet_valid),.uart_busy(pc_busy),
        .uart_done(pc_done && result_mode),.data(result_data),.trig(result_trig),.active(result_active));
    Uart_8bits #(.CLK_FREQ(CLK_FREQ),.BAUD_RATE(BAUD_RATE),.DATA_BITS(8),.STOP_BITS(1),.PARITY_EN(1),.PARITY_TYPE(1)) pc_uart (
        .i_clk(clk),.i_rst_n(rst_n),.i_rx(pc_rx),.o_rx_data(rx_data),.o_rx_done(),.o_rx_err(),
        .i_tx_data(tx_data),.i_trig(tx_trig),.o_tx(pc_tx),.o_tx_busy(pc_busy),.o_tx_done(pc_done));
    wire stm_busy, stm_done, stm_trig;
    wire [7:0] stm_data;
    ParticlePacketBytes stm_results (
        .clk(clk),.rst_n(rst_n),.enable(1'b1),.packet(packet),.packet_valid(packet_valid),
        .uart_busy(stm_busy),.uart_done(stm_done),.data(stm_data),.trig(stm_trig),.active());
    Uart_8bits #(.CLK_FREQ(CLK_FREQ),.BAUD_RATE(BAUD_RATE),.DATA_BITS(8),.STOP_BITS(1),.PARITY_EN(0),.PARITY_TYPE(1)) stm_uart (
        .i_clk(clk),.i_rst_n(rst_n),.i_rx(1'b1),.o_rx_data(),.o_rx_done(),.o_rx_err(),
        .i_tx_data(stm_data),.i_trig(stm_trig),.o_tx(stm_tx),.o_tx_busy(stm_busy),.o_tx_done(stm_done));
endmodule
