`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2025 04:21:49 PM
// Design Name: 
// Module Name: UART_Rx
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


module UART_Rx(
    input clk_100MHZ,
    input packet_in,
    input clear_buffer,
    output wire[7:0] data_out,
    output data_flag
    );
    
    
    assign data_out = shift_reg;
    assign data_flag = ready_flag;
    
    reg ready_flag;
    
    reg [26:0] counter = 0;

    reg [3:0] bit_index = 0;
    reg [7:0] shift_reg;
    reg receiving;
    reg start;

    always @(posedge clk_100MHZ) begin
        if (clear_buffer) begin
            bit_index <= 0;
            receiving <= 0;
            ready_flag <= 0;
        end
        
        if (~receiving && ~packet_in) begin
            // Start bit detected
            start <= 1;
            receiving <= 1;
            bit_index <= 0;
            counter <= 0;  
        end else if(start && receiving && (counter == 5_208)) begin
            start <= 0;
            counter <= 0;
        end
        else if (~start && receiving && (counter == 10_416)) begin
            if (bit_index < 8) begin
                shift_reg <= {packet_in, shift_reg[7:1]};
                bit_index <= bit_index + 1;
            end
            else if(bit_index == 8) begin
                if(packet_in) begin
                    ready_flag <= 1;
                end 
                bit_index <= bit_index + 1;
            end
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
        

    end
endmodule
