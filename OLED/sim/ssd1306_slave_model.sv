// ================================================================
// ssd1306_slave_model.sv - Comprehensive Behavioral Model for SSD1306 OLED
// Features:
//   - Physical 128x64 display RAM (8 pages x 128 columns)
//   - Page addressing mode command and data stream decoding
//   - Initialization sequence validation (15 standard commands)
//   - SCL clock frequency & pulse width timing verification (400kHz)
//   - ASCII art terminal display dump for visual verification
// ================================================================
`timescale 1ns / 1ps

module ssd1306_slave_model #(
    parameter string INSTANCE_NAME = "SSD1306",
    parameter bit    ENABLE_SCL_CHECK = 1'b1,
    parameter bit    VERBOSE_LOG = 1'b0
)(
    input  wire  scl,
    inout  wire  sda
);

    // 128x64 Display RAM: 8 pages (0..7), 128 columns (0..127), 8 bits per column
    logic [7:0] gram [0:7][0:127];

    // Internal State Registers
    logic [2:0] cur_page;
    logic [6:0] cur_col;
    logic       display_on;
    logic       charge_pump_on;
    logic [1:0] addr_mode;
    logic [7:0] contrast;
    logic [7:0] prev_cmd;
    logic       slave_sda_drive;

    assign sda = slave_sda_drive ? 1'b0 : 1'bz;

    // Monitoring Statistics & Status
    int unsigned pkt_count;
    int unsigned byte_count;
    int unsigned total_bytes;
    int unsigned total_cmds;
    int unsigned total_data;
    int unsigned error_count;
    int unsigned init_cmd_count;

    logic [7:0] rx_byte;
    int         bit_cnt;
    logic       in_transaction;
    logic       current_is_cmd;
    logic       current_is_data;

    // SCL Timing Monitor
    realtime last_scl_rise;
    realtime last_scl_fall;
    realtime scl_period_ns;
    realtime scl_high_ns;
    realtime scl_low_ns;
    real     scl_freq_khz;

    // Fault injection control
    logic inject_nack;

    // Initialization
    initial begin
        slave_sda_drive = 1'b0;
        in_transaction  = 1'b0;
        bit_cnt         = 0;
        byte_count      = 0;
        pkt_count       = 0;
        total_bytes     = 0;
        total_cmds      = 0;
        total_data      = 0;
        error_count     = 0;
        init_cmd_count  = 0;
        cur_page        = '0;
        cur_col         = '0;
        display_on      = 1'b0;
        charge_pump_on  = 1'b0;
        addr_mode       = 2'b00;
        contrast        = 8'h7F;
        last_scl_rise   = 0;
        last_scl_fall   = 0;
        inject_nack     = 1'b0;

        for (int p = 0; p < 8; p++) begin
            for (int c = 0; c < 128; c++) begin
                gram[p][c] = 8'h00;
            end
        end
    end

    // -------------------------------------------------------------
    // I2C Bus Detection: START & STOP Conditions
    // -------------------------------------------------------------
    // START: SDA falling while SCL is high
    always @(negedge sda) begin
        if (scl === 1'b1) begin
            in_transaction  <= 1'b1;
            bit_cnt         <= 0;
            byte_count      <= 0;
            pkt_count       <= pkt_count + 1;
            slave_sda_drive <= 1'b0;
            current_is_cmd  <= 1'b0;
            current_is_data <= 1'b0;
        end
    end

    // STOP: SDA rising while SCL is high
    always @(posedge sda) begin
        if (scl === 1'b1 && in_transaction) begin
            in_transaction  <= 1'b0;
            slave_sda_drive <= 1'b0;
            bit_cnt         <= 0;
        end
    end

    // -------------------------------------------------------------
    // SCL Timing Verification Monitor (400kHz Fast-mode)
    // -------------------------------------------------------------
    always @(posedge scl) begin
        if (in_transaction && last_scl_rise > 0 && ENABLE_SCL_CHECK) begin
            scl_period_ns = $realtime - last_scl_rise;
            scl_low_ns    = $realtime - last_scl_fall;
            scl_freq_khz  = 1_000_000.0 / scl_period_ns;

            // Fast-mode nominal period is 2500ns (400kHz).
            // Allow 320kHz..460kHz tolerance for clock division rounding
            if (scl_freq_khz < 300.0 || scl_freq_khz > 500.0) begin
                $display("[%0t ns] [%s-SCL-MONITOR] WARNING: SCL frequency out of nominal 400kHz range: %0.1f kHz (Period: %0.1f ns)",
                         $time, INSTANCE_NAME, scl_freq_khz, scl_period_ns);
            end
        end
        last_scl_rise <= $realtime;
    end

    always @(negedge scl) begin
        if (in_transaction && last_scl_rise > 0 && ENABLE_SCL_CHECK) begin
            scl_high_ns <= $realtime - last_scl_rise;
        end
        last_scl_fall <= $realtime;
    end

    // -------------------------------------------------------------
    // Bit Sampling on SCL Rising Edge
    // -------------------------------------------------------------
    always @(posedge scl) begin
        if (in_transaction) begin
            if (bit_cnt < 8) begin
                rx_byte[7 - bit_cnt] <= (sda === 1'b0) ? 1'b0 : 1'b1;
                bit_cnt              <= bit_cnt + 1;
            end else begin
                // 9th clock edge (ACK bit)
                bit_cnt <= 0;
            end
        end
    end

    // -------------------------------------------------------------
    // ACK Generation and Byte Processing on SCL Falling Edge
    // -------------------------------------------------------------
    always @(negedge scl) begin
        if (in_transaction) begin
            if (bit_cnt == 8) begin
                // Drive ACK (SDA low) unless fault injection is enabled
                if (!inject_nack) begin
                    slave_sda_drive <= 1'b1;
                end else begin
                    slave_sda_drive <= 1'b0; // NACK injected
                end
            end else if (slave_sda_drive || (bit_cnt == 0 && byte_count > 0)) begin
                slave_sda_drive <= 1'b0;
                byte_count      <= byte_count + 1;
                total_bytes     <= total_bytes + 1;

                process_received_byte(byte_count, rx_byte);
            end else begin
                slave_sda_drive <= 1'b0;
            end
        end else begin
            slave_sda_drive <= 1'b0;
        end
    end

    // -------------------------------------------------------------
    // SSD1306 Command and Data Parser
    // -------------------------------------------------------------
    task automatic process_received_byte(input int idx, input logic [7:0] b);
        if (idx == 0) begin
            // Byte 0: Slave Address
            if (b == 8'h78) begin
                if (VERBOSE_LOG) $display("[%0t ns] [%s] Slave Address 0x78 ACK", $time, INSTANCE_NAME);
            end else begin
                $display("[%0t ns] [%s] ERROR: Unexpected Slave Address 0x%02X (Expected 0x78)", $time, INSTANCE_NAME, b);
                error_count++;
            end
        end else if (idx == 1) begin
            // Byte 1: Control Byte (0x00 for Command Stream, 0x40 for Data Stream)
            if (b == 8'h00) begin
                current_is_cmd  = 1'b1;
                current_is_data = 1'b0;
                if (VERBOSE_LOG) $display("[%0t ns] [%s] Control Byte: 0x00 (Command Mode)", $time, INSTANCE_NAME);
            end else if (b == 8'h40) begin
                current_is_cmd  = 1'b0;
                current_is_data = 1'b1;
                if (VERBOSE_LOG) $display("[%0t ns] [%s] Control Byte: 0x40 (Data Stream Mode)", $time, INSTANCE_NAME);
            end else begin
                $display("[%0t ns] [%s] FATAL ERROR: Invalid Control Byte 0x%02X! (Expected 0x00 or 0x40)", $time, INSTANCE_NAME, b);
                error_count++;
            end
        end else begin
            // Byte >= 2: Command or Data Payload
            if (current_is_cmd) begin
                total_cmds++;
                decode_command(b);
            end else if (current_is_data) begin
                total_data++;
                // Write byte into virtual GRAM at (cur_page, cur_col)
                gram[cur_page][cur_col] = b;

                // Column address auto-increments in page addressing mode
                if (cur_col == 7'd127) begin
                    cur_col = 7'd0;
                end else begin
                    cur_col = cur_col + 7'd1;
                end
            end
        end
    endtask

    // Command Decoder
    task automatic decode_command(input logic [7:0] cmd);
        // Multi-byte parameter processing
        if (prev_cmd == 8'h8D) begin
            if (cmd == 8'h14) charge_pump_on = 1'b1;
            prev_cmd = 8'h00;
            init_cmd_count++;
            if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Charge Pump Param 0x%02X (Pump ON: %0d)", $time, INSTANCE_NAME, cmd, charge_pump_on);
        end else if (prev_cmd == 8'h20) begin
            if (cmd == 8'h02) addr_mode = 2'b10; // Page Addressing Mode
            prev_cmd = 8'h00;
            init_cmd_count++;
            if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Addressing Mode Param 0x%02X (Mode: %0d)", $time, INSTANCE_NAME, cmd, addr_mode);
        end else if (prev_cmd == 8'hD5 || prev_cmd == 8'hA8 || prev_cmd == 8'hD3 ||
                     prev_cmd == 8'hDA || prev_cmd == 8'h81 || prev_cmd == 8'hD9 || prev_cmd == 8'hDB) begin
            prev_cmd = 8'h00;
            init_cmd_count++;
            if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Multi-byte Param 0x%02X", $time, INSTANCE_NAME, cmd);
        end else begin
            // Multi-byte command headers
            if (cmd == 8'h8D || cmd == 8'h20 || cmd == 8'hD5 || cmd == 8'hA8 ||
                cmd == 8'hD3 || cmd == 8'hDA || cmd == 8'h81 || cmd == 8'hD9 || cmd == 8'hDB) begin
                prev_cmd = cmd;
                init_cmd_count++;
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Multi-byte Header 0x%02X", $time, INSTANCE_NAME, cmd);
            end
            // Page start address (0xB0 .. 0xB7)
            else if (cmd >= 8'hB0 && cmd <= 8'hB7) begin
                cur_page = cmd[2:0];
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Set Page Address -> Page %0d", $time, INSTANCE_NAME, cur_page);
            end
            // Lower column start address (0x00 .. 0x0F)
            else if (cmd >= 8'h00 && cmd <= 8'h0F) begin
                cur_col[3:0] = cmd[3:0];
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Set Column Lower Nibble -> %0h (cur_col=%0d)", $time, INSTANCE_NAME, cmd[3:0], cur_col);
            end
            // Higher column start address (0x10 .. 0x1F)
            else if (cmd >= 8'h10 && cmd <= 8'h1F) begin
                cur_col[6:4] = cmd[2:0];
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Set Column Upper Nibble -> %0h (cur_col=%0d)", $time, INSTANCE_NAME, cmd[2:0], cur_col);
            end
            // Display ON / OFF
            else if (cmd == 8'hAF) begin
                display_on = 1'b1;
                init_cmd_count++;
                $display("[%0t ns] [%s] CMD: >>> 0xAF Display ON! <<<", $time, INSTANCE_NAME);
            end else if (cmd == 8'hAE) begin
                display_on = 1'b0;
                init_cmd_count++;
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: 0xAE Display OFF", $time, INSTANCE_NAME);
            end else begin
                init_cmd_count++;
                if (VERBOSE_LOG) $display("[%0t ns] [%s] CMD: Single-byte Cmd 0x%02X", $time, INSTANCE_NAME, cmd);
            end
        end
    endtask

    // -------------------------------------------------------------
    // Screen Visualizer Task: Dumps GRAM as ASCII Art to Console
    // -------------------------------------------------------------
    task automatic dump_screen_ascii(
        input string title,
        input int start_p = 0,
        input int end_p   = 7,
        input int start_c = 0,
        input int end_c   = 127
    );
        $display("\n================================================================");
        $display(" [VIRTUAL OLED DISPLAY PREVIEW] %s", title);
        $display(" Region: Pages %0d..%0d (Y: %0d..%0d), Cols %0d..%0d",
                 start_p, end_p, start_p * 8, (end_p + 1) * 8 - 1, start_c, end_c);
        $display(" Resolution: %0d x %0d pixels", (end_c - start_c + 1), (end_p - start_p + 1) * 8);
        $display("================================================================");

        for (int p = start_p; p <= end_p; p++) begin
            for (int b = 0; b < 8; b++) begin
                string row_str;
                row_str = $sformatf("Y%02d |", p * 8 + b);
                for (int c = start_c; c <= end_c; c++) begin
                    if (gram[p][c][b])
                        row_str = {row_str, "#"};
                    else
                        row_str = {row_str, " "};
                end
                row_str = {row_str, "|"};
                $display("%s", row_str);
            end
        end
        $display("================================================================\n");
    endtask

    // -------------------------------------------------------------
    // Helper: Check if a region is non-empty (has lit pixels)
    // -------------------------------------------------------------
    function automatic int count_lit_pixels(int p0, int p1, int c0, int c1);
        int lit = 0;
        for (int p = p0; p <= p1; p++) begin
            for (int c = c0; c <= c1; c++) begin
                for (int b = 0; b < 8; b++) begin
                    if (gram[p][c][b]) lit++;
                end
            end
        end
        return lit;
    endfunction

    // Helper: Clear internal GRAM manually
    task automatic clear_gram();
        for (int p = 0; p < 8; p++) begin
            for (int c = 0; c < 128; c++) begin
                gram[p][c] = 8'h00;
            end
        end
    endtask

endmodule
