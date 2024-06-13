# 16-Bit Adder

## Description

This repository contains the Verilog code for a 16-bit adder module implemented using a combination of a ripple carry adder and a carry lookahead adder. The design consists of a top-level module `adder16` which instantiates four 4-bit adder modules (`adder4`).

## Design Overview

### 16-Bit Adder (`adder16`)

The `adder16` module takes two 16-bit input vectors (`x` and `y`) and produces a 16-bit sum output (`z`). It also generates several status flags:

- **sign**: Indicates the sign of the result (most significant bit of the sum).
- **carry**: Indicates if there is a carry out of the most significant bit.
- **zero**: Indicates if the result is zero.
- **parity**: Indicates if the number of 1s in the result is even.
- **overflow**: Indicates if there is an arithmetic overflow.

The `adder16` module uses four instances of the `adder4` module to perform the addition. Carry-out from each 4-bit block is propagated to the next block.

### 4-Bit Adder (`adder4`)

The `adder4` module is a 4-bit adder implemented using carry lookahead logic to improve performance compared to a simple ripple carry adder. It takes two 4-bit inputs (`a` and `b`), and an input carry (`cin`). It produces a 4-bit sum (`s`) and a carry-out (`cout`).

## Modules

### `adder16` Module

#### Ports

- `input [15:0] x, y`: 16-bit inputs.
- `output [15:0] z`: 16-bit sum output.
- `output sign`: Sign bit of the result.
- `output carry`: Carry out of the most significant bit.
- `output zero`: Zero flag.
- `output parity`: Parity flag.
- `output overflow`: Overflow flag.

#### Internal Signals

- `wire [3:1] c`: Intermediate carry signals between the 4-bit adders.

#### Instantiation

Four `adder4` instances are used to build the 16-bit adder:

```verilog
adder4 A0 (z[3:0], c[1], x[3:0], y[3:0], 1'b0);
adder4 A1 (z[7:4], c[2], x[7:4], y[7:4], c[1]);
adder4 A2 (z[11:8], c[3], x[11:8], y[11:8], c[2]);
adder4 A3 (z[15:12], carry, x[15:12], y[15:12], c[3]);
```

#### Flag Assignments

```verilog
assign sign = z[15];
assign zero = ~|z;
assign parity = ~|z;
assign overflow = (x[15] & y[15] & ~z[15]) | (~x[15] & ~y[15] & z[15]);
```

### `adder4` Module

#### Ports

- `input [3:0] a, b`: 4-bit inputs.
- `input cin`: Carry input.
- `output [3:0] s`: 4-bit sum output.
- `output cout`: Carry out.

#### Internal Signals

- `wire p0, g0, p1, g1, p2, g2, p3, g3`: Propagate and generate signals.
- `wire c1, c2, c3`: Carry signals.

#### Logic

Carry lookahead logic is used to calculate the sum and carry out:

```verilog
assign p0 = a[0] ^ b[0], p1 = a[1] ^ b[1], p2 = a[2] ^ b[2], p3 = a[3] ^ b[3];
assign g0 = a[0] & b[0], g1 = a[1] & b[1], g2 = a[2] & b[2], g3 = a[3] & b[3];
assign c1 = g0 | (p0 & cin);
assign c2 = g1 | (p1 & g0) | (p1 & p0 & cin);
assign c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & cin);
assign cout = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & p0 & cin);
assign s[0] = p0 ^ cin;
assign s[1] = p1 ^ c1;
assign s[2] = p2 ^ c2;
assign s[3] = p3 ^ c3;
```

## Usage

To use this design in your project, include the `adder16` and `adder4` modules in your Verilog source files. Instantiate the `adder16` module and connect the inputs and outputs as needed.

## Example

```verilog
module testbench;
    reg [15:0] x, y;
    wire [15:0] z;
    wire sign, carry, zero, parity, overflow;
    
    adder16 uut (
        .x(x),
        .y(y),
        .z(z),
        .sign(sign),
        .carry(carry),
        .zero(zero),
        .parity(parity),
        .overflow(overflow)
    );
    
    initial begin
        // Test case
        x = 16'h1234;
        y = 16'h5678;
        #10; // Wait for result
        $display("x = %h, y = %h, z = %h, sign = %b, carry = %b, zero = %b, parity = %b, overflow = %b", x, y, z, sign, carry, zero, parity, overflow);
    end
endmodule
```



## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## Contact

For any questions or inquiries, please open an issue on this GitHub repository.
```
