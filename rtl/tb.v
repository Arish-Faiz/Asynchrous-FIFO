`timescale 1ns / 1ps

module fifo_tb;

// 1. Parameters
parameter DSIZE = 8;  // Data width
parameter ASIZE = 4;  // Address width (FIFO depth will be 2^ASIZE = 16)
parameter DEPTH = 1 << ASIZE;

// 2. Testbench Signals
reg wclk;
reg rclk;
reg wrst_n;
reg rrst_n;
reg winc;
reg rinc;
reg [DSIZE-1:0] wdata;

wire wfull;
wire rempty;
wire [DSIZE-1:0] rdata;

// Error and data tracking
integer error_count = 0;
integer write_count = 0;
integer read_count = 0;
reg [DSIZE-1:0] expected_data_q[DEPTH-1:0];


// 3. Instantiate the DUT (Device Under Test)
// Instantiates the top-level FIFO module from the paper [cite: 2438]
fifol #(
    .DSIZE(DSIZE),
    .ASIZE(ASIZE)
) dut (
    .rdata(rdata),
    .wfull(wfull),
    .rempty(rempty),
    .wdata(wdata),
    .winc(winc),
    .wclk(wclk),
    .wrst_n(wrst_n),
    .rinc(rinc),
    .rclk(rclk),
    .rrst_n(rrst_n)
);

// 4. Clock Generation (Asynchronous Clocks)
    // Write clock ( 125 MHz)
initial begin
    wclk = 0;
    forever #4 wclk = ~wclk;
end

    // Read clock (25 MHz)
initial begin
    rclk = 0;
    forever #20 rclk = ~rclk;
end

// 5. Main Test Sequence
initial begin
    $display("----------------------------------------------------");
    $display("INFO: Starting Asynchronous FIFO Testbench");
    $display("INFO: FIFO Depth = %0d, Data Width = %0d", DEPTH, DSIZE);
    $display("----------------------------------------------------");

    // -- RESET Sequence --
    wrst_n = 1'b0;
    rrst_n = 1'b0;
    winc   = 1'b0;
    rinc   = 1'b0;
    wdata  = 'hz;
    #20;
    wrst_n = 1'b1;
    rrst_n = 1'b1;
    #20;
    
    // Check initial state after reset
    if (rempty !== 1'b1) begin
        $display("FAIL: FIFO not empty after reset.");
        error_count = error_count + 1;
    end else begin
        $display("PASS: FIFO is empty after reset.");
    end

    // -- TEST 1: Write to Full --
    $display("\nTEST 1: Writing until FIFO is full...");
    repeat (DEPTH) begin
        @(negedge wclk);
        winc = 1'b1;
        wdata = $random;
        expected_data_q[write_count] = wdata; // Store data for later check
        write_count = write_count + 1;
        $display("Wrote data %h at address %0d", wdata, write_count-1);
    end
    @(negedge wclk);
    winc = 1'b0;
    #1; // Allow time for full flag to assert
    if (wfull !== 1'b1) begin
        $display("FAIL: FIFO not full after writing %0d words.", DEPTH);
        error_count = error_count + 1;
    end else begin
        $display("PASS: FIFO is full.");
    end

    // -- TEST 2: Read to Empty & Data Check --
    $display("\nTEST 2: Reading until FIFO is empty and checking data...");
    repeat (DEPTH) begin
        @(negedge rclk);
        rinc = 1'b1;
        #1; // Allow combinational logic to settle
        if (rdata !== expected_data_q[read_count]) begin
            $display("FAIL: Data mismatch! Addr %0d, Expected: %h, Got: %h", read_count, expected_data_q[read_count], rdata);
            error_count = error_count + 1;
        end else begin
            $display("Read data %h from address %0d... OK", rdata, read_count);
        end
        read_count = read_count + 1;
    end
    @(negedge rclk);
    rinc = 1'b0;
    #20; // Allow time for empty flag to assert
    if (rempty !== 1'b1) begin
        $display("FAIL: FIFO not empty after reading %0d words.", DEPTH);
        error_count = error_count + 1;
    end else begin
        $display("PASS: FIFO is empty.");
    end

    // -- FINAL REPORT --
    $display("\n----------------------------------------------------");
    if (error_count == 0) begin
        $display("INFO: All tests passed successfully!");
    end else begin
        $display("ERROR: %0d error(s) detected during simulation.", error_count);
    end
    $display("----------------------------------------------------");
    $finish;
end

endmodule
