module RAM (din , rx_valid , sclk , rst_n , tx_valid , dout);
parameter MEM_DEPTH = 256 ;
parameter ADDR_SIZE = 8 ;
input [9:0] din ;
input rx_valid , sclk , rst_n ;
output reg tx_valid ;
output reg [7:0] dout ;
reg [7:0] write_addr , read_addr ;
reg [7:0] mem [MEM_DEPTH-1:0] ;
always @(posedge sclk) begin
    if (~rst_n) begin
      dout <= 0;
      tx_valid <= 0; 
      write_addr <= 0 ;
      read_addr <= 0 ;
    end 
    else if (rx_valid) begin 
      case (din[9:8])
        2'b00: begin
          write_addr <= din[7:0];
          tx_valid <= 0;
        end
        2'b01: begin
          mem[write_addr] <= din[7:0];
          tx_valid <= 0;
        end
        2'b10: begin
          read_addr <= din[7:0];
          tx_valid <= 0;
        end
        2'b11: begin
          dout <= mem[read_addr];
          tx_valid <= 1;
        end
        default: tx_valid <= 0;
      endcase
    end
  end
endmodule