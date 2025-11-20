module stimulus;

  reg clk, reset, r;
  reg [7:0] i;
  reg [1:0] s;
  wire [7:0] o;

  // Instantiate your Shift_Register
  Shift_Register U0(i, s, o, clk, reset, r);

  // Clock generator
  always #5 clk = ~clk;

  initial begin
    clk = 0;

    reset = 1'b1; 
    i     = 8'b00000000; 
    s     = 2'b00; 
    r     = 1'b0;       // reset ???????? 0

    #5 reset = 1'b0;
    
    #5 i = 8'b10100101; s = 2'b11; // ?????output = 10100101

    #10 s = 2'b00;  // ???output = 10100101

    #10 s = 2'b01;  // ???output = 01001010

    #10 s = 2'b10; r = 1'b1; // ???????=1?output = 10100101
  end

endmodule

