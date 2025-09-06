`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2025 09:22:34 PM
// Design Name: 
// Module Name: I2C_Host
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


module I2C_Host(
    input  wire       clk,        // system clock (fast compared to I2C bit rate)
    input  wire       send,       // trigger a write transaction
    input  wire [6:0] address,    // 7-bit slave address
    input  wire [7:0] data_in,    // data byte to write
    input read_only,
    output reg        busy = 0,
    output reg        ack_error = 0,
    output reg [7:0]  data_send,
    output wire       SCL,
    inout  wire       SDA
);


    localparam IDLE      = 3'd0;
    localparam START     = 3'd1;
    localparam SEND_ADDR = 3'd2;
    localparam ACK_ADDR  = 3'd3;
    localparam RW_DATA   = 3'd4;
    localparam ACK_DATA  = 3'd5;
    localparam STOP      = 3'd6;
    localparam DELAY     = 3'd6;

    reg [2:0] state = IDLE;
    reg [3:0] counter = 0;        
    reg [7:0] adreg;              
    reg [7:0] write_reg;
    reg [7:0] data_reg;

    reg scl_drive = 0;         
    reg read;  
    reg sda_drive = 0;            
    reg sda_out   = 0;      
    
    reg [7:0] data_out;      

    assign SCL = (scl_drive) ? 1'b0 : 1'bz;
    assign SDA = (sda_drive) ? 1'b0 : 1'bz;


    always @(posedge clk) begin
        case(state)
            IDLE: begin
                busy <= 0;
                scl_drive <= 0;   // release SCL
                sda_drive <= 0;   // release SDA
                if(send) begin
                    busy <= 1;
                    adreg <= {address,read_only};
                    if(!read_only)begin
                        write_reg <= data_in;
                    end
                    read <= read_only;
                    counter <= 0;
                    ack_error <= 0;
                    sda_drive <= 1;
                    sda_out   <= 0;
                    state <= START;
                end
            end

            START: begin
                // Generate START: SDA goes low while SCL high
                scl_drive <= 1;   // let SCL be low
                state <= SEND_ADDR;
                counter <= 0;
            end

            SEND_ADDR: begin
                if(counter == 0) begin
                    sda_drive <= ~adreg[7];
                    adreg <= {adreg[6:0],1'b0};
                    counter <= 1;
                end else begin
                    scl_drive <= ~scl_drive;
                    if(scl_drive) begin
                            counter <= counter +1;
                    end else begin
                        adreg <= {adreg[6:0],1'b0};
                        sda_drive <= ~adreg[7];
                        if(counter == 9) begin
                            sda_drive <= 0;
                            counter <= 0;
                            state <= ACK_ADDR;
                        end
                    end
                end
            end

            ACK_ADDR: begin
                scl_drive <= ~scl_drive;
                if(scl_drive) begin
                    if(SDA) begin
                    ack_error <= 1;
                    end
                end else begin
                    if(ack_error) begin
                        sda_drive <= 1;
                        state <= STOP;
                    end else begin
                        state <= RW_DATA;
                    end
                end
            end

            RW_DATA: begin
                if(counter == 0) begin
                    if(!read) begin
                        sda_drive <= ~write_reg[7];
                        write_reg <= {write_reg[6:0],1'b0};
                    end
                    counter <= 1;
                end else begin
                    scl_drive <= ~scl_drive;
                    if(scl_drive) begin
                            counter <= counter +1;
                            if(read) begin
                                data_reg <= {data_reg,SDA};
                            end
                    end else begin
                        if(counter == 9) begin
                            sda_drive <= 0;
                            counter <= 0;
                            state <= ACK_DATA;
                        end else begin
                            if(!read) begin
                                write_reg <= {write_reg[6:0],1'b0};
                                sda_drive <= ~write_reg[7];
                            end
                        end
                    end
                end
            end

            ACK_DATA: begin
                scl_drive <= ~scl_drive;
                if(scl_drive) begin
                    if(SDA && (!read)) begin
                        ack_error <= 1;
                    end
                end else begin
                    sda_drive <= 1;
                    state <= STOP;
                end
            end

            STOP: begin
                if (counter == 1) begin
                    sda_drive <= 0;
                    state <= IDLE;
                    if(read) begin
                        data_send <= data_reg;
                    end
                end else begin 
                    counter <= 1;
                    scl_drive <= 0;
                    sda_drive <= 1;   
                end
            end
        endcase
    end
endmodule

