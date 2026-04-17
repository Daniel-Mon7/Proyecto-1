`timescale 1ns/1ps

module tb_error_injection;

    logic [6:0] encoded_word;
    logic [2:0] error_position;
    logic [6:0] error_injected_word;

    module_error_injection dut (
        .encoded_word(encoded_word),
        .error_position(error_position),
        .error_injected_word(error_injected_word)
    );

    initial begin
        $dumpfile("tb_error_injection.vcd");
        $dumpvars(0, tb_error_injection);

        $display("==============================================");
        $display("Inicio testbench module_error_injection");
        $display("==============================================");

        // Palabra base
        encoded_word = 7'b0000001;

        // Caso 1: sin error
        error_position = 3'b000; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 2: invertir bit 0
        error_position = 3'b001; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 3: invertir bit 1
        error_position = 3'b010; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 4: invertir bit 2
        error_position = 3'b011; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 5: invertir bit 3
        error_position = 3'b100; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 6: invertir bit 4
        error_position = 3'b101; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 7: invertir bit 5
        error_position = 3'b110; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        // Caso 8: invertir bit 6
        error_position = 3'b111; #10;
        $display("pos=%b in=%b out=%b", error_position, encoded_word, error_injected_word);

        $display("==============================================");
        $display("Fin testbench module_error_injection");
        $display("==============================================");

        $finish;
    end

endmodule