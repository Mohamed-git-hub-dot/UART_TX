
module parity_calc(
  input CLK,RST,
  input DATA_VALID,
  input [7:0] P_DATA,
  input PAR_TYP,
  output reg par_bit
  );
  
  parameter EVEN_PAR = 1'b0,
            ODD_PAR = 1'b1;
            
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
       par_bit <= 1'd0;
      end
      
    else if(DATA_VALID && PAR_TYP == EVEN_PAR)
      begin
       par_bit <= ^P_DATA;
      end
      
    else if(DATA_VALID && PAR_TYP == ODD_PAR)
      begin
       par_bit <= ~^P_DATA;
      end
  end
  
endmodule
