// ================================================================
// oled_particle_display.sv - Dedicated Bridge Module for project_41
// Connects directly to Neural_network.v outputs:
//   - particle_class[1:0] (0=小米, 1=玻璃珠, 2=细盐, 3=白砂糖)
//   - particle_valid
//   - particle_empty
// ================================================================
`timescale 1ns / 1ps

module oled_particle_display #(
    parameter int CLK_FREQ = 100_000_000,
    parameter int I2C_FREQ = 400_000,
    parameter int PWRON_DELAY_CYCLES = 2_000_000
)(
    input  logic        clk,            // 100MHz
    input  logic        rst_n,

    // Neural Network Result Interface
    input  logic [1:0]  particle_class, // 0=小米, 1=玻璃珠, 2=细盐, 3=白砂糖
    input  logic        particle_valid, // Pulse when nn inference completes
    input  logic        particle_empty, // 1 when no particle detected in frame

    output logic        o_ready,        // Display idle/ready
    output logic        o_init_done,    // OLED initialization finished

    // Physical I2C Bus Pins
    output logic        oled_scl,
    inout  wire         oled_sda
);

    // OLED Controller Interface
    logic        oled_clear;
    logic        oled_wr_en;
    logic [6:0]  oled_col;
    logic [2:0]  oled_row;
    logic [15:0] oled_char;
    logic [1:0]  oled_font_size;
    logic        oled_ctrl_ready;
    logic        oled_ack_err;

    oled_controller #(
        .CLK_FREQ(CLK_FREQ),
        .I2C_FREQ(I2C_FREQ),
        .PWRON_DELAY_CYCLES(PWRON_DELAY_CYCLES)
    ) u_oled_controller (
        .clk        (clk),
        .rst_n      (rst_n),
        .i_clear    (oled_clear),
        .i_wr_en    (oled_wr_en),
        .i_col      (oled_col),
        .i_row      (oled_row),
        .i_char     (oled_char),
        .i_font_size(oled_font_size),
        .o_ready    (oled_ctrl_ready),
        .o_init_done(o_init_done),
        .o_ack_error(oled_ack_err),
        .oled_scl   (oled_scl),
        .oled_sda   (oled_sda)
    );

    // Display Sequencer State Definitions
    typedef enum logic [2:0] {
        DISP_INIT       = 3'd0,
        DISP_CLEAR      = 3'd1,
        DISP_CLEAR_WAIT = 3'd2,
        DISP_STEP       = 3'd3,
        DISP_STEP_WAIT  = 3'd4,
        DISP_IDLE       = 3'd5
    } disp_state_t;

    disp_state_t disp_state;
    logic [4:0]  step_idx;
    logic [4:0]  step_max;

    // Latched classification result (double-buffered to prevent mid-draw glitching)
    logic [1:0] incoming_class, latched_class;
    logic       incoming_empty, latched_empty;
    logic       update_pending;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            incoming_class <= 2'b00;
            incoming_empty <= 1'b1;
            latched_class  <= 2'b00;
            latched_empty  <= 1'b1; // Default empty on boot
            update_pending <= 1'b1; // Initial draw on boot
        end else begin
            if (particle_valid) begin
                incoming_class <= particle_class;
                incoming_empty <= particle_empty;
                update_pending <= 1'b1;
            end

            if (disp_state == DISP_CLEAR && oled_ctrl_ready) begin
                latched_class  <= incoming_class;
                latched_empty  <= incoming_empty;
                update_pending <= 1'b0;
            end
        end
    end

    // Character drawing command structure
    typedef struct packed {
        logic [1:0]  font;
        logic [2:0]  row;
        logic [6:0]  col;
        logic [15:0] ch;
    } draw_cmd_t;

    draw_cmd_t current_step;

    function automatic draw_cmd_t make_cmd(input logic [1:0] f, input logic [2:0] r, input logic [6:0] c, input logic [15:0] ch);
        draw_cmd_t cmd;
        cmd.font = f;
        cmd.row  = r;
        cmd.col  = c;
        cmd.ch   = ch;
        return cmd;
    endfunction

    always_comb begin
        current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
        step_max     = 5'd0;

        if (latched_empty) begin
            // "No Particle"
            step_max = 5'd11;
            case (step_idx)
                5'd0:  current_step = make_cmd(2'd1, 3'd2, 7'd16, 16'h004E); // 'N'
                5'd1:  current_step = make_cmd(2'd1, 3'd2, 7'd24, 16'h006F); // 'o'
                5'd2:  current_step = make_cmd(2'd1, 3'd2, 7'd32, 16'h0020); // ' '
                5'd3:  current_step = make_cmd(2'd1, 3'd2, 7'd40, 16'h0050); // 'P'
                5'd4:  current_step = make_cmd(2'd1, 3'd2, 7'd48, 16'h0061); // 'a'
                5'd5:  current_step = make_cmd(2'd1, 3'd2, 7'd56, 16'h0072); // 'r'
                5'd6:  current_step = make_cmd(2'd1, 3'd2, 7'd64, 16'h0074); // 't'
                5'd7:  current_step = make_cmd(2'd1, 3'd2, 7'd72, 16'h0069); // 'i'
                5'd8:  current_step = make_cmd(2'd1, 3'd2, 7'd80, 16'h0063); // 'c'
                5'd9:  current_step = make_cmd(2'd1, 3'd2, 7'd88, 16'h006C); // 'l'
                5'd10: current_step = make_cmd(2'd1, 3'd2, 7'd96, 16'h0065); // 'e'
                default: current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
            endcase
        end else begin
            case (latched_class)
                // Class 0: 小米
                2'b00: begin
                    step_max = 5'd2;
                    case (step_idx)
                        5'd0: current_step = make_cmd(2'd1, 3'd2, 7'd48, 16'h5C0F); // '小'
                        5'd1: current_step = make_cmd(2'd1, 3'd2, 7'd64, 16'h7C73); // '米'
                        default: current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                    endcase
                end

                // Class 1: 玻璃珠
                2'b01: begin
                    step_max = 5'd3;
                    case (step_idx)
                        5'd0: current_step = make_cmd(2'd1, 3'd2, 7'd40, 16'h73BB); // '玻'
                        5'd1: current_step = make_cmd(2'd1, 3'd2, 7'd56, 16'h7483); // '璃'
                        5'd2: current_step = make_cmd(2'd1, 3'd2, 7'd72, 16'h73E0); // '珠'
                        default: current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                    endcase
                end

                // Class 2: 细盐
                2'b10: begin
                    step_max = 5'd2;
                    case (step_idx)
                        5'd0: current_step = make_cmd(2'd1, 3'd2, 7'd48, 16'h7EC6); // '细'
                        5'd1: current_step = make_cmd(2'd1, 3'd2, 7'd64, 16'h76D0); // '盐'
                        default: current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                    endcase
                end

                // Class 3: 白砂糖
                2'b11: begin
                    step_max = 5'd3;
                    case (step_idx)
                        5'd0: current_step = make_cmd(2'd1, 3'd2, 7'd40, 16'h767D); // '白'
                        5'd1: current_step = make_cmd(2'd1, 3'd2, 7'd56, 16'h7802); // '砂'
                        5'd2: current_step = make_cmd(2'd1, 3'd2, 7'd72, 16'h7CD6); // '糖'
                        default: current_step = make_cmd(2'd0, 3'd0, 7'd0, 16'h0020);
                    endcase
                end
            endcase
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            disp_state     <= DISP_INIT;
            oled_clear     <= 1'b0;
            oled_wr_en     <= 1'b0;
            oled_col       <= '0;
            oled_row       <= '0;
            oled_char      <= '0;
            oled_font_size <= '0;
            step_idx       <= '0;
        end else begin
            oled_clear <= 1'b0;
            oled_wr_en <= 1'b0;

            case (disp_state)
                DISP_INIT: begin
                    if (o_init_done && oled_ctrl_ready) begin
                        disp_state <= DISP_CLEAR;
                    end
                end

                DISP_CLEAR: begin
                    if (oled_ctrl_ready) begin
                        oled_clear <= 1'b1;
                        step_idx   <= 5'd0;
                        disp_state <= DISP_CLEAR_WAIT;
                    end
                end

                DISP_CLEAR_WAIT: begin
                    if (!oled_clear && oled_ctrl_ready) begin
                        disp_state <= DISP_STEP;
                    end
                end

                DISP_STEP: begin
                    if (step_idx < step_max) begin
                        if (oled_ctrl_ready) begin
                            oled_wr_en     <= 1'b1;
                            oled_font_size <= current_step.font;
                            oled_row       <= current_step.row;
                            oled_col       <= current_step.col;
                            oled_char      <= current_step.ch;
                            disp_state     <= DISP_STEP_WAIT;
                        end
                    end else begin
                        disp_state <= DISP_IDLE;
                    end
                end

                DISP_STEP_WAIT: begin
                    if (!oled_wr_en && oled_ctrl_ready) begin
                        step_idx   <= step_idx + 1'b1;
                        disp_state <= DISP_STEP;
                    end
                end

                DISP_IDLE: begin
                    if (update_pending) begin
                        disp_state <= DISP_CLEAR;
                    end
                end

                default: disp_state <= DISP_IDLE;
            endcase
        end
    end

    assign o_ready = (disp_state == DISP_IDLE) && oled_ctrl_ready;

endmodule
