
module ALU (clk, a, b, c, sel, result);
  output reg[4:0] result;
  input  clk;
  input  [3:0] a, b, c;
  input  [2:0] sel;

  function [4:0] Max;
    input [3:0] x1, x2, x3;
    begin
      if (x1 > x2 && x1 > x3) Max = x1;
      else if (x2 > x3)        Max = x2;
      else                      Max = x3;
    end
  endfunction

  always @(posedge clk) begin
    case(sel)
      3'b000: result = Max(a, b, c);
      3'b001: result = a + b;
      3'b010: result = a - b;
      3'b011: result = a / b;
      3'b100: result = a % b;
      3'b101: result = a << 1;
      3'b110: result = a >> 1;
      3'b111: result = a > b;
    endcase
  end

endmodule
