module tb_comparator(
    
);
reg [15:0] in1;
reg [15:0] in2;
wire signed [1:0] out;

initial begin
    #1 in1 = 16'habcd; in2 = 16'hcabd;
    #1 in1 = 16'hcaca; in2 = 16'h9999;
    #1 in =  16'heeee; in2 = 16'heeee;
    #1
    $finish;
end


comparator DUT(
    .in1(in1),
    .in2(in2),
    .out(out)

);
    

endmodule
