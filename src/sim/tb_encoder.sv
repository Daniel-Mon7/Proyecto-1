`timescale 1ns/1ps

module tb_encoder;

    logic [3:0] dip_switch;
    logic [2:0] parity_bits;
    logic [6:0] encoded_word;

    module_encoder dut (
        .dip_switch(dip_switch),
        .parity_bits(parity_bits),
        .encoded_word(encoded_word)
    );

    initial begin
        $display("Inicio testbench module_encoder");

        dip_switch = 4'b0000; #10;
        $display("dip_switch=%b parity_bits=%b encoded_word=%b", dip_switch, parity_bits, encoded_word);

        dip_switch = 4'b0001; #10;
        $display("dip_switch=%b parity_bits=%b encoded_word=%b", dip_switch, parity_bits, encoded_word);

        dip_switch = 4'b0010; #10;
        $display("dip_switch=%b parity_bits=%b encoded_word=%b", dip_switch, parity_bits, encoded_word);

        dip_switch = 4'b1011; #10;
        $display("dip_switch=%b parity_bits=%b encoded_word=%b", dip_switch, parity_bits, encoded_word);

        dip_switch = 4'b1111; #10;
        $display("dip_switch=%b parity_bits=%b encoded_word=%b", dip_switch, parity_bits, encoded_word);

        $display("eso fue todo amigos");

        $finish;
    end

endmodule