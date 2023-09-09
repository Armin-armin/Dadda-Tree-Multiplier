`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// Project Group: Leyla                                  //
// Group Members: Armin Asgharifard, Emrecan Yigit       //
// Project Completion Date: 07/12/2022                   //
// Project Name: Dadda Multiplier                        //
// Target Device: Nexys4 DDR                             //
///////////////////////////////////////////////////////////

module HA(
    input x,
    input y,
    output s,
    output cout
    );
    
    assign cout = x & y;
    assign s = x ^ y;
    
endmodule
