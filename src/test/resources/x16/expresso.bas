0 REM ** EXPRESSO -  BY EGONOLSEN71 - 10/2019 **
1 GOSUB 30000:INPUT "EXPRESSION :";X$:IF X$=""THENRUN
2 TI$="000000":TD=0:OB=0:PRINT
3 PRINT "...EVALUATING ";X$:PRINT
5 REM SETUP
10 GOSUB 1000:GOSUB 1100
20 GOSUB 1200:GOSUB 3000
30 REM RUN EVALUATOR
40 GOSUB 2000
80 PRINT:PRINT "PROCESSED IN";((TI-TD)/60);"SECONDS"
90 POKE646,177:PRINT:PRINT "RESULT: ";RE:POKE646,97
100 GOTO 3900
1000 REM SETUP VARIABLE STORAGE
1001 :
1005 VC=25:DIM VN$(VC),VV(VC):VT=0
1060 RETURN
1100 REM SETUP OPERATORS AND FUNCTIONS
1101 :
1110 DIM OP$(14),FS$(10)
1120 OP$(0)="+":OP$(1)="-":OP$(2)="*":OP$(3)="/":OP$(4)=CHR$(94)
1130 OP$(5)="SIN":OP$(6)="COS":OP$(7)="TAN":OP$(8)="ABS"
1135 OP$(9)="ATN":OP$(10)="EXP":OP$(11)="INT":OP$(12)="LOG"
1136 OP$(13)="SGN":OP$(14)="SQR"
1140 FOR I=0 TO 9:FS$(I)=OP$(5+I):NEXT
1150 RETURN
1200 REM SETUP STACK
1201 :
1210 DIM SK(100):SP=0:RETURN
2000 REM EVALUATE EXPRESSION
2001 :
2010 NU$="":WE=0:WM=1:WF=0:NG=1:LO=1
2020 LE=LEN(X$):FORI=1TOLE
2030 C$=MID$(X$,I,1)
2040 IFC$>="A"ANDC$<="Z"THENGOSUB3100:GOTO2800
2045 P=0
2050 IFOP$(P)=C$THENGOSUB3400:GOTO2800
2060 P=P+1:IFP<5THEN2050
2070 IFC$="("ORC$=")"THENGOSUB3600:GOTO2800
2080 GOSUB 3800
2800 NEXT
2810 IFLEN(NU$)>0THENSV=VAL(NU$):GOSUB 10000
2820 WF=-1:GOSUB 20000:GOSUB 10100:RE=SV
2830 IF OB<>0 THEN GOTO 3810
2900 RETURN
3000 REM REMOVE WHITESPACES
3001 :
3010 LE=LEN(X$):TM$="":FORI=1TOLE
3020 C$=MID$(X$,I,1)
3030 IFC$<>" "THENTM$=TM$+C$
3040 NEXT:X$=TM$:RETURN
3100 REM VARIABLE OR FUNCTION CALL FOUND
3110 :
3120 IFI+3>=LEN(X$)THEN3300
3130 F$=MID$(X$,I,3):P=0
3140 IFF$=FS$(P)THEN3170
3150 P=P+1:IFP<10THEN3140
3160 GOTO 3300
3170 WE=WM+3
3180 SV=P+5:GOSUB 10000
3190 SV=WE:GOSUB 10000
3200 SV=0:GOSUB 10000
3210 LO=0:I=I+2:RETURN
3300 FORP=0TOVT
3310 IFC$=VN$(P)THENNU$=STR$(VV(P)):RETURN
3320 NEXT
3325 TS=TI
3330 VN$(VT)=C$:PRINT"VALUE OF ";C$;": ";
3340 INPUT JI
3345 TD=TD+(TI-TS):IF VT>=25 THEN 3810
3350 VV(VT)=JI:NU$=STR$(JI):VT=VT+1:RETURN
3400 REM HANDLE OPERAND
3401 :
3405 WE=WM
3410 IFC$="*"ORC$="/"THENWE=WM+1:GOTO 3430
3420 IFC$=CHR$(94)THENWE=WM+2
3430 IFLEN(NU$)>0THENSV=VAL(NU$)*NG:NG=1:GOSUB 10000:GOTO3440
3431 IFC$="-"ANDLO=1THENNG=-1*NG:RETURN
3440 WF=WE:GOSUB 20000
3450 GOSUB 10100:TV=SV
3460 SV=P:GOSUB 10000
3470 SV=WE:GOSUB 10000
3480 SV=TV:GOSUB 10000
3490 NU$="":LO=1:RETURN
3600 REM HANDLE BRACKETS
3601 :
3610 IFLEN(NU$)>0THENSV=VAL(NU$)*NG:NG=1:GOSUB 10000:NU$=""
3620 IFC$="("THENLO=1:WM=WM+10:OB=OB+1:IFNG=-1THENGOSUB3700
3630 IFC$=")"THENLO=0:WM=WM-10:OB=OB-1
3640 RETURN
3700 REM HANDLE NEGATION BEFORE BRACKET
3710 NG=1
3720 SV=2:GOSUB 10000
3730 SV=WM-10+2:GOSUB 10000
3740 SV=-1:GOSUB 10000
3750 RETURN
3800 IF(C$>="0"ANDC$<"9")ORC$="."THENNU$=NU$+C$:LO=0:RETURN
3810 POKE646,33:PRINT:PRINT"SYNTAX ERROR IN ";X$;" AT POSITION ";I;": ";C$
3900 POKE646,97:PRINT:PRINT"PRESS ANY KEY!"
3910 GETA$:IFA$="" THEN 3910
3920 RUN
10000 REM PUSH VALUE TO STACK
10001 :
10010 SK(SP)=SV:SP=SP+1:RETURN
10100 REM POP VALUE FROM STACK
10101 :
10105 IF SP=0THEN3810
10110 SV=SK(SP-1):SP=SP-1:RETURN
20000 REM RUN CALCULATION
20001 :
20010 :
20020 IFSP<=2THENRETURN
20030 WW=WF
20040 IFWW<>-1THENWW=SK(SP-3)
20050 IFWF>WWTHENRETURN
20060 GOSUB 10100:N1=SV
20070 GOSUB 10100:N2=SV
20080 GOSUB 10100
20090 GOSUB 10100:OP=SV
20100 ON OP+1 GOSUB 21000,21100,21200,21300,21400,21500,21600,21700
20102 IF OP<=7 THEN 20110
20105 ON OP-7 GOSUB 21800,21900,22000,22100,22200,22300,22400
20110 SV=N1:GOSUB 10000
20120 GOTO 20010
21000 REM +
21010 N1=N2+N1:RETURN
21100 REM -
21110 N1=N2-N1:RETURN
21200 REM *
21210 N1=N2*N1:RETURN
21300 REM /
21310 N1=N2/N1:RETURN
21400 REM POWER
21410 N1=N2^N1:RETURN
21500 REM SIN
21510 N1=SIN(N2+N1):RETURN
21600 REM COS
21610 N1=COS(N2+N1):RETURN
21700 REM TAN
21710 N1=TAN(N2+N1):RETURN
21800 REM ABS
21810 N1=ABS(N2+N1):RETURN
21900 REM ATN
21910 N1=ATN(N2+N1):RETURN
22000 REM EXP
22010 N1=EXP(N2+N1):RETURN
22100 REM INT
22110 N1=INT(N2+N1):RETURN
22200 REM LOG
22210 N1=LOG(N2+N1):RETURN
22300 REM SGN
22310 N1=SGN(N2+N1):RETURN
22400 REM SQR
22410 N1=SQR(N2+N1):RETURN
30000 REM
30010 :
30020 POKE646,97:PRINT CHR$(147):POKE646,240
30030 PRINT "**** EXPRESSO - A SIMPLE EXPRESSION EVALUATOR FOR BASIC V2 ****"
30035 POKE646,97
30040 PRINT:PRINT"THIS PROGRAM EVALUATES EXPRESSIONS LIKE (A+3)*X+SIN(A/X) OR"
30050 PRINT "A*(B+E/-(R+T)*11)+(12/T+3*.8)*E+(E/(R+SIN(T)*SIN(A+COS(B+R))/E))."
30055 PRINT
30060 PRINT "AFTER ENTERING THE EXPRESSION, THE PROGRAM WILL ASK FOR THE VALUE"
30070 PRINT "OF EACH VARIABLE AND THEN PRINT OUT THE RESULT.":PRINT
30080 PRINT"VARIABLES HAVE TO BE SINGLE LETTERS (LIKE A,B...X), ";
30085 PRINT "OPS ARE +,-,*,/,";CHR$(94)
30090 PRINT"SUPPORTED FUNCTIONS ARE: SIN, COS, TAN, LOG, ABS, ATN, EXP,";
30100 PRINT"INT, SGN, SQR":PRINT
30110 RETURN

