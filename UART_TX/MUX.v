
module MUX(
  input [1:0] mux_sel,
  input ser_data,par_bit,
  output reg tx_out
  );
  
  always @(*)
  begin
    
    case(mux_sel)
      2'b00:
      begin
       tx_out = 1'd0;
      end
      
      2'b01:
      begin
        tx_out = 1'd1;
      end
      
      2'b10:
      begin
        tx_out = ser_data;
      end
      
      2'b11:
      begin
        tx_out = par_bit;
      end

    endcase
    
  end
  
endmodule
