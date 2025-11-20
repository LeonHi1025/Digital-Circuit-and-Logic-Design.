module stimulus;
  
reg clk,reset;
wire [7:0]count;

Shift shift(count, clk,reset);

initial clk = 1'b0;
always #5 clk = ~clk;


initial
begin

// design your test case here
reset = 'b1;
#5 reset = 1'b0;
#20 reset = 1'b1;
#5 reset = 1'b0;

end

// Monitor the outputs 
initial
	$monitor($time, " Output count = %b",  count);


endmodule