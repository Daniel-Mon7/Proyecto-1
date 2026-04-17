module module_top (
    input  logic [3:0] switch,   
    input  logic [2:0] pos_error,     
    // Display 1: Mensaje de Entrada
    output logic [6:0] catodo_p0,        
    output logic anodo_p0,         // Pin 56

    // Display 2: Mensaje Transmitido (Hamming)
    output logic [6:0] salida,     

    // LEDs Integrados: Monitor de Entrada
    output logic [3:0] led 
);

    // Señales internas
    logic [6:0] codeword;
    logic [6:0] word_with_error;
    logic [6:0] final_word;

    // 1. Codificador Hamming (7,4)
    module_encoder encoder (
        .dip_switch(switch),
        .encoded_word(codeword),
        .parity_bits() // Ignoramos esta salida es nada para el testbench
    );

    // 2. Inyector de Error
    module_error_injection error_injector (
        .encoded_word(codeword),
        .error_position(pos_error),
        .error_injected_word(word_with_error)
    );

    assign final_word = word_with_error;

    // 4. Visualización en el Display  (Entrada Original)
    module_bin_to_hexa display_entrada (
        .binary_input(switch),
        .hex_output(catodo_p0)
    );

    // 5. Activación de Ánodos (Asumiendo Cátodo Común, enviar 1 para activar)
    assign anodo_p0 = 1'b1; 
    assign anodo_p1 = 1'b1;
    assign salida = final_word; // Invertimos para cátodo común

    // 6. LEDs de monitoreo en la FPGA
    assign led = ~switch;

endmodule