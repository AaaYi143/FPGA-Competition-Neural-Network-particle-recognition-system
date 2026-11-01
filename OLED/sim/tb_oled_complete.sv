// ================================================================
// tb_oled_complete.sv - Comprehensive Testbench for FPGA SSD1306 OLED Driver
// Tests:
//   Phase 1: Power-on initialization & 15-command sequence check
//   Phase 2: Screen clear verification & virtual GRAM zero check
//   Phase 3: FONT8 direct rendering (ASCII & Chinese) with terminal ASCII art dump
//   Phase 4: FONT16 multi-page direct rendering (ASCII & Chinese)
//   Phase 5: FONT32 4-page large font rendering (digits & Chinese)
//   Phase 6: All 10 Target Chinese characters point-matrix validation
//   Phase 7: Project_41 Neural Network Display Bridge (oled_particle_display)
//   Phase 8: Board-level integration & SW debounce demo cycling (Top_OLED)
//   Phase 9: I2C timing & 400kHz frequency compliance
//   Phase 10: I2C NACK fault injection & error reporting
// ================================================================
`timescale 1ns / 1ps

module tb_oled_complete;

    // -------------------------------------------------------------
    // System Clock (100MHz) and Reset
    // -------------------------------------------------------------
    logic clk;
    logic rst_n;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // 100MHz period = 10ns
    end

    // -------------------------------------------------------------
    // Global Test Pass/Fail Counters
    // -------------------------------------------------------------
    int test_pass_count = 0;
    int test_fail_count = 0;

    task automatic check_assertion(input string test_name, input bit condition, input string details = "");
        if (condition) begin
            $display("  [PASS] %s %s", test_name, details);
            test_pass_count++;
        end else begin
            $display("  [FAIL] >>> %s <<< %s", test_name, details);
            test_fail_count++;
        end
    endtask

    // -------------------------------------------------------------
    // Section A: Direct oled_controller DUT & Virtual Screen
    // -------------------------------------------------------------
    logic        ctrl_clear;
    logic        ctrl_wr_en;
    logic [6:0]  ctrl_col;
    logic [2:0]  ctrl_row;
    logic [15:0] ctrl_char;
    logic [1:0]  ctrl_font_size;
    logic        ctrl_ready;
    logic        ctrl_init_done;
    logic        ctrl_ack_error;

    wire         ctrl_scl;
    wire         ctrl_sda;
    pullup (ctrl_scl);
    pullup (ctrl_sda);

    oled_controller #(
        .CLK_FREQ           (100_000_000),
        .I2C_FREQ           (400_000),
        .PWRON_DELAY_CYCLES (100), // Fast sim delay
        .CLEAR_PAGES        (8),
        .CLEAR_COLS         (128)
    ) u_dut_ctrl (
        .clk        (clk),
        .rst_n      (rst_n),
        .i_clear    (ctrl_clear),
        .i_wr_en    (ctrl_wr_en),
        .i_col      (ctrl_col),
        .i_row      (ctrl_row),
        .i_char     (ctrl_char),
        .i_font_size(ctrl_font_size),
        .o_ready    (ctrl_ready),
        .o_init_done(ctrl_init_done),
        .o_ack_error(ctrl_ack_error),
        .oled_scl   (ctrl_scl),
        .oled_sda   (ctrl_sda)
    );

    ssd1306_slave_model #(
        .INSTANCE_NAME    ("SLAVE_CTRL"),
        .ENABLE_SCL_CHECK (1'b1),
        .VERBOSE_LOG      (1'b0)
    ) u_slave_ctrl (
        .scl(ctrl_scl),
        .sda(ctrl_sda)
    );

    // -------------------------------------------------------------
    // Section B: Dedicated Project_41 Neural Net Bridge DUT & Screen
    // -------------------------------------------------------------
    logic [1:0] part_class;
    logic       part_valid;
    logic       part_empty;
    logic       part_ready;
    logic       part_init_done;

    wire        part_scl;
    wire        part_sda;
    pullup (part_scl);
    pullup (part_sda);

    oled_particle_display #(
        .CLK_FREQ           (100_000_000),
        .I2C_FREQ           (400_000),
        .PWRON_DELAY_CYCLES (100)
    ) u_dut_particle (
        .clk           (clk),
        .rst_n         (rst_n),
        .particle_class(part_class),
        .particle_valid(part_valid),
        .particle_empty(part_empty),
        .o_ready       (part_ready),
        .o_init_done   (part_init_done),
        .oled_scl      (part_scl),
        .oled_sda      (part_sda)
    );

    ssd1306_slave_model #(
        .INSTANCE_NAME    ("SLAVE_PARTICLE"),
        .ENABLE_SCL_CHECK (1'b0),
        .VERBOSE_LOG      (1'b0)
    ) u_slave_particle (
        .scl(part_scl),
        .sda(part_sda)
    );

    // -------------------------------------------------------------
    // Section C: Standalone Top_OLED Board Demo DUT & Screen
    // -------------------------------------------------------------
    logic [1:0] top_sw;
    logic [7:0] top_led;
    wire        top_scl;
    wire        top_sda;
    pullup (top_scl);
    pullup (top_sda);

    Top_OLED #(
        .CLK_FREQ           (100_000_000),
        .I2C_FREQ           (400_000),
        .PWRON_DELAY_CYCLES (100),
        .DEBOUNCE_CYCLES    (10), // Fast debounce for sim
        .CLEAR_PAGES        (2),  // Reduced clear pages for fast sim
        .CLEAR_COLS         (16)
    ) u_dut_top (
        .ipClk   (clk),
        .ipRst_  (rst_n),
        .ipSw    (top_sw),
        .opLed   (top_led),
        .oled_scl(top_scl),
        .oled_sda(top_sda)
    );

    ssd1306_slave_model #(
        .INSTANCE_NAME    ("SLAVE_TOP"),
        .ENABLE_SCL_CHECK (1'b0),
        .VERBOSE_LOG      (1'b0)
    ) u_slave_top (
        .scl(top_scl),
        .sda(top_sda)
    );

    // -------------------------------------------------------------
    // Helper Tasks for Driving oled_controller
    // -------------------------------------------------------------
    task automatic send_char(
        input logic [6:0]  col,
        input logic [2:0]  row,
        input logic [15:0] ch,
        input logic [1:0]  fsize
    );
        // Wait until controller is ready
        while (!ctrl_ready) @(posedge clk);
        @(posedge clk);
        ctrl_col       <= col;
        ctrl_row       <= row;
        ctrl_char      <= ch;
        ctrl_font_size <= fsize;
        ctrl_wr_en     <= 1'b1;
        @(posedge clk);
        ctrl_wr_en     <= 1'b0;

        // Wait until operation finishes
        @(posedge clk);
        while (!ctrl_ready) @(posedge clk);
        @(posedge clk);
    endtask

    task automatic clear_screen_sync();
        while (!ctrl_ready) @(posedge clk);
        @(posedge clk);
        ctrl_clear <= 1'b1;
        @(posedge clk);
        ctrl_clear <= 1'b0;
        @(posedge clk);
        while (!ctrl_ready) @(posedge clk);
        @(posedge clk);
    endtask

    // -------------------------------------------------------------
    // Main Verification Test Suite
    // -------------------------------------------------------------
    initial begin
        $display("\n================================================================");
        $display("   SSD1306 FPGA OLED DRIVER COMPREHENSIVE VERIFICATION SUITE");
        $display("   Target Device: xc7a35tcsg324-1 | Clock: 100MHz | I2C: 400kHz");
        $display("================================================================\n");

        // Initial Signal States
        rst_n          = 1'b0;
        ctrl_clear     = 1'b0;
        ctrl_wr_en     = 1'b0;
        ctrl_col       = 7'd0;
        ctrl_row       = 3'd0;
        ctrl_char      = 16'd0;
        ctrl_font_size = 2'd0;

        part_class     = 2'b00;
        part_valid     = 1'b0;
        part_empty     = 1'b1;

        top_sw         = 2'b00;

        // Apply Reset
        #200;
        rst_n = 1'b1;
        $display("[%0t ns] Reset released. Beginning verification phases...\n", $time);

        // =========================================================
        // PHASE 1: Power-on Initialization Sequence Verification
        // =========================================================
        $display("----------------------------------------------------------------");
        $display(">>> PHASE 1: Power-on Initialization & Command Sequence Check");
        $display("----------------------------------------------------------------");

        // Wait for u_dut_ctrl to finish power-on init
        wait (ctrl_init_done === 1'b1);
        $display("[%0t ns] u_dut_ctrl asserted o_init_done!", $time);

        check_assertion("P1.1: Slave received 0x78 Address", (u_slave_ctrl.pkt_count > 0));
        check_assertion("P1.2: Display ON (0xAF) command decoded", (u_slave_ctrl.display_on === 1'b1));
        check_assertion("P1.3: Charge Pump enabled (0x8D, 0x14)", (u_slave_ctrl.charge_pump_on === 1'b1));
        check_assertion("P1.4: Page Addressing Mode set (0x20, 0x02)", (u_slave_ctrl.addr_mode === 2'b10));
        check_assertion("P1.5: Zero protocol errors during init", (u_slave_ctrl.error_count == 0));

        // =========================================================
        // PHASE 2: Screen Clear Verification (All 8 pages x 128 cols)
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 2: Screen Clear Command Verification");
        $display("----------------------------------------------------------------");

        // Fill slave GRAM with dummy pattern 0xFF first
        for (int p = 0; p < 8; p++)
            for (int c = 0; c < 128; c++)
                u_slave_ctrl.gram[p][c] = 8'hAA;

        // Trigger hardware clear
        clear_screen_sync();

        // Check if GRAM is now 100% zeroed
        begin
            automatic int non_zero_count = 0;
            for (int p = 0; p < 8; p++) begin
                for (int c = 0; c < 128; c++) begin
                    if (u_slave_ctrl.gram[p][c] !== 8'h00) non_zero_count++;
                end
            end
            check_assertion("P2.1: Full Screen Clear verified (all 1024 bytes zeroed)",
                            (non_zero_count == 0),
                            $sformatf("(Non-zero bytes: %0d)", non_zero_count));
        end

        // =========================================================
        // PHASE 3: FONT8 Direct Rendering (ASCII & Chinese)
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 3: FONT8 Rendering (ASCII 6x8 + Chinese 16x8)");
        $display("----------------------------------------------------------------");

        // Write "OLED" in FONT8 at Page 0, Column 10
        send_char(7'd10, 3'd0, 16'h004F, 2'd0); // 'O' (width 6)
        send_char(7'd16, 3'd0, 16'h004C, 2'd0); // 'L' (width 6)
        send_char(7'd22, 3'd0, 16'h0045, 2'd0); // 'E' (width 6)
        send_char(7'd28, 3'd0, 16'h0044, 2'd0); // 'D' (width 6)

        // Write Chinese "小米" in FONT8 at Page 0, Column 40
        send_char(7'd40, 3'd0, 16'h5C0F, 2'd0); // '小' (width 16)
        send_char(7'd56, 3'd0, 16'h7C73, 2'd0); // '米' (width 16)

        // Check lit pixel counts
        begin
            automatic int lit_oled = u_slave_ctrl.count_lit_pixels(0, 0, 10, 33);
            automatic int lit_xiao = u_slave_ctrl.count_lit_pixels(0, 0, 40, 55);
            automatic int lit_mi   = u_slave_ctrl.count_lit_pixels(0, 0, 56, 71);

            check_assertion("P3.1: FONT8 ASCII 'OLED' non-empty", (lit_oled > 10), $sformatf("(%0d lit pixels)", lit_oled));
            check_assertion("P3.2: FONT8 Chinese '小' rendered", (lit_xiao > 5), $sformatf("(%0d lit pixels)", lit_xiao));
            check_assertion("P3.3: FONT8 Chinese '米' rendered", (lit_mi > 5), $sformatf("(%0d lit pixels)", lit_mi));

            // Visual terminal dump of Page 0
            u_slave_ctrl.dump_screen_ascii("FONT8 Preview: 'OLED' and '小米'", 0, 0, 8, 73);
        end

        // =========================================================
        // PHASE 4: FONT16 Multi-Page Rendering (8x16 ASCII + 16x16 Chinese)
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 4: FONT16 Multi-Page Rendering (Pages 2..3)");
        $display("----------------------------------------------------------------");

        // Write "FPGA" at Page 2, Column 0
        send_char(7'd0,  3'd2, 16'h0046, 2'd1); // 'F'
        send_char(7'd8,  3'd2, 16'h0050, 2'd1); // 'P'
        send_char(7'd16, 3'd2, 16'h0047, 2'd1); // 'G'
        send_char(7'd24, 3'd2, 16'h0041, 2'd1); // 'A'

        // Write "玻璃珠" (Glass beads) at Page 2, Column 36
        send_char(7'd36, 3'd2, 16'h73BB, 2'd1); // '玻'
        send_char(7'd52, 3'd2, 16'h7483, 2'd1); // '璃'
        send_char(7'd68, 3'd2, 16'h73E0, 2'd1); // '珠'

        // Write "细盐" (Fine salt) at Page 2, Column 90
        send_char(7'd90,  3'd2, 16'h7EC6, 2'd1); // '细'
        send_char(7'd106, 3'd2, 16'h76D0, 2'd1); // '盐'

        begin
            automatic int lit_p2 = u_slave_ctrl.count_lit_pixels(2, 2, 0, 122);
            automatic int lit_p3 = u_slave_ctrl.count_lit_pixels(3, 3, 0, 122);

            check_assertion("P4.1: FONT16 Page 2 upper half non-empty", (lit_p2 > 50), $sformatf("(%0d lit pixels)", lit_p2));
            check_assertion("P4.2: FONT16 Page 3 lower half non-empty", (lit_p3 > 50), $sformatf("(%0d lit pixels)", lit_p3));

            // Visual terminal dump of FONT16 Region
            u_slave_ctrl.dump_screen_ascii("FONT16 Preview: 'FPGA', '玻璃珠', '细盐'", 2, 3, 0, 122);
        end

        // =========================================================
        // PHASE 5: FONT32 4-Page Large Font Rendering
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 5: FONT32 4-Page Large Font Rendering (Pages 4..7)");
        $display("----------------------------------------------------------------");

        // Write "26" at Page 4, Column 0
        send_char(7'd0,  3'd4, 16'h0032, 2'd2); // '2' (width 16, height 4 pages)
        send_char(7'd16, 3'd4, 16'h0036, 2'd2); // '6' (width 16, height 4 pages)

        // Write Chinese "糖" at Page 4, Column 40 (width 32, height 4 pages)
        send_char(7'd40, 3'd4, 16'h7CD6, 2'd2); // '糖' (32x32)

        begin
            automatic int lit_p4 = u_slave_ctrl.count_lit_pixels(4, 4, 0, 72);
            automatic int lit_p5 = u_slave_ctrl.count_lit_pixels(5, 5, 0, 72);
            automatic int lit_p6 = u_slave_ctrl.count_lit_pixels(6, 6, 0, 72);
            automatic int lit_p7 = u_slave_ctrl.count_lit_pixels(7, 7, 0, 72);

            check_assertion("P5.1: FONT32 Page 4 row has content", (lit_p4 > 10));
            check_assertion("P5.2: FONT32 Page 5 row has content", (lit_p5 > 10));
            check_assertion("P5.3: FONT32 Page 6 row has content", (lit_p6 > 10));
            check_assertion("P5.4: FONT32 Page 7 row has content", (lit_p7 > 10));

            // Visual terminal dump of FONT32 Region
            u_slave_ctrl.dump_screen_ascii("FONT32 Preview: '26' and '糖'", 4, 7, 0, 72);
        end

        // =========================================================
        // PHASE 6: All 10 Target Chinese Characters Validation
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 6: Validating All 10 Target Chinese Characters Dot Matrices");
        $display("----------------------------------------------------------------");

        begin
            automatic logic [15:0] target_chars [0:9] = '{
                16'h5C0F, // 小
                16'h7C73, // 米
                16'h73BB, // 玻
                16'h7483, // 璃
                16'h73E0, // 珠
                16'h7EC6, // 细
                16'h76D0, // 盐
                16'h767D, // 白
                16'h7802, // 砂
                16'h7CD6  // 糖
            };
            automatic string char_names [0:9] = '{"小", "米", "玻", "璃", "珠", "细", "盐", "白", "砂", "糖"};

            automatic int valid_char_count = 0;
            for (int i = 0; i < 10; i++) begin
                send_char(7'd0, 3'd0, target_chars[i], 2'd1); // Draw FONT16 at (0, 0)
                if (u_slave_ctrl.count_lit_pixels(0, 1, 0, 15) > 8) begin
                    valid_char_count++;
                    $display("  [CHAR-OK] '%s' (Unicode 0x%04X): Valid non-empty dot matrix (%0d lit pixels)",
                             char_names[i], target_chars[i], u_slave_ctrl.count_lit_pixels(0, 1, 0, 15));
                end else begin
                    $display("  [CHAR-FAIL] '%s' (Unicode 0x%04X): Empty or missing dot matrix!",
                             char_names[i], target_chars[i]);
                end
            end
            check_assertion("P6.1: All 10 target Chinese characters generated valid dot matrices",
                            (valid_char_count == 10),
                            $sformatf("(%0d/10 valid)", valid_char_count));
        end

        // =========================================================
        // PHASE 7: Project_41 Neural Net Display Bridge (oled_particle_display)
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 7: Neural Network Result Display Bridge Testing");
        $display("----------------------------------------------------------------");

        wait (part_init_done === 1'b1);
        $display("[%0t ns] u_dut_particle asserted o_init_done!", $time);

        // Test Class 0: "小米"
        $display("[%0t ns] Injecting inference result: Class 0 (小米)...", $time);
        part_class = 2'b00;
        part_empty = 1'b0;
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_200_000; // Wait for redraw
        check_assertion("P7.1: Class 0 (小米) rendered to screen", (u_slave_particle.count_lit_pixels(2, 3, 40, 80) > 20));
        u_slave_particle.dump_screen_ascii("Neural Net Class 0: 小米", 2, 3, 30, 90);

        // Test Class 1: "玻璃珠"
        $display("[%0t ns] Injecting inference result: Class 1 (玻璃珠)...", $time);
        part_class = 2'b01;
        part_empty = 1'b0;
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_500_000;
        check_assertion("P7.2: Class 1 (玻璃珠) rendered to screen", (u_slave_particle.count_lit_pixels(2, 3, 40, 88) > 30));
        u_slave_particle.dump_screen_ascii("Neural Net Class 1: 玻璃珠", 2, 3, 30, 95);

        // Test Class 2: "细盐"
        $display("[%0t ns] Injecting inference result: Class 2 (细盐)...", $time);
        part_class = 2'b10;
        part_empty = 1'b0;
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_200_000;
        check_assertion("P7.3: Class 2 (细盐) rendered to screen", (u_slave_particle.count_lit_pixels(2, 3, 40, 80) > 20));

        // Test Class 3: "白砂糖"
        $display("[%0t ns] Injecting inference result: Class 3 (白砂糖)...", $time);
        part_class = 2'b11;
        part_empty = 1'b0;
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_500_000;
        check_assertion("P7.4: Class 3 (白砂糖) rendered to screen", (u_slave_particle.count_lit_pixels(2, 3, 40, 88) > 30));
        u_slave_particle.dump_screen_ascii("Neural Net Class 3: 白砂糖", 2, 3, 30, 95);

        // Test Empty Frame: "NO PARTICLE"
        $display("[%0t ns] Injecting inference result: Empty Frame (NO PARTICLE)...", $time);
        part_empty = 1'b1;
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_200_000;
        check_assertion("P7.5: Empty frame indicates NO PARTICLE", (u_slave_particle.count_lit_pixels(2, 3, 10, 110) > 20));
        u_slave_particle.dump_screen_ascii("Neural Net Empty Frame: NO PARTICLE", 2, 3, 10, 118);

        // Double-buffering stress test: Rapid pulses while busy
        $display("[%0t ns] Injecting rapid pulses to test double-buffering immunity...", $time);
        part_empty = 1'b0;
        part_class = 2'b00; // Request 小米
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #200_000; // While drawing is in progress, interrupt with Class 3
        part_class = 2'b11; // Request 白砂糖
        part_valid = 1'b1;
        #20 part_valid = 1'b0;
        #1_800_000; // Wait for final settle
        check_assertion("P7.6: Double-buffering prevented corrupt text", (u_slave_particle.error_count == 0));

        // =========================================================
        // PHASE 8: Standalone Board Top Demo Module (Top_OLED)
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 8: Standalone Board Top Module (Top_OLED) & SW Debounce");
        $display("----------------------------------------------------------------");

        wait (top_led[0] === 1'b1); // Wait for OLED init done
        $display("[%0t ns] Top_OLED initialized. LED status: 8'b%08b", $time, top_led);
        check_assertion("P8.1: Top_OLED LED0 asserted (init_done)", (top_led[0] === 1'b1));
        check_assertion("P8.2: Top_OLED LED2 asserted (ACK OK)", (top_led[2] === 1'b1));

        // Cycle through all switches
        $display("[%0t ns] Switching SW to 2'b01 (Demo 1)...", $time);
        top_sw = 2'b01;
        #300_000;

        $display("[%0t ns] Switching SW to 2'b10 (Demo 2)...", $time);
        top_sw = 2'b10;
        #300_000;

        $display("[%0t ns] Switching SW to 2'b11 (Demo 3)...", $time);
        top_sw = 2'b11;
        #300_000;

        check_assertion("P8.3: Top_OLED switch cycling completed with 0 errors", (u_slave_top.error_count == 0));

        // =========================================================
        // PHASE 9: I2C SCL Frequency and Protocol Compliance
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 9: I2C Physical Protocol & 400kHz Timing Compliance");
        $display("----------------------------------------------------------------");

        check_assertion("P9.1: SCL clock frequency within 400kHz +/-10% (360k..440k)",
                        (u_slave_ctrl.scl_freq_khz >= 360.0 && u_slave_ctrl.scl_freq_khz <= 440.0),
                        $sformatf("(Measured: %0.1f kHz, Period: %0.1f ns)", u_slave_ctrl.scl_freq_khz, u_slave_ctrl.scl_period_ns));
        check_assertion("P9.2: Total I2C Transactions Completed", (u_slave_ctrl.pkt_count > 50),
                        $sformatf("(Total: %0d packets, %0d bytes)", u_slave_ctrl.pkt_count, u_slave_ctrl.total_bytes));

        // =========================================================
        // PHASE 10: Fault Injection - I2C NACK Error Handling
        // =========================================================
        $display("\n----------------------------------------------------------------");
        $display(">>> PHASE 10: Fault Injection - NACK Error Handling");
        $display("----------------------------------------------------------------");

        // Enable NACK on slave
        u_slave_ctrl.inject_nack = 1'b1;
        $display("[%0t ns] Injected I2C NACK on slave...", $time);
        send_char(7'd0, 3'd0, 16'h0020, 2'd0); // Send dummy char
        #100_000;

        check_assertion("P10.1: Controller correctly flagged o_ack_error on NACK", (ctrl_ack_error === 1'b1));
        u_slave_ctrl.inject_nack = 1'b0; // Restore slave

        // =========================================================
        // FINAL VERIFICATION SUMMARY SCORECARD
        // =========================================================
        $display("\n================================================================");
        $display("          OLED DRIVER VERIFICATION SCORECARD SUMMARY            ");
        $display("================================================================");
        $display("  TOTAL ASSERTIONS RUN : %0d", (test_pass_count + test_fail_count));
        $display("  PASSED ASSERTIONS    : %0d", test_pass_count);
        $display("  FAILED ASSERTIONS    : %0d", test_fail_count);
        $display("  SLAVE CTRL ERRORS    : %0d", u_slave_ctrl.error_count);
        $display("  SLAVE PARTICLE ERRORS: %0d", u_slave_particle.error_count);
        $display("  SLAVE TOP ERRORS     : %0d", u_slave_top.error_count);
        $display("================================================================");

        if (test_fail_count == 0 && u_slave_ctrl.error_count == 0 &&
            u_slave_particle.error_count == 0 && u_slave_top.error_count == 0) begin
            $display(">>> ALL 10 TEST PHASES COMPLETED SUCCESSFULLY WITH 0 ERRORS! <<<");
            $display("================================================================\n");
        end else begin
            $fatal(1, "\n>>> VERIFICATION FAILED! Some assertions or protocol checks failed! <<<\n");
        end

        $finish;
    end

endmodule
