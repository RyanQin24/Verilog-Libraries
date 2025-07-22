`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2025 06:26:35 PM
// Design Name: 
// Module Name: Seven_Seg_Mux
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


module Seven_Seg_Mux(
    input clock,
    input decimal_place_1,
    input decimal_place_2,
    input decimal_place_3,
    input decimal_place_4,
    input wire [6:0] dig1,
    input wire [6:0] dig2,
    input wire [6:0] dig3,
    input wire [6:0] dig4,
    output wire[7:0] dig_out,
    output wire [3:0] anode
    );
    
    reg clk_1kHz = 0;
    reg out = 0;
    reg [26:0] counter = 0;
    reg [1:0] sequencer = 0;
    
    reg [7:0] digit;
    reg [4:0] anode_reg;
    
    assign dig_out = digit;
    assign anode = anode_reg;
    
    always @(posedge clock) begin
        if (counter == 50_000 - 1) begin
            counter <= 0;
            clk_1kHz <= ~clk_1kHz;
        end else begin
            counter <= counter + 1;
        end
    end
    
    always @(posedge clk_1kHz) begin
        case(sequencer)
            2'b00: begin
            digit <= {~decimal_place_1,dig1};
            anode_reg <= 4'b0111;
            sequencer <= sequencer + 1;
            end
            2'b01: begin
            digit <= {~decimal_place_2,dig2};
            anode_reg <= 4'b1011;
            sequencer <= sequencer + 1;
            end
            2'b10: begin
            digit <= {~decimal_place_3,dig3};
            anode_reg <= 4'b1101;
            sequencer <= sequencer + 1;
            end
            2'b11: begin
            digit <= {~decimal_place_4,dig4};
            anode_reg <= 4'b1110;
            sequencer <= sequencer + 1;
            end
        endcase
    end
    
endmodule

