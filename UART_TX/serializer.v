module serializer(
  input CLK,RST,
  input [7:0] P_DATA,
  input ser_en,
  output reg ser_done,ser_data 
  );
  
  reg [3:0] cntr;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        ser_done <= 1'd0;
        ser_data <= 1'd1;
        cntr <= 4'd0;
      end
      
    else if(ser_en && cntr != 4'd8)
      begin
        ser_data <= P_DATA[cntr];
        cntr <= cntr + 4'd1;
        if(cntr == 4'd7)
          begin
           ser_done <= 1'd1;
          end
      end
      
    else 
      begin
        ser_done <= 1'd0;
        ser_data <= 1'd1;
        cntr <=  4'd0;
      end
      
  end 
  
endmodule
