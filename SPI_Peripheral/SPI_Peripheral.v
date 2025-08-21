`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2025 08:27:12 AM
// Design Name: 
// Module Name: SPI_Peripheral
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


module SPI_Peripheral(
    (* IOB = "true" *)  // keep close to IO, avoid BUFG
    input clock,
    input chip_select,
    input write_mode,
    input Peripheral_in,
    input wire[7:0] write_data,
    output Peripheral_OUT,
    output write_ready_flag,
    output read_ready_flag,
    output reg [7:0] data_input
    );
    
    reg write_ready;
    reg read_ready;
    reg clock_stat;
    reg read;
    
    
    assign read_ready_flag = read_ready;
    assign write_ready_flag = write_ready;
    
    assign Peripheral_OUT = (chip_select) ?  write_data[write_stat_counter] : 1'bz;
    
    reg [2:0] read_stat_counter = 0;
    reg [2:0] write_stat_counter = 0;
    
    always @(posedge clock or negedge chip_select) begin
        if(~chip_select) begin
            read_stat_counter <= 0;
            write_stat_counter <= 0;
        end else begin
            if(~write_mode) begin
                if(read_stat_counter == 7) begin
                    data_input <= {Peripheral_in,data_input[7:1]};
                    read_stat_counter <= 0;
                    read_ready <= 1;
                end else begin
                    data_input <= {Peripheral_in,data_input[7:1]};
                    read_stat_counter <= read_stat_counter + 1;
                    read_ready <= 0;
                end
            end else begin
                if(write_stat_counter == 7) begin
                    write_stat_counter <= 0;
                    write_ready <= 1;
                end else begin
                    write_ready <= 0;
                    write_stat_counter <= write_stat_counter + 1;
                end
            end
        end
    end
    
endmodule
