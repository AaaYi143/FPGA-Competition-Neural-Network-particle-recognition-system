// ================================================================
// ssd1306_ctrl.sv - SSD1306 OLED Command & Initialization Controller
// Manages power-on sequence, page addressing mode, and GDDRAM streaming
// ================================================================
`timescale 1ns / 1ps

module ssd1306_ctrl #(
    parameter int CLK_FREQ = 100_000_000,
    parameter int I2C_FREQ = 400_000,
    parameter int PWRON_DELAY_CYCLES = 2_000_000, // 20ms @ 100MHz (reduced in sim)
    parameter int CLEAR_PAGES = 8,
    parameter int CLEAR_COLS = 128
)(
    input  logic        clk,
    input  logic        rst_n,

    // High-Level User Commands
    input  logic        i_clear,       // Pulse high to clear all 8 pages
    input  logic        i_set_pos,     // Pulse high to set page and column
    input  logic [2:0]  i_page,        // Page (0..7)
    input  logic [6:0]  i_col,         // Column (0..127)
    input  logic        i_write_data,  // Pulse high to write a data byte
    input  logic [7:0]  i_data,        // Data byte (vertical 8-pixels)
    input  logic        i_data_last,   // 1 if this is the last byte in current stream

    output logic        o_ready,       // 1: ready for next high-level command
    output logic        o_init_done,   // 1: power-on init and initial clear completed
    output logic        o_ack_error,   // Sticky 1 if any I2C NACK occurred

    // Physical I2C Pins (passed to internal i2c_master)
    output logic        oled_scl,
    inout  wire         oled_sda
);

    // I2C Master Interface
    logic        i2c_start;
    logic [7:0]  i2c_data;
    logic        i2c_is_last;
    logic        i2c_ready;
    logic        i2c_done;
    logic        i2c_ack;

    i2c_master #(
        .CLK_FREQ(CLK_FREQ),
        .I2C_FREQ(I2C_FREQ)
    ) u_i2c_master (
        .clk        (clk),
        .rst_n      (rst_n),
        .i_start    (i2c_start),
        .i_dev_addr (8'h78),
        .i_data     (i2c_data),
        .i_is_last  (i2c_is_last),
        .o_ready    (i2c_ready),
        .o_done     (i2c_done),
        .o_ack      (i2c_ack),
        .o_scl      (oled_scl),
        .io_sda     (oled_sda)
    );

    // 25-byte SSD1306 Initialization sequence (Page Addressing Mode)
    localparam int INIT_LEN = 25;
    logic [7:0] init_rom [0:INIT_LEN-1];
    initial begin
        init_rom[0]  = 8'hAE; // Display OFF
        init_rom[1]  = 8'hD5; // Set Display Clock Divide Ratio
        init_rom[2]  = 8'h80; // Suggested ratio 0x80
        init_rom[3]  = 8'hA8; // Set Multiplex Ratio
        init_rom[4]  = 8'h3F; // 64 MUX (128x64)
        init_rom[5]  = 8'hD3; // Set Display Offset
        init_rom[6]  = 8'h00; // 0 Offset
        init_rom[7]  = 8'h40; // Set Display Start Line 0
        init_rom[8]  = 8'h8D; // Charge Pump Setting
        init_rom[9]  = 8'h14; // Enable Charge Pump (7.5V)
        init_rom[10] = 8'h20; // Set Memory Addressing Mode
        init_rom[11] = 8'h02; // Page Addressing Mode (0x02)
        init_rom[12] = 8'hA1; // Set Segment Re-map (0xA1 = column 127 mapped to SEG0)
        init_rom[13] = 8'hC8; // Set COM Output Scan Direction (remapped mode)
        init_rom[14] = 8'hDA; // Set COM Pins Hardware Config
        init_rom[15] = 8'h12; // Alternative COM config
        init_rom[16] = 8'h81; // Set Contrast Control
        init_rom[17] = 8'hCF; // Contrast value 0xCF
        init_rom[18] = 8'hD9; // Set Pre-charge Period
        init_rom[19] = 8'hF1; // Phase 1: 1 DCLK, Phase 2: 15 DCLK
        init_rom[20] = 8'hDB; // Set VCOMH Deselect Level
        init_rom[21] = 8'h40; // ~0.77 x VCC
        init_rom[22] = 8'hA4; // Entire Display ON (Resume to RAM)
        init_rom[23] = 8'hA6; // Normal Display (1=ON, 0=OFF)
        init_rom[24] = 8'hAF; // Display ON!
    end

    // FSM States
    typedef enum logic [3:0] {
        ST_PWRON_DELAY        = 4'd0,
        ST_INIT_START         = 4'd1,
        ST_INIT_BYTE          = 4'd2,
        ST_READY              = 4'd3,
        ST_CLEAR_SETPOS_START = 4'd4,
        ST_CLEAR_SETPOS_BYTE  = 4'd5,
        ST_CLEAR_DATA_START   = 4'd6,
        ST_CLEAR_DATA_STREAM  = 4'd7,
        ST_SETPOS_START       = 4'd8,
        ST_SETPOS_BYTE        = 4'd9,
        ST_DATA_START         = 4'd10,
        ST_DATA_START_STREAM  = 4'd11,
        ST_DATA_CONT          = 4'd12,
        ST_DATA_CONT_WAIT     = 4'd13
    } state_t;

    state_t state;

    // Registers
    logic [31:0] delay_cnt;
    logic [4:0]  init_idx;
    logic [2:0]  clr_page;
    logic [6:0]  clr_col;
    logic [2:0]  pos_step;
    logic [1:0]  data_step;
    logic [2:0]  latched_page;
    logic [6:0]  latched_col;
    logic [7:0]  latched_data;
    logic        latched_last;
    logic        stream_active;
    logic        init_done_reg;
    logic        ack_err_reg;

    assign o_init_done = init_done_reg;
    assign o_ack_error = ack_err_reg;
    assign o_ready     = (state == ST_READY);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= ST_PWRON_DELAY;
            delay_cnt     <= '0;
            init_idx      <= '0;
            clr_page      <= '0;
            clr_col       <= '0;
            pos_step      <= '0;
            data_step     <= '0;
            latched_page  <= '0;
            latched_col   <= '0;
            latched_data  <= '0;
            latched_last  <= '0;
            stream_active <= 1'b0;
            init_done_reg <= 1'b0;
            ack_err_reg   <= 1'b0;
            i2c_start     <= 1'b0;
            i2c_data      <= 8'h00;
            i2c_is_last   <= 1'b0;
        end else begin
            i2c_start <= 1'b0; // Default pulse low

            // Record any NACK error
            if (i2c_done && i2c_ack) begin
                ack_err_reg <= 1'b1;
            end

            case (state)
                // -------------------------------------------------------------
                // 1. Power-on reset delay (~20ms)
                // -------------------------------------------------------------
                ST_PWRON_DELAY: begin
                    if (delay_cnt < PWRON_DELAY_CYCLES) begin
                        delay_cnt <= delay_cnt + 1'b1;
                    end else begin
                        delay_cnt <= '0;
                        state     <= ST_INIT_START;
                    end
                end

                // -------------------------------------------------------------
                // 2. Send 25-byte Initialization sequence
                // Packet: [START, 0x78], [0x00], [cmd 0], ..., [cmd 24, STOP]
                // -------------------------------------------------------------
                ST_INIT_START: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= 8'h78; // Device Address
                        i2c_is_last <= 1'b0;
                        init_idx    <= 5'd0;
                        state       <= ST_INIT_BYTE;
                    end
                end

                ST_INIT_BYTE: begin
                    if (i2c_done) begin
                        if (init_idx == 5'd0) begin
                            // Control byte: 0x00 (Command stream)
                            i2c_start   <= 1'b1;
                            i2c_data    <= 8'h00;
                            i2c_is_last <= 1'b0;
                            init_idx    <= 5'd1;
                        end else if (init_idx <= INIT_LEN) begin
                            // Command bytes: init_rom[init_idx - 1]
                            i2c_start   <= 1'b1;
                            i2c_data    <= init_rom[init_idx - 1];
                            i2c_is_last <= (init_idx == INIT_LEN);
                            init_idx    <= init_idx + 1'b1;
                        end else begin
                            // Init STOP has completed -> start screen clear
                            clr_page <= 3'd0;
                            state    <= ST_CLEAR_SETPOS_START;
                        end
                    end
                end

                // -------------------------------------------------------------
                // 3. Clear Screen: Set Page & Col 0
                // -------------------------------------------------------------
                ST_CLEAR_SETPOS_START: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= 8'h78;
                        i2c_is_last <= 1'b0;
                        pos_step    <= 3'd0;
                        state       <= ST_CLEAR_SETPOS_BYTE;
                    end
                end

                ST_CLEAR_SETPOS_BYTE: begin
                    if (i2c_done) begin
                        case (pos_step)
                            3'd0: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h00; // Command stream
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd1;
                            end
                            3'd1: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= {5'b10110, clr_page}; // Set Page (0xB0..0xB7)
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd2;
                            end
                            3'd2: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h00; // Col low = 0
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd3;
                            end
                            3'd3: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h10; // Col high = 0 (with STOP)
                                i2c_is_last <= 1'b1;
                                pos_step    <= 3'd4;
                            end
                            3'd4: begin
                                // STOP completed -> proceed to clear data stream
                                state <= ST_CLEAR_DATA_START;
                            end
                            default: state <= ST_CLEAR_DATA_START;
                        endcase
                    end
                end

                // -------------------------------------------------------------
                // 4. Clear Screen: Stream 128 zeros
                // -------------------------------------------------------------
                ST_CLEAR_DATA_START: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= 8'h78;
                        i2c_is_last <= 1'b0;
                        clr_col     <= 7'd0;
                        data_step   <= 2'd0;
                        state       <= ST_CLEAR_DATA_STREAM;
                    end
                end

                ST_CLEAR_DATA_STREAM: begin
                    if (i2c_done) begin
                        case (data_step)
                            2'd0: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h40; // GDDRAM data stream control byte
                                i2c_is_last <= 1'b0;
                                data_step   <= 2'd1;
                            end
                            2'd1: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h00; // Clear byte
                                i2c_is_last <= (clr_col == CLEAR_COLS - 1);
                                if (clr_col < CLEAR_COLS - 1) begin
                                    clr_col <= clr_col + 1'b1;
                                end else begin
                                    data_step <= 2'd2; // All bytes queued, wait for STOP
                                end
                            end
                            2'd2: begin
                                // STOP completed
                                if (clr_page < CLEAR_PAGES - 1) begin
                                    clr_page <= clr_page + 1'b1;
                                    state    <= ST_CLEAR_SETPOS_START;
                                end else begin
                                    init_done_reg <= 1'b1;
                                    state         <= ST_READY;
                                end
                            end
                            default: state <= ST_READY;
                        endcase
                    end
                end

                // -------------------------------------------------------------
                // 5. IDLE / READY for external commands
                // -------------------------------------------------------------
                ST_READY: begin
                    if (i_clear) begin
                        clr_page      <= 3'd0;
                        stream_active <= 1'b0;
                        state         <= ST_CLEAR_SETPOS_START;
                    end else if (i_set_pos) begin
                        latched_page  <= i_page;
                        latched_col   <= i_col;
                        stream_active <= 1'b0;
                        state         <= ST_SETPOS_START;
                    end else if (i_write_data) begin
                        latched_data <= i_data;
                        latched_last <= i_data_last;
                        if (!stream_active) begin
                            state <= ST_DATA_START;
                        end else begin
                            state <= ST_DATA_CONT;
                        end
                    end
                end

                // -------------------------------------------------------------
                // 6. SET POSITION (Page & Column)
                // -------------------------------------------------------------
                ST_SETPOS_START: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= 8'h78;
                        i2c_is_last <= 1'b0;
                        pos_step    <= 3'd0;
                        state       <= ST_SETPOS_BYTE;
                    end
                end

                ST_SETPOS_BYTE: begin
                    if (i2c_done) begin
                        case (pos_step)
                            3'd0: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h00; // Command stream
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd1;
                            end
                            3'd1: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= {5'b10110, latched_page}; // Set Page (0xB0..0xB7)
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd2;
                            end
                            3'd2: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= {4'b0000, latched_col[3:0]}; // Column lower nibble
                                i2c_is_last <= 1'b0;
                                pos_step    <= 3'd3;
                            end
                            3'd3: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= {4'b0001, 1'b0, latched_col[6:4]}; // Column higher nibble
                                i2c_is_last <= 1'b1; // STOP
                                pos_step    <= 3'd4;
                            end
                            3'd4: begin
                                // STOP completed -> position is set
                                state <= ST_READY;
                            end
                            default: state <= ST_READY;
                        endcase
                    end
                end

                // -------------------------------------------------------------
                // 7. WRITE DATA STREAM
                // Start new stream: [START, 0x78], [0x40], [data_byte]
                // -------------------------------------------------------------
                ST_DATA_START: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= 8'h78;
                        i2c_is_last <= 1'b0;
                        data_step   <= 2'd0;
                        state       <= ST_DATA_START_STREAM;
                    end
                end

                ST_DATA_START_STREAM: begin
                    if (i2c_done) begin
                        case (data_step)
                            2'd0: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= 8'h40; // Data stream control byte
                                i2c_is_last <= 1'b0;
                                data_step   <= 2'd1;
                            end
                            2'd1: begin
                                i2c_start   <= 1'b1;
                                i2c_data    <= latched_data;
                                i2c_is_last <= latched_last;
                                if (!latched_last) begin
                                    data_step <= 2'd2; // Non-last, wait for byte in ST_HOLD
                                end else begin
                                    data_step <= 2'd3; // Last, wait for STOP in ST_IDLE
                                end
                            end
                            2'd2: begin
                                stream_active <= 1'b1;
                                state         <= ST_READY;
                            end
                            2'd3: begin
                                stream_active <= 1'b0;
                                state         <= ST_READY;
                            end
                            default: begin
                                stream_active <= 1'b0;
                                state         <= ST_READY;
                            end
                        endcase
                    end
                end

                // Continue existing stream directly
                ST_DATA_CONT: begin
                    if (i2c_ready) begin
                        i2c_start   <= 1'b1;
                        i2c_data    <= latched_data;
                        i2c_is_last <= latched_last;
                        state       <= ST_DATA_CONT_WAIT;
                    end
                end

                ST_DATA_CONT_WAIT: begin
                    if (i2c_done) begin
                        if (!latched_last) begin
                            stream_active <= 1'b1;
                            state         <= ST_READY;
                        end else begin
                            stream_active <= 1'b0;
                            state         <= ST_READY;
                        end
                    end
                end

                default: state <= ST_READY;
            endcase
        end
    end

endmodule
