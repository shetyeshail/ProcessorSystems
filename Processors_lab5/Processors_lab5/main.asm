;
; Lab6.asm
;
; Created: 10/10/2017 1:15:07 PM
; Author : tuf88658
;


; Replace with your application code

ldi r16, HIGH (RAMEND)
	out sph, r16
ldi r16, LOW (RAMEND)
	out spl, r16

out portb, r16
out ddrb, r16

;activity 1
start:
    ldi r16, 0b00000001
	out portb, r16
	call delay_1s

	ldi r16, 0b00000011
	out portb, r16
	call delay_1s

	ldi r16, 0b00000111
	out portb, r16
	call delay_1s

	ldi r16, 0b00001111
	out portb, r16
	call delay_1s

	ldi r16, 0b00011111
	out portb, r16
	call delay_1s

	ldi r16, 0b00111111
	out portb, r16
	call delay_1s

	ldi r16, 0b01111111
	out portb, r16
	call delay_1s

	ldi r16, 0b11111111
	out portb, r16
	call delay_1s

	ldi r16, 0b01111111
	out portb, r16
	call delay_1s

	ldi r16, 0b00111111
	out portb, r16
	call delay_1s

	ldi r16, 0b00011111
	out portb, r16
	call delay_1s

	ldi r16, 0b00001111
	out portb, r16
	call delay_1s

	ldi r16, 0b00000111
	out portb, r16
	call delay_1s

	ldi r16, 0b00000011
	out portb, r16
	call delay_1s

	ldi r16, 0b00000001
	out portb, r16
	call delay_1s

	ldi r16, 0b00000000
	out portb, r16
	call delay_1s
rjmp start

/*
;activity 2
start:
    ldi r16, 0b10000000
	out portb, r16
	call delay_1s

	ldi r16, 0b01000000
	out portb, r16
	call delay_1s

	ldi r16, 0b00100000
	out portb, r16
	call delay_1s

	ldi r16, 0b00010000
	out portb, r16
	call delay_1s

	ldi r16, 0b00001000
	out portb, r16
	call delay_1s

	ldi r16, 0b00000100
	out portb, r16
	call delay_1s

	ldi r16, 0b00000010
	out portb, r16
	call delay_1s

	ldi r16, 0b00000001
	out portb, r16
	call delay_1s

	ldi r16, 0b10000000
	out portb, r16
	call delay_1s

	ldi r16, 0b01000000
	out portb, r16
	call delay_1s

	ldi r16, 0b00100000
	out portb, r16
	call delay_1s

	ldi r16, 0b00010000
	out portb, r16
	call delay_1s

	ldi r16, 0b00001000
	out portb, r16
	call delay_1s

	ldi r16, 0b00000100
	out portb, r16
	call delay_1s

	ldi r16, 0b00000010
	out portb, r16
	call delay_1s

	ldi r16, 0b00000001
	out portb, r16
	call delay_1s
rjmp start
*/

delay_1s:
	ldi r24, 32
	L1: ldi r25, 200
	L2: ldi r26, 250
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