module comparator(
    input [15:0] in1,
    input [15:0] in2,
    output signed [1:0] out
);
    wire gt_low, eq_low, lt_low;
    wire gt_high, eq_high, lt_high;


    comp_8 DUT_COMP_LOW (
         .in1(in1[7:0]),
         .in2(in2[7:0]),
         .gt(gt_low),
         .eq(eq_low),
         .lt(lt_low)
    );
    
    comp_8 DUT_COMP_HIGH (
         .in1(in1[15:8]),
         .in2(in2[15:8]),
         .gt(gt_high),
         .eq(eq_high),
         .lt(lt_high)
    );
    
    
    reg signed [1:0] out_reg;
    
    wire greater = gt_high || (eq_high && gt_low);
    wire less = lt_high || (eq_high && lt_low);
    
    always @(*) begin
        casex({greater, less})
            2'b1x: out_reg = 2'sb01; // 1
            2'b01: out_reg = 2'sb11; // -1
            default: out_reg = 2'sb01; // 1
        endcase
    end
    
    assign out = out_reg;

endmodule

module comp_8(
    input [7:0] in1,
    input [7:0] in2,
    output gt, eq, lt
);
    wire gt_low, eq_low, lt_low;
    wire gt_high, eq_high, lt_high;

    comp_4 DUT_COMP_LOW (
         .in1(in1[3:0]),
         .in2(in2[3:0]),
         .gt(gt_low),
         .eq(eq_low),
         .lt(lt_low)
    );
    
    comp_4 DUT_COMP_HIGH (
         .in1(in1[7:4]),
         .in2(in2[7:4]),
         .gt(gt_high),
         .eq(eq_high),
         .lt(lt_high)
    );
    
    reg gt_reg, eq_reg, lt_reg;
    
    wire greater = gt_high || (eq_high && gt_low);
    wire less = lt_high || (eq_high && lt_low);

    always @(*) begin
        casex({greater, less})
            2'b1x: {gt_reg, eq_reg, lt_reg} = 3'b100;
            2'b01: {gt_reg, eq_reg, lt_reg} = 3'b001;
            default: {gt_reg, eq_reg, lt_reg} = 3'b010;
        endcase
    end

    assign gt = gt_reg;
    assign eq = eq_reg;
    assign lt = lt_reg;
    

endmodule

module comp_4(
    input [3:0] in1, // edit:signed 
    input [3:0] in2,
    output gt, eq, lt
);
    wire gt_low, eq_low, lt_low;
    wire gt_high, eq_high, lt_high;

    comp_2 DUT_COMP_LOW (
         .in1(in1[1:0]),
         .in2(in2[1:0]),
         .gt(gt_low),
         .eq(eq_low),
         .lt(lt_low)
    );
    
    comp_2 DUT_COMP_HIGH (
         .in1(in1[3:2]),
         .in2(in2[3:2]),
         .gt(gt_high),
         .eq(eq_high),
         .lt(lt_high)
    );
    
    
    reg gt_reg, eq_reg, lt_reg;
    
    wire greater = gt_high || (eq_high && gt_low);
    wire less = lt_high || (eq_high && lt_low);

    always @(*) begin
        casex({greater, less})
            2'b1x: {gt_reg, eq_reg, lt_reg} = 3'b100;
            2'b01: {gt_reg, eq_reg, lt_reg} = 3'b001;
            default: {gt_reg, eq_reg, lt_reg} = 3'b010;
        endcase
    end

    assign gt = gt_reg;
    assign eq = eq_reg;
    assign lt = lt_reg;
    

endmodule


module comp_2(
    input [1:0] in1,
    input [1:0] in2,
    output gt, eq, lt
);
    wire gt_low, eq_low, lt_low;
    wire gt_high, eq_high, lt_high;

    comp_1 DUT_COMP_LOW (
         .in1(in1[0]),
         .in2(in2[0]),
         .gt(gt_low),
         .eq(eq_low),
         .lt(lt_low)
    );
    
    comp_1 DUT_COMP_HIGH (
         .in1(in1[1]),
         .in2(in2[1]),
         .gt(gt_high),
         .eq(eq_high),
         .lt(lt_high)
    );
    
    
    reg gt_reg, eq_reg, lt_reg;
    
    wire greater = gt_high || (eq_high && gt_low);
    wire less = lt_high || (eq_high && lt_low);

    always @(*) begin
        casex({greater, less})
            2'b1x: {gt_reg, eq_reg, lt_reg} = 3'b100;
            2'b01: {gt_reg, eq_reg, lt_reg} = 3'b001;
            default: {gt_reg, eq_reg, lt_reg} = 3'b010;
        endcase
    end
    
    
    assign gt = gt_reg;
    assign eq = eq_reg;
    assign lt = lt_reg;
    

endmodule

module comp_1(
    input in1,
    input in2,
    output gt, eq, lt
);
    
    assign gt = in1 && (!in2);
    assign eq = ~(in1 ^ in2);
    assign lt = (!in1) && in2;
    

endmodule