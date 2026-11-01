// ================================================================
// i2c_master.sv - 400kHz I2C Master with Open-Drain SDA & Tri-state
// Compatible with Xilinx Artix-7 (xc7a35tcsg324-1)
// ================================================================
`timescale 1ns / 1ps

module i2c_master #(
    parameter int CLK_FREQ = 100_000_000,
    parameter int I2C_FREQ = 400_000
)(
    input  logic        clk,
    input  logic        rst_n,

    // Control Interface
    input  logic        i_start,     // Pulse high for 1 clock to send next byte
    input  logic [7:0]  i_dev_addr,  // Optional device address (default 8'h78)
    input  logic [7:0]  i_data,      // Byte to transmit
    input  logic        i_is_last,   // 1: generate STOP condition after this byte

    output logic        o_ready,     // 1: idle or waiting for next byte
    output logic        o_done,      // 1-cycle pulse on byte/stop completion
    output logic        o_ack,       // ACK bit sampled (0=ACK, 1=NACK)

    // Physical I2C Bus
    output logic        o_scl,
    inout  wire         io_sda
);

    // Number of clock cycles per quarter and full bit period
    localparam int CYCLES_PER_BIT     = CLK_FREQ / I2C_FREQ;          // 250 cycles @ 100MHz / 400kHz
    localparam int CYCLES_QUARTER     = CYCLES_PER_BIT / 4;           // 62 cycles
    localparam int CYCLES_HALF        = CYCLES_PER_BIT / 2;           // 125 cycles
    localparam int CYCLES_THREE_QUART = CYCLES_PER_BIT * 3 / 4;       // 187 cycles

    // FSM States
    typedef enum logic [2:0] {
        ST_IDLE      = 3'd0,
        ST_START     = 3'd1,
        ST_DATA      = 3'd2,
        ST_ACK       = 3'd3,
        ST_STOP      = 3'd4,
        ST_HOLD      = 3'd5
    } state_t;

    state_t state, state_next;

    // Registers
    logic [15:0] clk_cnt;
    logic [2:0]  bit_cnt;
    logic [7:0]  tx_shift;
    logic        is_last_reg;
    logic        scl_reg;
    logic        sda_reg;
    logic        ack_reg;
    logic        done_pulse;

    // Open-drain SDA output: drive 0 or release (high-Z)
    assign io_sda = sda_reg ? 1'bz : 1'b0;
    assign o_scl  = scl_reg;
    assign o_ack  = ack_reg;
    assign o_done = done_pulse;
    assign o_ready = (state == ST_IDLE) || (state == ST_HOLD);

    // Main FSM
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= ST_IDLE;
            clk_cnt     <= '0;
            bit_cnt     <= 3'd7;
            tx_shift    <= 8'h00;
            is_last_reg <= 1'b0;
            scl_reg     <= 1'b1;
            sda_reg     <= 1'b1;
            ack_reg     <= 1'b0;
            done_pulse  <= 1'b0;
        end else begin
            done_pulse <= 1'b0; // Default pulse low

            case (state)
                ST_IDLE: begin
                    scl_reg <= 1'b1;
                    sda_reg <= 1'b1;
                    clk_cnt <= '0;
                    if (i_start) begin
                        tx_shift    <= i_data;
                        is_last_reg <= i_is_last;
                        bit_cnt     <= 3'd7;
                        state       <= ST_START;
                    end
                end

                ST_START: begin
                    // Generate START: SDA falls while SCL is high
                    if (clk_cnt < CYCLES_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                        if (clk_cnt < CYCLES_QUARTER) begin
                            scl_reg <= 1'b1;
                            sda_reg <= 1'b1;
                        end else if (clk_cnt < CYCLES_THREE_QUART) begin
                            scl_reg <= 1'b1;
                            sda_reg <= 1'b0; // START condition!
                        end else begin
                            scl_reg <= 1'b0; // SCL falls
                            sda_reg <= 1'b0;
                        end
                    end else begin
                        clk_cnt <= '0;
                        state   <= ST_DATA;
                    end
                end

                ST_DATA: begin
                    // Transmit 1 bit (MSB first)
                    if (clk_cnt < CYCLES_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                        if (clk_cnt < CYCLES_QUARTER) begin
                            scl_reg <= 1'b0;
                            sda_reg <= tx_shift[7]; // Set SDA while SCL is low
                        end else if (clk_cnt < CYCLES_THREE_QUART) begin
                            scl_reg <= 1'b1;        // SCL high, data stable
                        end else begin
                            scl_reg <= 1'b0;        // SCL falls
                        end
                    end else begin
                        clk_cnt <= '0;
                        if (bit_cnt > 0) begin
                            bit_cnt  <= bit_cnt - 1'b1;
                            tx_shift <= {tx_shift[6:0], 1'b0};
                        end else begin
                            state <= ST_ACK;
                        end
                    end
                end

                ST_ACK: begin
                    // Sample ACK on 9th clock
                    if (clk_cnt < CYCLES_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                        if (clk_cnt < CYCLES_QUARTER) begin
                            scl_reg <= 1'b0;
                            sda_reg <= 1'b1; // Release SDA to read ACK
                        end else if (clk_cnt == CYCLES_HALF) begin
                            scl_reg <= 1'b1;
                            ack_reg <= io_sda; // Sample ACK from slave (0=ACK, 1=NACK)
                        end else if (clk_cnt < CYCLES_THREE_QUART) begin
                            scl_reg <= 1'b1;
                        end else begin
                            scl_reg <= 1'b0;
                        end
                    end else begin
                        clk_cnt <= '0;
                        if (is_last_reg) begin
                            state <= ST_STOP;
                        end else begin
                            done_pulse <= 1'b1; // Byte finished
                            state      <= ST_HOLD;
                        end
                    end
                end

                ST_STOP: begin
                    // Generate STOP: SDA rises while SCL is high
                    if (clk_cnt < CYCLES_PER_BIT - 1) begin
                        clk_cnt <= clk_cnt + 1'b1;
                        if (clk_cnt < CYCLES_QUARTER) begin
                            scl_reg <= 1'b0;
                            sda_reg <= 1'b0;
                        end else if (clk_cnt < CYCLES_HALF) begin
                            scl_reg <= 1'b1;
                            sda_reg <= 1'b0;
                        end else begin
                            scl_reg <= 1'b1;
                            sda_reg <= 1'b1; // STOP condition!
                        end
                    end else begin
                        clk_cnt    <= '0;
                        done_pulse <= 1'b1; // Complete transaction finished
                        state      <= ST_IDLE;
                    end
                end

                ST_HOLD: begin
                    // Bus held (SCL low, waiting for next byte)
                    scl_reg <= 1'b0;
                    sda_reg <= 1'b1;
                    clk_cnt <= '0;
                    if (i_start) begin
                        tx_shift    <= i_data;
                        is_last_reg <= i_is_last;
                        bit_cnt     <= 3'd7;
                        state       <= ST_DATA; // Continue streaming directly!
                    end
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule
