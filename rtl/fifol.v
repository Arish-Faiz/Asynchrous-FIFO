1 module fifol #(parameter DSIZE = 8,
2 parameter ASIZE = 4)
3 (output [DSIZE-1:0] rdata,
4 output wfull,
5 output rempty,
6 input [DSIZE-1:0] wdata,
7 input winc, wclk, wrst_n,
8 input rinc, rclk, rrst_n);
9
10 wire [ASIZE-1:0] waddr, raddr;
11 wire [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
12
13 sync_r2w #(ASIZE) sync_r2w
14 (.wq2_rptr(wq2_rptr), .rptr(rptr),
15 .wclk(wclk), .wrst_n(wrst_n));
16
17 sync_w2r #(ASIZE) sync_w2r
18 (.rq2_wptr(rq2_wptr), .wptr(wptr),
19 .rclk(rclk), .rrst_n(rrst_n));
20
21 fifomem #(DSIZE, ASIZE) fifomem
22 (.rdata(rdata), .wdata(wdata),
23 .waddr(waddr), .raddr(raddr),
24 .wclken(winc & ~wfull),
25 .wclk(wclk));
26
27 rptr_empty #(ASIZE) rptr_empty
28 (.rempty(rempty), .raddr(raddr),
29 .rptr(rptr), .rq2_wptr(rq2_wptr),
30 .rinc(rinc), .rclk(rclk),
31 .rrst_n(rrst_n));
32
33 wptr_full #(ASIZE) wptr_full
34 (.wfull(wfull), .waddr(waddr),
35 .wptr(wptr), .wq2_rptr(wq2_rptr),
36 .winc(winc), .wclk(wclk),
37 .wrst_n(wrst_n));
38 endmodule
