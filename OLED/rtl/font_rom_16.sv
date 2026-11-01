// ================================================================
// font_rom_16.sv - FONT16 Dot Matrix ROM (ASCII 8x16 + Chinese 16x16)
// Generated automatically by scripts/gen_font.py
// ================================================================
`timescale 1ns / 1ps

module font_rom_16 (
    input  logic        clk,
    input  logic [15:0] i_char,      // ASCII: 0x0020..0x007E, Chinese: Unicode
    input  logic        i_page_idx,  // 0: top page (rows 0..7), 1: bottom page (rows 8..15)
    input  logic [3:0]  i_col_idx,   // 0..7 (ASCII) or 0..15 (Chinese)
    output logic [7:0]  o_dot_data,  // 8 vertical pixels (bit0=top)
    output logic [4:0]  o_char_width // Width: 8 (ASCII), 16 (Chinese)
);

    logic [7:0] dot_reg;
    logic [4:0] width_reg;

    always_ff @(posedge clk) begin
        dot_reg <= 8'h00;
        width_reg <= 5'd8;
        case (i_char)
            16'h0020: begin // ASCII ' '
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0021: begin // ASCII '!'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hFC;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0D;
                        4'd4: dot_reg <= 8'h0C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0022: begin // ASCII '"'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h1C;
                        4'd2: dot_reg <= 8'h1C;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h1C;
                        4'd5: dot_reg <= 8'h1C;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0023: begin // ASCII '#'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h20;
                        4'd1: dot_reg <= 8'hA0;
                        4'd2: dot_reg <= 8'h7C;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'hA0;
                        4'd6: dot_reg <= 8'h7C;
                        4'd7: dot_reg <= 8'h20;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h01;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h0F;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h01;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0024: begin // ASCII '$'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h38;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'hE4;
                        4'd4: dot_reg <= 8'h9E;
                        4'd5: dot_reg <= 8'h84;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h3F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0025: begin // ASCII '%'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h18;
                        4'd1: dot_reg <= 8'h24;
                        4'd2: dot_reg <= 8'h24;
                        4'd3: dot_reg <= 8'h98;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h30;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h04;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h08;
                        4'd1: dot_reg <= 8'h0C;
                        4'd2: dot_reg <= 8'h03;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h06;
                        4'd5: dot_reg <= 8'h09;
                        4'd6: dot_reg <= 8'h09;
                        4'd7: dot_reg <= 8'h06;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0026: begin // ASCII '&'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hB8;
                        4'd2: dot_reg <= 8'h64;
                        4'd3: dot_reg <= 8'hC4;
                        4'd4: dot_reg <= 8'h24;
                        4'd5: dot_reg <= 8'h38;
                        4'd6: dot_reg <= 8'h80;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h07;
                        4'd1: dot_reg <= 8'h0C;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h0B;
                        4'd5: dot_reg <= 8'h06;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h08;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0027: begin // ASCII '\''
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h1C;
                        4'd4: dot_reg <= 8'h1C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0028: begin // ASCII '('
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h02;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h07;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h40;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0029: begin // ASCII ')'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h02;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'hE0;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'h07;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002A: begin // ASCII '*'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h48;
                        4'd3: dot_reg <= 8'h30;
                        4'd4: dot_reg <= 8'hFC;
                        4'd5: dot_reg <= 8'h30;
                        4'd6: dot_reg <= 8'h48;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002B: begin // ASCII '+'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h01;
                        4'd1: dot_reg <= 8'h01;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h01;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002C: begin // ASCII ','
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h6C;
                        4'd4: dot_reg <= 8'h3C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002D: begin // ASCII '-'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h01;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002E: begin // ASCII '.'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0C;
                        4'd4: dot_reg <= 8'h0C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h002F: begin // ASCII '/'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'hC0;
                        4'd5: dot_reg <= 8'h38;
                        4'd6: dot_reg <= 8'h0C;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h1C;
                        4'd3: dot_reg <= 8'h07;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0030: begin // ASCII '0'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hF0;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'h28;
                        4'd7: dot_reg <= 8'hF0;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h03;
                        4'd2: dot_reg <= 8'h05;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h03;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0031: begin // ASCII '1'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h10;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'hFC;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h0F;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h08;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0032: begin // ASCII '2'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h8C;
                        4'd6: dot_reg <= 8'h78;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h0A;
                        4'd4: dot_reg <= 8'h09;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0033: begin // ASCII '3'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'hE4;
                        4'd6: dot_reg <= 8'hB8;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h03;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0034: begin // ASCII '4'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h60;
                        4'd3: dot_reg <= 8'h30;
                        4'd4: dot_reg <= 8'h0C;
                        4'd5: dot_reg <= 8'hFC;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h03;
                        4'd1: dot_reg <= 8'h03;
                        4'd2: dot_reg <= 8'h02;
                        4'd3: dot_reg <= 8'h02;
                        4'd4: dot_reg <= 8'h02;
                        4'd5: dot_reg <= 8'h0F;
                        4'd6: dot_reg <= 8'h02;
                        4'd7: dot_reg <= 8'h02;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0035: begin // ASCII '5'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h7C;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h84;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h07;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0036: begin // ASCII '6'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hF0;
                        4'd2: dot_reg <= 8'h88;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'h80;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h03;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0037: begin // ASCII '7'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h7C;
                        4'd6: dot_reg <= 8'h0C;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h07;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0038: begin // ASCII '8'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h38;
                        4'd2: dot_reg <= 8'hA4;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'hA4;
                        4'd6: dot_reg <= 8'h38;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0039: begin // ASCII '9'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h78;
                        4'd2: dot_reg <= 8'h8C;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h4C;
                        4'd6: dot_reg <= 8'hF0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h03;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003A: begin // ASCII ':'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h60;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0C;
                        4'd4: dot_reg <= 8'h0C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003B: begin // ASCII ';'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h60;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h6C;
                        4'd4: dot_reg <= 8'h3C;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003C: begin // ASCII '<'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h80;
                        4'd3: dot_reg <= 8'hC0;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h10;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h01;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h03;
                        4'd4: dot_reg <= 8'h06;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003D: begin // ASCII '='
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'h40;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h01;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h01;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003E: begin // ASCII '>'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h10;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'hC0;
                        4'd6: dot_reg <= 8'h80;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h06;
                        4'd5: dot_reg <= 8'h03;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h01;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h003F: begin // ASCII '?'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h84;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h88;
                        4'd5: dot_reg <= 8'h70;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h0D;
                        4'd3: dot_reg <= 8'h0C;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0040: begin // ASCII '@'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h30;
                        4'd1: dot_reg <= 8'h88;
                        4'd2: dot_reg <= 8'hC4;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'hF0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h20;
                        4'd1: dot_reg <= 8'h4F;
                        4'd2: dot_reg <= 8'h48;
                        4'd3: dot_reg <= 8'h48;
                        4'd4: dot_reg <= 8'h6F;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0041: begin // ASCII 'A'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'hC0;
                        4'd3: dot_reg <= 8'h3C;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h3C;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0E;
                        4'd2: dot_reg <= 8'h03;
                        4'd3: dot_reg <= 8'h02;
                        4'd4: dot_reg <= 8'h02;
                        4'd5: dot_reg <= 8'h02;
                        4'd6: dot_reg <= 8'h03;
                        4'd7: dot_reg <= 8'h0E;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0042: begin // ASCII 'B'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'hE4;
                        4'd6: dot_reg <= 8'hB8;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0043: begin // ASCII 'C'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hF0;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h03;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0044: begin // ASCII 'D'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'hF0;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h06;
                        4'd7: dot_reg <= 8'h03;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0045: begin // ASCII 'E'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0046: begin // ASCII 'F'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'hFC;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h84;
                        4'd6: dot_reg <= 8'h84;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h0F;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0047: begin // ASCII 'G'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'hE0;
                        4'd1: dot_reg <= 8'h18;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h84;
                        4'd6: dot_reg <= 8'h88;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h03;
                        4'd1: dot_reg <= 8'h06;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0048: begin // ASCII 'H'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'hFC;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0049: begin // ASCII 'I'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'hFC;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004A: begin // ASCII 'J'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'hFC;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h07;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004B: begin // ASCII 'K'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'hC0;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h30;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h03;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004C: begin // ASCII 'L'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'hFC;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h0F;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h08;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004D: begin // ASCII 'M'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hF8;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'hF0;
                        4'd4: dot_reg <= 8'hC0;
                        4'd5: dot_reg <= 8'h38;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'hFC;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h0F;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004E: begin // ASCII 'N'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h1C;
                        4'd3: dot_reg <= 8'h60;
                        4'd4: dot_reg <= 8'h80;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hFC;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h03;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h004F: begin // ASCII 'O'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'hF0;
                        4'd1: dot_reg <= 8'h18;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'hF0;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h03;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h06;
                        4'd7: dot_reg <= 8'h03;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0050: begin // ASCII 'P'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h84;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h4C;
                        4'd6: dot_reg <= 8'h78;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0051: begin // ASCII 'Q'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'hF0;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'hF0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h03;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h38;
                        4'd4: dot_reg <= 8'h48;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'h63;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0052: begin // ASCII 'R'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'hC4;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h38;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h03;
                        4'd5: dot_reg <= 8'h0E;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0053: begin // ASCII 'S'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h38;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h84;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0054: begin // ASCII 'T'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h04;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'hFC;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0055: begin // ASCII 'U'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hFC;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0056: begin // ASCII 'V'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h1C;
                        4'd2: dot_reg <= 8'hF0;
                        4'd3: dot_reg <= 8'h80;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h80;
                        4'd6: dot_reg <= 8'hF0;
                        4'd7: dot_reg <= 8'h1C;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h07;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0057: begin // ASCII 'W'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h7C;
                        4'd1: dot_reg <= 8'hC0;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hC0;
                        4'd4: dot_reg <= 8'hE0;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h7C;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h03;
                        4'd4: dot_reg <= 8'h03;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0058: begin // ASCII 'X'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h04;
                        4'd1: dot_reg <= 8'h0C;
                        4'd2: dot_reg <= 8'h30;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'hE0;
                        4'd5: dot_reg <= 8'h30;
                        4'd6: dot_reg <= 8'h0C;
                        4'd7: dot_reg <= 8'h04;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h08;
                        4'd1: dot_reg <= 8'h0C;
                        4'd2: dot_reg <= 8'h07;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h07;
                        4'd6: dot_reg <= 8'h0C;
                        4'd7: dot_reg <= 8'h08;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0059: begin // ASCII 'Y'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h04;
                        4'd1: dot_reg <= 8'h18;
                        4'd2: dot_reg <= 8'h60;
                        4'd3: dot_reg <= 8'h80;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h18;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005A: begin // ASCII 'Z'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'hC4;
                        4'd5: dot_reg <= 8'h34;
                        4'd6: dot_reg <= 8'h1C;
                        4'd7: dot_reg <= 8'h04;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h0E;
                        4'd3: dot_reg <= 8'h0B;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005B: begin // ASCII '['
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hFE;
                        4'd4: dot_reg <= 8'h02;
                        4'd5: dot_reg <= 8'h02;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h7F;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005C: begin // ASCII '\\'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h38;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h80;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h03;
                        4'd5: dot_reg <= 8'h1C;
                        4'd6: dot_reg <= 8'h30;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005D: begin // ASCII ']'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h02;
                        4'd3: dot_reg <= 8'h02;
                        4'd4: dot_reg <= 8'hFE;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h7F;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005E: begin // ASCII '^'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h60;
                        4'd2: dot_reg <= 8'h18;
                        4'd3: dot_reg <= 8'h04;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h005F: begin // ASCII '_'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h40;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'h40;
                        4'd7: dot_reg <= 8'h40;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0060: begin // ASCII '`'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0061: begin // ASCII 'a'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h06;
                        4'd2: dot_reg <= 8'h09;
                        4'd3: dot_reg <= 8'h09;
                        4'd4: dot_reg <= 8'h09;
                        4'd5: dot_reg <= 8'h05;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0062: begin // ASCII 'b'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h03;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0063: begin // ASCII 'c'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h20;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0064: begin // ASCII 'd'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hFC;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0065: begin // ASCII 'e'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hC0;
                        4'd2: dot_reg <= 8'h60;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h0D;
                        4'd3: dot_reg <= 8'h09;
                        4'd4: dot_reg <= 8'h09;
                        4'd5: dot_reg <= 8'h09;
                        4'd6: dot_reg <= 8'h09;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0066: begin // ASCII 'f'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'hF8;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0067: begin // ASCII 'g'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hC0;
                        4'd2: dot_reg <= 8'h20;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h20;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h3F;
                        4'd2: dot_reg <= 8'h4A;
                        4'd3: dot_reg <= 8'h4A;
                        4'd4: dot_reg <= 8'h4A;
                        4'd5: dot_reg <= 8'h4A;
                        4'd6: dot_reg <= 8'h49;
                        4'd7: dot_reg <= 8'h30;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0068: begin // ASCII 'h'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0069: begin // ASCII 'i'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h2C;
                        4'd3: dot_reg <= 8'hEC;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006A: begin // ASCII 'j'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h20;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h2C;
                        4'd5: dot_reg <= 8'hEC;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h3F;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006B: begin // ASCII 'k'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hFC;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h80;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'h20;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h02;
                        4'd4: dot_reg <= 8'h06;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006C: begin // ASCII 'l'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h04;
                        4'd3: dot_reg <= 8'hFC;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006D: begin // ASCII 'm'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'hE0;
                        4'd1: dot_reg <= 8'h60;
                        4'd2: dot_reg <= 8'h20;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h60;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h0F;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006E: begin // ASCII 'n'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hE0;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h006F: begin // ASCII 'o'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h60;
                        4'd7: dot_reg <= 8'hC0;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'h03;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0070: begin // ASCII 'p'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hE0;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h7F;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h03;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0071: begin // ASCII 'q'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h7F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0072: begin // ASCII 'r'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hE0;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h0F;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0073: begin // ASCII 's'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hC0;
                        4'd2: dot_reg <= 8'h20;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h09;
                        4'd3: dot_reg <= 8'h09;
                        4'd4: dot_reg <= 8'h09;
                        4'd5: dot_reg <= 8'h06;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0074: begin // ASCII 't'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h20;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'hF8;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h20;
                        4'd6: dot_reg <= 8'h20;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h07;
                        4'd3: dot_reg <= 8'h0C;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0075: begin // ASCII 'u'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'hE0;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h07;
                        4'd2: dot_reg <= 8'h08;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h04;
                        4'd6: dot_reg <= 8'h0F;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0076: begin // ASCII 'v'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h60;
                        4'd2: dot_reg <= 8'hC0;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h60;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'h0E;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h06;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0077: begin // ASCII 'w'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'hE0;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h80;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hE0;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h0F;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h07;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h07;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h07;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0078: begin // ASCII 'x'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h60;
                        4'd3: dot_reg <= 8'hC0;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'hC0;
                        4'd6: dot_reg <= 8'h60;
                        4'd7: dot_reg <= 8'h20;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h06;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h06;
                        4'd6: dot_reg <= 8'h0C;
                        4'd7: dot_reg <= 8'h08;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h0079: begin // ASCII 'y'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h60;
                        4'd2: dot_reg <= 8'hC0;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'h60;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h40;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h41;
                        4'd3: dot_reg <= 8'h36;
                        4'd4: dot_reg <= 8'h18;
                        4'd5: dot_reg <= 8'h06;
                        4'd6: dot_reg <= 8'h01;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h007A: begin // ASCII 'z'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h20;
                        4'd3: dot_reg <= 8'h20;
                        4'd4: dot_reg <= 8'hA0;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'h20;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h08;
                        4'd2: dot_reg <= 8'h0C;
                        4'd3: dot_reg <= 8'h0B;
                        4'd4: dot_reg <= 8'h09;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h08;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h007B: begin // ASCII '{'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h80;
                        4'd2: dot_reg <= 8'h80;
                        4'd3: dot_reg <= 8'h7C;
                        4'd4: dot_reg <= 8'h02;
                        4'd5: dot_reg <= 8'h02;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h3F;
                        4'd4: dot_reg <= 8'h40;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h007C: begin // ASCII '|'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'hFF;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h7F;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h007D: begin // ASCII '}'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h02;
                        4'd3: dot_reg <= 8'h02;
                        4'd4: dot_reg <= 8'h7C;
                        4'd5: dot_reg <= 8'h80;
                        4'd6: dot_reg <= 8'h80;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h40;
                        4'd3: dot_reg <= 8'h40;
                        4'd4: dot_reg <= 8'h3F;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h007E: begin // ASCII '~'
                width_reg <= 5'd8;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h40;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h80;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'hC0;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'h01;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h5C0F: begin // Chinese '小'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'h00;
                        4'd3: dot_reg <= 8'hE0;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hFF;
                        4'd8: dot_reg <= 8'h00;
                        4'd9: dot_reg <= 8'h00;
                        4'd10: dot_reg <= 8'h00;
                        4'd11: dot_reg <= 8'h20;
                        4'd12: dot_reg <= 8'h40;
                        4'd13: dot_reg <= 8'h80;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h08;
                        4'd1: dot_reg <= 8'h04;
                        4'd2: dot_reg <= 8'h03;
                        4'd3: dot_reg <= 8'h00;
                        4'd4: dot_reg <= 8'h00;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'h80;
                        4'd7: dot_reg <= 8'h7F;
                        4'd8: dot_reg <= 8'h00;
                        4'd9: dot_reg <= 8'h00;
                        4'd10: dot_reg <= 8'h00;
                        4'd11: dot_reg <= 8'h00;
                        4'd12: dot_reg <= 8'h00;
                        4'd13: dot_reg <= 8'h01;
                        4'd14: dot_reg <= 8'h0E;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h7C73: begin // Chinese '米'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h42;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h58;
                        4'd5: dot_reg <= 8'h40;
                        4'd6: dot_reg <= 8'hC0;
                        4'd7: dot_reg <= 8'hFF;
                        4'd8: dot_reg <= 8'hC0;
                        4'd9: dot_reg <= 8'h40;
                        4'd10: dot_reg <= 8'h50;
                        4'd11: dot_reg <= 8'h48;
                        4'd12: dot_reg <= 8'h46;
                        4'd13: dot_reg <= 8'h40;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h20;
                        4'd1: dot_reg <= 8'h20;
                        4'd2: dot_reg <= 8'h10;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h04;
                        4'd5: dot_reg <= 8'h03;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hFF;
                        4'd8: dot_reg <= 8'h00;
                        4'd9: dot_reg <= 8'h03;
                        4'd10: dot_reg <= 8'h04;
                        4'd11: dot_reg <= 8'h08;
                        4'd12: dot_reg <= 8'h10;
                        4'd13: dot_reg <= 8'h20;
                        4'd14: dot_reg <= 8'h20;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h73BB: begin // Chinese '玻'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h84;
                        4'd1: dot_reg <= 8'h84;
                        4'd2: dot_reg <= 8'hFC;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hF8;
                        4'd7: dot_reg <= 8'h88;
                        4'd8: dot_reg <= 8'h88;
                        4'd9: dot_reg <= 8'h88;
                        4'd10: dot_reg <= 8'hFF;
                        4'd11: dot_reg <= 8'h88;
                        4'd12: dot_reg <= 8'h88;
                        4'd13: dot_reg <= 8'hA8;
                        4'd14: dot_reg <= 8'h18;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h10;
                        4'd1: dot_reg <= 8'h30;
                        4'd2: dot_reg <= 8'h1F;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h88;
                        4'd5: dot_reg <= 8'h60;
                        4'd6: dot_reg <= 8'h1F;
                        4'd7: dot_reg <= 8'h80;
                        4'd8: dot_reg <= 8'h43;
                        4'd9: dot_reg <= 8'h2C;
                        4'd10: dot_reg <= 8'h10;
                        4'd11: dot_reg <= 8'h28;
                        4'd12: dot_reg <= 8'h46;
                        4'd13: dot_reg <= 8'h81;
                        4'd14: dot_reg <= 8'h80;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h7483: begin // Chinese '璃'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h84;
                        4'd1: dot_reg <= 8'h84;
                        4'd2: dot_reg <= 8'hFC;
                        4'd3: dot_reg <= 8'h84;
                        4'd4: dot_reg <= 8'h84;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'h04;
                        4'd7: dot_reg <= 8'hF4;
                        4'd8: dot_reg <= 8'h84;
                        4'd9: dot_reg <= 8'hD5;
                        4'd10: dot_reg <= 8'hA6;
                        4'd11: dot_reg <= 8'hD4;
                        4'd12: dot_reg <= 8'h84;
                        4'd13: dot_reg <= 8'hF4;
                        4'd14: dot_reg <= 8'h04;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h10;
                        4'd1: dot_reg <= 8'h30;
                        4'd2: dot_reg <= 8'h1F;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h00;
                        4'd6: dot_reg <= 8'hFE;
                        4'd7: dot_reg <= 8'h02;
                        4'd8: dot_reg <= 8'h1A;
                        4'd9: dot_reg <= 8'h16;
                        4'd10: dot_reg <= 8'h13;
                        4'd11: dot_reg <= 8'h1A;
                        4'd12: dot_reg <= 8'h32;
                        4'd13: dot_reg <= 8'h82;
                        4'd14: dot_reg <= 8'hFE;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h73E0: begin // Chinese '珠'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h04;
                        4'd1: dot_reg <= 8'h44;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'hFC;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'h44;
                        4'd6: dot_reg <= 8'hA0;
                        4'd7: dot_reg <= 8'h9E;
                        4'd8: dot_reg <= 8'h88;
                        4'd9: dot_reg <= 8'h88;
                        4'd10: dot_reg <= 8'hFF;
                        4'd11: dot_reg <= 8'h88;
                        4'd12: dot_reg <= 8'h88;
                        4'd13: dot_reg <= 8'h88;
                        4'd14: dot_reg <= 8'h80;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h10;
                        4'd1: dot_reg <= 8'h30;
                        4'd2: dot_reg <= 8'h10;
                        4'd3: dot_reg <= 8'h0F;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h08;
                        4'd6: dot_reg <= 8'h20;
                        4'd7: dot_reg <= 8'h18;
                        4'd8: dot_reg <= 8'h06;
                        4'd9: dot_reg <= 8'h01;
                        4'd10: dot_reg <= 8'hFF;
                        4'd11: dot_reg <= 8'h01;
                        4'd12: dot_reg <= 8'h06;
                        4'd13: dot_reg <= 8'h18;
                        4'd14: dot_reg <= 8'h20;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h767D: begin // Chinese '白'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'hF8;
                        4'd3: dot_reg <= 8'h08;
                        4'd4: dot_reg <= 8'h08;
                        4'd5: dot_reg <= 8'h0C;
                        4'd6: dot_reg <= 8'h0A;
                        4'd7: dot_reg <= 8'h09;
                        4'd8: dot_reg <= 8'h08;
                        4'd9: dot_reg <= 8'h08;
                        4'd10: dot_reg <= 8'h08;
                        4'd11: dot_reg <= 8'h08;
                        4'd12: dot_reg <= 8'hF8;
                        4'd13: dot_reg <= 8'h00;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h00;
                        4'd1: dot_reg <= 8'h00;
                        4'd2: dot_reg <= 8'hFF;
                        4'd3: dot_reg <= 8'h41;
                        4'd4: dot_reg <= 8'h41;
                        4'd5: dot_reg <= 8'h41;
                        4'd6: dot_reg <= 8'h41;
                        4'd7: dot_reg <= 8'h41;
                        4'd8: dot_reg <= 8'h41;
                        4'd9: dot_reg <= 8'h41;
                        4'd10: dot_reg <= 8'h41;
                        4'd11: dot_reg <= 8'h41;
                        4'd12: dot_reg <= 8'hFF;
                        4'd13: dot_reg <= 8'h00;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h7802: begin // Chinese '砂'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h04;
                        4'd1: dot_reg <= 8'h84;
                        4'd2: dot_reg <= 8'hE4;
                        4'd3: dot_reg <= 8'h5C;
                        4'd4: dot_reg <= 8'h44;
                        4'd5: dot_reg <= 8'hC4;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hC0;
                        4'd8: dot_reg <= 8'h38;
                        4'd9: dot_reg <= 8'h00;
                        4'd10: dot_reg <= 8'hFF;
                        4'd11: dot_reg <= 8'h00;
                        4'd12: dot_reg <= 8'h08;
                        4'd13: dot_reg <= 8'h10;
                        4'd14: dot_reg <= 8'h60;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h02;
                        4'd1: dot_reg <= 8'h01;
                        4'd2: dot_reg <= 8'h7F;
                        4'd3: dot_reg <= 8'h10;
                        4'd4: dot_reg <= 8'h10;
                        4'd5: dot_reg <= 8'h3F;
                        4'd6: dot_reg <= 8'h81;
                        4'd7: dot_reg <= 8'h80;
                        4'd8: dot_reg <= 8'h40;
                        4'd9: dot_reg <= 8'h40;
                        4'd10: dot_reg <= 8'h27;
                        4'd11: dot_reg <= 8'h10;
                        4'd12: dot_reg <= 8'h0C;
                        4'd13: dot_reg <= 8'h03;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h7CD6: begin // Chinese '糖'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h44;
                        4'd1: dot_reg <= 8'h58;
                        4'd2: dot_reg <= 8'hC0;
                        4'd3: dot_reg <= 8'hFF;
                        4'd4: dot_reg <= 8'h50;
                        4'd5: dot_reg <= 8'h4C;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hFC;
                        4'd8: dot_reg <= 8'h44;
                        4'd9: dot_reg <= 8'h54;
                        4'd10: dot_reg <= 8'h55;
                        4'd11: dot_reg <= 8'hFE;
                        4'd12: dot_reg <= 8'h54;
                        4'd13: dot_reg <= 8'hF4;
                        4'd14: dot_reg <= 8'h44;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h08;
                        4'd1: dot_reg <= 8'h06;
                        4'd2: dot_reg <= 8'h01;
                        4'd3: dot_reg <= 8'hFF;
                        4'd4: dot_reg <= 8'h01;
                        4'd5: dot_reg <= 8'h86;
                        4'd6: dot_reg <= 8'h60;
                        4'd7: dot_reg <= 8'h1F;
                        4'd8: dot_reg <= 8'h00;
                        4'd9: dot_reg <= 8'hFD;
                        4'd10: dot_reg <= 8'h45;
                        4'd11: dot_reg <= 8'h47;
                        4'd12: dot_reg <= 8'h45;
                        4'd13: dot_reg <= 8'hFD;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h7EC6: begin // Chinese '细'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h20;
                        4'd1: dot_reg <= 8'h30;
                        4'd2: dot_reg <= 8'hAC;
                        4'd3: dot_reg <= 8'h63;
                        4'd4: dot_reg <= 8'h20;
                        4'd5: dot_reg <= 8'h18;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hFC;
                        4'd8: dot_reg <= 8'h04;
                        4'd9: dot_reg <= 8'h04;
                        4'd10: dot_reg <= 8'hFC;
                        4'd11: dot_reg <= 8'h04;
                        4'd12: dot_reg <= 8'h04;
                        4'd13: dot_reg <= 8'hFC;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h22;
                        4'd1: dot_reg <= 8'h67;
                        4'd2: dot_reg <= 8'h22;
                        4'd3: dot_reg <= 8'h12;
                        4'd4: dot_reg <= 8'h12;
                        4'd5: dot_reg <= 8'h12;
                        4'd6: dot_reg <= 8'h00;
                        4'd7: dot_reg <= 8'hFF;
                        4'd8: dot_reg <= 8'h41;
                        4'd9: dot_reg <= 8'h41;
                        4'd10: dot_reg <= 8'h7F;
                        4'd11: dot_reg <= 8'h41;
                        4'd12: dot_reg <= 8'h41;
                        4'd13: dot_reg <= 8'hFF;
                        4'd14: dot_reg <= 8'h00;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            16'h76D0: begin // Chinese '盐'
                width_reg <= 5'd16;
                if (!i_page_idx) begin // Top page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h40;
                        4'd1: dot_reg <= 8'hC4;
                        4'd2: dot_reg <= 8'h44;
                        4'd3: dot_reg <= 8'h44;
                        4'd4: dot_reg <= 8'h3F;
                        4'd5: dot_reg <= 8'h24;
                        4'd6: dot_reg <= 8'h24;
                        4'd7: dot_reg <= 8'h24;
                        4'd8: dot_reg <= 8'h00;
                        4'd9: dot_reg <= 8'h00;
                        4'd10: dot_reg <= 8'hFF;
                        4'd11: dot_reg <= 8'h00;
                        4'd12: dot_reg <= 8'h08;
                        4'd13: dot_reg <= 8'h10;
                        4'd14: dot_reg <= 8'h20;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end else begin // Bottom page
                    case (i_col_idx)
                        4'd0: dot_reg <= 8'h40;
                        4'd1: dot_reg <= 8'h40;
                        4'd2: dot_reg <= 8'h7E;
                        4'd3: dot_reg <= 8'h42;
                        4'd4: dot_reg <= 8'h42;
                        4'd5: dot_reg <= 8'h7E;
                        4'd6: dot_reg <= 8'h42;
                        4'd7: dot_reg <= 8'h42;
                        4'd8: dot_reg <= 8'h42;
                        4'd9: dot_reg <= 8'h7E;
                        4'd10: dot_reg <= 8'h42;
                        4'd11: dot_reg <= 8'h42;
                        4'd12: dot_reg <= 8'h7E;
                        4'd13: dot_reg <= 8'h40;
                        4'd14: dot_reg <= 8'h40;
                        4'd15: dot_reg <= 8'h00;
                        default: dot_reg <= 8'h00;
                    endcase
                end
            end
            default: begin
                dot_reg <= 8'h00;
                width_reg <= 5'd8;
            end
        endcase
    end

    assign o_dot_data   = dot_reg;
    assign o_char_width = width_reg;
endmodule
