// ================================================================
// font_rom_32.sv - FONT32 Dot Matrix ROM (ASCII 16x32 + Chinese 32x32)
// Generated automatically by scripts/gen_font.py
// ================================================================
`timescale 1ns / 1ps

module font_rom_32 (
    input  logic        clk,
    input  logic [15:0] i_char,      // ASCII: 0x0020..0x007E, Chinese: Unicode
    input  logic [1:0]  i_page_idx,  // 0..3 (4 pages = 32 vertical pixels)
    input  logic [4:0]  i_col_idx,   // 0..15 (ASCII) or 0..31 (Chinese)
    output logic [7:0]  o_dot_data,  // 8 vertical pixels
    output logic [5:0]  o_char_width // Width: 16 (ASCII), 32 (Chinese)
);

    logic [7:0] dot_reg;
    logic [5:0] width_reg;

    always_ff @(posedge clk) begin
        dot_reg <= 8'h00;
        width_reg <= 6'd16;
        case (i_char)
            16'h0020: begin // ASCII ' '
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0021: begin // ASCII '!'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hFC;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h31;
                            4'd7: dot_reg <= 8'h79;
                            4'd8: dot_reg <= 8'h79;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0022: begin // ASCII '"'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'hFC;
                            4'd6: dot_reg <= 8'hFC;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'hFC;
                            4'd12: dot_reg <= 8'hFC;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h01;
                            4'd4: dot_reg <= 8'h01;
                            4'd5: dot_reg <= 8'h01;
                            4'd6: dot_reg <= 8'h01;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h01;
                            4'd11: dot_reg <= 8'h01;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0023: begin // ASCII '#'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hF0;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h06;
                            4'd3: dot_reg <= 8'h06;
                            4'd4: dot_reg <= 8'h06;
                            4'd5: dot_reg <= 8'hFE;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'h06;
                            4'd9: dot_reg <= 8'hFE;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h06;
                            4'd14: dot_reg <= 8'h06;
                            4'd15: dot_reg <= 8'h06;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h7F;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0024: begin // ASCII '$'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hFE;
                            4'd10: dot_reg <= 8'h7E;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h0F;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h1C;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'hF0;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0025: begin // ASCII '%'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hF0;
                            4'd2: dot_reg <= 8'hF8;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'h1C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'h80;
                            4'd11: dot_reg <= 8'hC0;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'h38;
                            4'd14: dot_reg <= 8'h1C;
                            4'd15: dot_reg <= 8'h04;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h01;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h07;
                            4'd4: dot_reg <= 8'h07;
                            4'd5: dot_reg <= 8'h86;
                            4'd6: dot_reg <= 8'hE7;
                            4'd7: dot_reg <= 8'h77;
                            4'd8: dot_reg <= 8'h3F;
                            4'd9: dot_reg <= 8'h8F;
                            4'd10: dot_reg <= 8'hC7;
                            4'd11: dot_reg <= 8'hC1;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'hC0;
                            4'd15: dot_reg <= 8'h80;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h40;
                            4'd1: dot_reg <= 8'h60;
                            4'd2: dot_reg <= 8'h78;
                            4'd3: dot_reg <= 8'h1C;
                            4'd4: dot_reg <= 8'h0F;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h01;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h3F;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h71;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h71;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h3F;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0026: begin // ASCII '&'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'hF8;
                            4'd5: dot_reg <= 8'hF8;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'h0C;
                            4'd8: dot_reg <= 8'h0C;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h80;
                            4'd2: dot_reg <= 8'hC0;
                            4'd3: dot_reg <= 8'hE3;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h3E;
                            4'd7: dot_reg <= 8'h7C;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hEE;
                            4'd10: dot_reg <= 8'h87;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hE0;
                            4'd15: dot_reg <= 8'hE0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h0F;
                            4'd2: dot_reg <= 8'h1F;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h78;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h61;
                            4'd10: dot_reg <= 8'h73;
                            4'd11: dot_reg <= 8'h37;
                            4'd12: dot_reg <= 8'h3E;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h71;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0027: begin // ASCII '\''
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h01;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0028: begin // ASCII '('
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'hE0;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'h78;
                            4'd10: dot_reg <= 8'h1C;
                            4'd11: dot_reg <= 8'h0E;
                            4'd12: dot_reg <= 8'h04;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'hF8;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h07;
                            4'd5: dot_reg <= 8'h3F;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hF8;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'h80;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h0E;
                            4'd11: dot_reg <= 8'h1C;
                            4'd12: dot_reg <= 8'h08;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0029: begin // ASCII ')'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h04;
                            4'd4: dot_reg <= 8'h0E;
                            4'd5: dot_reg <= 8'h1C;
                            4'd6: dot_reg <= 8'h78;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h07;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'hC0;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h3F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h08;
                            4'd4: dot_reg <= 8'h1C;
                            4'd5: dot_reg <= 8'h0E;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002A: begin // ASCII '*'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h20;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h40;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'h40;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h70;
                            4'd13: dot_reg <= 8'h20;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h04;
                            4'd3: dot_reg <= 8'h0C;
                            4'd4: dot_reg <= 8'h06;
                            4'd5: dot_reg <= 8'h02;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'h3F;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h02;
                            4'd11: dot_reg <= 8'h06;
                            4'd12: dot_reg <= 8'h0C;
                            4'd13: dot_reg <= 8'h04;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002B: begin // ASCII '+'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hC0;
                            4'd2: dot_reg <= 8'hC0;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hC0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'hC0;
                            4'd15: dot_reg <= 8'hC0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'h3F;
                            4'd9: dot_reg <= 8'h3F;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002C: begin // ASCII ','
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hF8;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0E;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h07;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002D: begin // ASCII '-'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hC0;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hC0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002E: begin // ASCII '.'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'h7C;
                            4'd8: dot_reg <= 8'h7C;
                            4'd9: dot_reg <= 8'h7C;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h002F: begin // ASCII '/'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'h7C;
                            4'd13: dot_reg <= 8'h0C;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'hE0;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'h3F;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'h01;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h7C;
                            4'd6: dot_reg <= 8'h1F;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h02;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0030: begin // ASCII '0'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h80;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFE;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h01;
                            4'd5: dot_reg <= 8'h80;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFE;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h71;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0031: begin // ASCII '1'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h01;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0032: begin // ASCII '2'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h40;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h80;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hE0;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'h7F;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h78;
                            4'd5: dot_reg <= 8'h7C;
                            4'd6: dot_reg <= 8'h7E;
                            4'd7: dot_reg <= 8'h6F;
                            4'd8: dot_reg <= 8'h63;
                            4'd9: dot_reg <= 8'h61;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0033: begin // ASCII '3'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h38;
                            4'd9: dot_reg <= 8'h78;
                            4'd10: dot_reg <= 8'hEF;
                            4'd11: dot_reg <= 8'hEF;
                            4'd12: dot_reg <= 8'hC7;
                            4'd13: dot_reg <= 8'h80;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h3F;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h07;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0034: begin // ASCII '4'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hC0;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'h78;
                            4'd5: dot_reg <= 8'h3C;
                            4'd6: dot_reg <= 8'h0F;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h07;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h07;
                            4'd4: dot_reg <= 8'h06;
                            4'd5: dot_reg <= 8'h06;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h06;
                            4'd8: dot_reg <= 8'h06;
                            4'd9: dot_reg <= 8'h06;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h7F;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h06;
                            4'd14: dot_reg <= 8'h06;
                            4'd15: dot_reg <= 8'h06;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0035: begin // ASCII '5'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h3F;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h07;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0036: begin // ASCII '6'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h80;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'hE0;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h70;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFC;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h33;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h78;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hE0;
                            4'd15: dot_reg <= 8'hC0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h3C;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'h38;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h1F;
                            4'd15: dot_reg <= 8'h07;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0037: begin // ASCII '7'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'h70;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'h1F;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h01;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h40;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h7C;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'h0F;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0038: begin // ASCII '8'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hC0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h8F;
                            4'd4: dot_reg <= 8'hCF;
                            4'd5: dot_reg <= 8'hFC;
                            4'd6: dot_reg <= 8'h78;
                            4'd7: dot_reg <= 8'h78;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'h78;
                            4'd11: dot_reg <= 8'hFC;
                            4'd12: dot_reg <= 8'hCF;
                            4'd13: dot_reg <= 8'h87;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h71;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0039: begin // ASCII '9'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hC0;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'h80;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h1F;
                            4'd2: dot_reg <= 8'h3F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hC0;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'h61;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFE;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h1E;
                            4'd12: dot_reg <= 8'h0F;
                            4'd13: dot_reg <= 8'h07;
                            4'd14: dot_reg <= 8'h01;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003A: begin // ASCII ':'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h0E;
                            4'd7: dot_reg <= 8'h1F;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h0E;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'h7C;
                            4'd8: dot_reg <= 8'h7C;
                            4'd9: dot_reg <= 8'h38;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003B: begin // ASCII ';'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h0E;
                            4'd7: dot_reg <= 8'h1F;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h0E;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hF8;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0E;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h07;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003C: begin // ASCII '<'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h80;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'hF8;
                            4'd7: dot_reg <= 8'h3C;
                            4'd8: dot_reg <= 8'h1E;
                            4'd9: dot_reg <= 8'h0E;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h01;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h0F;
                            4'd8: dot_reg <= 8'h1E;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'h20;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003D: begin // ASCII '='
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h30;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h06;
                            4'd3: dot_reg <= 8'h06;
                            4'd4: dot_reg <= 8'h06;
                            4'd5: dot_reg <= 8'h06;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h06;
                            4'd8: dot_reg <= 8'h06;
                            4'd9: dot_reg <= 8'h06;
                            4'd10: dot_reg <= 8'h06;
                            4'd11: dot_reg <= 8'h06;
                            4'd12: dot_reg <= 8'h06;
                            4'd13: dot_reg <= 8'h06;
                            4'd14: dot_reg <= 8'h06;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003E: begin // ASCII '>'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h80;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h01;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h07;
                            4'd6: dot_reg <= 8'h0E;
                            4'd7: dot_reg <= 8'h1C;
                            4'd8: dot_reg <= 8'h3C;
                            4'd9: dot_reg <= 8'hF8;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h40;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h20;
                            4'd4: dot_reg <= 8'h70;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'h0E;
                            4'd8: dot_reg <= 8'h0F;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h01;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h003F: begin // ASCII '?'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0C;
                            4'd7: dot_reg <= 8'h1C;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h38;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hF8;
                            4'd7: dot_reg <= 8'hF8;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h0F;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h79;
                            4'd7: dot_reg <= 8'h79;
                            4'd8: dot_reg <= 8'h31;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0040: begin // ASCII '@'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h80;
                            4'd2: dot_reg <= 8'hE0;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h38;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h0C;
                            4'd7: dot_reg <= 8'h0C;
                            4'd8: dot_reg <= 8'h0C;
                            4'd9: dot_reg <= 8'h0C;
                            4'd10: dot_reg <= 8'h1C;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'hFE;
                            4'd1: dot_reg <= 8'h1F;
                            4'd2: dot_reg <= 8'h01;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hF8;
                            4'd5: dot_reg <= 8'hFC;
                            4'd6: dot_reg <= 8'h1E;
                            4'd7: dot_reg <= 8'h06;
                            4'd8: dot_reg <= 8'hFE;
                            4'd9: dot_reg <= 8'hFE;
                            4'd10: dot_reg <= 8'h1E;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'hFF;
                            4'd1: dot_reg <= 8'hC0;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h3F;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h3F;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h1C;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h03;
                            4'd1: dot_reg <= 8'h07;
                            4'd2: dot_reg <= 8'h0E;
                            4'd3: dot_reg <= 8'h1C;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0041: begin // ASCII 'A'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hE0;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'hF0;
                            4'd11: dot_reg <= 8'h80;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hF8;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'h0F;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h0F;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hF8;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h70;
                            4'd2: dot_reg <= 8'h7E;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h07;
                            4'd5: dot_reg <= 8'h06;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h06;
                            4'd8: dot_reg <= 8'h06;
                            4'd9: dot_reg <= 8'h06;
                            4'd10: dot_reg <= 8'h06;
                            4'd11: dot_reg <= 8'h06;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h7E;
                            4'd15: dot_reg <= 8'h70;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0042: begin // ASCII 'B'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h78;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hEF;
                            4'd13: dot_reg <= 8'hC7;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0043: begin // ASCII 'C'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h80;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h70;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFC;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3E;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h70;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h30;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0044: begin // ASCII 'D'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFE;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h1E;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h07;
                            4'd15: dot_reg <= 8'h01;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0045: begin // ASCII 'E'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0046: begin // ASCII 'F'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0047: begin // ASCII 'G'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h80;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h70;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFC;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hE0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3E;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h3F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0048: begin // ASCII 'H'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0049: begin // ASCII 'I'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h7F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004A: begin // ASCII 'J'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h3F;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004B: begin // ASCII 'K'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h80;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'h70;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h10;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h20;
                            4'd6: dot_reg <= 8'hF8;
                            4'd7: dot_reg <= 8'hFC;
                            4'd8: dot_reg <= 8'hCE;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h0F;
                            4'd10: dot_reg <= 8'h1E;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h78;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h40;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004C: begin // ASCII 'L'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004D: begin // ASCII 'M'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hC0;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h80;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'h70;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFF;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h01;
                            4'd5: dot_reg <= 8'h0F;
                            4'd6: dot_reg <= 8'h3E;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hF8;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h80;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h7F;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h7F;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004E: begin // ASCII 'N'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'hE0;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h78;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h004F: begin // ASCII 'O'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFC;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFE;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3C;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h3E;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h01;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0050: begin // ASCII 'P'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hC0;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0051: begin // ASCII 'Q'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFC;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFE;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3C;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'hE0;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'hE0;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h3E;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h01;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h07;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h0F;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h0C;
                            4'd13: dot_reg <= 8'h0C;
                            4'd14: dot_reg <= 8'h0C;
                            4'd15: dot_reg <= 8'h0E;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0052: begin // ASCII 'R'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'h80;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h70;
                            4'd9: dot_reg <= 8'hF8;
                            4'd10: dot_reg <= 8'hD8;
                            4'd11: dot_reg <= 8'h9F;
                            4'd12: dot_reg <= 8'h0F;
                            4'd13: dot_reg <= 8'h07;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'h3F;
                            4'd12: dot_reg <= 8'h7E;
                            4'd13: dot_reg <= 8'h70;
                            4'd14: dot_reg <= 8'h40;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0053: begin // ASCII 'S'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h80;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h0F;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h3C;
                            4'd6: dot_reg <= 8'h38;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h70;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'hE0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h31;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h0F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0054: begin // ASCII 'T'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h30;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h30;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h30;
                            4'd15: dot_reg <= 8'h30;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h7F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0055: begin // ASCII 'U'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'hF0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFF;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h70;
                            4'd12: dot_reg <= 8'h38;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h1F;
                            4'd15: dot_reg <= 8'h07;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0056: begin // ASCII 'V'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h70;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'h80;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h70;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hF8;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h0F;
                            4'd6: dot_reg <= 8'h7F;
                            4'd7: dot_reg <= 8'h7E;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h7E;
                            4'd10: dot_reg <= 8'h3F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0057: begin // ASCII 'W'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hF0;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'hF0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'h1C;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFF;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h01;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h78;
                            4'd6: dot_reg <= 8'h7E;
                            4'd7: dot_reg <= 8'h0F;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h7E;
                            4'd12: dot_reg <= 8'h70;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h01;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0058: begin // ASCII 'X'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h10;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'hE0;
                            4'd5: dot_reg <= 8'hC0;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'hC0;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'h30;
                            4'd15: dot_reg <= 8'h10;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h01;
                            4'd5: dot_reg <= 8'h87;
                            4'd6: dot_reg <= 8'hEF;
                            4'd7: dot_reg <= 8'hFE;
                            4'd8: dot_reg <= 8'h7C;
                            4'd9: dot_reg <= 8'hFE;
                            4'd10: dot_reg <= 8'hEF;
                            4'd11: dot_reg <= 8'h87;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h40;
                            4'd1: dot_reg <= 8'h60;
                            4'd2: dot_reg <= 8'h78;
                            4'd3: dot_reg <= 8'h7C;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h0F;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h0F;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h7C;
                            4'd14: dot_reg <= 8'h78;
                            4'd15: dot_reg <= 8'h60;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0059: begin // ASCII 'Y'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h10;
                            4'd1: dot_reg <= 8'h70;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hE0;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h80;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h70;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h0F;
                            4'd5: dot_reg <= 8'h1F;
                            4'd6: dot_reg <= 8'h7C;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'h7C;
                            4'd11: dot_reg <= 8'h3F;
                            4'd12: dot_reg <= 8'h0F;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h7F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005A: begin // ASCII 'Z'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h30;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h30;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h30;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'hF0;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'h30;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'hE0;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'h3C;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h7C;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h67;
                            4'd7: dot_reg <= 8'h61;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005B: begin // ASCII '['
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'hFC;
                            4'd6: dot_reg <= 8'hFC;
                            4'd7: dot_reg <= 8'h0C;
                            4'd8: dot_reg <= 8'h0C;
                            4'd9: dot_reg <= 8'h0C;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h1F;
                            4'd6: dot_reg <= 8'h1F;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h18;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005C: begin // ASCII '\\'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h04;
                            4'd3: dot_reg <= 8'h3C;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h1F;
                            4'd7: dot_reg <= 8'h7E;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hC0;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h0F;
                            4'd10: dot_reg <= 8'h3E;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h01;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005D: begin // ASCII ']'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0C;
                            4'd7: dot_reg <= 8'h0C;
                            4'd8: dot_reg <= 8'h0C;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'hFC;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h1F;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h1F;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005E: begin // ASCII '^'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'h30;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'h80;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h18;
                            4'd4: dot_reg <= 8'h1E;
                            4'd5: dot_reg <= 8'h1F;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h01;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h1C;
                            4'd14: dot_reg <= 8'h18;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h005F: begin // ASCII '_'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h18;
                            4'd1: dot_reg <= 8'h18;
                            4'd2: dot_reg <= 8'h18;
                            4'd3: dot_reg <= 8'h18;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h18;
                            4'd12: dot_reg <= 8'h18;
                            4'd13: dot_reg <= 8'h18;
                            4'd14: dot_reg <= 8'h18;
                            4'd15: dot_reg <= 8'h18;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0060: begin // ASCII '`'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h04;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'h3C;
                            4'd8: dot_reg <= 8'h38;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h20;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0061: begin // ASCII 'a'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h86;
                            4'd4: dot_reg <= 8'h86;
                            4'd5: dot_reg <= 8'hC3;
                            4'd6: dot_reg <= 8'hC3;
                            4'd7: dot_reg <= 8'hC3;
                            4'd8: dot_reg <= 8'hC3;
                            4'd9: dot_reg <= 8'hC3;
                            4'd10: dot_reg <= 8'hC3;
                            4'd11: dot_reg <= 8'hC7;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFE;
                            4'd14: dot_reg <= 8'hF8;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h1E;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h71;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'h30;
                            4'd11: dot_reg <= 8'h38;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0062: begin // ASCII 'b'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFC;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h0F;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h3F;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0063: begin // ASCII 'c'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hE0;
                            4'd3: dot_reg <= 8'hF8;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'h1E;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h06;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h30;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0064: begin // ASCII 'd'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'hFC;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'hFC;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF8;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'h0E;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h78;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h70;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h1C;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0065: begin // ASCII 'e'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF8;
                            4'd4: dot_reg <= 8'hFE;
                            4'd5: dot_reg <= 8'hCE;
                            4'd6: dot_reg <= 8'hC7;
                            4'd7: dot_reg <= 8'hC3;
                            4'd8: dot_reg <= 8'hC3;
                            4'd9: dot_reg <= 8'hC3;
                            4'd10: dot_reg <= 8'hC7;
                            4'd11: dot_reg <= 8'hCE;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h38;
                            4'd6: dot_reg <= 8'h70;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h30;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0066: begin // ASCII 'f'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hE0;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h0C;
                            4'd13: dot_reg <= 8'h0C;
                            4'd14: dot_reg <= 8'h0C;
                            4'd15: dot_reg <= 8'h0C;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h0C;
                            4'd2: dot_reg <= 8'h0C;
                            4'd3: dot_reg <= 8'h0C;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'h0C;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h0C;
                            4'd13: dot_reg <= 8'h0C;
                            4'd14: dot_reg <= 8'h0C;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h7F;
                            4'd7: dot_reg <= 8'h7F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0067: begin // ASCII 'g'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h78;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'hFE;
                            4'd5: dot_reg <= 8'h87;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h87;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'h7B;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h03;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hDE;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h73;
                            4'd6: dot_reg <= 8'h63;
                            4'd7: dot_reg <= 8'h63;
                            4'd8: dot_reg <= 8'h63;
                            4'd9: dot_reg <= 8'h63;
                            4'd10: dot_reg <= 8'h63;
                            4'd11: dot_reg <= 8'hE1;
                            4'd12: dot_reg <= 8'hE0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h80;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h07;
                            4'd2: dot_reg <= 8'h0F;
                            4'd3: dot_reg <= 8'h0F;
                            4'd4: dot_reg <= 8'h1C;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h18;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h0F;
                            4'd13: dot_reg <= 8'h07;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0068: begin // ASCII 'h'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFC;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h7F;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0069: begin // ASCII 'i'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h3C;
                            4'd9: dot_reg <= 8'h3C;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006A: begin // ASCII 'j'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h18;
                            4'd10: dot_reg <= 8'h3C;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h18;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h0C;
                            4'd3: dot_reg <= 8'h18;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h18;
                            4'd7: dot_reg <= 8'h18;
                            4'd8: dot_reg <= 8'h1C;
                            4'd9: dot_reg <= 8'h0E;
                            4'd10: dot_reg <= 8'h0F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h01;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006B: begin // ASCII 'k'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'hFC;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'hE0;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'h38;
                            4'd10: dot_reg <= 8'h1C;
                            4'd11: dot_reg <= 8'h0E;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h01;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h01;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h0F;
                            4'd10: dot_reg <= 8'h1E;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h78;
                            4'd13: dot_reg <= 8'h70;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h40;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006C: begin // ASCII 'l'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h0C;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0C;
                            4'd7: dot_reg <= 8'h0C;
                            4'd8: dot_reg <= 8'hFC;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'hFC;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hFF;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h60;
                            4'd4: dot_reg <= 8'h60;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h7F;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006D: begin // ASCII 'm'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hFF;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'h0E;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFC;
                            4'd10: dot_reg <= 8'h0E;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'hFE;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h7F;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h7F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'h7F;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h7F;
                            4'd15: dot_reg <= 8'h7F;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006E: begin // ASCII 'n'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h7F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h7F;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h006F: begin // ASCII 'o'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hE0;
                            4'd2: dot_reg <= 8'hF8;
                            4'd3: dot_reg <= 8'hFC;
                            4'd4: dot_reg <= 8'h1E;
                            4'd5: dot_reg <= 8'h07;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h07;
                            4'd11: dot_reg <= 8'h0E;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h07;
                            4'd2: dot_reg <= 8'h1F;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h38;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h03;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0070: begin // ASCII 'p'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h06;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h0F;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'hFC;
                            4'd14: dot_reg <= 8'hF0;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h70;
                            4'd11: dot_reg <= 8'h3C;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h0F;
                            4'd14: dot_reg <= 8'h07;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h1F;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0071: begin // ASCII 'q'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hF0;
                            4'd3: dot_reg <= 8'hF8;
                            4'd4: dot_reg <= 8'hFC;
                            4'd5: dot_reg <= 8'h0E;
                            4'd6: dot_reg <= 8'h07;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'h3F;
                            4'd5: dot_reg <= 8'h78;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h38;
                            4'd11: dot_reg <= 8'h1C;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h1F;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h1F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0072: begin // ASCII 'r'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'h0E;
                            4'd8: dot_reg <= 8'h06;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h07;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h3E;
                            4'd15: dot_reg <= 8'h38;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h7F;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0073: begin // ASCII 's'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h3C;
                            4'd4: dot_reg <= 8'h7E;
                            4'd5: dot_reg <= 8'hFE;
                            4'd6: dot_reg <= 8'hE7;
                            4'd7: dot_reg <= 8'hC3;
                            4'd8: dot_reg <= 8'hC3;
                            4'd9: dot_reg <= 8'hC3;
                            4'd10: dot_reg <= 8'h83;
                            4'd11: dot_reg <= 8'h83;
                            4'd12: dot_reg <= 8'h83;
                            4'd13: dot_reg <= 8'h06;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h30;
                            4'd4: dot_reg <= 8'h70;
                            4'd5: dot_reg <= 8'h60;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h61;
                            4'd9: dot_reg <= 8'h61;
                            4'd10: dot_reg <= 8'h61;
                            4'd11: dot_reg <= 8'h73;
                            4'd12: dot_reg <= 8'h3F;
                            4'd13: dot_reg <= 8'h3F;
                            4'd14: dot_reg <= 8'h1E;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0074: begin // ASCII 't'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'hF0;
                            4'd6: dot_reg <= 8'hF8;
                            4'd7: dot_reg <= 8'hF8;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h03;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'hFF;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'h03;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h1F;
                            4'd6: dot_reg <= 8'h3F;
                            4'd7: dot_reg <= 8'h3F;
                            4'd8: dot_reg <= 8'h70;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h60;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0075: begin // ASCII 'u'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hFF;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'hFF;
                            4'd12: dot_reg <= 8'hFF;
                            4'd13: dot_reg <= 8'hFF;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h1F;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'h7F;
                            4'd5: dot_reg <= 8'h70;
                            4'd6: dot_reg <= 8'h60;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h30;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h7F;
                            4'd12: dot_reg <= 8'h7F;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0076: begin // ASCII 'v'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h3F;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hF8;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h80;
                            4'd11: dot_reg <= 8'hF0;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h07;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h07;
                            4'd6: dot_reg <= 8'h3F;
                            4'd7: dot_reg <= 8'h7C;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h7C;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h07;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0077: begin // ASCII 'w'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h7F;
                            4'd2: dot_reg <= 8'hFF;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h80;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'h70;
                            4'd9: dot_reg <= 8'hF0;
                            4'd10: dot_reg <= 8'h80;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'hF0;
                            4'd14: dot_reg <= 8'hFF;
                            4'd15: dot_reg <= 8'h7F;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h3F;
                            4'd3: dot_reg <= 8'h7F;
                            4'd4: dot_reg <= 8'h70;
                            4'd5: dot_reg <= 8'h7C;
                            4'd6: dot_reg <= 8'h1F;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h03;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h7C;
                            4'd12: dot_reg <= 8'h70;
                            4'd13: dot_reg <= 8'h7F;
                            4'd14: dot_reg <= 8'h1F;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0078: begin // ASCII 'x'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h01;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h07;
                            4'd4: dot_reg <= 8'h1F;
                            4'd5: dot_reg <= 8'h3C;
                            4'd6: dot_reg <= 8'hF8;
                            4'd7: dot_reg <= 8'hF0;
                            4'd8: dot_reg <= 8'hE0;
                            4'd9: dot_reg <= 8'hF8;
                            4'd10: dot_reg <= 8'h3C;
                            4'd11: dot_reg <= 8'h1E;
                            4'd12: dot_reg <= 8'h0F;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h01;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h40;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h7C;
                            4'd5: dot_reg <= 8'h1E;
                            4'd6: dot_reg <= 8'h0F;
                            4'd7: dot_reg <= 8'h03;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h0F;
                            4'd11: dot_reg <= 8'h1E;
                            4'd12: dot_reg <= 8'h78;
                            4'd13: dot_reg <= 8'h70;
                            4'd14: dot_reg <= 8'h60;
                            4'd15: dot_reg <= 8'h40;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h0079: begin // ASCII 'y'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h07;
                            4'd3: dot_reg <= 8'h1F;
                            4'd4: dot_reg <= 8'hFF;
                            4'd5: dot_reg <= 8'hF8;
                            4'd6: dot_reg <= 8'hC0;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'hC0;
                            4'd11: dot_reg <= 8'hF8;
                            4'd12: dot_reg <= 8'hFE;
                            4'd13: dot_reg <= 8'h1F;
                            4'd14: dot_reg <= 8'h07;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h07;
                            4'd6: dot_reg <= 8'h3F;
                            4'd7: dot_reg <= 8'hFE;
                            4'd8: dot_reg <= 8'hF0;
                            4'd9: dot_reg <= 8'hFE;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h18;
                            4'd2: dot_reg <= 8'h18;
                            4'd3: dot_reg <= 8'h18;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h0F;
                            4'd7: dot_reg <= 8'h07;
                            4'd8: dot_reg <= 8'h01;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h007A: begin // ASCII 'z'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h03;
                            4'd3: dot_reg <= 8'h03;
                            4'd4: dot_reg <= 8'h03;
                            4'd5: dot_reg <= 8'h03;
                            4'd6: dot_reg <= 8'h83;
                            4'd7: dot_reg <= 8'hC3;
                            4'd8: dot_reg <= 8'hF3;
                            4'd9: dot_reg <= 8'h7B;
                            4'd10: dot_reg <= 8'h1F;
                            4'd11: dot_reg <= 8'h0F;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h60;
                            4'd3: dot_reg <= 8'h70;
                            4'd4: dot_reg <= 8'h7C;
                            4'd5: dot_reg <= 8'h7E;
                            4'd6: dot_reg <= 8'h67;
                            4'd7: dot_reg <= 8'h63;
                            4'd8: dot_reg <= 8'h60;
                            4'd9: dot_reg <= 8'h60;
                            4'd10: dot_reg <= 8'h60;
                            4'd11: dot_reg <= 8'h60;
                            4'd12: dot_reg <= 8'h60;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h007B: begin // ASCII '{'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'hE0;
                            4'd7: dot_reg <= 8'hF8;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'h0C;
                            4'd11: dot_reg <= 8'h0C;
                            4'd12: dot_reg <= 8'h0C;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'hC0;
                            4'd3: dot_reg <= 8'hC0;
                            4'd4: dot_reg <= 8'hC0;
                            4'd5: dot_reg <= 8'hE0;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hBF;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h01;
                            4'd6: dot_reg <= 8'hFF;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFE;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h03;
                            4'd7: dot_reg <= 8'h0F;
                            4'd8: dot_reg <= 8'h0F;
                            4'd9: dot_reg <= 8'h1C;
                            4'd10: dot_reg <= 8'h18;
                            4'd11: dot_reg <= 8'h18;
                            4'd12: dot_reg <= 8'h18;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h007C: begin // ASCII '|'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFF;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h1F;
                            4'd8: dot_reg <= 8'h1F;
                            4'd9: dot_reg <= 8'h1F;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h007D: begin // ASCII '}'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h0C;
                            4'd4: dot_reg <= 8'h0C;
                            4'd5: dot_reg <= 8'h0C;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'hF8;
                            4'd8: dot_reg <= 8'hF8;
                            4'd9: dot_reg <= 8'hE0;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h1F;
                            4'd8: dot_reg <= 8'h7F;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'hE0;
                            4'd11: dot_reg <= 8'hC0;
                            4'd12: dot_reg <= 8'hC0;
                            4'd13: dot_reg <= 8'hC0;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'hFE;
                            4'd8: dot_reg <= 8'hFF;
                            4'd9: dot_reg <= 8'hFF;
                            4'd10: dot_reg <= 8'h01;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h18;
                            4'd4: dot_reg <= 8'h18;
                            4'd5: dot_reg <= 8'h18;
                            4'd6: dot_reg <= 8'h1C;
                            4'd7: dot_reg <= 8'h0F;
                            4'd8: dot_reg <= 8'h0F;
                            4'd9: dot_reg <= 8'h07;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h007E: begin // ASCII '~'
                width_reg <= 6'd16;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'hC0;
                            4'd2: dot_reg <= 8'hE0;
                            4'd3: dot_reg <= 8'hF0;
                            4'd4: dot_reg <= 8'h70;
                            4'd5: dot_reg <= 8'h30;
                            4'd6: dot_reg <= 8'h30;
                            4'd7: dot_reg <= 8'h60;
                            4'd8: dot_reg <= 8'hC0;
                            4'd9: dot_reg <= 8'h80;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h80;
                            4'd13: dot_reg <= 8'hE0;
                            4'd14: dot_reg <= 8'hE0;
                            4'd15: dot_reg <= 8'hE0;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h01;
                            4'd2: dot_reg <= 8'h01;
                            4'd3: dot_reg <= 8'h01;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h01;
                            4'd10: dot_reg <= 8'h03;
                            4'd11: dot_reg <= 8'h03;
                            4'd12: dot_reg <= 8'h03;
                            4'd13: dot_reg <= 8'h03;
                            4'd14: dot_reg <= 8'h01;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx[3:0])
                            4'd0: dot_reg <= 8'h00;
                            4'd1: dot_reg <= 8'h00;
                            4'd2: dot_reg <= 8'h00;
                            4'd3: dot_reg <= 8'h00;
                            4'd4: dot_reg <= 8'h00;
                            4'd5: dot_reg <= 8'h00;
                            4'd6: dot_reg <= 8'h00;
                            4'd7: dot_reg <= 8'h00;
                            4'd8: dot_reg <= 8'h00;
                            4'd9: dot_reg <= 8'h00;
                            4'd10: dot_reg <= 8'h00;
                            4'd11: dot_reg <= 8'h00;
                            4'd12: dot_reg <= 8'h00;
                            4'd13: dot_reg <= 8'h00;
                            4'd14: dot_reg <= 8'h00;
                            4'd15: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h5C0F: begin // Chinese '小'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h00;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'hFC;
                            5'd16: dot_reg <= 8'hF8;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h08;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h00;
                            5'd7: dot_reg <= 8'h80;
                            5'd8: dot_reg <= 8'hE0;
                            5'd9: dot_reg <= 8'h7C;
                            5'd10: dot_reg <= 8'h38;
                            5'd11: dot_reg <= 8'h08;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'hFF;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h08;
                            5'd22: dot_reg <= 8'h30;
                            5'd23: dot_reg <= 8'h60;
                            5'd24: dot_reg <= 8'hC0;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h80;
                            5'd3: dot_reg <= 8'h40;
                            5'd4: dot_reg <= 8'h30;
                            5'd5: dot_reg <= 8'h18;
                            5'd6: dot_reg <= 8'h06;
                            5'd7: dot_reg <= 8'h03;
                            5'd8: dot_reg <= 8'h01;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'hFF;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h03;
                            5'd26: dot_reg <= 8'h0F;
                            5'd27: dot_reg <= 8'h3E;
                            5'd28: dot_reg <= 8'h7C;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h00;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h08;
                            5'd11: dot_reg <= 8'h08;
                            5'd12: dot_reg <= 8'h10;
                            5'd13: dot_reg <= 8'h30;
                            5'd14: dot_reg <= 8'h70;
                            5'd15: dot_reg <= 8'h3F;
                            5'd16: dot_reg <= 8'h1F;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h7C73: begin // Chinese '米'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h20;
                            5'd7: dot_reg <= 8'hC0;
                            5'd8: dot_reg <= 8'hC0;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'hFC;
                            5'd16: dot_reg <= 8'hF8;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'hC0;
                            5'd23: dot_reg <= 8'hF0;
                            5'd24: dot_reg <= 8'h70;
                            5'd25: dot_reg <= 8'h20;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h20;
                            5'd3: dot_reg <= 8'h20;
                            5'd4: dot_reg <= 8'h20;
                            5'd5: dot_reg <= 8'h20;
                            5'd6: dot_reg <= 8'h20;
                            5'd7: dot_reg <= 8'h20;
                            5'd8: dot_reg <= 8'h23;
                            5'd9: dot_reg <= 8'h2F;
                            5'd10: dot_reg <= 8'h27;
                            5'd11: dot_reg <= 8'h20;
                            5'd12: dot_reg <= 8'h20;
                            5'd13: dot_reg <= 8'hE0;
                            5'd14: dot_reg <= 8'hE0;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'hFF;
                            5'd17: dot_reg <= 8'h60;
                            5'd18: dot_reg <= 8'hA0;
                            5'd19: dot_reg <= 8'h38;
                            5'd20: dot_reg <= 8'h2C;
                            5'd21: dot_reg <= 8'h27;
                            5'd22: dot_reg <= 8'h21;
                            5'd23: dot_reg <= 8'h20;
                            5'd24: dot_reg <= 8'h20;
                            5'd25: dot_reg <= 8'h20;
                            5'd26: dot_reg <= 8'h20;
                            5'd27: dot_reg <= 8'h30;
                            5'd28: dot_reg <= 8'h30;
                            5'd29: dot_reg <= 8'h20;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h80;
                            5'd7: dot_reg <= 8'hC0;
                            5'd8: dot_reg <= 8'h60;
                            5'd9: dot_reg <= 8'h30;
                            5'd10: dot_reg <= 8'h18;
                            5'd11: dot_reg <= 8'h0E;
                            5'd12: dot_reg <= 8'h07;
                            5'd13: dot_reg <= 8'h03;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'hFF;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h01;
                            5'd19: dot_reg <= 8'h06;
                            5'd20: dot_reg <= 8'h1C;
                            5'd21: dot_reg <= 8'h38;
                            5'd22: dot_reg <= 8'h70;
                            5'd23: dot_reg <= 8'hE0;
                            5'd24: dot_reg <= 8'hC0;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h08;
                            5'd3: dot_reg <= 8'h04;
                            5'd4: dot_reg <= 8'h02;
                            5'd5: dot_reg <= 8'h03;
                            5'd6: dot_reg <= 8'h01;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'h7F;
                            5'd16: dot_reg <= 8'h3F;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h01;
                            5'd25: dot_reg <= 8'h03;
                            5'd26: dot_reg <= 8'h07;
                            5'd27: dot_reg <= 8'h07;
                            5'd28: dot_reg <= 8'h02;
                            5'd29: dot_reg <= 8'h02;
                            5'd30: dot_reg <= 8'h02;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h73BB: begin // Chinese '玻'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h80;
                            5'd3: dot_reg <= 8'h80;
                            5'd4: dot_reg <= 8'h80;
                            5'd5: dot_reg <= 8'h80;
                            5'd6: dot_reg <= 8'h80;
                            5'd7: dot_reg <= 8'h80;
                            5'd8: dot_reg <= 8'h80;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'hC0;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h80;
                            5'd15: dot_reg <= 8'h80;
                            5'd16: dot_reg <= 8'h80;
                            5'd17: dot_reg <= 8'h80;
                            5'd18: dot_reg <= 8'h80;
                            5'd19: dot_reg <= 8'h80;
                            5'd20: dot_reg <= 8'hFC;
                            5'd21: dot_reg <= 8'hF8;
                            5'd22: dot_reg <= 8'h80;
                            5'd23: dot_reg <= 8'h80;
                            5'd24: dot_reg <= 8'h80;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'h80;
                            5'd27: dot_reg <= 8'h80;
                            5'd28: dot_reg <= 8'hC0;
                            5'd29: dot_reg <= 8'h80;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h80;
                            5'd3: dot_reg <= 8'h80;
                            5'd4: dot_reg <= 8'h80;
                            5'd5: dot_reg <= 8'h80;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h80;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'hC0;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hFF;
                            5'd15: dot_reg <= 8'h80;
                            5'd16: dot_reg <= 8'h80;
                            5'd17: dot_reg <= 8'h80;
                            5'd18: dot_reg <= 8'h80;
                            5'd19: dot_reg <= 8'h80;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'hFF;
                            5'd22: dot_reg <= 8'h80;
                            5'd23: dot_reg <= 8'h80;
                            5'd24: dot_reg <= 8'h80;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'hC6;
                            5'd27: dot_reg <= 8'h83;
                            5'd28: dot_reg <= 8'h01;
                            5'd29: dot_reg <= 8'h01;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h80;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'h80;
                            5'd13: dot_reg <= 8'hFE;
                            5'd14: dot_reg <= 8'h3F;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h01;
                            5'd18: dot_reg <= 8'h0E;
                            5'd19: dot_reg <= 8'h30;
                            5'd20: dot_reg <= 8'hC0;
                            5'd21: dot_reg <= 8'h80;
                            5'd22: dot_reg <= 8'hC0;
                            5'd23: dot_reg <= 8'h60;
                            5'd24: dot_reg <= 8'h38;
                            5'd25: dot_reg <= 8'h0E;
                            5'd26: dot_reg <= 8'h07;
                            5'd27: dot_reg <= 8'h01;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h06;
                            5'd3: dot_reg <= 8'h06;
                            5'd4: dot_reg <= 8'h06;
                            5'd5: dot_reg <= 8'h02;
                            5'd6: dot_reg <= 8'h03;
                            5'd7: dot_reg <= 8'h41;
                            5'd8: dot_reg <= 8'h21;
                            5'd9: dot_reg <= 8'h11;
                            5'd10: dot_reg <= 8'h18;
                            5'd11: dot_reg <= 8'h4E;
                            5'd12: dot_reg <= 8'h43;
                            5'd13: dot_reg <= 8'h20;
                            5'd14: dot_reg <= 8'h20;
                            5'd15: dot_reg <= 8'h10;
                            5'd16: dot_reg <= 8'h10;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h0C;
                            5'd19: dot_reg <= 8'h06;
                            5'd20: dot_reg <= 8'h02;
                            5'd21: dot_reg <= 8'h01;
                            5'd22: dot_reg <= 8'h03;
                            5'd23: dot_reg <= 8'h06;
                            5'd24: dot_reg <= 8'h0C;
                            5'd25: dot_reg <= 8'h1C;
                            5'd26: dot_reg <= 8'h18;
                            5'd27: dot_reg <= 8'h30;
                            5'd28: dot_reg <= 8'h30;
                            5'd29: dot_reg <= 8'h10;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h7483: begin // Chinese '璃'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h80;
                            5'd3: dot_reg <= 8'h80;
                            5'd4: dot_reg <= 8'h80;
                            5'd5: dot_reg <= 8'h80;
                            5'd6: dot_reg <= 8'h80;
                            5'd7: dot_reg <= 8'h80;
                            5'd8: dot_reg <= 8'h80;
                            5'd9: dot_reg <= 8'hC0;
                            5'd10: dot_reg <= 8'h80;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h40;
                            5'd13: dot_reg <= 8'h40;
                            5'd14: dot_reg <= 8'h40;
                            5'd15: dot_reg <= 8'h40;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h40;
                            5'd18: dot_reg <= 8'h44;
                            5'd19: dot_reg <= 8'h4C;
                            5'd20: dot_reg <= 8'h78;
                            5'd21: dot_reg <= 8'h70;
                            5'd22: dot_reg <= 8'h40;
                            5'd23: dot_reg <= 8'hC0;
                            5'd24: dot_reg <= 8'h40;
                            5'd25: dot_reg <= 8'h40;
                            5'd26: dot_reg <= 8'h40;
                            5'd27: dot_reg <= 8'h40;
                            5'd28: dot_reg <= 8'h60;
                            5'd29: dot_reg <= 8'h40;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h80;
                            5'd3: dot_reg <= 8'h80;
                            5'd4: dot_reg <= 8'h80;
                            5'd5: dot_reg <= 8'h80;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h80;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'hC0;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'hFE;
                            5'd14: dot_reg <= 8'hFE;
                            5'd15: dot_reg <= 8'h82;
                            5'd16: dot_reg <= 8'hA0;
                            5'd17: dot_reg <= 8'hA2;
                            5'd18: dot_reg <= 8'h92;
                            5'd19: dot_reg <= 8'h9E;
                            5'd20: dot_reg <= 8'h8C;
                            5'd21: dot_reg <= 8'h8C;
                            5'd22: dot_reg <= 8'h9E;
                            5'd23: dot_reg <= 8'hBB;
                            5'd24: dot_reg <= 8'hF1;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'hFE;
                            5'd27: dot_reg <= 8'hFE;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'h80;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'hFC;
                            5'd13: dot_reg <= 8'hF8;
                            5'd14: dot_reg <= 8'h09;
                            5'd15: dot_reg <= 8'h08;
                            5'd16: dot_reg <= 8'h88;
                            5'd17: dot_reg <= 8'hC8;
                            5'd18: dot_reg <= 8'h38;
                            5'd19: dot_reg <= 8'h1E;
                            5'd20: dot_reg <= 8'h0F;
                            5'd21: dot_reg <= 8'h0A;
                            5'd22: dot_reg <= 8'hA8;
                            5'd23: dot_reg <= 8'hC8;
                            5'd24: dot_reg <= 8'hC8;
                            5'd25: dot_reg <= 8'h88;
                            5'd26: dot_reg <= 8'h09;
                            5'd27: dot_reg <= 8'hF9;
                            5'd28: dot_reg <= 8'hFC;
                            5'd29: dot_reg <= 8'h08;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h02;
                            5'd2: dot_reg <= 8'h06;
                            5'd3: dot_reg <= 8'h06;
                            5'd4: dot_reg <= 8'h02;
                            5'd5: dot_reg <= 8'h03;
                            5'd6: dot_reg <= 8'h03;
                            5'd7: dot_reg <= 8'h01;
                            5'd8: dot_reg <= 8'h01;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'h7F;
                            5'd13: dot_reg <= 8'h3F;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'h01;
                            5'd16: dot_reg <= 8'h03;
                            5'd17: dot_reg <= 8'h03;
                            5'd18: dot_reg <= 8'h01;
                            5'd19: dot_reg <= 8'h01;
                            5'd20: dot_reg <= 8'h01;
                            5'd21: dot_reg <= 8'h01;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h10;
                            5'd24: dot_reg <= 8'h11;
                            5'd25: dot_reg <= 8'h33;
                            5'd26: dot_reg <= 8'h70;
                            5'd27: dot_reg <= 8'h3F;
                            5'd28: dot_reg <= 8'h1F;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h73E0: begin // Chinese '珠'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h40;
                            5'd3: dot_reg <= 8'h40;
                            5'd4: dot_reg <= 8'h40;
                            5'd5: dot_reg <= 8'h40;
                            5'd6: dot_reg <= 8'hC0;
                            5'd7: dot_reg <= 8'hC0;
                            5'd8: dot_reg <= 8'h40;
                            5'd9: dot_reg <= 8'h40;
                            5'd10: dot_reg <= 8'h60;
                            5'd11: dot_reg <= 8'h60;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hC0;
                            5'd15: dot_reg <= 8'hE0;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'hFC;
                            5'd20: dot_reg <= 8'hF8;
                            5'd21: dot_reg <= 8'h08;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h40;
                            5'd3: dot_reg <= 8'h40;
                            5'd4: dot_reg <= 8'h40;
                            5'd5: dot_reg <= 8'h40;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h40;
                            5'd9: dot_reg <= 8'h40;
                            5'd10: dot_reg <= 8'h60;
                            5'd11: dot_reg <= 8'hC0;
                            5'd12: dot_reg <= 8'hA0;
                            5'd13: dot_reg <= 8'h9C;
                            5'd14: dot_reg <= 8'h87;
                            5'd15: dot_reg <= 8'h83;
                            5'd16: dot_reg <= 8'h82;
                            5'd17: dot_reg <= 8'h82;
                            5'd18: dot_reg <= 8'h82;
                            5'd19: dot_reg <= 8'hFF;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'h82;
                            5'd22: dot_reg <= 8'h82;
                            5'd23: dot_reg <= 8'h82;
                            5'd24: dot_reg <= 8'h82;
                            5'd25: dot_reg <= 8'h83;
                            5'd26: dot_reg <= 8'h83;
                            5'd27: dot_reg <= 8'h82;
                            5'd28: dot_reg <= 8'hC0;
                            5'd29: dot_reg <= 8'h80;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h80;
                            5'd9: dot_reg <= 8'h80;
                            5'd10: dot_reg <= 8'h80;
                            5'd11: dot_reg <= 8'h40;
                            5'd12: dot_reg <= 8'h40;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h80;
                            5'd15: dot_reg <= 8'hC0;
                            5'd16: dot_reg <= 8'h70;
                            5'd17: dot_reg <= 8'h1C;
                            5'd18: dot_reg <= 8'h0F;
                            5'd19: dot_reg <= 8'hFF;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h07;
                            5'd23: dot_reg <= 8'h18;
                            5'd24: dot_reg <= 8'h60;
                            5'd25: dot_reg <= 8'hC0;
                            5'd26: dot_reg <= 8'h80;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h06;
                            5'd3: dot_reg <= 8'h06;
                            5'd4: dot_reg <= 8'h03;
                            5'd5: dot_reg <= 8'h03;
                            5'd6: dot_reg <= 8'h01;
                            5'd7: dot_reg <= 8'h01;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h10;
                            5'd11: dot_reg <= 8'h08;
                            5'd12: dot_reg <= 8'h04;
                            5'd13: dot_reg <= 8'h03;
                            5'd14: dot_reg <= 8'h01;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h7F;
                            5'd20: dot_reg <= 8'h3F;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h01;
                            5'd26: dot_reg <= 8'h03;
                            5'd27: dot_reg <= 8'h07;
                            5'd28: dot_reg <= 8'h0E;
                            5'd29: dot_reg <= 8'h04;
                            5'd30: dot_reg <= 8'h04;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h767D: begin // Chinese '白'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h00;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h00;
                            5'd12: dot_reg <= 8'hC0;
                            5'd13: dot_reg <= 8'h70;
                            5'd14: dot_reg <= 8'h3C;
                            5'd15: dot_reg <= 8'h18;
                            5'd16: dot_reg <= 8'h08;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'h00;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h80;
                            5'd26: dot_reg <= 8'h80;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h01;
                            5'd9: dot_reg <= 8'h01;
                            5'd10: dot_reg <= 8'h01;
                            5'd11: dot_reg <= 8'h01;
                            5'd12: dot_reg <= 8'h01;
                            5'd13: dot_reg <= 8'h01;
                            5'd14: dot_reg <= 8'h01;
                            5'd15: dot_reg <= 8'h01;
                            5'd16: dot_reg <= 8'h01;
                            5'd17: dot_reg <= 8'h01;
                            5'd18: dot_reg <= 8'h01;
                            5'd19: dot_reg <= 8'h01;
                            5'd20: dot_reg <= 8'h01;
                            5'd21: dot_reg <= 8'h01;
                            5'd22: dot_reg <= 8'h01;
                            5'd23: dot_reg <= 8'h01;
                            5'd24: dot_reg <= 8'h01;
                            5'd25: dot_reg <= 8'hFF;
                            5'd26: dot_reg <= 8'hFF;
                            5'd27: dot_reg <= 8'h01;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h02;
                            5'd9: dot_reg <= 8'h02;
                            5'd10: dot_reg <= 8'h02;
                            5'd11: dot_reg <= 8'h02;
                            5'd12: dot_reg <= 8'h02;
                            5'd13: dot_reg <= 8'h02;
                            5'd14: dot_reg <= 8'h02;
                            5'd15: dot_reg <= 8'h02;
                            5'd16: dot_reg <= 8'h02;
                            5'd17: dot_reg <= 8'h02;
                            5'd18: dot_reg <= 8'h02;
                            5'd19: dot_reg <= 8'h02;
                            5'd20: dot_reg <= 8'h02;
                            5'd21: dot_reg <= 8'h02;
                            5'd22: dot_reg <= 8'h02;
                            5'd23: dot_reg <= 8'h02;
                            5'd24: dot_reg <= 8'h02;
                            5'd25: dot_reg <= 8'hFF;
                            5'd26: dot_reg <= 8'hFF;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h7F;
                            5'd7: dot_reg <= 8'h3F;
                            5'd8: dot_reg <= 8'h08;
                            5'd9: dot_reg <= 8'h08;
                            5'd10: dot_reg <= 8'h08;
                            5'd11: dot_reg <= 8'h08;
                            5'd12: dot_reg <= 8'h08;
                            5'd13: dot_reg <= 8'h08;
                            5'd14: dot_reg <= 8'h08;
                            5'd15: dot_reg <= 8'h08;
                            5'd16: dot_reg <= 8'h08;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h08;
                            5'd19: dot_reg <= 8'h08;
                            5'd20: dot_reg <= 8'h08;
                            5'd21: dot_reg <= 8'h08;
                            5'd22: dot_reg <= 8'h08;
                            5'd23: dot_reg <= 8'h08;
                            5'd24: dot_reg <= 8'h08;
                            5'd25: dot_reg <= 8'h3F;
                            5'd26: dot_reg <= 8'h3F;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h7802: begin // Chinese '砂'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h20;
                            5'd3: dot_reg <= 8'h20;
                            5'd4: dot_reg <= 8'h20;
                            5'd5: dot_reg <= 8'h20;
                            5'd6: dot_reg <= 8'hE0;
                            5'd7: dot_reg <= 8'hE0;
                            5'd8: dot_reg <= 8'h20;
                            5'd9: dot_reg <= 8'h20;
                            5'd10: dot_reg <= 8'h20;
                            5'd11: dot_reg <= 8'h20;
                            5'd12: dot_reg <= 8'h30;
                            5'd13: dot_reg <= 8'h20;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h04;
                            5'd21: dot_reg <= 8'hFC;
                            5'd22: dot_reg <= 8'h08;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'hC0;
                            5'd5: dot_reg <= 8'hFC;
                            5'd6: dot_reg <= 8'hCF;
                            5'd7: dot_reg <= 8'h41;
                            5'd8: dot_reg <= 8'h40;
                            5'd9: dot_reg <= 8'h40;
                            5'd10: dot_reg <= 8'hC0;
                            5'd11: dot_reg <= 8'hE0;
                            5'd12: dot_reg <= 8'h40;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hC0;
                            5'd15: dot_reg <= 8'h7C;
                            5'd16: dot_reg <= 8'h1F;
                            5'd17: dot_reg <= 8'h07;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h00;
                            5'd21: dot_reg <= 8'hFF;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h01;
                            5'd25: dot_reg <= 8'h02;
                            5'd26: dot_reg <= 8'h06;
                            5'd27: dot_reg <= 8'h1C;
                            5'd28: dot_reg <= 8'h78;
                            5'd29: dot_reg <= 8'h70;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h10;
                            5'd2: dot_reg <= 8'h0C;
                            5'd3: dot_reg <= 8'h03;
                            5'd4: dot_reg <= 8'h01;
                            5'd5: dot_reg <= 8'hFF;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'hFF;
                            5'd11: dot_reg <= 8'hFF;
                            5'd12: dot_reg <= 8'h08;
                            5'd13: dot_reg <= 8'h06;
                            5'd14: dot_reg <= 8'h01;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'h10;
                            5'd21: dot_reg <= 8'h0F;
                            5'd22: dot_reg <= 8'hC0;
                            5'd23: dot_reg <= 8'hE0;
                            5'd24: dot_reg <= 8'h70;
                            5'd25: dot_reg <= 8'h3C;
                            5'd26: dot_reg <= 8'h1E;
                            5'd27: dot_reg <= 8'h0C;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h1F;
                            5'd6: dot_reg <= 8'h0F;
                            5'd7: dot_reg <= 8'h01;
                            5'd8: dot_reg <= 8'h01;
                            5'd9: dot_reg <= 8'h01;
                            5'd10: dot_reg <= 8'h4F;
                            5'd11: dot_reg <= 8'h47;
                            5'd12: dot_reg <= 8'h20;
                            5'd13: dot_reg <= 8'h20;
                            5'd14: dot_reg <= 8'h20;
                            5'd15: dot_reg <= 8'h10;
                            5'd16: dot_reg <= 8'h18;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h0C;
                            5'd19: dot_reg <= 8'h06;
                            5'd20: dot_reg <= 8'h03;
                            5'd21: dot_reg <= 8'h03;
                            5'd22: dot_reg <= 8'h01;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h7CD6: begin // Chinese '糖'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h60;
                            5'd3: dot_reg <= 8'hC0;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'hFC;
                            5'd7: dot_reg <= 8'hF8;
                            5'd8: dot_reg <= 8'h08;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'hC0;
                            5'd11: dot_reg <= 8'hC0;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h20;
                            5'd14: dot_reg <= 8'hC0;
                            5'd15: dot_reg <= 8'h40;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h40;
                            5'd18: dot_reg <= 8'h40;
                            5'd19: dot_reg <= 8'h44;
                            5'd20: dot_reg <= 8'h4C;
                            5'd21: dot_reg <= 8'hD8;
                            5'd22: dot_reg <= 8'h78;
                            5'd23: dot_reg <= 8'h40;
                            5'd24: dot_reg <= 8'h40;
                            5'd25: dot_reg <= 8'h40;
                            5'd26: dot_reg <= 8'h40;
                            5'd27: dot_reg <= 8'h60;
                            5'd28: dot_reg <= 8'h60;
                            5'd29: dot_reg <= 8'h40;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h20;
                            5'd2: dot_reg <= 8'h20;
                            5'd3: dot_reg <= 8'h27;
                            5'd4: dot_reg <= 8'h27;
                            5'd5: dot_reg <= 8'h20;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h24;
                            5'd9: dot_reg <= 8'h23;
                            5'd10: dot_reg <= 8'h21;
                            5'd11: dot_reg <= 8'h30;
                            5'd12: dot_reg <= 8'h20;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hFF;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h44;
                            5'd18: dot_reg <= 8'h44;
                            5'd19: dot_reg <= 8'h44;
                            5'd20: dot_reg <= 8'h44;
                            5'd21: dot_reg <= 8'hFF;
                            5'd22: dot_reg <= 8'hFF;
                            5'd23: dot_reg <= 8'h44;
                            5'd24: dot_reg <= 8'h44;
                            5'd25: dot_reg <= 8'h44;
                            5'd26: dot_reg <= 8'hFE;
                            5'd27: dot_reg <= 8'h44;
                            5'd28: dot_reg <= 8'h60;
                            5'd29: dot_reg <= 8'h40;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'hC0;
                            5'd4: dot_reg <= 8'h38;
                            5'd5: dot_reg <= 8'h0F;
                            5'd6: dot_reg <= 8'hFF;
                            5'd7: dot_reg <= 8'hFF;
                            5'd8: dot_reg <= 8'h02;
                            5'd9: dot_reg <= 8'h06;
                            5'd10: dot_reg <= 8'h1C;
                            5'd11: dot_reg <= 8'h18;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'hFE;
                            5'd14: dot_reg <= 8'h3F;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h20;
                            5'd17: dot_reg <= 8'hC4;
                            5'd18: dot_reg <= 8'h44;
                            5'd19: dot_reg <= 8'h44;
                            5'd20: dot_reg <= 8'h44;
                            5'd21: dot_reg <= 8'h5F;
                            5'd22: dot_reg <= 8'h5F;
                            5'd23: dot_reg <= 8'h44;
                            5'd24: dot_reg <= 8'h44;
                            5'd25: dot_reg <= 8'h44;
                            5'd26: dot_reg <= 8'hEF;
                            5'd27: dot_reg <= 8'hC0;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h02;
                            5'd2: dot_reg <= 8'h01;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h7F;
                            5'd7: dot_reg <= 8'h3F;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'h00;
                            5'd10: dot_reg <= 8'h30;
                            5'd11: dot_reg <= 8'h0C;
                            5'd12: dot_reg <= 8'h07;
                            5'd13: dot_reg <= 8'h01;
                            5'd14: dot_reg <= 8'h00;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h7F;
                            5'd18: dot_reg <= 8'h10;
                            5'd19: dot_reg <= 8'h10;
                            5'd20: dot_reg <= 8'h10;
                            5'd21: dot_reg <= 8'h10;
                            5'd22: dot_reg <= 8'h10;
                            5'd23: dot_reg <= 8'h10;
                            5'd24: dot_reg <= 8'h10;
                            5'd25: dot_reg <= 8'h10;
                            5'd26: dot_reg <= 8'h3F;
                            5'd27: dot_reg <= 8'h3F;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h7EC6: begin // Chinese '细'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'hC0;
                            5'd6: dot_reg <= 8'hF0;
                            5'd7: dot_reg <= 8'h3C;
                            5'd8: dot_reg <= 8'h18;
                            5'd9: dot_reg <= 8'h08;
                            5'd10: dot_reg <= 8'h00;
                            5'd11: dot_reg <= 8'h80;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hE0;
                            5'd15: dot_reg <= 8'hC0;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h40;
                            5'd18: dot_reg <= 8'h40;
                            5'd19: dot_reg <= 8'h40;
                            5'd20: dot_reg <= 8'hC0;
                            5'd21: dot_reg <= 8'hC0;
                            5'd22: dot_reg <= 8'h40;
                            5'd23: dot_reg <= 8'h40;
                            5'd24: dot_reg <= 8'h40;
                            5'd25: dot_reg <= 8'h40;
                            5'd26: dot_reg <= 8'h40;
                            5'd27: dot_reg <= 8'hC0;
                            5'd28: dot_reg <= 8'hE0;
                            5'd29: dot_reg <= 8'h40;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h38;
                            5'd3: dot_reg <= 8'h3C;
                            5'd4: dot_reg <= 8'h37;
                            5'd5: dot_reg <= 8'h11;
                            5'd6: dot_reg <= 8'h90;
                            5'd7: dot_reg <= 8'hD0;
                            5'd8: dot_reg <= 8'h70;
                            5'd9: dot_reg <= 8'h18;
                            5'd10: dot_reg <= 8'h0E;
                            5'd11: dot_reg <= 8'h07;
                            5'd12: dot_reg <= 8'h03;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hFF;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'h00;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'hFF;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'hFF;
                            5'd28: dot_reg <= 8'hFF;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h08;
                            5'd3: dot_reg <= 8'h18;
                            5'd4: dot_reg <= 8'h3C;
                            5'd5: dot_reg <= 8'h1A;
                            5'd6: dot_reg <= 8'h19;
                            5'd7: dot_reg <= 8'h08;
                            5'd8: dot_reg <= 8'h08;
                            5'd9: dot_reg <= 8'h08;
                            5'd10: dot_reg <= 8'h04;
                            5'd11: dot_reg <= 8'h04;
                            5'd12: dot_reg <= 8'h04;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'hFF;
                            5'd15: dot_reg <= 8'hFF;
                            5'd16: dot_reg <= 8'h01;
                            5'd17: dot_reg <= 8'h01;
                            5'd18: dot_reg <= 8'h01;
                            5'd19: dot_reg <= 8'h01;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'hFF;
                            5'd22: dot_reg <= 8'h01;
                            5'd23: dot_reg <= 8'h01;
                            5'd24: dot_reg <= 8'h01;
                            5'd25: dot_reg <= 8'h01;
                            5'd26: dot_reg <= 8'h01;
                            5'd27: dot_reg <= 8'hFF;
                            5'd28: dot_reg <= 8'hFF;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h04;
                            5'd2: dot_reg <= 8'h0C;
                            5'd3: dot_reg <= 8'h1C;
                            5'd4: dot_reg <= 8'h0C;
                            5'd5: dot_reg <= 8'h04;
                            5'd6: dot_reg <= 8'h04;
                            5'd7: dot_reg <= 8'h02;
                            5'd8: dot_reg <= 8'h02;
                            5'd9: dot_reg <= 8'h02;
                            5'd10: dot_reg <= 8'h01;
                            5'd11: dot_reg <= 8'h01;
                            5'd12: dot_reg <= 8'h01;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h7F;
                            5'd15: dot_reg <= 8'h3F;
                            5'd16: dot_reg <= 8'h08;
                            5'd17: dot_reg <= 8'h08;
                            5'd18: dot_reg <= 8'h08;
                            5'd19: dot_reg <= 8'h08;
                            5'd20: dot_reg <= 8'h0F;
                            5'd21: dot_reg <= 8'h0F;
                            5'd22: dot_reg <= 8'h08;
                            5'd23: dot_reg <= 8'h08;
                            5'd24: dot_reg <= 8'h08;
                            5'd25: dot_reg <= 8'h08;
                            5'd26: dot_reg <= 8'h08;
                            5'd27: dot_reg <= 8'h7F;
                            5'd28: dot_reg <= 8'h3F;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            16'h76D0: begin // Chinese '盐'
                width_reg <= 6'd32;
                case (i_page_idx)
                    2'd0: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h00;
                            5'd5: dot_reg <= 8'h00;
                            5'd6: dot_reg <= 8'h00;
                            5'd7: dot_reg <= 8'h00;
                            5'd8: dot_reg <= 8'h00;
                            5'd9: dot_reg <= 8'hFC;
                            5'd10: dot_reg <= 8'hFC;
                            5'd11: dot_reg <= 8'h08;
                            5'd12: dot_reg <= 8'h00;
                            5'd13: dot_reg <= 8'h00;
                            5'd14: dot_reg <= 8'h80;
                            5'd15: dot_reg <= 8'h00;
                            5'd16: dot_reg <= 8'h00;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'hFC;
                            5'd20: dot_reg <= 8'hF8;
                            5'd21: dot_reg <= 8'h08;
                            5'd22: dot_reg <= 8'h00;
                            5'd23: dot_reg <= 8'h00;
                            5'd24: dot_reg <= 8'h00;
                            5'd25: dot_reg <= 8'h00;
                            5'd26: dot_reg <= 8'h00;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd1: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h00;
                            5'd4: dot_reg <= 8'h01;
                            5'd5: dot_reg <= 8'h01;
                            5'd6: dot_reg <= 8'h01;
                            5'd7: dot_reg <= 8'h01;
                            5'd8: dot_reg <= 8'h01;
                            5'd9: dot_reg <= 8'hFF;
                            5'd10: dot_reg <= 8'hFF;
                            5'd11: dot_reg <= 8'h81;
                            5'd12: dot_reg <= 8'h81;
                            5'd13: dot_reg <= 8'h81;
                            5'd14: dot_reg <= 8'h81;
                            5'd15: dot_reg <= 8'h41;
                            5'd16: dot_reg <= 8'h40;
                            5'd17: dot_reg <= 8'h00;
                            5'd18: dot_reg <= 8'h00;
                            5'd19: dot_reg <= 8'hFF;
                            5'd20: dot_reg <= 8'hFF;
                            5'd21: dot_reg <= 8'h02;
                            5'd22: dot_reg <= 8'h02;
                            5'd23: dot_reg <= 8'h04;
                            5'd24: dot_reg <= 8'h0C;
                            5'd25: dot_reg <= 8'h18;
                            5'd26: dot_reg <= 8'h38;
                            5'd27: dot_reg <= 8'h70;
                            5'd28: dot_reg <= 8'h60;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd2: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h00;
                            5'd3: dot_reg <= 8'h01;
                            5'd4: dot_reg <= 8'h07;
                            5'd5: dot_reg <= 8'h03;
                            5'd6: dot_reg <= 8'hF3;
                            5'd7: dot_reg <= 8'hE3;
                            5'd8: dot_reg <= 8'h21;
                            5'd9: dot_reg <= 8'h21;
                            5'd10: dot_reg <= 8'h21;
                            5'd11: dot_reg <= 8'h20;
                            5'd12: dot_reg <= 8'hE0;
                            5'd13: dot_reg <= 8'hE0;
                            5'd14: dot_reg <= 8'h20;
                            5'd15: dot_reg <= 8'h20;
                            5'd16: dot_reg <= 8'h20;
                            5'd17: dot_reg <= 8'h20;
                            5'd18: dot_reg <= 8'hE0;
                            5'd19: dot_reg <= 8'hEF;
                            5'd20: dot_reg <= 8'h27;
                            5'd21: dot_reg <= 8'h20;
                            5'd22: dot_reg <= 8'h20;
                            5'd23: dot_reg <= 8'h20;
                            5'd24: dot_reg <= 8'hE0;
                            5'd25: dot_reg <= 8'hF0;
                            5'd26: dot_reg <= 8'h20;
                            5'd27: dot_reg <= 8'h00;
                            5'd28: dot_reg <= 8'h00;
                            5'd29: dot_reg <= 8'h00;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                    2'd3: begin
                        case (i_col_idx)
                            5'd0: dot_reg <= 8'h00;
                            5'd1: dot_reg <= 8'h00;
                            5'd2: dot_reg <= 8'h20;
                            5'd3: dot_reg <= 8'h20;
                            5'd4: dot_reg <= 8'h20;
                            5'd5: dot_reg <= 8'h20;
                            5'd6: dot_reg <= 8'h3F;
                            5'd7: dot_reg <= 8'h3F;
                            5'd8: dot_reg <= 8'h20;
                            5'd9: dot_reg <= 8'h20;
                            5'd10: dot_reg <= 8'h20;
                            5'd11: dot_reg <= 8'h20;
                            5'd12: dot_reg <= 8'h3F;
                            5'd13: dot_reg <= 8'h3F;
                            5'd14: dot_reg <= 8'h20;
                            5'd15: dot_reg <= 8'h20;
                            5'd16: dot_reg <= 8'h20;
                            5'd17: dot_reg <= 8'h20;
                            5'd18: dot_reg <= 8'h3F;
                            5'd19: dot_reg <= 8'h3F;
                            5'd20: dot_reg <= 8'h20;
                            5'd21: dot_reg <= 8'h20;
                            5'd22: dot_reg <= 8'h20;
                            5'd23: dot_reg <= 8'h20;
                            5'd24: dot_reg <= 8'h3F;
                            5'd25: dot_reg <= 8'h3F;
                            5'd26: dot_reg <= 8'h20;
                            5'd27: dot_reg <= 8'h20;
                            5'd28: dot_reg <= 8'h30;
                            5'd29: dot_reg <= 8'h20;
                            5'd30: dot_reg <= 8'h00;
                            5'd31: dot_reg <= 8'h00;
                            default: dot_reg <= 8'h00;
                        endcase
                    end
                endcase
            end
            default: begin
                dot_reg <= 8'h00;
                width_reg <= 6'd16;
            end
        endcase
    end

    assign o_dot_data   = dot_reg;
    assign o_char_width = width_reg;
endmodule
