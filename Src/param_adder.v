`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// Project Group: Leyla                                  //
// Group Members: Armin Asgharifard, Emrecan Yigit       //
// Project Completion Date: 07/12/2022                   //
// Project Name: Dadda Multiplier                        //
// Target Device: Nexys4 DDR                             //
///////////////////////////////////////////////////////////

module parametric_RCA #(
    parameter SIZE = 31)(
    x, y, ci, s, cout
    );
    
    input [(SIZE-1):0] x, y;
    input ci;
    output [(SIZE-1):0] s;
    output cout;
    
    wire [SIZE:0] tmp;
    
    assign tmp[0] = ci;
    assign cout = tmp[SIZE];
    
    genvar j;
    generate
        for(j = 0; j < SIZE; j = j + 1)
        begin : FA_loop
            FA fa_n(x[j], y[j], tmp[j], s[j], tmp[j+1]);
        end
    endgenerate
endmodule