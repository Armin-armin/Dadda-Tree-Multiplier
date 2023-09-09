`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// Project Group: Leyla                                  //
// Group Members: Armin Asgharifard, Emrecan Yigit       //
// Project Completion Date: 07/12/2022                   //
// Project Name: Dadda Multiplier                        //
// Target Device: Nexys4 DDR                             //
///////////////////////////////////////////////////////////

module dadda_tb();
    // the stimulus txt file must be stored in "D:\"
    // the results of the simulation will also be stored in "D:\"
    reg [15:0] memory [1:200];
    reg [15:0] a;
    reg [15:0] b;
    wire [31:0] result;
    integer i, file;
    
    dadda_mul dadda(a, b, result);
    
    wire [31:0] tmp;
    assign tmp = a*b;
    
    initial
    begin
        $readmemb("D:\random_numbers.txt", memory);
        file = $fopen("D:\results.txt", "a");
        $fmonitor(file, "A = b'%0b' = %0d   B = b'%0b' = %0d    Obtained_Result = b'%0b' = %0d  Expected_Result = b'%0b' = %0d  Status = %0s", a, a, b, b, result, result, tmp, tmp, tmp == result ? "TRUE" : "FALSE");
        $monitor(file, "A = b'%0b' = %0d   B = b'%0b' = %0d    Obtained_Result = b'%0b' = %0d  Expected_Result = b'%0b' = %0d  Status = %0s", a, a, b, b, result, result, tmp, tmp, tmp == result ? "TRUE" : "FALSE");
        for (i = 1; i <= 200; i = i + 2)
        begin
            a = memory [i];
            b = memory [i + 1];
            #10;
        end        
        $finish;
    end
endmodule

