;
; LabFinal_Problem4.asm
;
; Created: 12/15/2017 3:46:49 PM
; Author : shail
;


; Replace with your application code

ldi r16, 0xff
out ddrd, r16			//sets portd as output

ldi r17, high(ramend)	//sets stack pointer
out sph, r17
ldi r17, low(ramend)
out spl, r17

loop:
	ldi r16, (1<<0)		//enable bit0
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<1)		//enable bit1
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<2)		//enable bit2
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<3)		//enable bit3
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<4)		//enable bit4
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<5)		//enable bit5
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<6)		//enable bit6
	out portd, r16		//output to portd
	//call delay			//call 1sec delay

	ldi r16, (1<<7)		//enable bit7
	out portd, r16		//output to portd
	//call delay			//call 1sec delay
jmp loop

delay:					//1sec delay
	ldi r24, 32
	L1:
		ldi r25, 200
	L2:
		ldi r26, 250
	L3:
		nop
		nop
		dec r26
		brne L3
		dec r25
		brne L2
		dec r24
		brne L1
	ret