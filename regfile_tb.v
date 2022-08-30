module Regfile_tb();
  parameter Depth=8;
  parameter Width=16;
  parameter Addr=3;
  parameter TimeClk=10;
  
  //TEST bench signals
  reg  [Width-1:0]  WrData_tb;
  reg  [Depth-1:0]  Address_tb;
  reg               clk_tb;
  reg               RST_tb;
  reg               RdEn_tb;
  reg               WrEn_tb;
  wire [Width-1:0]  RdData_tb;
  //Intial
  initial
   begin
     //intial values
    clk_tb=1'b0;
    RST_tb=1'b1;
    RdEn_tb = 1'b0 ;
    WrEn_tb = 1'b0 ;
    //Rest the reg file
  #TimeClk
  RST_tb=1'b0;
  #TimeClk
  RST_tb=1'b1;
  RdEn_tb=1'b1;
  Address_tb=3'b01;
  #TimeClk
  if(RdData_tb!=16'b0)
    $display("TEST case 1 at reg[1] failed");
  else
     $display("TEST case 1 at reg[1] success");

  #TimeClk
  WrEn_tb = 1'b1;
  RdEn_tb = 1'b0 ;
  Address_tb = 3'b11;// wrie data in reg [3]
  WrData_tb = 16'b001011;

  #TimeClk
  WrEn_tb = 1'b1;
  RdEn_tb = 1'b0 ; 
  Address_tb = 3'b111;//write data in reg [7]
  WrData_tb = 16'b01;

  #TimeClk
  WrEn_tb = 1'b1;
  RdEn_tb = 1'b0 ;
  Address_tb = 3'b001;//write data in reg[1]
  WrData_tb = 16'b11100;
  
  #TimeClk
  WrEn_tb=1'b0;
  RdEn_tb=1'b1;
  Address_tb=3'b11;
  #TimeClk
  if(RdData_tb!=16'b001011)
    $display("TEST case 2 at reg[3] failed");
  else
     $display("TEST case 2 at reg[3] success");
  
  #TimeClk
  WrEn_tb=1'b0;
  RdEn_tb=1'b1;
  Address_tb=3'b111;
  #TimeClk
  if(RdData_tb!=16'b001)
    $display("TEST case 3 at reg[7] failed");
  else
     $display("TEST case 3 at reg[7] success");
  
  #TimeClk
  WrEn_tb=1'b0;
  RdEn_tb=1'b1;
  Address_tb=3'b01;
  #TimeClk
  if(RdData_tb!=16'b11100)
    $display("TEST case 4 at reg[1] failed");
  else
     $display("TEST case 4 at reg[1] success");
     
  #100
  $stop;
  end
  
  always 
  #5 clk_tb=~clk_tb;
  
  //DUT inst
  Regfile DUT(
  .WrData(WrData_tb),
  .RdEn(RdEn_tb),
  .WrEn(WrEn_tb),
  .CLK(clk_tb),
  .RST(RST_tb),
  .Address(Address_tb),
  .RdData(RdData_tb)
  );
  
endmodule