1000 GOTO 1310
1010 :
1020 REM ***** SUBROUTINEN *****
1030 :
1040 POKE19,64
1050 INPUTA$
1060 POKE19,0
1070 PRINT
1080 RETURN
1090 INPUT#1,X1$,X2$,X3$,X4$
1100 D=VAL(X1$)
1110 D$=X1$+","+X2$+","+X3$+","+X4$
1120 RETURN
1130 GET#2,L$,H$
1140 AD=ASC(L$+CHR$(0))+256*ASC(H$+CHR$(0))
1150 RETURN
1160 DA$=""
1170 GET#2,X$
1180 IFX$<>""THENDA$=DA$+X$:GOTO 1170
1190 RETURN
1200 FORYY=1TOSS
1210 : IFJA=S(YY)THENJN=U(YY):RETURN
1220 NEXT
1230 ERR$="Undef'd Statement Error"
1240 ERR=D(I)
1250 GOSUB 3580
1260 JN=63999
1270 RETURN
1280 :
1290 REM ***** INITIALISIEREN ******
1300 :
1310 DIMS$(500),S(500),U(500),D$(1000),D(1000)
1320 GA=8
1330 SP$=":{space*20}"
1340 REM 20 SPACES
1350 :
1360 REM ***** PARAMETER-EINGABE *****
1370 :
1380 PRINT"{clear}{down}{space*6}Recompactor{space*4}by GD-Soft {ct h}{ct n}"
1390 PRINT"{down*2} Source-Filename{space*6}: ";
1400 GOSUB 1040
1410 SN$=A$
1420 PRINT"{down} Destination-Filename : ";
1430 GOSUB 1040
1440 DN$=A$
1450 PRINT"{down} Schleifen formatieren (j/n) : ";
1460 POKE204,0
1470 GETFO$
1480 IFFO$<>"j"ANDFO$<>"y"ANDFO$<>"n"THEN 1470
1490 POKE204,1
1500 PRINTFO$
1510 PRINT"{down} Startadresse{space*2}: 2049{left*4}";
1520 GOSUB 1040
1530 SA=VAL(A$)
1540 PRINT"{down} Startzeilennr.: 1000{left*4}";
1550 GOSUB 1040
1560 SZ=VAL(A$)
1570 PRINT"{down} Schrittweite{space*2}: 10{left*2}";
1580 GOSUB 1040
1590 SW=VAL(A$)
1600 PRINT"{clear}{down}{space*6}Recompactor{space*4}by GD-Soft {ct h}{ct n}"
1610 PRINT"{down*2}{space*3}Sourcefile{space*6}: "SN$
1620 PRINT"{down}{space*3}Destinationfile : "DN$
1630 :
1640 REM*****        PASS 1        *****
1650 :
1660 PRINT"{home}{down*10}"TAB(3)"Pass 1 :"
1670 OPEN1,GA,15
1680 OPEN2,GA,0,SN$
1690 GOSUB 1090
1700 IFDTHENCLOSE2:CLOSE1:GOSUB 3600:RUN
1710 GOSUB 1130
1720 GOSUB 1130
1730 IFAD=0THENCLOSE2:CLOSE1:GOTO 1840
1740 GOSUB 1130
1750 PRINT"{home}{down*10}"TAB(11)AD
1760 SS=SS+1
1770 S(SS)=AD
1780 GOSUB 1160
1790 S$(SS)=DA$
1800 GOTO 1720
1810 :
1820 REM ***** PASS 2 *****
1830 :
1840 PRINT"{home}{down*10}"TAB(23)"Pass 2 :"
1850 FORI=1TOSS
1860 : PRINT"{home}{down*10}"TAB(31)S(I)
1870 : U(I)=SW*DD+SZ
1880 : F1=0
1890 : F2=0
1900 : F3=0
1910 : FORM=1TOLEN(S$(I))
1920 :   X$=MID$(S$(I),M,1)
1930 :   X=ASC(X$+CHR$(0))
1940 :   IFX$=":"ANDZE$<>""THEN 2010
1950 :   IFX=139THENF1=1
1960 :   IFX=143THENF1=1
1970 :   IFX=34THENF2=1-F2
1980 :   ZE$=ZE$+X$
1990 : NEXTM
2000 : F3=1
2010 : IFF3=0THENIF F1 OR F2 THEN 1980
2020 : DD=DD+1
2030 : D$(DD)=ZE$
2040 : ZE$=""
2050 : D(DD)=SW*DD+SZ-SW
2060 IFF3=0THENNEXTM
2070 S$(I)=""
2080 NEXTI
2090 IFD(DD)>63999THENERR$="Line Increment too large !":ERR=0:GOSUB 3580:RUN
2100 :
2110 REM ***** PASS 3 *****
2120 :
2130 PRINT"{home}{down*13}"TAB(3)"Pass 3 :"
2140 FORI=1TODD
2150 : MM=.
2160 : F1=.
2170 : F2=.
2180 : PRINT"{home}{down*13}"TAB(11)D(I)
2190 : MM=MM+1
2200 IFMM>LEN(D$(I))THENNEXTI:GOTO 3090
2210 YY=ASC(MID$(D$(I),MM,1)+CHR$(0))
2220 IFYY=34THENF2=1-F2      :REM FALLS
2230 IFYY=143THENF1=1 :REM ANFUEHRUNGSZEICHEN ODER REM,
2240 IFF1ORF2THEN 2190:REM DANN NICHT PRUEFEN
2250 IFYY=137ORYY=141THEN 2310:REM GOTO/GOSUB
2260 IFYY=167THEN 2490:REM THEN-MIT/OHNE ZEILENNR.?
2270 IFYY=145THEN 2570:REM ON...
2280 IFYY=203THEN 2980:REM GO
2290 GOTO 2190
2300 REM GOTO/GOSUB
2310 JA=.
2320 JA$=""
2330 NN=.
2340 NN=NN+1
2350 NN$=MID$(D$(I),MM+NN,1)
2360 IF(NN$<"0"ORNN$>"9")ANDNN$<>" "THEN 2390
2370 JA$=JA$+NN$
2380 GOTO 2340
2390 JA=VAL(JA$)
2400 GOSUB 1200
2410 LI$=LEFT$(D$(I),MM)
2420 RE$=MID$(D$(I),MM+NN)
2430 D$(I)=LI$+STR$(JN)+RE$
2440 MM=MM+NN
2450 GOTO 2190
2460 REM THEN
2470 REM ERST PRUEFEN OB ZEILENNUMMER, WENN JA, DANN SPRUNG ZUR
2480 REM ADRESSENUMWANDLUNG (AB 2310, AUCH BEI GOTO/GOSUB BENUTZT)
2490 NN=.
2500 F4=.
2510 NN=NN+1
2520 NN$=MID$(D$(I),MM+NN,1)
2530 IF(NN$<"0"ORNN$>"9")ANDNN$<>" "THEN 2190
2540 IFNN$=" "THEN 2510:REM SPACE UEBERLESEN
2550 GOTO 2310
2560 REM ON...GOTO/ON...GOSUB
2570 MM=MM+1
2580 AS=ASC(MID$(D$(I),MM,1)+CHR$(0))
2590 IFAS=137ORAS=141THEN 2760
2600 IFAS=203THEN 2670
2610 IFMM<LEN(D$(I))THEN 2570
2620 ERR$="ON without GOTO Error"
2630 ERR=D(I)
2640 GOSUB 3580
2650 NEXTI
2660 REM NACH 'ON...GO' AUF 'TO' PRUEFEN
2670 MM=MM+1
2680 AS=ASC(MID$(D$(I),MM,1)+CHR$(0))
2690 IFAS=164THEN 2760
2700 IFMM<LEN(D$(I))THEN 2670
2710 ERR$="GO without TO Error"
2720 ERR=D(I)
2730 GOSUB 3580
2740 NEXTI
2750 REM ADRESSEN EINZELN HOLEN UND GLEICH UMWANDELN
2760 NN=.
2770 MM=MM+NN
2780 NN=.
2790 JA$=""
2800 NN=NN+1
2810 NN$=MID$(D$(I),MM+NN,1)
2820 IF(NN$<"0"ORNN$>"9")ANDNN$<>" "THENGOTO 2850
2830 JA$=JA$+NN$
2840 GOTO 2800
2850 JA=VAL(JA$)
2860 GOSUB 1200
2870 LI$=LEFT$(D$(I),MM)
2880 RE$=MID$(D$(I),MM+NN)
2890 D$(I)=LI$+STR$(JN)+RE$
2900 NN=NN-1
2910 NN=NN+1
2920 NN$=MID$(D$(I),MM+NN,1)
2930 IFNN$=" "THEN 2910
2940 IFNN$=","THEN 2770
2950 IFNN$=":"ORMM+NN>LEN(D$(I))THENMM=MM+NN:GOTO 2190
2960 GOTO 2910
2970 REM NACH 'GO' AUF 'TO' PRUEFEN
2980 MM=MM+1
2990 AS=ASC(MID$(D$(I),MM,1)+CHR$(0))
3000 IFAS=164THEN 2310:REMTO GEFUNDEN
3010 IFMM<LEN(D$(I))THEN 2980
3020 ERR$="GO without TO Error"
3030 ERR=D(I)
3040 GOSUB 3580
3050 NEXTI
3060 :
3070 REM ***** PASS 4 *****
3080 :
3090 IFFO$<>"j"ANDFO$<>"y"THEN 3300
3100 PRINT"{home}{down*13}"TAB(23)"Pass 4 :"
3110 FO=0
3120 FORI=1TODD
3130 : MM=.
3140 : F1=.
3150 : F2=.
3160 : D$(I)=LEFT$(SP$,FO)+D$(I)
3170 : PRINT"{home}{down*13}"TAB(31)D(I)
3180 : MM=MM+1
3190 IFMM>LEN(D$(I))THENNEXTI:GOTO 3300
3200 YY=ASC(MID$(D$(I),MM,1)+CHR$(0))
3210 IFYY=34THENF2=1-F2      :REM FALLS
3220 IFYY=143THENF1=1 :REM ANFUEHRUNGSZEICHEN ODER REM,
3230 IFF1ORF2THEN 3180:REM DANN NICHT PRUEFEN
3240 IFYY=129 THEN FO=FO+2 :REM FOR -> SCHACHTELUNGSTIEFE +1
3250 IFYY=130 AND FO>0 THEN FO=FO-2 :D$(I)=LEFT$(SP$,FO)+MID$(D$(I),FO+3)
3260 GOTO 3180
3270 :
3280 REM ***** SAVE *****
3290 :
3300 PRINT"{home}{down*17}"TAB(16)"{reverse on} saving "
3310 OPEN1,GA,15
3320 OPEN2,GA,1,DN$
3330 GOSUB 1090
3340 IFDTHENCLOSE2:CLOSE1:GOSUB 3600:GOTO 3300
3350 AD=SA
3360 LB=255ANDSA
3370 HB=SA/256
3380 PRINT#2,CHR$(LB)CHR$(HB);
3390 FORI=1TODD
3400 : AD=AD+LEN(D$(I))+5
3410 : LP=255ANDAD
3420 : HP=AD/256
3430 : PRINT#2,CHR$(LP)CHR$(HP);
3440 : LZ=D(I)AND255
3450 : HZ=D(I)/256
3460 : PRINT#2,CHR$(LZ)CHR$(HZ);
3470 : PRINT#2,D$(I)CHR$(0);
3480 NEXT
3490 PRINT#2,CHR$(0)CHR$(0);
3500 CLOSE2
3510 CLOSE1
3520 PRINT"{home}{down*20}{space*2}Errors :"ER%
3530 PRINT
3540 END
3550 :
3560 REM ***** FEHLER *****
3570 :
3580 D$=ERR$
3590 D=ERR
3600 PRINT"{home}{down*21}{right}error for "SN$" :"
3610 PRINT"{down}{sh space}"D$;
3620 IFD<>VAL(D$)THENPRINT"{right}in";D;
3630 FORT=1TO5000
3640 : GETA$
3650 IFA$=""THENNEXT
3660 PRINT"{home}{down*21}{space*39}"
3670 PRINT"{down}{space*39}";
3680 RETURN
