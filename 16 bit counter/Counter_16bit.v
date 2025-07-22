`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 11:52:36 AM
// Design Name: 
// Module Name: Counter_16bit
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


module Counter_16bit(
    input clock,
    input increase,
    input decrease,
    input overflow_protect,
    output wire [15:0] count
    );
    
    reg[15:0] curcount = 6'h0000;
    
    assign count = curcount;
    
    always @(posedge clock) begin
        if(increase) begin
            if(~(overflow_protect && curcount == 16'hFFFF)) begin
                curcount <= curcount + 1;
            end 
        end else if (decrease) begin
            if(~(overflow_protect && curcount == 16'h0000)) begin
                curcount <= curcount - 1;
            end 
        end
    end
endmodule
