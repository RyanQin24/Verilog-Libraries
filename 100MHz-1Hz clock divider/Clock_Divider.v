`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 11:48:31 AM
// Design Name: 
// Module Name: Clock_Divider
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


module Clock_Divider(
    input clk_100MHZ,
    output clk_1Hz
    );
    
    reg [26:0] counter = 0;
    reg clock = 0;
    
    assign clk_1Hz = clock;
    
    always @(posedge clk_100MHZ) begin
        if (counter == 50_000_000 - 1) begin
            counter <= 0;
            clock = ~clock;
        end else begin
            counter <= counter + 1;
        end
    end
    
endmodule
