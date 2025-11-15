vlib work
vlog SPISlave.v SPItb.v SPIWrapper.v Single_Port_SYNCH_RAM.v
vsim -voptargs=+acc work.SPI_tb
add wave *
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/spi_slave/tx_data \
sim:/SPI_tb/spi_wrapper/spi_slave/tx_valid \
sim:/SPI_tb/spi_wrapper/spi_slave/rx_data \
sim:/SPI_tb/spi_wrapper/spi_slave/rx_valid \
sim:/SPI_tb/spi_wrapper/spi_slave/read_check \
sim:/SPI_tb/spi_wrapper/spi_slave/counter
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/ram/din \
sim:/SPI_tb/spi_wrapper/ram/dout \
sim:/SPI_tb/spi_wrapper/ram/write_addr \
sim:/SPI_tb/spi_wrapper/ram/read_addr \
sim:/SPI_tb/spi_wrapper/ram/mem
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/spi_slave/cs
run -all
#quit -sim