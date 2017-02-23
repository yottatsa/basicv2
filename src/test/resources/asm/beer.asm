*=$c000

ECHO=$FFD2
MAXBEER=99

   			LDX #MAXBEER	  	;99 bottles
LOOP		JSR BOTTLEOUT
			JSR PUTS
			LDY #<COM
			JSR PUTS
			JSR BOTTLEOUT
			TYA
			CLC
			ADC #13
			TAY
			JSR PUTS
   			DEX
   			BPL CONTI
   			LDY #<STORE
   			JSR PUTS
   			LDX #MAXBEER
   			JSR WALLCR
   			RTS
CONTI		LDY #<TAKE
			JSR PUTS
			JSR WALLCR
			JMP LOOP

WALLCR 		JSR BOTTLEOUT
			JSR PUTS
			JSR PUTS
			DEY
			DEY
			JSR PUTS
			RTS

BOTTLEOUT  	TXA
			BNE STILLBEER
			LDY #<NOMORE
			JSR PUTS
			JMP POSTFIX
STILLBEER	PHA
			LDX #-1
   			SEC
DIV10	    INX
   			SBC #10
   			BCS DIV10
   			PHA
   			TXA
   			BEQ SINGLE
   			CLC
   			ADC #48
   			JSR OUT
SINGLE  	PLA
   			CLC
   			ADC #58
   			JSR OUT
			PLA
   			TAX
POSTFIX		LDY #<BOTTLE
   			JSR PUTS
   			CPX #1
   			BNE MULTI
   			INY
MULTI		JSR PUTS
   			RTS

PUTS		INY
			LDA $bfff,Y
			BEQ DONE
			JSR OUT
			JMP PUTS
DONE		RTS
OUT			PHP
			JSR ECHO
			PLP
			RTS



TAKE 		.text "take one down and pass it around, "
   			.byte $0
STORE  		.text "go to the store and buy some more"
COM  		.text ", "
   			.byte $0
NOMORE  	.text "no more"
   			.byte $0
BOTTLE 		.text " bottle"
			.byte $0
			.text "s of beer"
			.byte $0
			.text " on the wall"
			.byte $0
DOTCR 		.text "."
CR			.byte 13 0