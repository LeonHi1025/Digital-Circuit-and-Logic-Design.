module DFF(q, d, clk, reset);

  output q;
  input d, clk, reset;
  reg q;

  always @(posedge reset or negedge clk)
  if (reset)
    q = 1'b0;
  else 
        q = d;

endmodule

module MUX4_1(s0, s1, i0, i1, i2, i3, o);
  input s0, s1;
  input i0, i1, i2, i3;
  output o;
  wire y0, y1, y2, y3;

  // according to the provided circuit diagram(MUX)
  assign y0 = i0 & ~s1 & ~s0;
  assign y1 = i1 & ~s1 & s0;
  assign y2 = i2 & s1 & ~s0;
  assign y3 = i3 & s1 & s0;
  assign o = y0 | y1 | y2 | y3;

endmodule

module Shift_Register(i, s, o, clk, reset, r);
  
  wire [7:0] d;  // line D
  input [7:0] i; // input i0~i7
  input [1:0] s; // "00"->nothing, "01"->move left, "10"->move right, "11"->the same
  input clk, reset, r; 
  output [7:0] o;

  // according to the provided circuit diagram
  MUX4_1 mux0 (s[0], s[1], o[0], r, o[1], i[0], d[0]);    
  MUX4_1 mux1 (s[0], s[1], o[1], o[0], o[2], i[1], d[1]); 
  MUX4_1 mux2 (s[0], s[1], o[2], o[1], o[3], i[2], d[2]); 
  MUX4_1 mux3 (s[0], s[1], o[3], o[2], o[4], i[3], d[3]);  
  MUX4_1 mux4 (s[0], s[1], o[4], o[3], o[5], i[4], d[4]); 
  MUX4_1 mux5 (s[0], s[1], o[5], o[4], o[6], i[5], d[5]); 
  MUX4_1 mux6 (s[0], s[1], o[6], o[5], o[7], i[6], d[6]);   
  MUX4_1 mux7 (s[0], s[1], o[7], o[6], r, i[7], d[7]);

  // 
  DFF dff0(o[0], d[0], clk, reset);
  DFF dff1(o[1], d[1], clk, reset);
  DFF dff2(o[2], d[2], clk, reset);
  DFF dff3(o[3], d[3], clk, reset);
  DFF dff4(o[4], d[4], clk, reset);
  DFF dff5(o[5], d[5], clk, reset);
  DFF dff6(o[6], d[6], clk, reset);
  DFF dff7(o[7], d[7], clk, reset);


endmodule




  
