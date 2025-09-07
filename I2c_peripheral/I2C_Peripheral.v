`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2025 09:45:02 AM
// Design Name: 
// Module Name: I2C_Peripheral
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


module I2C_Peripheral(
    input  wire       sys_clk,
    input  wire       SCL,        // system clock (fast compared to I2C bit rate)
    input  wire       read_ready,       // trigger a write transaction
    input  wire [6:0] address,    // 7-bit slave address
    input  wire [7:0] data_in,    // data byte to write
    output reg        ready = 0,
    output reg        ack_error = 0,
    output reg [7:0]  data_out,
    inout  wire       SDA
    );
    
    reg [3:0] data_counter;
    reg [2:0] state = IDLE;
    reg [7:0] control_data;
    reg [7:0] data_payload;
    reg start_cond;
    reg stop_init;
    
    reg start1 = 0;
    reg stop1 = 0;
    
    reg sda_drive = 0;
    
    reg [7:0]write_payload;
    reg write_enable;
    
    localparam IDLE        = 3'd0;
    localparam REC_control = 3'd1;
    localparam ACK_Ctrl    = 3'd2;
    localparam RW_DATA     = 3'd3;
    localparam ACK_DATA    = 3'd4;
    localparam STOP        = 3'd5;
    
    assign SDA = (sda_drive) ? 1'b0 : 1'bz;
    
    always@(posedge sys_clk) begin
        case(state)
            IDLE: begin
                if (start_cond) begin
                    if(SDA && SCL) begin
                        start_cond <= 0;
                        ready <= 1;
                        if(!control_data[0]) begin
                            data_out <= data_payload;
                        end
                    end
                end else if(start1) begin
                    if((!SDA)&&(!SCL)) begin
                        start_cond <= 1;
                        write_enable <= read_ready;
                        write_payload <= { ~data_in[0], ~data_in[1], ~data_in[2], ~data_in[3],~data_in[4], ~data_in[5], ~data_in[6], ~data_in[7] };
                        start1 <= 0;
                    end
                end else begin
                    if((!SDA)&&(SCL)) begin
                        start1 <= 1;
                        ready <= 0;
                    end
                end
            end
            default: begin
                start1 <= 0;
            end
        endcase
    end
    
    always@(posedge SCL) begin
        case(state) 
            IDLE: begin
                if(start_cond)begin
                    state <= REC_control;
                    data_counter <= 0;
                    control_data <= {control_data[6:0],SDA};
                end
            end
            REC_control: begin
                if(data_counter == 6) begin
                    state <= ACK_Ctrl;
                end
                    data_counter <= data_counter + 1;
                    control_data <= {control_data[6:0],SDA};
            end
            ACK_Ctrl: begin
                data_counter <= 0;
                if(control_data[0]) begin
                    if(write_enable) begin
                        state <= RW_DATA;
                        ack_error <= 0;
                    end else begin 
                        state <= STOP;
                        ack_error <= 1;
                    end
                end else begin
                    state <= RW_DATA;
                    ack_error <= 0;
                end
            end
            RW_DATA: begin
                if(data_counter == 7) begin
                    state <= ACK_DATA;
                end else begin
                    data_counter <= data_counter + 1;
                end
                if(!control_data[0]) begin
                    data_payload <= {data_payload[6:0],SDA};
                end
            end
            ACK_DATA: begin
                state <= STOP;
                if(control_data[0]) begin
                    if(!SDA) begin
                            ack_error <= 1;
                        end else begin
                            ack_error <= 0;
                        end
                end else begin
                    ack_error <= 0;
                end
            end
            STOP: begin
                state <= IDLE;
            end
        endcase
    end
    
    always@(negedge SCL) begin
        case(state) 
            ACK_Ctrl: begin
                if(control_data[7:1] == address) begin
                    if(!control_data[0]) begin
                        sda_drive <= 1;
                    end else begin
                        if(write_enable) begin
                            sda_drive <= 1;
                        end 
                    end
                end 
            end
            RW_DATA: begin
                    if(control_data[0]) begin
                        sda_drive <= write_payload[data_counter];
                    end else if(data_counter == 0) begin
                        sda_drive <= 0;
                    end
            end
            ACK_DATA: begin
                if(control_data[7:1] == address) begin
                    if(!control_data[0]) begin
                        sda_drive <= 1;
                    end else begin
                        sda_drive <= 0;
                    end
                end 
            end
            STOP: begin
                sda_drive <= 0;
            end
        endcase
    end

endmodule
