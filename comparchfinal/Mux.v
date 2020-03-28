/* 2-input multiplexor */  

module mux21 (out,a, b, select);

input a,b;
input select;  
output out;
wire s0,w0,w1; 

not (s0, select);
and (w0, s0, a),
(w1, select, b);
or(out, w0, w1); 

endmodule // mux2
 module mux2x5to5( AddrOut,Addr0, Addr1, Select);  
 output [4:0] AddrOut; // Address Out  
 input [4:0] Addr0, Addr1; // Address In 1 and 2  
 input Select;  
 mux21 mux0(AddrOut[0],Addr0[0],Addr1[0],Select);  
 mux21 mux1(AddrOut[1],Addr0[1],Addr1[1],Select);  
 mux21 mux2(AddrOut[2],Addr0[2],Addr1[2],Select);  
 mux21 mux3(AddrOut[3],Addr0[3],Addr1[3],Select);  
 mux21 mux4(AddrOut[4],Addr0[4],Addr1[4],Select);
 endmodule

 module mux2x32to32( AddrOut,Addr0, Addr1, Select);
 output [31:0] AddrOut; // Address Out  
 input [31:0] Addr0, Addr1; // Address In 1 and 2  
 input Select;
//  initial begin
//    if(Select==1'b1)  
//     AddrOut=Addr1;  
//     // begin
//     else if(Select==1'b0)
//     AddrOut=Addr0;
// //$display("%b",AddrOut); end
//  end
 //$display("%b",Addr0);$display("%b",Addr1);
assign AddrOut=(Select==0)?Addr0:Addr1;
 endmodule
