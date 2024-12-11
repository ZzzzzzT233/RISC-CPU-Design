module address_decoder (MemWrite,Addr,RAM_CS,RAM_WE,ROM_CS,UART_WR, UART_RD, CE_SR,CE_UART);

   input MemWrite;
   input [31:0] Addr;
   output reg	RAM_CS;
   output reg	RAM_WE;
   output reg	ROM_CS;
   output reg 	UART_WR;
   output reg 	UART_RD;
   output reg 	CE_UART;
   output reg 	CE_SR;

   // The memory map has non-volatile ROM (32 bits wide) from 
   // address 0x00000000 to 0x000003FF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0000 0011 1111 1111 = 0x000003FF

   // The memory map has volatile RAM memory from
   // address 0x00000400 to address 0x0000004FF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0000 0100 0000 0000 = 0x00000400
   // 0000 0000 0000 0000 0000 0100 1111 1111 = 0x000004FF

   always @* begin
      RAM_CS = 1'b0;
      RAM_WE = 1'b0;
      ROM_CS = 1'b0;
      UART_WR = 1'b0;
      UART_RD = 1'b0;
      CE_SR = 1'b0;
      CE_UART = 1'b0;

      if (Addr >=  32'h0 && Addr <= 32'h3FF)
      begin
         ROM_CS <= 1;
      end

      else if(Addr >=  32'h400 && Addr <= 32'h4FF)
      begin
         RAM_CS <= 1;
         RAM_WE <= MemWrite;
      end

      else if(Addr == 32'h500)
      begin
         CE_UART <= 1;
         if(MemWrite)begin
            UART_WR <= 1;
         end
         else begin
            UART_RD <= 1;
         end
      end

      else if(Addr == 32'h504)
      begin
         UART_RD <= 1;
         CE_SR <= 1;
      end
   end

endmodule