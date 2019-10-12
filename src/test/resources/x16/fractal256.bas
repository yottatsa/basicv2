10 PRINT CHR$(147);
20 GOSUB 20000:GOSUB 30000
300 XL = -1.2:XU = -1.185: REM XL = -2.000:XU = 0.500
310 YL = -0.195:YU = -0.185 :REM YL = -1.100:YU = 1.100
315 REPS = 255
316 ITERS% = 0
320 WIDTH = 320:HEIGHT = 200
330 XINC = (XU-XL)/WIDTH
340 YINC = (YU-YL)/HEIGHT
400 REM MAIN
410 FOR J = 0 TO HEIGHT - 1
420 FOR I = 0 TO WIDTH - 1
510 ISMND = -1
512 NREAL = XL + I * XINC
513 NIMG  = YL + J * YINC
515 RZ = 0: IZ = 0
516 R2Z = 0: I2Z = 0
520 FOR K = 0 TO REPS
530 R2Z = RZ*RZ - IZ*IZ
540 I2Z = 2*RZ*IZ
550 RZ = R2Z+NREAL
560 IZ = I2Z +NIMG
565 ITERS%=K
570 IF (RZ*RZ + IZ*IZ)>4 THEN ISMND=0:K=REPS
590 NEXT
620 IF ISMND<>0 THEN CV=0:GOTO 630
625 CV=ITERS%
630 GOSUB 10000
640 NEXT:NEXT
690 GET A$:IF A$ = "" THEN 690
750 END
10000 REM
10020 PO=J*320+I:BA=0
10030 IF PO>$FFFF THEN PO=PO-$FFFF:BA=1
10040 VPOKE BA, PO, CV
10050 RETURN
20000 REM
20010 VPOKE 15,2,52:VPOKE 15,1,64:POKE 218,40:VPOKE15,$2000,0
20020 VPOKE 15,$3005,$0:VPOKE 15,$3001,$0:VPOKE 15,$3000,$A1+64
20030 RETURN
30000 REM
30010 RP=20:GP=80:BP=100
30020 FOR I=0TO255
30030 VPOKE 15, $1000+I*2, INT(GP/16)*16+INT(BP/16)
30035 VPOKE 15, $1000+I*2+1, INT(RP/16)
30040 RP=RP+7:GP=GP+9:BP=BP+5
30050 IF RP>255 THEN RP=20
30060 IF GP>255 THEN GP=20
30070 IF BP>255 THEN BP=20
30080 NEXT:RETURN