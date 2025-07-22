`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 11:40:02 PM
// Design Name: 
// Module Name: Synchronizer
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


module Synchronizer(
    input clock,
    input data_in,
    input reset,
    output data_out
    );
    reg  sync1 = 1'b0;
    reg  sync2 = 1'b0;
    assign data_out = sync2;
    always @(posedge clock) begin
        if(reset)begin
            sync1 <= 1'b0;
	    sync2 <= 1'b0;
        end else begin
        sync1 <= data_in;
        sync2 <= sync1;
        end
    end
endmodule
