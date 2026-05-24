module top_tb();

reg clk, rst_n;
reg [7:0] pixels [0:783];
reg [9:0] img_idx;
reg [7:0] data_in;

wire [3:0] decision;
wire valid_out_6;

// Module Instantiation
cnn_mnist dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .decision(decision),
        .valid_out(valid_out_6)
);

// Clock generation
always #5 clk = ~clk;

// Read image text file
initial begin
  $readmemh("3_0.txt", pixels);
  clk <= 1'b0;
  rst_n <= 1'b1;
  #3
  rst_n <= 1'b0;
  #3
  rst_n <= 1'b1;
end

always @(posedge clk) begin
  if(~rst_n) begin
    img_idx <= 0;
  end else begin
    if(img_idx < 10'd784) begin
      img_idx <= img_idx + 1'b1;
    end
    data_in <= pixels[img_idx];
  end
end

endmodule
