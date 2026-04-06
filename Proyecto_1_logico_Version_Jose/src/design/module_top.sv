module module_top (
    input  logic [3:0] codigo_gray_pi,   // DIP Switch 1: Datos (Pines 28, 27, 26, 25)
    input  logic [2:0] pos_error_pi,     // DIP Switch 2: Posición (Pines 31, 32, 33)
    input  logic button,                 // Botón S1 (Pin 3)

    // Display 1: Mensaje de Entrada
    output logic [6:0] catodo_p0,        
    output logic [0:0] anodo_p0,         // Pin 56

    // Display 2: Mensaje Transmitido (Hamming)
    output logic [6:0] catodo_trans,     
    output logic [0:0] anodo_p1,         // Pin 79

    // LEDs Integrados: Monitor de Entrada
    output logic [3:0] codigo_bin_led_p0 
);

    // Señales internas
    logic [6:0] codeword;
    logic [6:0] word_with_error;
    logic [6:0] final_word;

    // 1. Codificador Hamming (7,4)
    module_encoder encoder (
        .dip_switch(codigo_gray_pi),
        .encoded_word(codeword),
        .parity_bits() // Ignoramos esta salida aquí si no la ocupamos
    );

    // 2. Inyector de Error
    module_error_injection error_injector (
        .encoded_word(codeword),
        .error_position(pos_error_pi),
        .error_injected_word(word_with_error)
    );

    // 3. Lógica del botón (Inyectar si se presiona y la posición es 0-6)
    // NOTA: Si el error se activa sin tocar el botón, cambia "button" por "!button"
    // Cambio de línea de código porque el módulo de inyección de error ya contempla estas variables
    // También se quitó el valid_position xq no hacía falta con el cambio anterior
    assign final_word = button ? word_with_error : codeword;


    // 4. Visualización en Display 1 (Entrada Original)
    module_bin_to_hexa display_entrada (
        .binary_input(codigo_gray_pi),
        .hex_output(catodo_p0)
    );

    // 5. Visualización en Display 2 (Palabra Transmitida)
    // Mostramos los 4 bits menos significativos de la palabra Hamming
    module_bin_to_hexa display_transmision (
        .binary_input(final_word[3:0]), 
        .hex_output(catodo_trans)
    );

    // 6. Activación de Ánodos (Asumiendo Cátodo Común, enviar 1 para activar)
    assign anodo_p0 = 1'b1; 
    assign anodo_p1 = 1'b1;

    // 7. LEDs de monitoreo
    assign codigo_bin_led_p0 = codigo_gray_pi;

endmodule