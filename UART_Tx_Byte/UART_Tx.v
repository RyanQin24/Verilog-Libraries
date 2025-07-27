`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 08:50:13 AM
// Design Name: 
// Module Name: UART_Tx
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


module UART_Tx(
    input clk_100MHZ,
    input transmit_enable,
    input wire[7:0] data_in,
    output packet,
    output busy_flag
    );
    
    reg [26:0] counter = 0;
    reg clock_9600_Baud = 0;
    reg startup;
    reg [7:0] ascii_buffer;
    reg [3:0] data_counter;
    reg data_out_buffer;
    reg busy_reg;
    
    assign packet = data_out_buffer;
    assign busy_flag = busy_reg;
    
    always @(posedge clk_100MHZ) begin
        if (counter == 5_208) begin
            counter <= 0;
            clock_9600_Baud = ~clock_9600_Baud;
        end else begin
            counter <= counter + 1;
        end
    end
    
    always @(posedge clock_9600_Baud) begin
        if (~startup) begin
            
            data_out_buffer <= 1;
            busy_reg <= 0;
            if(transmit_enable) begin
                ascii_buffer <= data_in;
                startup <= 1;
                data_counter <= 4'b1001;
            end else begin
                startup <= 0;
            end
        end else if(data_counter == 9) begin
            busy_reg <= 1;
            data_out_buffer <= 0;
            data_counter <= data_counter - 1;
        end else if(data_counter == 0) begin
            busy_reg <= 0;
            startup <= 0;
            data_out_buffer <= 1;
        end else begin
            busy_reg <= 0;
            data_out_buffer <= ascii_buffer[0];
            ascii_buffer <= {0,ascii_buffer[7:1]};
            data_counter <= data_counter - 1;
        end
    end
endmodule
