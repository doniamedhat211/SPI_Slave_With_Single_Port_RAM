module SPI_Wrapper (MOSI , SS_n , sclk , rst_n , MISO) ;
input MOSI , SS_n , sclk , rst_n ;
output MISO ; 
wire rx_valid ,tx_valid ;
wire [9:0] rx_data ;
wire [7:0] tx_data ;
SPI_Slave spi_slave (MOSI ,tx_data , tx_valid , sclk , rst_n , SS_n , MISO , rx_data , rx_valid);
RAM ram (rx_data , rx_valid , sclk , rst_n , tx_valid , tx_data) ;
endmodule 