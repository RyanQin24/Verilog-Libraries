`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2025 11:23:32 AM
// Design Name: 
// Module Name: Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder(
    input wire[3:0] number,
    output wire [6:0] seg
    );
    
    assign seg = (number == 4'b0000) ? 7'b1000000 :
                 (number == 4'b0001) ? 7'b1111001 :
                 (number == 4'b0010) ? 7'b0100100 :
                 (number == 4'b0011) ? 7'b0110000 :
                 (number == 4'b0100) ? 7'b0011001 :
                 (number == 4'b0101) ? 7'b0010010 :
                 (number == 4'b0110) ? 7'b0000010 :
                 (number == 4'b0111) ? 7'b1111000 :
                 (number == 4'b1000) ? 7'b0000000 :
                 (number == 4'b1001) ? 7'b0010000 :
                 (number == 4'b1010) ? 7'b0001000 :
                 (number == 4'b1011) ? 7'b0000011 :
                 (number == 4'b1100) ? 7'b0100111 :
                 (number == 4'b1101) ? 7'b0100001 :
                 (number == 4'b1110) ? 7'b0000110 :
                 (number == 4'b1111) ? 7'b0001110 :
                 7'b1111111;
endmodule
