// ================================================================
// Top_OLED.sv - Top-Level Board Demo Module for EGo1 Artix-7 FPGA
// Target Part: xc7a35tcsg324-1
// SSD1306 128x64 I2C OLED Driver Demo
// ================================================================
`timescale 1ns / 1ps

module Top_OLED #(
    parameter int CLK_FREQ = 100_000_000,
    parameter int I2C_FREQ = 400_000,
    parameter int PWRON_DELAY_CYCLES = 2_000_000, // 20ms @ 100MHz (can be overridden in sim)
    parameter int DEBOUNCE_CYCLES    = 2_000_000, // 20ms debounce for mechanical slider switches
    parameter int CLEAR_PAGES        = 8,
    parameter int CLEAR_COLS         = 128
)(
    input  logic        ipClk,     // 100MHz onboard oscillator (P17)
    input  logic        ipRst_,    // Active-low push-button S6 (P15)
    input  logic [1:0]  ipSw,      // SW0 (R1), SW1 (N4) mode selection
    output logic [7:0]  opLed,     // Status LEDs (K2, J2, J3, H4, J4, G3, G4, F6)

    // OLED I2C Pins
    output logic        oled_scl,  // J5-25 (H14)
    inout  wire         oled_sda   // J5-26 (G14)
);

    // Heartbeat clock divider
    logic [25:0] heartbeat_cnt;
    always_ff @(posedge ipClk or negedge ipRst_) begin
        if (!ipRst_) begin
            heartbeat_cnt <= '0;
        end else begin
            heartbeat_cnt <= heartbeat_cnt + 1'b1;
        end
    end
    wire heartbeat = heartbeat_cnt[25];

    // OLED Controller Interface
    logic        oled_clear;
    logic        oled_wr_en;
    logic [6:0]  oled_col;
    logic [2:0]  oled_row;
    logic [15:0] oled_char;
    logic [1:0]  oled_font_size;
    logic        oled_ready;
    logic        oled_init_done;
    logic        oled_ack_err;

    oled_controller #(
        .CLK_FREQ(CLK_FREQ),
        .I2C_FREQ(I2C_FREQ),
        .PWRON_DELAY_CYCLES(PWRON_DELAY_CYCLES),
        .CLEAR_PAGES(CLEAR_PAGES),
        .CLEAR_COLS(CLEAR_COLS)
    ) u_oled_controller (
        .clk        (ipClk),
        .rst_n      (ipRst_),
        .i_clear    (oled_clear),
        .i_wr_en    (oled_wr_en),
        .i_col      (oled_col),
        .i_row      (oled_row),
        .i_char     (oled_char),
        .i_font_size(oled_font_size),
        .o_ready    (oled_ready),
        .o_init_done(oled_init_done),
        .o_ack_error(oled_ack_err),
        .oled_scl   (oled_scl),
        .oled_sda   (oled_sda)
    );

    // Debounced switch inputs (20ms filter)
    logic [1:0]  sw_sync_0, sw_sync_1, sw_debounced, sw_prev;
    logic [20:0] sw_debounce_cnt;

    always_ff @(posedge ipClk or negedge ipRst_) begin
        if (!ipRst_) begin
            sw_sync_0       <= 2'b00;
            sw_sync_1       <= 2'b00;
            sw_debounced    <= 2'b00;
            sw_prev         <= 2'b00;
            sw_debounce_cnt <= '0;
        end else begin
            sw_sync_0 <= ipSw;
            sw_sync_1 <= sw_sync_0;
            sw_prev   <= sw_debounced;

            if (sw_sync_1 != sw_debounced) begin
                if (sw_debounce_cnt < DEBOUNCE_CYCLES) begin
                    sw_debounce_cnt <= sw_debounce_cnt + 1'b1;
                end else begin
                    sw_debounced    <= sw_sync_1;
                    sw_debounce_cnt <= '0;
                end
            end else begin
                sw_debounce_cnt <= '0;
            end
        end
    end
    wire sw_changed = (sw_debounced != sw_prev);

    // -------------------------------------------------------------
    // Demo Script Definition
    // -------------------------------------------------------------
    // Structure of each step: {font_size[1:0], row[2:0], col[6:0], char[15:0]} = 28 bits
    typedef struct packed {
        logic [1:0]  font;
        logic [2:0]  row;
        logic [6:0]  col;
        logic [15:0] ch;
    } draw_cmd_t;

    // Demo length constants
    localparam int D0_LEN = 53;  // Welcome: EGo1 OLED + info
    localparam int D1_LEN = 22;  // Chinese particle names
    localparam int D2_LEN = 107; // ASCII table in FONT8
    localparam int D3_LEN = 6;   // FONT32 Numbers + Chinese

    logic [7:0] cmd_idx;
    logic [7:0] cmd_max;
    draw_cmd_t  current_cmd;

    // Helper functions for character commands
    function automatic draw_cmd_t make_cmd(input logic [1:0] f, input logic [2:0] r, input logic [6:0] c, input logic [15:0] ch);
        draw_cmd_t cmd;
        cmd.font = f;
        cmd.row  = r;
        cmd.col  = c;
        cmd.ch   = ch;
        return cmd;
    endfunction

    always_comb begin
        current_cmd = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
        cmd_max     = 8'd0;

        case (sw_debounced)
            // ---------------------------------------------------------
            // Demo 0: EGo1 OLED System Info
            // ---------------------------------------------------------
            2'b00: begin
                cmd_max = D0_LEN[7:0];
                case (cmd_idx)
                    // Row 0 (FONT16): "EGo1 OLED" (col 28)
                    8'd0:  current_cmd = make_cmd(2'd1, 3'd0, 7'd28, 16'h0045); // 'E'
                    8'd1:  current_cmd = make_cmd(2'd1, 3'd0, 7'd36, 16'h0047); // 'G'
                    8'd2:  current_cmd = make_cmd(2'd1, 3'd0, 7'd44, 16'h006F); // 'o'
                    8'd3:  current_cmd = make_cmd(2'd1, 3'd0, 7'd52, 16'h0031); // '1'
                    8'd4:  current_cmd = make_cmd(2'd1, 3'd0, 7'd60, 16'h0020); // ' '
                    8'd5:  current_cmd = make_cmd(2'd1, 3'd0, 7'd68, 16'h004F); // 'O'
                    8'd6:  current_cmd = make_cmd(2'd1, 3'd0, 7'd76, 16'h004C); // 'L'
                    8'd7:  current_cmd = make_cmd(2'd1, 3'd0, 7'd84, 16'h0045); // 'E'
                    8'd8:  current_cmd = make_cmd(2'd1, 3'd0, 7'd92, 16'h0044); // 'D'

                    // Row 2 (FONT8): "SSD1306 128x64" (col 22)
                    8'd9:  current_cmd = make_cmd(2'd0, 3'd2, 7'd22, 16'h0053); // 'S'
                    8'd10: current_cmd = make_cmd(2'd0, 3'd2, 7'd28, 16'h0053); // 'S'
                    8'd11: current_cmd = make_cmd(2'd0, 3'd2, 7'd34, 16'h0044); // 'D'
                    8'd12: current_cmd = make_cmd(2'd0, 3'd2, 7'd40, 16'h0031); // '1'
                    8'd13: current_cmd = make_cmd(2'd0, 3'd2, 7'd46, 16'h0033); // '3'
                    8'd14: current_cmd = make_cmd(2'd0, 3'd2, 7'd52, 16'h0030); // '0'
                    8'd15: current_cmd = make_cmd(2'd0, 3'd2, 7'd58, 16'h0036); // '6'
                    8'd16: current_cmd = make_cmd(2'd0, 3'd2, 7'd64, 16'h0020); // ' '
                    8'd17: current_cmd = make_cmd(2'd0, 3'd2, 7'd70, 16'h0031); // '1'
                    8'd18: current_cmd = make_cmd(2'd0, 3'd2, 7'd76, 16'h0032); // '2'
                    8'd19: current_cmd = make_cmd(2'd0, 3'd2, 7'd82, 16'h0038); // '8'
                    8'd20: current_cmd = make_cmd(2'd0, 3'd2, 7'd88, 16'h0078); // 'x'
                    8'd21: current_cmd = make_cmd(2'd0, 3'd2, 7'd94, 16'h0036); // '6'
                    8'd22: current_cmd = make_cmd(2'd0, 3'd2, 7'd100,16'h0034); // '4'

                    // Row 4 (FONT8): "I2C 400kHz Fast" (col 19)
                    8'd23: current_cmd = make_cmd(2'd0, 3'd4, 7'd19, 16'h0049); // 'I'
                    8'd24: current_cmd = make_cmd(2'd0, 3'd4, 7'd25, 16'h0032); // '2'
                    8'd25: current_cmd = make_cmd(2'd0, 3'd4, 7'd31, 16'h0043); // 'C'
                    8'd26: current_cmd = make_cmd(2'd0, 3'd4, 7'd37, 16'h0020); // ' '
                    8'd27: current_cmd = make_cmd(2'd0, 3'd4, 7'd43, 16'h0034); // '4'
                    8'd28: current_cmd = make_cmd(2'd0, 3'd4, 7'd49, 16'h0030); // '0'
                    8'd29: current_cmd = make_cmd(2'd0, 3'd4, 7'd55, 16'h0030); // '0'
                    8'd30: current_cmd = make_cmd(2'd0, 3'd4, 7'd61, 16'h006B); // 'k'
                    8'd31: current_cmd = make_cmd(2'd0, 3'd4, 7'd67, 16'h0048); // 'H'
                    8'd32: current_cmd = make_cmd(2'd0, 3'd4, 7'd73, 16'h007A); // 'z'
                    8'd33: current_cmd = make_cmd(2'd0, 3'd4, 7'd79, 16'h0020); // ' '
                    8'd34: current_cmd = make_cmd(2'd0, 3'd4, 7'd85, 16'h0046); // 'F'
                    8'd35: current_cmd = make_cmd(2'd0, 3'd4, 7'd91, 16'h0061); // 'a'
                    8'd36: current_cmd = make_cmd(2'd0, 3'd4, 7'd97, 16'h0073); // 's'
                    8'd37: current_cmd = make_cmd(2'd0, 3'd4, 7'd103,16'h0074); // 't'

                    // Row 6 (FONT8): "Artix-7 xc7a35t" (col 19)
                    8'd38: current_cmd = make_cmd(2'd0, 3'd6, 7'd19, 16'h0041); // 'A'
                    8'd39: current_cmd = make_cmd(2'd0, 3'd6, 7'd25, 16'h0072); // 'r'
                    8'd40: current_cmd = make_cmd(2'd0, 3'd6, 7'd31, 16'h0074); // 't'
                    8'd41: current_cmd = make_cmd(2'd0, 3'd6, 7'd37, 16'h0069); // 'i'
                    8'd42: current_cmd = make_cmd(2'd0, 3'd6, 7'd43, 16'h0078); // 'x'
                    8'd43: current_cmd = make_cmd(2'd0, 3'd6, 7'd49, 16'h002D); // '-'
                    8'd44: current_cmd = make_cmd(2'd0, 3'd6, 7'd55, 16'h0037); // '7'
                    8'd45: current_cmd = make_cmd(2'd0, 3'd6, 7'd61, 16'h0020); // ' '
                    8'd46: current_cmd = make_cmd(2'd0, 3'd6, 7'd67, 16'h0078); // 'x'
                    8'd47: current_cmd = make_cmd(2'd0, 3'd6, 7'd73, 16'h0063); // 'c'
                    8'd48: current_cmd = make_cmd(2'd0, 3'd6, 7'd79, 16'h0037); // '7'
                    8'd49: current_cmd = make_cmd(2'd0, 3'd6, 7'd85, 16'h0061); // 'a'
                    8'd50: current_cmd = make_cmd(2'd0, 3'd6, 7'd91, 16'h0033); // '3'
                    8'd51: current_cmd = make_cmd(2'd0, 3'd6, 7'd97, 16'h0035); // '5'
                    8'd52: current_cmd = make_cmd(2'd0, 3'd6, 7'd103,16'h0074); // 't'
                    default: current_cmd = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                endcase
            end

            // ---------------------------------------------------------
            // Demo 1: All 10 Chinese Particle Characters in FONT16
            // 0: 小米
            // 1: 玻璃珠
            // 2: 细盐
            // 3: 白砂糖
            // ---------------------------------------------------------
            2'b01: begin
                cmd_max = D1_LEN[7:0];
                case (cmd_idx)
                    // Row 0: "0: 小米"
                    8'd0:  current_cmd = make_cmd(2'd1, 3'd0, 7'd16, 16'h0030); // '0'
                    8'd1:  current_cmd = make_cmd(2'd1, 3'd0, 7'd24, 16'h003A); // ':'
                    8'd2:  current_cmd = make_cmd(2'd1, 3'd0, 7'd32, 16'h0020); // ' '
                    8'd3:  current_cmd = make_cmd(2'd1, 3'd0, 7'd44, 16'h5C0F); // '小'
                    8'd4:  current_cmd = make_cmd(2'd1, 3'd0, 7'd64, 16'h7C73); // '米'

                    // Row 2: "1: 玻璃珠"
                    8'd5:  current_cmd = make_cmd(2'd1, 3'd2, 7'd16, 16'h0031); // '1'
                    8'd6:  current_cmd = make_cmd(2'd1, 3'd2, 7'd24, 16'h003A); // ':'
                    8'd7:  current_cmd = make_cmd(2'd1, 3'd2, 7'd32, 16'h0020); // ' '
                    8'd8:  current_cmd = make_cmd(2'd1, 3'd2, 7'd44, 16'h73BB); // '玻'
                    8'd9:  current_cmd = make_cmd(2'd1, 3'd2, 7'd64, 16'h7483); // '璃'
                    8'd10: current_cmd = make_cmd(2'd1, 3'd2, 7'd84, 16'h73E0); // '珠'

                    // Row 4: "2: 细盐"
                    8'd11: current_cmd = make_cmd(2'd1, 3'd4, 7'd16, 16'h0032); // '2'
                    8'd12: current_cmd = make_cmd(2'd1, 3'd4, 7'd24, 16'h003A); // ':'
                    8'd13: current_cmd = make_cmd(2'd1, 3'd4, 7'd32, 16'h0020); // ' '
                    8'd14: current_cmd = make_cmd(2'd1, 3'd4, 7'd44, 16'h7EC6); // '细'
                    8'd15: current_cmd = make_cmd(2'd1, 3'd4, 7'd64, 16'h76D0); // '盐'

                    // Row 6: "3: 白砂糖"
                    8'd16: current_cmd = make_cmd(2'd1, 3'd6, 7'd16, 16'h0033); // '3'
                    8'd17: current_cmd = make_cmd(2'd1, 3'd6, 7'd24, 16'h003A); // ':'
                    8'd18: current_cmd = make_cmd(2'd1, 3'd6, 7'd32, 16'h0020); // ' '
                    8'd19: current_cmd = make_cmd(2'd1, 3'd6, 7'd44, 16'h767D); // '白'
                    8'd20: current_cmd = make_cmd(2'd1, 3'd6, 7'd64, 16'h7802); // '砂'
                    8'd21: current_cmd = make_cmd(2'd1, 3'd6, 7'd84, 16'h7CD6); // '糖'
                    default: current_cmd = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                endcase
            end

            // ---------------------------------------------------------
            // Demo 2: ASCII Table in FONT8 (0x21 '!' to 0x7E '~')
            // Row 0: "ASCII TABLE:"
            // Rows 1..6: 16 chars per row
            // ---------------------------------------------------------
            2'b10: begin
                cmd_max = D2_LEN[7:0];
                if (cmd_idx < 8'd12) begin
                    // Title "ASCII TABLE:"
                    case (cmd_idx)
                        8'd0:  current_cmd = make_cmd(2'd0, 3'd0, 7'd28, 16'h0041); // 'A'
                        8'd1:  current_cmd = make_cmd(2'd0, 3'd0, 7'd34, 16'h0053); // 'S'
                        8'd2:  current_cmd = make_cmd(2'd0, 3'd0, 7'd40, 16'h0043); // 'C'
                        8'd3:  current_cmd = make_cmd(2'd0, 3'd0, 7'd46, 16'h0049); // 'I'
                        8'd4:  current_cmd = make_cmd(2'd0, 3'd0, 7'd52, 16'h0049); // 'I'
                        8'd5:  current_cmd = make_cmd(2'd0, 3'd0, 7'd58, 16'h0020); // ' '
                        8'd6:  current_cmd = make_cmd(2'd0, 3'd0, 7'd64, 16'h0054); // 'T'
                        8'd7:  current_cmd = make_cmd(2'd0, 3'd0, 7'd70, 16'h0041); // 'A'
                        8'd8:  current_cmd = make_cmd(2'd0, 3'd0, 7'd76, 16'h0042); // 'B'
                        8'd9:  current_cmd = make_cmd(2'd0, 3'd0, 7'd82, 16'h004C); // 'L'
                        8'd10: current_cmd = make_cmd(2'd0, 3'd0, 7'd88, 16'h0045); // 'E'
                        8'd11: current_cmd = make_cmd(2'd0, 3'd0, 7'd94, 16'h003A); // ':'
                        default: current_cmd = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                    endcase
                end else begin
                    // ASCII chars 0x20..0x7E
                    logic [7:0] a_idx;
                    logic [2:0] a_row;
                    logic [3:0] a_col_idx;
                    a_idx     = cmd_idx - 8'd12;
                    a_row     = 3'd1 + (a_idx >> 4);         // 16 chars per row, rows 1..6
                    a_col_idx = a_idx[3:0];                  // column index 0..15
                    current_cmd = make_cmd(2'd0, a_row, {a_col_idx, 3'b000}, {8'h00, 8'h20 + a_idx});
                end
            end

            // ---------------------------------------------------------
            // Demo 3: FONT32 Numbers and Chinese
            // Row 0 (32px): "2026"
            // Row 4 (32px): "小米"
            // ---------------------------------------------------------
            2'b11: begin
                cmd_max = D3_LEN[7:0];
                case (cmd_idx)
                    // FONT32 ASCII: "2026" at row 0 (pages 0..3)
                    8'd0: current_cmd = make_cmd(2'd2, 3'd0, 7'd32, 16'h0032); // '2'
                    8'd1: current_cmd = make_cmd(2'd2, 3'd0, 7'd48, 16'h0030); // '0'
                    8'd2: current_cmd = make_cmd(2'd2, 3'd0, 7'd64, 16'h0032); // '2'
                    8'd3: current_cmd = make_cmd(2'd2, 3'd0, 7'd80, 16'h0036); // '6'

                    // FONT32 Chinese: "小米" at row 4 (pages 4..7)
                    8'd4: current_cmd = make_cmd(2'd2, 3'd4, 7'd32, 16'h5C0F); // '小'
                    8'd5: current_cmd = make_cmd(2'd2, 3'd4, 7'd64, 16'h7C73); // '米'
                    default: current_cmd = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                endcase
            end
        endcase
    end

    // Demo Sequencer FSM
    typedef enum logic [2:0] {
        SEQ_WAIT_INIT = 3'd0,
        SEQ_CLEAR     = 3'd1,
        SEQ_CLEAR_WAIT= 3'd2,
        SEQ_WRITE_CMD = 3'd3,
        SEQ_WRITE_WAIT= 3'd4,
        SEQ_IDLE      = 3'd5
    } seq_state_t;

    seq_state_t seq_state;

    always_ff @(posedge ipClk or negedge ipRst_) begin
        if (!ipRst_) begin
            seq_state      <= SEQ_WAIT_INIT;
            oled_clear     <= 1'b0;
            oled_wr_en     <= 1'b0;
            oled_col       <= '0;
            oled_row       <= '0;
            oled_char      <= '0;
            oled_font_size <= '0;
            cmd_idx        <= '0;
        end else begin
            oled_clear <= 1'b0;
            oled_wr_en <= 1'b0;

            // Any switch toggle triggers a redraw of the new demo!
            if (sw_changed && oled_init_done) begin
                seq_state <= SEQ_CLEAR;
            end else begin
                case (seq_state)
                    SEQ_WAIT_INIT: begin
                        if (oled_init_done && oled_ready) begin
                            seq_state <= SEQ_CLEAR;
                        end
                    end

                    SEQ_CLEAR: begin
                        if (oled_ready) begin
                            oled_clear <= 1'b1;
                            cmd_idx    <= 8'd0;
                            seq_state  <= SEQ_CLEAR_WAIT;
                        end
                    end

                    SEQ_CLEAR_WAIT: begin
                        if (!oled_clear && oled_ready) begin
                            seq_state <= SEQ_WRITE_CMD;
                        end
                    end

                    SEQ_WRITE_CMD: begin
                        if (cmd_idx < cmd_max) begin
                            if (oled_ready) begin
                                oled_wr_en     <= 1'b1;
                                oled_font_size <= current_cmd.font;
                                oled_row       <= current_cmd.row;
                                oled_col       <= current_cmd.col;
                                oled_char      <= current_cmd.ch;
                                seq_state      <= SEQ_WRITE_WAIT;
                            end
                        end else begin
                            seq_state <= SEQ_IDLE; // Finished drawing current demo
                        end
                    end

                    SEQ_WRITE_WAIT: begin
                        if (!oled_wr_en && oled_ready) begin
                            cmd_idx   <= cmd_idx + 1'b1;
                            seq_state <= SEQ_WRITE_CMD;
                        end
                    end

                    SEQ_IDLE: begin
                        // Idle until SW changes
                    end

                    default: seq_state <= SEQ_IDLE;
                endcase
            end
        end
    end

    // Status LED Output Mapping
    assign opLed[0] = oled_init_done;                       // LED0: OLED initialization finished
    assign opLed[1] = oled_ready;                           // LED1: Controller ready
    assign opLed[2] = !oled_ack_err;                        // LED2: I2C ACK OK (lit when no NACK)
    assign opLed[3] = heartbeat;                            // LED3: 1Hz Heartbeat pulse
    assign opLed[4] = sw_debounced[0];                      // LED4: Debounced SW0
    assign opLed[5] = sw_debounced[1];                      // LED5: Debounced SW1
    assign opLed[6] = (seq_state == SEQ_CLEAR_WAIT);        // LED6: Screen clearing in progress
    assign opLed[7] = (seq_state == SEQ_WRITE_WAIT);        // LED7: Writing characters in progress

endmodule
