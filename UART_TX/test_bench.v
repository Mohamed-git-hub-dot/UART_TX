`timescale 1ns/1ps

module test_bench();
  
  reg CLK,RST;
  reg [7:0] PAR_DATA;
  reg DATA_VALID,PAR_EN,PAR_TYP;
  
  wire TX_OUT,BUSY;
  
  integer i;
  
  
  always #(2.5) CLK = ~CLK;
  
  
  TOP DUT(
  .CLK(CLK),
  .RST(RST),
  .PAR_DATA(PAR_DATA),
  .DATA_VALID(DATA_VALID),
  .PAR_EN(PAR_EN),
  .PAR_TYP(PAR_TYP),
  .TX_OUT(TX_OUT),
  .BUSY(BUSY)
  );
  
  initial
  begin
    
    $dumpfile("test_bench.vcd");
    $dumpvars;
    
    CLK = 1'd0;
    RESET();
    
    // First Operation //
    
    PAR_DATA = 8'b00011011;
    PAR_EN = 1'd1;
    PAR_TYP = 1'd1;
    #5
    DATA_VALID = 1'd1;
    #5
    DATA_VALID = 1'd0;
    
    // Second Operation with two consequetive frames with no return to IDLE state //
    
    #(9*5)
    PAR_DATA = 8'b01101001;
    PAR_TYP = 1'd0;
    #5
    DATA_VALID = 1'd1;
    #5
    DATA_VALID = 1'd0;
    
    // Third Operation with return to IDLE state and Disabled Parity //
    
    #(5*15)
    PAR_DATA = 8'b0101101;
    PAR_EN = 1'd0;
    PAR_TYP = 1'd0;
    #5
    DATA_VALID = 1'd1;
    #5
    DATA_VALID = 1'd0;
    
    
    #100
    $finish;
    
  end
  
  task RESET;
  begin
    RST = 1'd1;
    #2.5
    RST = 1'd0;
    #2.5
    RST = 1'd1;
    #2.5;
  end
endtask
  
endmodule
