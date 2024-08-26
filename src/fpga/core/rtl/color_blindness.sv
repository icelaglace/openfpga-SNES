// Original module by Marcus Andrade (Boogermann)
module color_blindness
(
    input  wire [23:0] rgb_in,
    input  wire  [1:0] deficiency,
    output reg  [23:0] rgb_out
);

    wire [7:0] R_in = rgb_in[23:16];
    wire [7:0] G_in = rgb_in[15:8];
    wire [7:0] B_in = rgb_in[7:0];

    reg [15:0] R_temp, G_temp, B_temp;

    always @(*) begin
        case (deficiency)
            2'd0: rgb_out = rgb_in; // Bypass
            2'd1: begin // Deuteranopia
                R_temp = (R_in * 16'd160 + G_in * 16'd96) >> 8;
                G_temp = (R_in * 16'd179 + G_in * 16'd77) >> 8;
                B_temp = (G_in * 16'd77  + B_in * 16'd179) >> 8;
                rgb_out = {R_temp[7:0], G_temp[7:0], B_temp[7:0]};
            end
            2'd2: begin // Protanopia
                R_temp = (R_in * 16'd145 + G_in * 16'd111) >> 8;
                G_temp = (R_in * 16'd143 + G_in * 16'd113) >> 8;
                B_temp = (G_in * 16'd61  + B_in * 16'd194) >> 8;
                rgb_out = {R_temp[7:0], G_temp[7:0], B_temp[7:0]};
            end
            2'd3: begin // Tritanopia
                R_temp = (R_in * 16'd243 + G_in * 16'd13) >> 8;
                G_temp = (G_in * 16'd111 + B_in * 16'd145) >> 8;
                B_temp = (G_in * 16'd121 + B_in * 16'd134) >> 8;
                rgb_out = {R_temp[7:0], G_temp[7:0], B_temp[7:0]};
            end
        endcase
    end
endmodule