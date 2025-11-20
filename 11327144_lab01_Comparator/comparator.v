module Comparator (A, B, A_gt_B, A_eq_B, A_lt_B);

input  [3:0] A,B;
output A_gt_B, A_eq_B, A_lt_B;
wire x0, x1, x2, x3;

assign x0 = (A[0] & B[0]) | (~A[0] & ~B[0]); 
assign x1 = (A[1] & B[1]) | (~A[1] & ~B[1]); 
assign x2 = (A[2] & B[2]) | (~A[2] & ~B[2]); 
assign x3 = (A[3] & B[3]) | (~A[3] & ~B[3]); 

assign A_gt_B = (A[3] & ~B[3]) | (x3 & A[2] & ~B[2]) | (x3 & x2 & A[1] & ~B[1]) |
                (x3 & x2 & x1 & A[0] & ~B[0]);

assign A_lt_B = (~A[3] & B[3]) | (x3 & ~A[2] & B[2]) | (x3 & x2 & ~A[1] & B[1]) |
                (x3 & x2 & x1 & ~A[0] & B[0]);   

assign A_eq_B = x3 & x2 & x1 & x0;         

endmodule