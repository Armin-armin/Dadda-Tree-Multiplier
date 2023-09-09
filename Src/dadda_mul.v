`timescale 1ns / 1ps

///////////////////////////////////////////////////////////
// Project Group: Leyla                                  //
// Group Members: Armin Asgharifard, Emrecan Yigit       //
// Project Completion Date: 07/12/2022                   //
// Project Name: Dadda Multiplier                        //
// Target Device: Nexys4 DDR                             //
///////////////////////////////////////////////////////////

(* DONT_TOUCH = "TRUE" *)
module dadda_mul(
    input [15:0] A,
    input [15:0] B,
    output [31:0] MULT    
    );
    
    wire [30:0] x, y; // inputs to the final adder
    wire [30:0] MUL; // sum output of the final adder
    wire cout; // carry output of the final adder
    
    //stages of Dadda tree
    wire [16:0] stage1 [0:16];
    wire [16:0] stage2 [0:16];
    wire [16:0] stage3 [0:16];
    wire [16:0] stage4 [0:16];
    wire [16:0] stage5 [0:16];
    wire [16:0] stage6 [0:16];
    wire [16:0] stage7 [0:16];

    genvar i, j;
    for (i = 0; i <= 15; i = i + 1)
    begin
        for (j = 0; j <= 15; j = j + 1)
        begin
            assign stage1[i][j] = B[i] & A[j];
            assign stage1[j][16] = 1'b0;
        end
    end
           

    //stage1 to stage2 connection
    FA FA1(stage1[3][15], stage1[4][14], stage1[5][13], stage2[5][13], stage2[3][16]);
    FA FA2(stage1[5][12], stage1[6][11], stage1[7][10], stage2[7][10], stage2[4][14]);
    FA FA3(stage1[2][15], stage1[3][14], stage1[4][13], stage2[6][11], stage2[3][15]);
    HA HA1(stage1[7][9] , stage1[8][8] , stage2[8][8] , stage2[5][12]);     
    FA FA4(stage1[4][12], stage1[5][11], stage1[6][10], stage2[7][9],  stage2[4][13]);
    FA FA5(stage1[1][15], stage1[2][14], stage1[3][13], stage2[6][10], stage2[3][14]);
    HA HA2(stage1[6][9] , stage1[7][8] , stage2[7][8] , stage2[5][11]);     
    FA FA6(stage1[3][12], stage1[4][11], stage1[5][10], stage2[6][9],  stage2[4][12]);
    FA FA7(stage1[0][15], stage1[1][14], stage1[2][13], stage2[5][10], stage2[3][13]);
    HA HA3(stage1[3][11], stage1[4][10], stage2[4][10], stage2[4][11]);     
    FA FA8(stage1[0][14], stage1[1][13], stage1[2][12], stage2[3][11], stage2[3][12]);
    HA HA0(stage1[0][13], stage1[1][12], stage2[1][12], stage2[2][12]);
    
    assign stage2[15] = stage1[15] ;      
    assign stage2[14] = stage1[14];
    assign stage2[13] = stage1[13];
    assign stage2[12] = stage1[12];
    assign stage2[11] = stage1[11];
    assign stage2[10] = stage1[10];
    assign stage2[9] = stage1[9];
    assign stage2[8][15:9] = stage1[8][15:9] ;
    assign stage2[8][7:0] = stage1[8][7:0]  ;
    assign stage2[7][15:11] = stage1[7][15:11];
    assign stage2[7][7:0] = stage1[7][7:0]  ;
    assign stage2[6][15:12] = stage1[6][15:12];
    assign stage2[6][8:0] = stage1[6][8:0]  ;
    assign stage2[5][15:14] = stage1[5][15:14];
    assign stage2[5][9:0] = stage1[5][9:0]  ;
    assign stage2[4][15] = stage1[4][15]   ;
    assign stage2[4][9:0] = stage1[4][9:0]  ;
    assign stage2[3][10:0] = stage1[3][10:0] ;
    assign stage2[2][11:0] = stage1[2][11:0] ;
    assign stage2[1][11:0] = stage1[1][11:0] ;
    assign stage2[0][12:0] = stage1[0][12:0] ;    
    
    assign stage2[8][15] = stage1[8][15]  ;
    assign stage2[0][8:0] = stage1[0][8:0] ;
    assign stage2[1][7:0] = stage1[1][7:0] ;
    assign stage2[2][7:0] = stage1[2][7:0] ;
    assign stage2[3][6:0] = stage1[3][6:0] ;
    assign stage2[4][5:0] = stage1[4][5:0] ;
    assign stage2[5][5:0] = stage1[5][5:0] ;
    assign stage2[6][4:0] = stage1[6][4:0] ;
    assign stage2[7][3:0] = stage1[7][3:0] ;
    assign stage2[8][3:0] = stage1[8][3:0] ;
    assign stage2[9][2:0] = stage1[9][2:0] ;
    assign stage2[10][1:0] = stage1[10][1:0];
    assign stage2[11][1:0] = stage1[11][1:0];
    assign stage2[12][0] = stage1[12][0]  ;
    assign stage2[13][0] = stage1[13][0]  ;
    assign stage2[14][0] = stage1[14][0]  ;            
    
    
    // stage2 to stage3 connection
    FA FA10(stage2[7][15], stage2[8][14], stage2[9][13], stage3[9][13], stage3[7][16]);
    FA FA11(stage2[9][12], stage2[10][11],stage2[11][10],stage3[11][10],stage3[8][14]);
    FA FA12(stage2[6][15], stage2[7][14], stage2[8][13], stage3[10][11],stage3[7][15]);
    FA FA13(stage2[11][9], stage2[12][8], stage2[13][7], stage3[13][7], stage3[9][12]);
    FA FA14(stage2[8][12], stage2[9][11], stage2[10][10],stage3[12][8], stage3[8][13]);
    FA FA15(stage2[5][15], stage2[6][14], stage2[7][13], stage3[11][9], stage3[7][14]);
    FA FA16(stage2[12][7], stage2[13][6], stage2[14][5], stage3[14][5], stage3[10][10]);
    FA FA17(stage2[9][10], stage2[10][9], stage2[11][8], stage3[13][6], stage3[9][11]);
    FA FA18(stage2[6][13], stage2[7][12], stage2[8][11], stage3[12][7], stage3[8][12]);
    FA FA19(stage2[3][16], stage2[4][15], stage2[5][14], stage3[11][8], stage3[7][13]);
    FA FA20(stage2[12][6], stage2[13][5], stage2[14][4], stage3[14][4], stage3[10][9]);
    FA FA21(stage2[9][9],  stage2[10][8], stage2[11][7], stage3[13][5], stage3[9][10]);
    FA FA22(stage2[6][12], stage2[7][11], stage2[8][10], stage3[12][6], stage3[8][11]);
    FA FA23(stage2[3][15], stage2[4][14], stage2[5][13], stage3[11][7], stage3[7][12]);
    FA FA24(stage2[12][5], stage2[13][4], stage2[14][3], stage3[14][3], stage3[10][8]);
    FA FA25(stage2[9][8],  stage2[10][7], stage2[11][6], stage3[13][4], stage3[9][9]);
    FA FA26(stage2[6][11], stage2[7][10], stage2[8][9],  stage3[12][5], stage3[8][10]);
    FA FA27(stage2[3][14], stage2[4][13], stage2[5][12], stage3[11][6], stage3[7][11]);
    FA FA28(stage2[12][4], stage2[13][3], stage2[14][2], stage3[14][2], stage3[10][7]);
    FA FA29(stage2[9][7],  stage2[10][6], stage2[11][5], stage3[13][3], stage3[9][8]);
    FA FA30(stage2[6][10], stage2[7][9],  stage2[8][8],  stage3[12][4], stage3[8][9]);
    FA FA31(stage2[3][13], stage2[4][12], stage2[5][11], stage3[11][5], stage3[7][10]);
    FA FA32(stage2[12][3], stage2[13][2], stage2[14][1], stage3[14][1], stage3[10][6]);
    FA FA33(stage2[9][6],  stage2[10][5], stage2[11][4], stage3[13][2], stage3[9][7]);
    FA FA34(stage2[6][9],  stage2[7][8],  stage2[8][7],  stage3[12][3], stage3[8][8]);
    FA FA35(stage2[3][12], stage2[4][11], stage2[5][10], stage3[11][4], stage3[7][9]);
    FA FA36(stage2[11][3], stage2[12][2], stage2[13][1], stage3[13][1], stage3[10][5]);
    FA FA37(stage2[8][6],  stage2[9][5],  stage2[10][4], stage3[12][2], stage3[9][6]);
    FA FA38(stage2[5][9],  stage2[6][8],  stage2[7][7],  stage3[11][3], stage3[8][7]);
    FA FA39(stage2[2][12], stage2[3][11], stage2[4][10], stage3[10][4], stage3[7][8]);
    FA FA40(stage2[10][3], stage2[11][2], stage2[12][1], stage3[12][1], stage3[9][5]);
    FA FA41(stage2[7][6],  stage2[8][5],  stage2[9][4],  stage3[11][2], stage3[8][6]);
    FA FA42(stage2[4][9],  stage2[5][8],  stage2[6][7],  stage3[10][3], stage3[7][7]);
    FA FA43(stage2[1][12], stage2[2][11], stage2[3][10], stage3[9][4],  stage3[6][8]);
    HA HA4(stage2[9][3],   stage2[10][2], stage3[10][2], stage3[8][5]);
    FA FA44(stage2[6][6],  stage2[7][5],  stage2[8][4],  stage3[9][3],  stage3[7][6]);
    FA FA45(stage2[3][9],  stage2[4][8],  stage2[5][7],  stage3[8][4],  stage3[6][7]);
    FA FA46(stage2[0][12], stage2[1][11], stage2[2][10], stage3[7][5],  stage3[5][8]);
    HA HA5 (stage2[6][5],  stage2[7][4],  stage3[7][4],  stage3[6][6]);
    FA FA47(stage2[3][8],  stage2[4][7],  stage2[5][6],  stage3[6][5],  stage3[5][7]);
    FA FA48(stage2[0][11], stage2[1][10], stage2[2][9],  stage3[5][6],  stage3[4][8]);
    HA HA6 (stage2[3][7],  stage2[4][6],  stage3[4][6],  stage3[4][7]);
    FA FA49(stage2[0][10], stage2[1][9],  stage2[2][8],  stage3[3][7],  stage3[3][8]);
    HA HA7 (stage2[0][9],  stage2[1][8],  stage3[1][8],  stage3[2][8]);
    
    assign stage3[15]       = stage2[15] ;      
    assign stage3[14][15:6] = stage2[14][15:6] ;
    assign stage3[13][15:8] = stage2[13][15:8] ;
    assign stage3[12][15:9] = stage2[12][15:9] ;
    assign stage3[11][15:11]= stage2[11][15:11];
    assign stage3[10][15:12]= stage2[10][15:12];
    assign stage3[9][15:14] = stage2[9][15:14] ;
    assign stage3[8][15]    = stage2[8][15]    ;
    
    assign stage3[0][8:0] = stage2[0][8:0] ;
    assign stage3[1][7:0] = stage2[1][7:0] ;
    assign stage3[2][7:0] = stage2[2][7:0] ;
    assign stage3[3][6:0] = stage2[3][6:0] ;
    assign stage3[4][5:0] = stage2[4][5:0] ;
    assign stage3[5][5:0] = stage2[5][5:0] ;
    assign stage3[6][4:0] = stage2[6][4:0] ;
    assign stage3[7][3:0] = stage2[7][3:0] ;
    assign stage3[8][3:0] = stage2[8][3:0] ;
    assign stage3[9][2:0] = stage2[9][2:0] ;
    assign stage3[10][1:0] = stage2[10][1:0];
    assign stage3[11][1:0] = stage2[11][1:0];
    assign stage3[12][0]  = stage2[12][0]  ;
    assign stage3[13][0]  = stage2[13][0]  ;
    assign stage3[14][0]  = stage2[14][0]  ;
    
    
    //stage3 to stage4 connection    
    FA FA50(stage3[10][15], stage3[11][14], stage3[12][13], stage4[12][13], stage4[10][16]);
    FA FA51(stage3[12][12], stage3[13][11], stage3[14][10], stage4[14][10], stage4[11][14]);
    FA FA52(stage3[9][15],  stage3[10][14], stage3[11][13], stage4[13][11], stage4[10][15]);
    FA FA53(stage3[13][10], stage3[14][9],  stage3[15][8],  stage4[15][8],  stage4[12][12]);
    FA FA54(stage3[10][13], stage3[11][12], stage3[12][11], stage4[14][9],  stage4[11][13]);
    FA FA55(stage3[7][16],  stage3[8][15],  stage3[9][14],  stage4[13][10], stage4[10][14]);
    FA FA56(stage3[13][9],  stage3[14][8],  stage3[15][7],  stage4[15][7],  stage4[12][11]);
    FA FA57(stage3[10][12], stage3[11][11], stage3[12][10], stage4[14][8],  stage4[11][12]);
    FA FA58(stage3[7][15],  stage3[8][14],  stage3[9][13],  stage4[13][9],  stage4[10][13]);
    FA FA59(stage3[13][8],  stage3[14][7],  stage3[15][6],  stage4[15][6],  stage4[12][10]);
    FA FA60(stage3[10][11], stage3[11][10], stage3[12][9],  stage4[14][7],  stage4[11][11]);
    FA FA61(stage3[7][14],  stage3[8][13],  stage3[9][12],  stage4[13][8],  stage4[10][12]);
    FA FA62(stage3[13][7],  stage3[14][6],  stage3[15][5],  stage4[15][5],  stage4[12][9]);
    FA FA63(stage3[10][10], stage3[11][9],  stage3[12][8],  stage4[14][6],  stage4[11][10]);
    FA FA64(stage3[7][13],  stage3[8][12],  stage3[9][11],  stage4[13][7],  stage4[10][11]);
    FA FA65(stage3[13][6],  stage3[14][5],  stage3[15][4],  stage4[15][4],  stage4[12][8]);
    FA FA66(stage3[10][9],  stage3[11][8],  stage3[12][7],  stage4[14][5],  stage4[11][9]);
    FA FA67(stage3[7][12],  stage3[8][11],  stage3[9][10],  stage4[13][6],  stage4[10][10]);
    FA FA68(stage3[13][5],  stage3[14][4],  stage3[15][3],  stage4[15][3],  stage4[12][7]);
    FA FA69(stage3[10][8],  stage3[11][7],  stage3[12][6],  stage4[14][4],  stage4[11][8]);
    FA FA70(stage3[7][11],  stage3[8][10],  stage3[9][9],   stage4[13][5],  stage4[10][9]);
    FA FA71(stage3[13][4],  stage3[14][3],  stage3[15][2],  stage4[15][2],  stage4[12][6]);
    FA FA72(stage3[10][7],  stage3[11][6],  stage3[12][5],  stage4[14][3],  stage4[11][7]);
    FA FA73(stage3[7][10],  stage3[8][9],   stage3[9][8],   stage4[13][4],  stage4[10][8]);
    FA FA74(stage3[13][3],  stage3[14][2],  stage3[15][1],  stage4[15][1],  stage4[12][5]);
    FA FA75(stage3[10][6],  stage3[11][5],  stage3[12][4],  stage4[14][2],  stage4[11][6]);
    FA FA76(stage3[7][9],   stage3[8][8],   stage3[9][7],   stage4[13][3],  stage4[10][7]);
    FA FA77(stage3[13][2],  stage3[14][1],  stage3[15][0],  stage4[15][0],  stage4[12][4]);
    FA FA78(stage3[10][5],  stage3[11][4],  stage3[12][3],  stage4[14][1],  stage4[11][5]);
    FA FA79(stage3[7][8],   stage3[8][7],   stage3[9][6],   stage4[13][2],  stage4[10][6]);
    FA FA80(stage3[12][2],  stage3[13][1],  stage3[14][0],  stage4[14][0],  stage4[12][3]);
    FA FA81(stage3[9][5],   stage3[10][4],  stage3[11][3],  stage4[13][1],  stage4[11][4]);
    FA FA82(stage3[6][8],   stage3[7][7],   stage3[8][6],   stage4[12][2],  stage4[10][5]);
    FA FA83(stage3[11][2],  stage3[12][1],  stage3[13][0],  stage4[13][0],  stage4[11][3]);
    FA FA84(stage3[8][5],   stage3[9][4],   stage3[10][3],  stage4[12][1],  stage4[10][4]);
    FA FA85(stage3[5][8],   stage3[6][7],   stage3[7][6],   stage4[11][2],  stage4[9][5]);
    FA FA86(stage3[10][2],  stage3[11][1],  stage3[12][0],  stage4[12][0],  stage4[10][3]);
    FA FA87(stage3[7][5],   stage3[8][4],   stage3[9][3],   stage4[11][1],  stage4[9][4]);
    FA FA88(stage3[4][8],   stage3[5][7],   stage3[6][6],   stage4[10][2],  stage4[8][5]);
    FA FA89(stage3[9][2],   stage3[10][1],  stage3[11][0],  stage4[11][0],  stage4[9][3]);
    FA FA90(stage3[6][5],   stage3[7][4],   stage3[8][3],   stage4[10][1],  stage4[8][4]);
    FA FA91(stage3[3][8],   stage3[4][7],   stage3[5][6],   stage4[9][2],   stage4[7][5]);
    FA FA92(stage3[8][2],   stage3[9][1],   stage3[10][0],  stage4[10][0],  stage4[8][3]);
    FA FA93(stage3[5][5],   stage3[6][4],   stage3[7][3],   stage4[9][1],   stage4[7][4]);
    FA FA94(stage3[2][8],   stage3[3][7],   stage3[4][6],   stage4[8][2],   stage4[6][5]);
    FA FA95(stage3[7][2],   stage3[8][1],   stage3[9][0],   stage4[9][0],   stage4[7][3]);
    FA FA96(stage3[4][5],   stage3[5][4],   stage3[6][3],   stage4[8][1],   stage4[6][4]);
    FA FA97(stage3[1][8],   stage3[2][7],   stage3[3][6],   stage4[7][2],   stage4[5][5]);
    HA HA8(stage3[6][2],    stage3[7][1],   stage4[7][1],   stage4[6][3]);       
    FA FA98(stage3[3][5],   stage3[4][4],   stage3[5][3],   stage4[6][2],   stage4[5][4]);
    FA FA99(stage3[0][8],   stage3[1][7],   stage3[2][6],   stage4[5][3],   stage4[4][5]);
    HA HA9(stage3[3][4],    stage3[4][3],   stage4[4][3],   stage4[4][4]);       
    FA FA100(stage3[0][7],  stage3[1][6],   stage3[2][5],   stage4[3][4],   stage4[3][5]);
    HA HA10(stage3[0][6],   stage3[1][5],   stage4[1][5],   stage4[2][5]);
    
    
    assign stage4[15][15] = stage3[15][15];
    assign stage4[15][14] = stage3[15][14];
    assign stage4[15][13] = stage3[15][13];
    assign stage4[15][12] = stage3[15][12];
    assign stage4[15][11] = stage3[15][11];
    assign stage4[15][10] = stage3[15][10];
    assign stage4[15][9] = stage3[15][9] ;
    assign stage4[14][15] = stage3[14][15];
    assign stage4[14][14] = stage3[14][14];
    assign stage4[14][13] = stage3[14][13];
    assign stage4[14][12] = stage3[14][12];
    assign stage4[14][11] = stage3[14][11];
    assign stage4[13][15] = stage3[13][15];
    assign stage4[13][14] = stage3[13][14];
    assign stage4[13][13] = stage3[13][13];
    assign stage4[13][12] = stage3[13][12];
    assign stage4[12][15] = stage3[12][15];
    assign stage4[12][14] = stage3[12][14];
    assign stage4[11][15] = stage3[11][15];
               
    assign stage4[8][0] = stage3[8][0];
    assign stage4[7][0] = stage3[7][0];
    assign stage4[6][0] = stage3[6][0];
    assign stage4[5][0] = stage3[5][0];
    assign stage4[4][0] = stage3[4][0];
    assign stage4[3][0] = stage3[3][0];
    assign stage4[2][0] = stage3[2][0];
    assign stage4[1][0] = stage3[1][0];
    assign stage4[0][0] = stage3[0][0];
    assign stage4[6][1] = stage3[6][1];
    assign stage4[5][1] = stage3[5][1];
    assign stage4[4][1] = stage3[4][1];
    assign stage4[3][1] = stage3[3][1];
    assign stage4[2][1] = stage3[2][1];
    assign stage4[1][1] = stage3[1][1];
    assign stage4[0][1] = stage3[0][1];
    assign stage4[5][2] = stage3[5][2];
    assign stage4[4][2] = stage3[4][2];
    assign stage4[3][2] = stage3[3][2];
    assign stage4[2][2] = stage3[2][2];
    assign stage4[1][2] = stage3[1][2];
    assign stage4[0][2] = stage3[0][2];
    assign stage4[3][3] = stage3[3][3];
    assign stage4[2][3] = stage3[2][3];
    assign stage4[1][3] = stage3[1][3];
    assign stage4[0][3] = stage3[0][3];
    assign stage4[2][4] = stage3[2][4];
    assign stage4[1][4] = stage3[1][4];
    assign stage4[0][4] = stage3[0][4];
    assign stage4[0][5] = stage3[0][5];
    
    //stage4 to stage5 connection    
    FA FA101(stage4[12][15], stage4[13][14], stage4[14][13], stage5[14][13], stage5[12][16]);
    FA FA102(stage4[13][13], stage4[14][12], stage4[15][11], stage5[15][11], stage5[13][14]);
    FA FA103(stage4[10][16], stage4[11][15], stage4[12][14], stage5[14][12], stage5[12][15]);
    FA FA104(stage4[13][12], stage4[14][11], stage4[15][10], stage5[15][10], stage5[13][13]);
    FA FA105(stage4[10][15], stage4[11][14], stage4[12][13], stage5[14][11], stage5[12][14]);
    FA FA106(stage4[13][11], stage4[14][10], stage4[15][9],  stage5[15][9],  stage5[13][12]);
    FA FA107(stage4[10][14], stage4[11][13], stage4[12][12], stage5[14][10], stage5[12][13]);
    FA FA108(stage4[13][10], stage4[14][9],  stage4[15][8],  stage5[15][8],  stage5[13][11]);
    FA FA109(stage4[10][13], stage4[11][12], stage4[12][11], stage5[14][9],  stage5[12][12]);
    FA FA110(stage4[13][9],  stage4[14][8],  stage4[15][7],  stage5[15][7],  stage5[13][10]);
    FA FA111(stage4[10][12], stage4[11][11], stage4[12][10], stage5[14][8],  stage5[12][11]);
    FA FA112(stage4[13][8],  stage4[14][7],  stage4[15][6],  stage5[15][6],  stage5[13][9]);
    FA FA113(stage4[10][11], stage4[11][10], stage4[12][9],  stage5[14][7],  stage5[12][10]);
    FA FA114(stage4[13][7],  stage4[14][6],  stage4[15][5],  stage5[15][5],  stage5[13][8]);
    FA FA115(stage4[10][10], stage4[11][9],  stage4[12][8],  stage5[14][6],  stage5[12][9]);
    FA FA116(stage4[13][6],  stage4[14][5],  stage4[15][4],  stage5[15][4],  stage5[13][7]);
    FA FA117(stage4[10][9],  stage4[11][8],  stage4[12][7],  stage5[14][5],  stage5[12][8]);
    FA FA118(stage4[13][5],  stage4[14][4],  stage4[15][3],  stage5[15][3],  stage5[13][6]);
    FA FA119(stage4[10][8],  stage4[11][7],  stage4[12][6],  stage5[14][4],  stage5[12][7]);
    FA FA120(stage4[13][4],  stage4[14][3],  stage4[15][2],  stage5[15][2],  stage5[13][5]);
    FA FA121(stage4[10][7],  stage4[11][6],  stage4[12][5],  stage5[14][3],  stage5[12][6]);
    FA FA122(stage4[13][3],  stage4[14][2],  stage4[15][1],  stage5[15][1],  stage5[13][4]);
    FA FA123(stage4[10][6],  stage4[11][5],  stage4[12][4],  stage5[14][2],  stage5[12][5]);
    FA FA124(stage4[13][2],  stage4[14][1],  stage4[15][0],  stage5[15][0],  stage5[13][3]);
    FA FA125(stage4[10][5],  stage4[11][4],  stage4[12][3],  stage5[14][1],  stage5[12][4]);
    FA FA126(stage4[12][2],  stage4[13][1],  stage4[14][0],  stage5[14][0],  stage5[13][2]);
    FA FA127(stage4[9][5],   stage4[10][4],  stage4[11][3],  stage5[13][1],  stage5[12][3]);
    FA FA128(stage4[11][2],  stage4[12][1],  stage4[13][0],  stage5[13][0],  stage5[12][2]);
    FA FA129(stage4[8][5],   stage4[9][4],   stage4[10][3],  stage5[12][1],  stage5[11][3]);
    FA FA130(stage4[10][2],  stage4[11][1],  stage4[12][0],  stage5[12][0],  stage5[11][2]);
    FA FA131(stage4[7][5],   stage4[8][4],   stage4[9][3],   stage5[11][1],  stage5[10][3]);
    FA FA132(stage4[9][2],   stage4[10][1],  stage4[11][0],  stage5[11][0],  stage5[10][2]);
    FA FA133(stage4[6][5],   stage4[7][4],   stage4[8][3],   stage5[10][1],  stage5[9][3]);
    FA FA134(stage4[8][2],   stage4[9][1],   stage4[10][0],  stage5[10][0],  stage5[9][2]);
    FA FA135(stage4[5][5],   stage4[6][4],   stage4[7][3],   stage5[9][1],   stage5[8][3]);
    FA FA136(stage4[7][2],   stage4[8][1],   stage4[9][0],   stage5[9][0],   stage5[8][2]);
    FA FA137(stage4[4][5],   stage4[5][4],   stage4[6][3],   stage5[8][1],   stage5[7][3]);
    FA FA138(stage4[6][2],   stage4[7][1],   stage4[8][0],   stage5[8][0],   stage5[7][2]);
    FA FA139(stage4[3][5],   stage4[4][4],   stage4[5][3],   stage5[7][1],   stage5[6][3]);
    FA FA140(stage4[5][2],   stage4[6][1],   stage4[7][0],   stage5[7][0],   stage5[6][2]);
    FA FA141(stage4[2][5],   stage4[3][4],   stage4[4][3],   stage5[6][1],   stage5[5][3]);
    FA FA142(stage4[4][2],   stage4[5][1],   stage4[6][0],   stage5[6][0],   stage5[5][2]);
    FA FA143(stage4[1][5],   stage4[2][4],   stage4[3][3],   stage5[5][1],   stage5[4][3]);
    HA HA11 (stage4[3][2],   stage4[4][1],   stage5[4][1],   stage5[4][2]);
    FA FA144(stage4[0][5],   stage4[1][4],   stage4[2][3],   stage5[3][2],   stage5[3][3]);
    HA HA12 (stage4[0][4],   stage4[1][3],   stage5[1][3],   stage5[2][3]);
    
    assign stage5[15][15] = stage4[15][15];
    assign stage5[15][14] = stage4[15][14];
    assign stage5[15][13] = stage4[15][13];
    assign stage5[15][12] = stage4[15][12];
    assign stage5[14][15] = stage4[14][15];
    assign stage5[14][14] = stage4[14][14];
    assign stage5[13][15] = stage4[13][15];
    assign stage5[5][0] = stage4[5][0];
    assign stage5[4][0] = stage4[4][0];
    assign stage5[3][0] = stage4[3][0];
    assign stage5[2][0] = stage4[2][0];
    assign stage5[1][0] = stage4[1][0];
    assign stage5[0][0] = stage4[0][0];
    assign stage5[3][1] = stage4[3][1];
    assign stage5[2][1] = stage4[2][1];
    assign stage5[1][1] = stage4[1][1];
    assign stage5[0][1] = stage4[0][1];
    assign stage5[2][2] = stage4[2][2];
    assign stage5[1][2] = stage4[1][2];
    assign stage5[0][2] = stage4[0][2];
    assign stage5[0][3] = stage4[0][3];
    
    
    //stage5 to stage6 connection        
    FA FA145(stage5[12][16], stage5[13][15], stage5[14][14], stage6[14][14], stage6[13][16]);
    FA FA146(stage5[12][15], stage5[13][14], stage5[14][13], stage6[14][13], stage6[13][15]);
    FA FA147(stage5[12][14], stage5[13][13], stage5[14][12], stage6[14][12], stage6[13][14]);
    FA FA148(stage5[12][13], stage5[13][12], stage5[14][11], stage6[14][11], stage6[13][13]);
    FA FA149(stage5[12][12], stage5[13][11], stage5[14][10], stage6[14][10], stage6[13][12]);
    FA FA150(stage5[12][11], stage5[13][10], stage5[14][9],  stage6[14][9],  stage6[13][11]);
    FA FA151(stage5[12][10], stage5[13][9],  stage5[14][8],  stage6[14][8],  stage6[13][10]);
    FA FA152(stage5[12][9],  stage5[13][8],  stage5[14][7],  stage6[14][7],  stage6[13][9]);
    FA FA153(stage5[12][8],  stage5[13][7],  stage5[14][6],  stage6[14][6],  stage6[13][8]);
    FA FA154(stage5[12][7],  stage5[13][6],  stage5[14][5],  stage6[14][5],  stage6[13][7]);
    FA FA155(stage5[12][6],  stage5[13][5],  stage5[14][4],  stage6[14][4],  stage6[13][6]);
    FA FA156(stage5[12][5],  stage5[13][4],  stage5[14][3],  stage6[14][3],  stage6[13][5]);
    FA FA157(stage5[12][4],  stage5[13][3],  stage5[14][2],  stage6[14][2],  stage6[13][4]);
    FA FA158(stage5[12][3],  stage5[13][2],  stage5[14][1],  stage6[14][1],  stage6[13][3]);
    FA FA159(stage5[11][3],  stage5[12][2],  stage5[13][1],  stage6[13][1],  stage6[13][2]);
    FA FA160(stage5[10][3],  stage5[11][2],  stage5[12][1],  stage6[12][1],  stage6[12][2]);
    FA FA161(stage5[9] [3],  stage5[10][2],  stage5[11][1],  stage6[11][1],  stage6[11][2]);
    FA FA162(stage5[8] [3],  stage5[9] [2],  stage5[10][1],  stage6[10][1],  stage6[10][2]);
    FA FA163(stage5[7] [3],  stage5[8] [2],  stage5[9] [1],  stage6[9] [1],  stage6[9] [2]);
    FA FA164(stage5[6] [3],  stage5[7] [2],  stage5[8] [1],  stage6[8] [1],  stage6[8] [2]);
    FA FA165(stage5[5] [3],  stage5[6] [2],  stage5[7] [1],  stage6[7] [1],  stage6[7] [2]);
    FA FA166(stage5[4] [3],  stage5[5] [2],  stage5[6] [1],  stage6[6] [1],  stage6[6] [2]);
    FA FA167(stage5[3] [3],  stage5[4] [2],  stage5[5] [1],  stage6[5] [1],  stage6[5] [2]);
    FA FA168(stage5[2] [3],  stage5[3] [2],  stage5[4] [1],  stage6[4] [1],  stage6[4] [2]);
    FA FA169(stage5[1] [3],  stage5[2] [2],  stage5[3] [1],  stage6[3] [1],  stage6[3] [2]);
    HA HA13 (stage5[0] [3],  stage5[1] [2],  stage6[1] [2],  stage6[2] [2]);
    
    
    assign stage6[15][15] = stage5[15][15];
    assign stage6[15][14] = stage5[15][14];
    assign stage6[15][13] = stage5[15][13];
    assign stage6[15][12] = stage5[15][12];
    assign stage6[15][11] = stage5[15][11];
    assign stage6[15][10] = stage5[15][10];
    assign stage6[15][9] = stage5[15][9] ;
    assign stage6[15][8] = stage5[15][8] ;
    assign stage6[15][7] = stage5[15][7] ;
    assign stage6[15][6] = stage5[15][6] ;
    assign stage6[15][5] = stage5[15][5] ;
    assign stage6[15][4] = stage5[15][4] ;
    assign stage6[15][3] = stage5[15][3] ;
    assign stage6[15][2] = stage5[15][2] ;
    assign stage6[15][1] = stage5[15][1] ;
    assign stage6[15][0] = stage5[15][0] ;
    assign stage6[14][15] = stage5[14][15] ;
    assign stage6[14][0] = stage5[14][0];
    assign stage6[13][0] = stage5[13][0];
    assign stage6[12][0] = stage5[12][0];
    assign stage6[11][0] = stage5[11][0];
    assign stage6[10][0] = stage5[10][0];
    assign stage6[9][0] = stage5[9][0] ;
    assign stage6[8][0] = stage5[8][0] ;
    assign stage6[7][0] = stage5[7][0] ;
    assign stage6[6][0] = stage5[6][0] ;
    assign stage6[5][0] = stage5[5][0] ;
    assign stage6[4][0] = stage5[4][0] ;
    assign stage6[3][0] = stage5[3][0] ;
    assign stage6[2][0] = stage5[2][0] ;
    assign stage6[1][0] = stage5[1][0] ;
    assign stage6[0][0] = stage5[0][0] ;
    assign stage6[0][1] = stage5[0][1];
    assign stage6[0][2] = stage5[0][2];
    assign stage6[1][1] = stage5[1][1];
    assign stage6[2][1] = stage5[2][1];
   
 
    //stage6 to stage7 connection            
    FA FA170(stage6[13][16], stage6[14][15], stage6[15][14], stage7[15][14], stage7[14][16]);
    FA FA171(stage6[13][15], stage6[14][14], stage6[15][13], stage7[15][13], stage7[14][15]);
    FA FA172(stage6[13][14], stage6[14][13], stage6[15][12], stage7[15][12], stage7[14][14]);
    FA FA173(stage6[13][13], stage6[14][12], stage6[15][11], stage7[15][11], stage7[14][13]);
    FA FA174(stage6[13][12], stage6[14][11], stage6[15][10], stage7[15][10], stage7[14][12]);
    FA FA175(stage6[13][11], stage6[14][10], stage6[15][9],  stage7[15][9],  stage7[14][11]);
    FA FA176(stage6[13][10], stage6[14][9],  stage6[15][8],  stage7[15][8],  stage7[14][10]);
    FA FA177(stage6[13][9],  stage6[14][8],  stage6[15][7],  stage7[15][7],  stage7[14][9]);
    FA FA178(stage6[13][8],  stage6[14][7],  stage6[15][6],  stage7[15][6],  stage7[14][8]);
    FA FA179(stage6[13][7],  stage6[14][6],  stage6[15][5],  stage7[15][5],  stage7[14][7]);
    FA FA180(stage6[13][6],  stage6[14][5],  stage6[15][4],  stage7[15][4],  stage7[14][6]);
    FA FA181(stage6[13][5],  stage6[14][4],  stage6[15][3],  stage7[15][3],  stage7[14][5]);
    FA FA182(stage6[13][4],  stage6[14][3],  stage6[15][2],  stage7[15][2],  stage7[14][4]);
    FA FA183(stage6[13][3],  stage6[14][2],  stage6[15][1],  stage7[15][1],  stage7[14][3]);
    FA FA184(stage6[13][2],  stage6[14][1],  stage6[15][0],  stage7[15][0],  stage7[14][2]);
    FA FA185(stage6[12][2],  stage6[13][1],  stage6[14][0],  stage7[14][0],  stage7[14][1]);
    FA FA186(stage6[11][2],  stage6[12][1],  stage6[13][0],  stage7[13][0],  stage7[13][1]);
    FA FA187(stage6[10][2],  stage6[11][1],  stage6[12][0],  stage7[12][0],  stage7[12][1]);
    FA FA188(stage6[9] [2],  stage6[10][1],  stage6[11][0],  stage7[11][0],  stage7[11][1]);
    FA FA189(stage6[8] [2],  stage6[9] [1],  stage6[10][0],  stage7[10][0],  stage7[10][1]);
    FA FA190(stage6[7] [2],  stage6[8] [1],  stage6[9] [0],  stage7[9] [0],  stage7[9] [1]);
    FA FA191(stage6[6] [2],  stage6[7] [1],  stage6[8] [0],  stage7[8] [0],  stage7[8] [1]);
    FA FA192(stage6[5] [2],  stage6[6] [1],  stage6[7] [0],  stage7[7] [0],  stage7[7] [1]);
    FA FA193(stage6[4] [2],  stage6[5] [1],  stage6[6] [0],  stage7[6] [0],  stage7[6] [1]);
    FA FA194(stage6[3] [2],  stage6[4] [1],  stage6[5] [0],  stage7[5] [0],  stage7[5] [1]);
    FA FA195(stage6[2] [2],  stage6[3] [1],  stage6[4] [0],  stage7[4] [0],  stage7[4] [1]);
    FA FA196(stage6[1] [2],  stage6[2] [1],  stage6[3] [0],  stage7[3] [0],  stage7[3] [1]);
    HA HA14 (stage6[0] [2],  stage6[1] [1],  stage7[1] [1],  stage7[2] [1]);
    
    assign stage7[15][15] = stage6[15][15];
    assign stage7[2][0] = stage6[2][0];
    assign stage7[1][0] = stage6[1][0];
    assign stage7[0][1] = stage6[0][1];
    assign stage7[0][0] = stage6[0][0];

    //final addition stage
    assign x[30:15] = stage7[14][16:1];
    assign y[30:15] = stage7[15][15:0];                               
    assign x[14] =   stage7[13][1]   ;
    assign x[13] =   stage7[12][1]   ;
    assign x[12] =   stage7[11][1]   ;
    assign x[11] =   stage7[10][1]   ;
    assign x[10] =   stage7[9][1]    ;
    assign x[9] =    stage7[8][1]    ;
    assign x[8] =    stage7[7][1]    ;
    assign x[7] =    stage7[6][1]    ;
    assign x[6] =    stage7[5][1]    ;
    assign x[5] =    stage7[4][1]    ;
    assign x[4] =    stage7[3][1]    ;
    assign x[3] =    stage7[2][1]    ;
    assign x[2] =    stage7[1][1]    ;
    assign x[1] =    stage7[0][1]    ;
    assign x[0] = 1'b0               ;
    assign y[14] =   stage7[14][0]   ;
    assign y[13] =   stage7[13][0]   ;
    assign y[12] =   stage7[12][0]   ;
    assign y[11] =   stage7[11][0]   ;
    assign y[10] =   stage7[10][0]   ;
    assign y[9] =    stage7[9][0]    ;
    assign y[8] =    stage7[8][0]    ;
    assign y[7] =    stage7[7][0]    ;
    assign y[6] =    stage7[6][0]    ;
    assign y[5] =    stage7[5][0]    ;
    assign y[4] =    stage7[4][0]    ;
    assign y[3] =    stage7[3][0]    ;
    assign y[2] =    stage7[2][0]    ;
    assign y[1] =    stage7[1][0]    ;
    assign y[0] =    stage7[0][0]    ;
                                          
    parametric_RCA add(x, y, 1'b0, MUL, cout);
    assign MULT[31] = cout;
    assign MULT[30:0] = MUL;
endmodule
