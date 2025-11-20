module stimulus;

    reg [3:0] A, B;
    wire A_gt_B, A_eq_B, A_lt_B;

    Comparator cmp(A, B, A_gt_B, A_eq_B, A_lt_B);

    initial begin
        A = 0;
        B = 0;
    end

    always begin
        #10;
        if (B < 15) begin
            B = B + 1;
        end else begin
            B = 0;
            if (A < 15)
                A = A + 1;
            else
                $stop;
        end
    end

    initial begin
        $monitor($time, " ns: A=%d, B=%d | gt=%b eq=%b lt=%b",
                          A, B, A_gt_B, A_eq_B, A_lt_B);
    end

endmodule
