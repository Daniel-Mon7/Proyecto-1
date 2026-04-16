# Proyecto-1

## 1.Abreviaturas
-**FPGA**: Field Programable Gate Arrays

-**MSB**: Most Significant Bit

-**LSB**: Least Significant Bit

-**HDL**: Hardware Descrition Language

## 2. Desarrollo
### 2.0 Descripción general del sistema


El sistema implementado consiste en la generación y transmición de una palabra que posteriormente será procesada por el receptor. 
Para lograr este proceso se generara una palabra de 4 bits generada por un dip switch, se le realizara un proceso de códificación en donde se le añadirá los bits de pariedad en las posiciónes 0, 1 y 3. Esta palabra ya códificada se le podrá introducir un error en la posición deseada mediante un segundo dip switch (0 a 6).


## 2.1 Módulo 1
### Módulo encoder

```
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

```
#### Funcionamiento
Este módulo tiene como entrada los 4 bits que da el dip switch, este mismo es controlado por el usuario.
Una vez ingresada la palabra se extraen el MSB y los bits 0, 1 y 2 para generar los bits de pariedad (y<sub>n</sub>) mediante dos XOR.
Para el primer bit de pariedad se usan los bits 0, 1 y MSB y se realiza la función XOR entre el bit 0 y el bit 1, y el resultado de este mismo se le realiza la segunda función XOR con el MSB.
Este proceso se repite con los otros dos bits de pariedad con la diferencia que para el segundo se reemplaza el bit 1 por el 2 y para el tercer bit de pariedad se reemplaza el LSB por el bit 1.
Al final este módulo devuelve la palabra códificada.


## 2.2 Módulo 2
### Módulo inyector de error

```
module module_error_injection (
    input  logic [6:0] encoded_word, // Entrada de 7 bits que representa la palabra codificada
    input  logic [2:0] error_position, // Entrada de 3 bits que indica la posición del bit a invertir
    output logic [6:0] error_injected_word // Salida de 7 bits que representa la palabra codificada con el error inyectado
);

always @(*) begin
    error_injected_word = encoded_word; // Inicialización de la salida con la palabra codificada original

    // Inversión del bit en la posición indicada por error_position
    case (error_position)
        3'b000: error_injected_word = encoded_word;      // sin error
        3'b001: error_injected_word[0] = ~encoded_word[0]; // Invertir bit 0
        3'b010: error_injected_word[1] = ~encoded_word[1]; // Misma idea hasta el 7
        3'b011: error_injected_word[2] = ~encoded_word[2];
        3'b100: error_injected_word[3] = ~encoded_word[3];
        3'b101: error_injected_word[4] = ~encoded_word[4];
        3'b110: error_injected_word[5] = ~encoded_word[5];
        3'b111: error_injected_word[6] = ~encoded_word[6]; // Invertir bit 7
    endcase
    
end
endmodule

```
#### Funcionamiento

Este módulo es el encargado de "meter" el error, para esto recibe tanto la palabra códificada como la posición de error (determinada por el usuario en el segundo dip switch); mediante la sentencia always al momento de que ocurra un cambio en el dip switch se busca entre los posibles casos para realizar el cambio.
La sentencia case contiene todas las posibles combinaciones validas de este dip switch y dependiendo el caso en el que se encuentre se negará el bit en la posición deseada.
Cabe aclarar esté código fue creado para que cuando el dip switch este en 000 el mensaje se transmita sin error.


## 2.3 Módulo 3
### Módulo binario a hexadecimal
```
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

```
Este módulo lo que nos permite es la visualización de la palabra que estemos queriendo transmitir en un 7 segmentos
