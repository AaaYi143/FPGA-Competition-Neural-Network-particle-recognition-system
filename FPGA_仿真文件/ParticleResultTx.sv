`timescale 1ns/1ps
// Independent 115200 8N1 result stream. The PC's 8E1 spectral stream is unchanged.
// Packet: A5 5A 01 sequence class_id flags CRC8 0D.
// CRC8/ATM: poly=07, init=00, MSB first, bytes 2..5. flags[0]=SW7; flags[1]=no particles.
// When busy, retain the newest result. Sequence counts transmitted packets.
module ParticleResultTx #(
    parameter integer CLK_FREQ = 100_000_000,
    parameter integer BAUD_RATE = 115200
)(
    input wire clk, rst_n,
    input wire [1:0] class_id,
    input wire result_valid,
    input wire background_enabled,
    input wire no_particles,
    output wire tx
);
    localparam integer DIVISOR = CLK_FREQ / BAUD_RATE;
    localparam integer COUNT_W = (DIVISOR > 1) ? $clog2(DIVISOR) : 1;
    reg [COUNT_W-1:0] baud_count;
    reg [3:0] bit_index;
    reg [2:0] byte_index;
    reg [9:0] shift_reg;
    reg [63:0] packet;
    reg active, pending;
    reg [1:0] newest_class;
    reg newest_background, newest_empty;
    reg [7:0] sequence_number;
    wire [7:0] selected_class = {6'd0, result_valid ? class_id : newest_class};
    wire [7:0] selected_flags = {6'd0, result_valid ? no_particles : newest_empty, result_valid ? background_enabled : newest_background};

    function [7:0] crc_byte;
        input [7:0] previous, data;
        reg [7:0] c;
        integer i;
        begin
            c = previous ^ data;
            for(i=0;i<8;i=i+1) c = c[7] ? ((c << 1) ^ 8'h07) : (c << 1);
            crc_byte = c;
        end
    endfunction
    wire [7:0] checksum = crc_byte(crc_byte(crc_byte(crc_byte(8'd0,8'h01),
                                   sequence_number),selected_class),selected_flags);
    assign tx = active ? shift_reg[0] : 1'b1;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            baud_count<=0; bit_index<=0; byte_index<=0; shift_reg<=10'h3ff;
            packet<=0; active<=0; pending<=0;
            newest_class<=0; newest_background<=0; newest_empty<=1; sequence_number<=0;
        end else begin
            if(result_valid) begin
                newest_class<=class_id;
                newest_background<=background_enabled;
                newest_empty<=no_particles;
                pending<=1'b1;
            end
            if(!active) begin
                if(pending || result_valid) begin
                    // Low byte is transmitted first.
                    packet <= {8'h0d,checksum,selected_flags,selected_class,sequence_number,8'h01,8'h5a,8'ha5};
                    shift_reg <= {1'b1,8'ha5,1'b0};
                    sequence_number<=sequence_number+1'b1;
                    active<=1'b1; pending<=1'b0;
                    baud_count<=0; bit_index<=0; byte_index<=0;
                end
            end else if(baud_count == DIVISOR-1) begin
                baud_count<=0;
                if(bit_index == 9) begin
                    bit_index<=0;
                    if(byte_index == 7) active<=1'b0;
                    else begin
                        byte_index<=byte_index+1'b1;
                        shift_reg<={1'b1,packet[(byte_index+1)*8 +: 8],1'b0};
                    end
                end else begin
                    bit_index<=bit_index+1'b1;
                    shift_reg<={1'b1,shift_reg[9:1]};
                end
            end else baud_count<=baud_count+1'b1;
        end
    end
endmodule
