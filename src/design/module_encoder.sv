module module_encoder (
    input  logic [3:0] dip_switch, // Entrada de 4 bits dados por dip_switch
    output logic [2:0] parity_bits, // Bits de paridad calculados a partir de la entrada
    output logic [6:0] encoded_word // Salida de 7 bits que representa la palabra codificada
);
    logic x0, x1, x2, x3;
    assign{x0, x1, x2, x3} = dip_switch; // Asignación de los bits de entrada a variables individuales

    logic y1, y2, y4; //Bits de pariedad

    assign y1 = x0 ^ x1 ^ x3; // Cálculo del bit de paridad y1
    assign y2 = x0 ^ x2 ^ x3; // Cálculo del bit de paridad y2
    assign y3 = x1 ^ x2 ^ x3; // Cálculo del bit de paridad y3

assign encoded_word = {x3, x2, x1, y3, x0, y2, y1}; // Construcción de la palabra codificada con los bits de paridad y los bits de entrada
assign parity_bits = {y3, y2, y1}; // Asignación de los bits de paridad a la salida
endmodule