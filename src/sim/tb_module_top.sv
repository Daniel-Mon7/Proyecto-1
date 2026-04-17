`timescale 1ns / 1ps

module tb_module_top();

    // Señales de prueba
    logic [3:0] t_switch;
    logic [2:0] t_pos_error;
    
    logic [6:0] t_catodo_p0;
    logic       t_anodo_p0;
    logic [6:0] t_salida;
    logic [3:0] t_led;

    // Instancia del módulo (DUT)
    module_top dut (
        .switch(t_switch),
        .pos_error(t_pos_error),
        .catodo_p0(t_catodo_p0),
        .anodo_p0(t_anodo_p0),
        .salida(t_salida),
        .led(t_led)
    );

    // Procedimiento de prueba
    initial begin
        $display("\n==============================================================");
        $display("   TESTBENCH: VERIFICACIÓN DE INYECCIÓN DE ERROR HAMMING (7,4)");
        $display("==============================================================");
        $display(" Data | Codigo Base | Pos. Error | Palabra Final |  Estado");
        $display("--------------------------------------------------------------");

        // --- Caso 1: Sin error ---
        t_switch = 4'b1011; // Dato original
        t_pos_error = 3'b000; 
        #10;
        print_status("OK ");

        // --- Caso 2: Error en Bit 1 (p1) ---
        t_pos_error = 3'b001; 
        #10;
        print_status("ERR");

        // --- Caso 3: Error en Bit 7 (d4) ---
        t_pos_error = 3'b111; 
        #10;
        print_status("ERR");

        // --- Caso 4: Cambio de dato y error en Bit 4 (p3) ---
        t_switch = 4'b0110;
        t_pos_error = 3'b100; 
        #10;
        print_status("ERR");

        $display("--------------------------------------------------------------");
        $display("Simulacion finalizada.");
        $finish;
    end

    
    task print_status(input string label);
        $display(" %b  |   %b   |     %0d      |    %b    |  [%s]", 
                 t_switch, dut.codeword, t_pos_error, t_salida, label);
    endtask

initial begin
        $dumpfile("tb_module_top.vcd");  // For waveform viewing
        $dumpvars(0, tb_module_top);
    end

endmodule