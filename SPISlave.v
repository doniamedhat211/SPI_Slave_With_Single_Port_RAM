module SPI_Slave (MOSI ,tx_data , tx_valid , sclk , rst_n , SS_n , MISO , rx_data , rx_valid );   //fsm 
input [7:0] tx_data ; 
input MOSI , tx_valid , sclk , rst_n , SS_n ;
output reg [9:0] rx_data ;
output reg MISO , rx_valid ;
parameter [2:0] IDLE = 3'b000 ;
parameter [2:0] CHK_CMD = 3'b001 ;
parameter [2:0] WRITE = 3'b010 ; 
parameter [2:0] READ_ADD = 3'b011 ;
parameter [2:0] READ_DATA = 3'b100 ;
(*fsm_encoding = "sequential"*) reg [2:0] cs , ns ;
reg read_check  ;
reg [3:0] counter ;
// next state logic 
always @(*) begin 
    case(cs)
        IDLE:begin
            if(SS_n) 
              ns = IDLE ;
            else
              ns = CHK_CMD ;
        end 
        CHK_CMD:begin
            if(SS_n)
              ns = IDLE ;
            else begin 
              if(~MOSI)
                ns = WRITE ;
              else begin
                if(read_check)
                  ns = READ_DATA ;
                else
                  ns = READ_ADD ;
              end 
            end 
        end
        WRITE:begin
            if(SS_n)
              ns = IDLE ;
            else
              ns = WRITE ; 
        end
        READ_ADD:begin
            if(SS_n)
              ns = IDLE ;
            else
              ns = READ_ADD ;
        end
        READ_DATA:begin
            if(SS_n)
              ns = IDLE ;
            else
              ns = READ_DATA ;
        end 
        default: ns = IDLE ;
    endcase
end 
// state memory 
always @(posedge sclk) begin
    if(~rst_n)
      cs <= IDLE ;
    else 
      cs <= ns ;
end 
// output logic 
always @(posedge sclk)
    if(~rst_n) begin
      rx_data <= 10'b0000000000 ;
      MISO <= 1'b0 ;
      rx_valid <= 1'b0 ;
      read_check <= 0;
      counter <= 9 ;
    end 
    else begin 
      case(cs) 
        WRITE:begin 
          case(counter)
            9:begin 
              rx_data[counter] <= MOSI;
              rx_valid <= 0 ;
              counter <= counter - 1 ;
            end
            0:begin
              rx_data[counter] <= MOSI ;
              rx_valid <= 1 ;
              counter <= 9 ;
            end
            default:begin
              rx_data[counter] <= MOSI ;
              rx_valid <= 0 ;
              counter <= counter - 1 ;
            end
          endcase 
        end 
        READ_ADD,READ_DATA:begin 
          case(counter) 
            9:begin
              rx_data[counter] <= MOSI ;
              rx_valid <= 0 ;
              counter <= counter - 1;
            end 
            8:begin
              if(~MOSI)begin
               read_check <= 1 ;
               rx_data[counter] <= MOSI ;
               rx_valid <= 0 ;
               counter <= counter - 1;
              end
              else begin
               read_check <= 0 ;
               rx_data[counter] <= MOSI ;
               rx_valid <= 1 ;
               counter <= counter - 1;
              end 
            end 
            0:begin 
              if(tx_valid) begin
                MISO <= tx_data[counter] ;
                counter <= 9;
              end 
              else begin
                rx_data[counter] <= MOSI ;
                rx_valid <= 1 ;
                counter <= 9 ;
              end 
            end 
            default:begin 
              if(tx_valid) begin
                MISO <= tx_data[counter] ;
                counter <= counter - 1 ;
              end 
              else begin
                rx_data[counter] <= MOSI ;
                rx_valid <= 0 ;
                counter <= counter - 1;
              end 
            end 
          endcase 
        end
        default: begin
            MISO <= 0 ;
            rx_data <= 0 ;
            rx_valid <= 0 ;
            counter <= 9;
        end 
     endcase
    end 
endmodule