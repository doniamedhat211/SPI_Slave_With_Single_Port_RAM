module SPI_tb ();
reg MOSI_tb , SS_n_tb , sclk_tb , rst_n_tb ;
wire MISO_dut ;
SPI_Wrapper spi_wrapper (MOSI_tb , SS_n_tb , sclk_tb , rst_n_tb , MISO_dut) ;
initial begin
    sclk_tb = 0 ;
    forever 
    #1 sclk_tb = ~sclk_tb ;
end 
    initial begin 
        $readmemh("mem.dat",spi_wrapper.ram.mem);
        rst_n_tb=0;
        repeat(2)
        @(negedge sclk_tb);
        rst_n_tb=1;
        SS_n_tb=1;
        repeat(2)
        @(negedge sclk_tb);
        SS_n_tb=0;
        MOSI_tb=0;
        repeat(2)
        @(negedge sclk_tb);

        
        //write addr
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);


        SS_n_tb=1;
        repeat(2)
        @(negedge sclk_tb);
        SS_n_tb=0;
        MOSI_tb=0;
        repeat(2)
        @(negedge sclk_tb);

        //write data
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);


        SS_n_tb=1;
        repeat(2)
        @(negedge sclk_tb);
        SS_n_tb=0;
        MOSI_tb=1;
        repeat(2)
        @(negedge sclk_tb);

        //read addr
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);


        SS_n_tb=1;
        repeat(2)
        @(negedge sclk_tb);
        SS_n_tb=0;
        MOSI_tb=1;
        repeat(2)
        @(negedge sclk_tb);

        //read data
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=0;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        MOSI_tb=1;
        @(negedge sclk_tb);
        SS_n_tb=1;
    end
endmodule 