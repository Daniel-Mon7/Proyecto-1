module module_error_injection (
    input  logic [6:0] encoded_word, // Entrada de 7 bits que representa la palabra codificada
    input  logic [2:0] error_position, // Entrada de 3 bits que indica la posición del bit a invertir
    output logic [6:0] error_injected_word // Salida de 7 bits que representa la palabra codificada con el error inyectado
);

always @(*) begin
    error_injected_word = encoded_word; // Inicialización de la salida con la palabra codificada original

    // Inversión del bit en la posición indicada por error_position
    case (error_position)
        3'b000: error_injected_word = ~encoded_word[0]; // Invertir el bit 0
        3'b001: error_injected_word = ~encoded_word[1]; // Invertir el bit 1
        3'b010: error_injected_word = ~encoded_word[2]; // Invertir el bit 2
        3'b011: error_injected_word = ~encoded_word[3]; // Invertir el bit 3
        3'b100: error_injected_word = ~encoded_word[4]; // Invertir el bit 4
        3'b101: error_injected_word = ~encoded_word[5]; // Invertir el bit 5
        3'b110: error_injected_word = ~encoded_word[6]; // Invertir el bit 6
        default: error_injected_word = encoded_word; // Si no se selecciona una posición válida, no se inyecta ningún error
    endcase
    
end
endmodule