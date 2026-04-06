module module_encoder (
    input  logic [3:0] dip_switch, // Entrada de 4 bits dados por dip_switch
    output logic [2:0] parity_bits, // Bits de paridad calculados a partir de la entrada
    output logic [6:0] encoded_word // Salida de 7 bits que representa la palabra codificada
);
    logic x3, x5, x6, x7;
    assign{x3, x5, x6, x7} = dip_switch; // Asignación de los bits de entrada a variables individuales

    logic y1, y2, y4; //Bits de pariedad

    assign y1 = x3 ^ x5 ^ x7; // Cálculo del bit de paridad y1
    assign y2 = x3 ^ x6 ^ x7; // Cálculo del bit de paridad y2
    assign y4 = x5 ^ x6 ^ x7; // Cálculo del bit de paridad y4

assign encoded_word = {y1, y2, x3, y4, x5, x6, x7}; // Construcción de la palabra codificada con los bits de paridad y los bits de entrada
assign parity_bits = {y1, y2, y4}; // Asignación de los bits de paridad a la salida
endmodule