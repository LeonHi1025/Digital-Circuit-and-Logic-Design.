module vending_machine(clk , reset , coin , drink_choose , total_money , state , exchange , drink_out);

input clk , reset;
input [7:0] coin;
input [2:0] drink_choose;
output reg [7:0] total_money;
output reg [2:0] state;
output reg [7:0] exchange;
output reg [7:0] drink_out;

parameter tea = 8'd10;
parameter coke = 8'd15;
parameter coffee = 8'd20;
parameter milk = 8'd25;

// 狀態定義 [cite: 5-8]
parameter s0 = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;

reg [2:0] next_state;
reg [7:0] current_money;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        exchange <= 8'd0;
        total_money <= 8'd0;
        drink_out <= 8'd0;
        state <= s0;
    end else begin
        state <= next_state;
        case(next_state)
            s0, s1: begin
                if (coin == 1 || coin == 5 || coin == 10 || coin == 50) begin
                    total_money <= total_money + coin;
                end
                drink_out <= 8'd0;
                exchange <= 8'd0;
            end
            s2: begin
                drink_out <= drink_choose; // 飲料輸出 [cite: 46]
                case(drink_choose)
                    3'd1: begin current_money <= tea; end
                    3'd2: begin current_money <= coke; end
                    3'd3: begin current_money <= coffee; end
                    3'd4: begin current_money <= milk; end
                    default: begin current_money <= 8'd0; end
                endcase
            end
            s3: begin
                exchange <= total_money - current_money; // 找錢邏輯 [cite: 16, 45, 61]
                total_money <= 8'd0;
            end
        endcase
    end
end

always @(*) begin
    case(state)
        s0: begin
            if (total_money >= tea) begin
                next_state = s1;
            end else begin
                next_state = s0;
            end
        end
        s1: begin
            if (drink_choose >= 3'd1 && drink_choose <= 3'd4) begin
                next_state = s2; 
            end else begin
                next_state = s1;
            end
        end
        s2: begin
            next_state = s3; 
        end
        s3: begin
            next_state = s0;
        end
        default: begin
            next_state = s0;
        end
    endcase
end

always @(posedge clk) begin
    if (reset == 1'b0) begin
        if (coin == 1 || coin == 5 || coin == 10 || coin == 50) begin
            $write("coin %d,\t total %d" , coin , total_money + coin);
            if ((total_money + coin) >= tea) begin
                $write("\ttea"); // 不會換行
                if ((total_money + coin) >= coke) begin
                    $write(" | coke");
                end
                if ((total_money + coin) >= coffee) begin
                    $write(" | coffee");
                end
                if ((total_money + coin) >= milk) begin
                    $write(" | milk");
                end
                $display(""); // 換行
            end else begin
              $display("");
            end
        end
        
        if (state == s2) begin
            case(drink_out)
                8'd1: begin $display("tea out"); end
                8'd2: begin $display("coke out"); end
                8'd3: begin $display("coffee out"); end
                8'd4: begin $display("milk out"); end
            endcase
        end
        
        if (state == s3) begin
            $display("exchange %d dollars\n" , exchange);
        end
    end
end

endmodule