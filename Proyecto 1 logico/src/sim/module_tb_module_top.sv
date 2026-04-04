`timescale 1ns/1ps

module tb_module_top;

    // Señales de estímulo
    logic [3:0] entry;
    logic inject_error;

    // Entradas al DUT (estímulos)
    module_top dut (
        .codigo_gray_pi(entry), 
        .button(inject_error),
        .catodo_p0(),            
        .anodo_p0(),
        .codigo_bin_led_p0()
    );

    // Alias para facilitar la lectura de señales INTERNAS del DUT
    // Esto permite que el TB "vea" dentro del diseño
    wire [6:0] internal_codeword = dut.codeword;
    wire [6:0] internal_word_err = dut.word_with_error;

    initial begin
        $display("====================================================================");
        $display("   MODO     | ENTRY | POS ERR |  CODEWORD | WORD W/ ERR | FINAL OUT");
        $display("====================================================================");

        // Caso 1: SIN error (Button = 0)
        inject_error = 0;
        for (int i = 0; i < 4; i++) begin // Probamos 4 casos para no saturar consola
            entry = i;
            #10;
            $display(" NORMAL     |  %b  |    -    |  %b  |      -      |  %b", 
                     entry, internal_codeword, dut.final_word);
        end

        // Caso 2: CON error inyectado (Button = 1)
        inject_error = 1;
        // Probamos una entrada con diferentes posiciones de error
        entry = 4'b1011; 
        for (int j = 0; j < 7; j++) begin
            // Nota: En tu TOP, la posición del error viene de entry[2:0]
            // Para probar distintas posiciones, debemos cambiar 'entry'
            entry = {1'b1, j[2:0]}; 
            #10;
            $display(" INYECTADO  |  %b  |    %0d    |  %b  |   %b   |  %b", 
                     entry, entry[2:0], internal_codeword, internal_word_err, dut.final_word);
        end

        // Caso 3: POSICIÓN INVÁLIDA (Pos 7 según tu lógica)
        entry = 4'b1111; // 111 -> Posición 7
        inject_error = 1;
        #10;
        $display(" INVALIDO   |  %b  |    7    |  %b  |   %b   |  %b (DEBE SER IGUAL)", 
                 entry, internal_codeword, internal_word_err, dut.final_word);

        $display("====================================================================");
        $finish;
    end

    initial begin
        $dumpfile("tb_module_top.vcd");
        $dumpvars(0, tb_module_top);
    end
endmodule