// ================================================================
// oled_controller.sv - High-level OLED Display Controller
// Manages font selection (FONT8/16/32), multi-page character rendering,
// and SSD1306 coordinate mapping.
// ================================================================
`timescale 1ns / 1ps

module oled_controller #(
    parameter int CLK_FREQ = 100_000_000,
    parameter int I2C_FREQ = 400_000,
    parameter int PWRON_DELAY_CYCLES = 2_000_000,
    parameter int CLEAR_PAGES = 8,
    parameter int CLEAR_COLS = 128
)(
    input  logic        clk,            // 100MHz
    input  logic        rst_n,

    // User Command Interface
    input  logic        i_clear,        // Pulse high to clear screen
    input  logic        i_wr_en,        // Pulse high to write character
    input  logic [6:0]  i_col,          // Starting pixel column (0..127)
    input  logic [2:0]  i_row,          // Starting page row (0..7)
    input  logic [15:0] i_char,         // Character (ASCII 0x0020..0x007E or Chinese Unicode)
    input  logic [1:0]  i_font_size,    // 0=FONT8, 1=FONT16, 2=FONT32

    output logic        o_ready,        // 1: controller idle and ready for next command
    output logic        o_init_done,    // 1: SSD1306 power-on sequence completed
    output logic        o_ack_error,    // 1: any I2C NACK error detected

    // Physical I2C Bus Pins
    output logic        oled_scl,
    inout  wire         oled_sda
);

    // Font ROM Connections
    logic [15:0] rom_char;
    logic [4:0]  rom_col_idx;
    logic [1:0]  rom_page_idx;

    // FONT8 ROM
    logic [7:0]  font8_dot;
    logic [4:0]  font8_width;
    font_rom_8 u_font8 (
        .clk         (clk),
        .i_char      (rom_char),
        .i_col_idx   (rom_col_idx[3:0]),
        .o_dot_data  (font8_dot),
        .o_char_width(font8_width)
    );

    // FONT16 ROM
    logic [7:0]  font16_dot;
    logic [4:0]  font16_width;
    font_rom_16 u_font16 (
        .clk         (clk),
        .i_char      (rom_char),
        .i_page_idx  (rom_page_idx[0]),
        .i_col_idx   (rom_col_idx[3:0]),
        .o_dot_data  (font16_dot),
        .o_char_width(font16_width)
    );

    // FONT32 ROM
    logic [7:0]  font32_dot;
    logic [5:0]  font32_width;
    font_rom_32 u_font32 (
        .clk         (clk),
        .i_char      (rom_char),
        .i_page_idx  (rom_page_idx[1:0]),
        .i_col_idx   (rom_col_idx[4:0]),
        .o_dot_data  (font32_dot),
        .o_char_width(font32_width)
    );

    // SSD1306 Controller Interface
    logic        ctrl_clear;
    logic        ctrl_set_pos;
    logic [2:0]  ctrl_page;
    logic [6:0]  ctrl_col;
    logic        ctrl_write_data;
    logic [7:0]  ctrl_data;
    logic        ctrl_data_last;
    logic        ctrl_ready;

    ssd1306_ctrl #(
        .CLK_FREQ(CLK_FREQ),
        .I2C_FREQ(I2C_FREQ),
        .PWRON_DELAY_CYCLES(PWRON_DELAY_CYCLES),
        .CLEAR_PAGES(CLEAR_PAGES),
        .CLEAR_COLS(CLEAR_COLS)
    ) u_ssd1306 (
        .clk         (clk),
        .rst_n       (rst_n),
        .i_clear     (ctrl_clear),
        .i_set_pos   (ctrl_set_pos),
        .i_page      (ctrl_page),
        .i_col       (ctrl_col),
        .i_write_data(ctrl_write_data),
        .i_data      (ctrl_data),
        .i_data_last (ctrl_data_last),
        .o_ready     (ctrl_ready),
        .o_init_done (o_init_done),
        .o_ack_error (o_ack_error),
        .oled_scl    (oled_scl),
        .oled_sda    (oled_sda)
    );

    // Latched command parameters
    logic [6:0]  latched_col;
    logic [2:0]  latched_row;
    logic [15:0] latched_char;
    logic [1:0]  latched_font;
    logic [2:0]  page_offset;
    logic [5:0]  col_counter;

    // Active font attributes
    logic [7:0] current_dot;
    logic [5:0] current_width;
    logic [2:0] total_pages;

    always_comb begin
        case (latched_font)
            2'd0: begin // FONT8
                current_dot   = font8_dot;
                current_width = {1'b0, font8_width};
                total_pages   = 3'd1;
            end
            2'd1: begin // FONT16
                current_dot   = font16_dot;
                current_width = {1'b0, font16_width};
                total_pages   = 3'd2;
            end
            2'd2: begin // FONT32
                current_dot   = font32_dot;
                current_width = font32_width;
                total_pages   = 3'd4;
            end
            default: begin
                current_dot   = font16_dot;
                current_width = {1'b0, font16_width};
                total_pages   = 3'd2;
            end
        endcase
    end

    // FSM States
    typedef enum logic [2:0] {
        ST_IDLE         = 3'd0,
        ST_CLEAR        = 3'd1,
        ST_SETPOS_TRIG  = 3'd2,
        ST_SETPOS_WAIT  = 3'd3,
        ST_FETCH_WAIT   = 3'd4,
        ST_STREAM_BYTE  = 3'd5,
        ST_STREAM_WAIT  = 3'd6
    } state_t;

    state_t state;

    assign rom_char     = latched_char;
    assign rom_page_idx = page_offset[1:0];
    assign rom_col_idx  = col_counter[4:0];
    assign o_ready      = (state == ST_IDLE) && o_init_done && ctrl_ready;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state           <= ST_IDLE;
            ctrl_clear      <= 1'b0;
            ctrl_set_pos    <= 1'b0;
            ctrl_page       <= '0;
            ctrl_col        <= '0;
            ctrl_write_data <= 1'b0;
            ctrl_data       <= '0;
            ctrl_data_last  <= 1'b0;
            latched_col     <= '0;
            latched_row     <= '0;
            latched_char    <= '0;
            latched_font    <= '0;
            page_offset     <= '0;
            col_counter     <= '0;
        end else begin
            ctrl_clear      <= 1'b0;
            ctrl_set_pos    <= 1'b0;
            ctrl_write_data <= 1'b0;

            case (state)
                ST_IDLE: begin
                    if (o_init_done && ctrl_ready) begin
                        if (i_clear) begin
                            ctrl_clear <= 1'b1;
                            state      <= ST_CLEAR;
                        end else if (i_wr_en) begin
                            latched_col  <= i_col;
                            latched_row  <= i_row;
                            latched_char <= i_char;
                            latched_font <= i_font_size;
                            page_offset  <= 3'd0;
                            col_counter  <= 6'd0;
                            state        <= ST_SETPOS_TRIG;
                        end
                    end
                end

                ST_CLEAR: begin
                    // Wait for screen clear to finish
                    if (ctrl_ready && !ctrl_clear) begin
                        state <= ST_IDLE;
                    end
                end

                ST_SETPOS_TRIG: begin
                    if (ctrl_ready) begin
                        ctrl_set_pos <= 1'b1;
                        ctrl_page    <= latched_row + page_offset;
                        ctrl_col     <= latched_col;
                        col_counter  <= 6'd0;
                        state        <= ST_SETPOS_WAIT;
                    end
                end

                ST_SETPOS_WAIT: begin
                    // Wait until ssd1306_ctrl accepts the set_pos command and finishes
                    if (!ctrl_set_pos && ctrl_ready) begin
                        state <= ST_FETCH_WAIT;
                    end
                end

                ST_FETCH_WAIT: begin
                    // 1 cycle wait for font ROM synchronous read
                    state <= ST_STREAM_BYTE;
                end

                ST_STREAM_BYTE: begin
                    if (ctrl_ready) begin
                        ctrl_write_data <= 1'b1;
                        ctrl_data       <= current_dot;
                        ctrl_data_last  <= (col_counter == current_width - 1'b1);
                        state           <= ST_STREAM_WAIT;
                    end
                end

                ST_STREAM_WAIT: begin
                    if (!ctrl_write_data && ctrl_ready) begin
                        if (col_counter < current_width - 1'b1) begin
                            col_counter <= col_counter + 1'b1;
                            state       <= ST_FETCH_WAIT; // Fetch next column byte
                        end else begin
                            // Current page completed
                            if (page_offset < total_pages - 1'b1) begin
                                page_offset <= page_offset + 1'b1;
                                state       <= ST_SETPOS_TRIG; // Next page
                            end else begin
                                // All pages of character completed!
                                state <= ST_IDLE;
                            end
                        end
                    end
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule
