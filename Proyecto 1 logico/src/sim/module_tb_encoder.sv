`timescale 1ns / 1ps

module module_encoder_tb();

    logic [3:0] dip_switch_tb;
    logic [2:0] parity_bits_tb;
    logic [6:0] encoded_word_tb;
    int i; 

    // Instancia del módulo
    module_encoder uut (
        .dip_switch(dip_switch_tb),
        .parity_bits(parity_bits_tb),
        .encoded_word(encoded_word_tb)
    );

    initial begin
        $display("===================================================");
        $display(" Entrada (DIP) | Paridad (y1y2y4) | Palabra Final ");
        $display("===================================================");

        for (i = 0; i < 16; i = i + 1) begin
            dip_switch_tb = i[3:0]; 
            #10;
            $display("      %b     |       %b        |    %b", 
                     dip_switch_tb, parity_bits_tb, encoded_word_tb);
        end

        $display("===================================================");
        $display("Simulación terminada.");
        $finish;
    end

    initial begin
        $dumpfile("module_encoder_tb.vcd");
        $dumpvars(0, module_encoder_tb);
    end

endmodule