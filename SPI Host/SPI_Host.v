`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 06:11:12 PM
// Design Name: 
// Module Name: SPI_Host
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


module SPI_Host(
    input clock,
    input readmode,
    input data_ready,
    input Host_in,
    input wire[7:0] data_input,
    output Host_OUT,
    output clock_out,
    output busy_flag,
    output reg [7:0] data_output
    );
    
    reg busy_reg;
    reg clock_stat;
    reg read;
    
    reg [7:0] data_in;
    reg [3:0] stat_counter = 0;
    
    assign Host_OUT = data_in[0];
    assign clock_out = clock_stat;
    assign busy_flag = busy_reg;
    
    always @(posedge clock) begin
        if(data_ready) begin
            if(~readmode) begin
                data_in <= data_input;
            end else begin
                data_output[7] <= Host_in;
            end
            read <= readmode;
            clock_stat <= 0;
            busy_reg <= 1;
            stat_counter <= 3'b000;
        end else if (busy_reg) begin
            if(stat_counter == 8) begin
                clock_stat <= 0;
                busy_reg <= 0;
            end else begin
                if(clock_stat) begin
                    clock_stat <= 0;
                    if(read) begin
                        data_output <= {Host_in,data_output[7:1]};
                    end else begin
                        data_in <= {0,data_in[7:1]};
                    end
                end else begin
                    clock_stat <= 1;
                    stat_counter <= stat_counter + 1;
                end
            end
        end
    end
endmodule

