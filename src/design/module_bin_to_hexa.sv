module module_bin_to_hexa (
    input  logic [3:0] binary_input,// Entrada de 4 bits dados por deep_switch
    output logic [6:0] hex_output// Salida de 7 bits para el display de 7 segmentos
);

//Asignación de la salida del display de 7 segmentos según el valor de la entrada binaria
    assign hex_output = (binary_input == 4'b0000) ? 7'b0111111 : // 0
    (binary_input == 4'b0001) ? 7'b0000110 : // 1
    (binary_input == 4'b0010) ? 7'b1011011 : // 2
    (binary_input == 4'b0011) ? 7'b1001111 : // 3
    (binary_input == 4'b0100) ? 7'b1100110 : // 4
    (binary_input == 4'b0101) ? 7'b1101101 : // 5
    (binary_input == 4'b0110) ? 7'b1111101 : // 6
    (binary_input == 4'b0111) ? 7'b0000111 : // 7
    (binary_input == 4'b1000) ? 7'b1111111 : // 8
    (binary_input == 4'b1001) ? 7'b1101111 : // 9
    (binary_input == 4'b1010) ? 7'b1110111 : // A
    (binary_input == 4'b1011) ? 7'b1111100 : // b
    (binary_input == 4'b1100) ? 7'b0111001 : // C
    (binary_input == 4'b1101) ? 7'b1011110 : // d
    (binary_input == 4'b1110) ? 7'b1111001 : // E
    (binary_input == 4'b1111) ? 7'b1110001 : // F
                              7'b0000000;    

endmodule