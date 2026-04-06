`timescale 1ns/1ps

module tb_bin_to_hexa;

    logic [3:0] binary_input;
    logic [6:0] hex_output;

    module_bin_to_hexa dut (
        .binary_input(binary_input),
        .hex_output(hex_output)
    );

    initial begin
        $dumpfile("tb_bin_to_hexa.vcd");
        $dumpvars(0, tb_bin_to_hexa);

        $display("==============================================");
        $display("Inicio testbench module_bin_to_hexa");
        $display("==============================================");

        binary_input = 4'b0000; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0001; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0010; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0011; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0100; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0101; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0110; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b0111; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1000; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1001; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1010; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1011; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1100; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1101; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1110; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        binary_input = 4'b1111; #10;
        $display("in=%b out=%b", binary_input, hex_output);

        $display("==============================================");
        $display("Fin testbench module_bin_to_hexa");
        $display("==============================================");

        $finish;
    end

endmodule