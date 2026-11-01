`timescale 1ns / 1ps

// EGo1: LED_BIT1..4 use op_seg_data; LED_BIT5..8 use op_seg_data_bank1.
// Segment and enable signals are active high. Physical digits 5..8 stay off.
module SegLed #(
    parameter integer CLK_FREQ = 100_000_000,
    parameter integer SLOT_HZ = 1000
)(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] din,       // Display code 1..4; 0/invalid means all dashes.
    input  wire       start,
    output reg  [7:0] op_seg_data,
    output reg  [7:0] op_seg_data_bank1,
    output reg  [7:0] op_seg_en
);
    localparam integer SLOT_CYCLES = (CLK_FREQ / SLOT_HZ < 3) ? 3 : CLK_FREQ / SLOT_HZ;
    localparam integer COUNT_W = $clog2(SLOT_CYCLES);
    localparam [7:0] SEG_DASH = 8'h40;
    reg [COUNT_W-1:0] slot_count;
    reg [2:0] slot;
    reg [7:0] pending_code;
    reg [7:0] frame_code;

    function [7:0] glyph;
        input [2:0] position;
        input [7:0] code;
        begin
            glyph = SEG_DASH;
            if (code == {5'd0, position} + 8'd1) begin
                case (position)
                    3'd0: glyph = 8'h06;
                    3'd1: glyph = 8'h5b;
                    3'd2: glyph = 8'h4f;
                    3'd3: glyph = 8'h66;
                    default: glyph = SEG_DASH;
                endcase
            end
        end
    endfunction

    wire [7:0] next_code = start ? ((din >= 1 && din <= 4) ? din : 8'd0) : pending_code;
    wire [7:0] scan_code = (slot == 0) ? next_code : frame_code;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            slot_count <= 0;
            slot <= 0;
            pending_code <= 0;
            frame_code <= 0;
            op_seg_data <= 0;
            op_seg_data_bank1 <= 0;
            op_seg_en <= 0;
        end else begin
            if (start)
                pending_code <= (din >= 1 && din <= 4) ? din : 8'd0;
            if (slot_count == SLOT_CYCLES - 1) begin
                slot_count <= 0;
                slot <= (slot == 3) ? 3'd0 : slot + 3'd1;
                op_seg_en <= 0;
            end else begin
                slot_count <= slot_count + 1'b1;
                if (slot_count == 0) begin
                    // Load segment data only while every digit is disabled.
                    op_seg_en <= 0;
                    op_seg_data <= (slot < 4) ? glyph(slot, scan_code) : 8'd0;
                    op_seg_data_bank1 <= 8'd0;
                    if (slot == 0)
                        frame_code <= next_code;
                end else if (slot_count == 1) begin
                    op_seg_en <= 8'b00000001 << slot;
                end
            end
        end
    end
endmodule
