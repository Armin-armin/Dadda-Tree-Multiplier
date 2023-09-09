`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// Project Group: Leyla                                  //
// Group Members: Armin Asgharifard, Emrecan Yigit       //
// Project Completion Date: 07/12/2022                   //
// Project Name: Dadda Multiplier                        //
// Target Device: Nexys4 DDR                             //
///////////////////////////////////////////////////////////

module FA(
    input x,
    input y,
    input ci,
    output s, 
    output cout
    );

    wire s1, cout1, cout2;
    
    HA HA1(.x(x), .y(y), .cout(cout1), .s(s1));
    HA HA2(.x(ci), .y(s1), .cout(cout2), .s(s));    
    or(cout, cout1, cout2);
endmodule