10 POKE$9F61,1
20 POKE$A000,123
30 POKE$9F61,0
40 POKE$A000,255
50 POKE$9F61,1
60 PRINT"$A000 > EXPECTED:123, FOUND:";
70 PRINTPEEK($A000)