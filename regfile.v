module Regfile  #(parameter ADDRESS=3,
                            Width=16,
                            Depth=8
)
  (
input  wire [Width-1:0]  WrData, 
input  wire              RdEn,
input  wire              WrEn,
input  wire              CLK,
input  wire              RST,
input  wire [Depth-1:0]  Address,
output reg  [Width-1:0]  RdData
);
// register file of 8 registers each of 16 bits width
reg [Width-1:0] regarr [Depth-1:0];//2D array of 8 reg each on 16 bit 
integer Counter;
always@(posedge CLK or negedge RST)
begin
  if(!RST)
    begin
      for(Counter=0; Counter<Depth;Counter=Counter+1)
        begin
          regarr[Counter]<=0;//rest all registers
        end
    end
  else if(WrEn && !RdEn)
    begin
      regarr[Address]<=WrData;
    end
  else if (RdEn && !WrEn)
    begin
      RdData<=regarr[Address];
    end
end
endmodule