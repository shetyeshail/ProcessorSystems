;
; ICA5.asm
;
; Created: 10/9/2017 12:20:06 PM
; Author : shail
;


; Replace with your application code
;part 1
/*
ldi r16, $ff
out portd, r16		;Make all portb outputs
out ddrb, r16		;Made all outputs

here:				;loops when it gets to the end
	out portb, r17

	sbic pind, 0
	sbi portb, 0

	sbic pind, 1
	sbi portb, 1

	sbic pind, 2
	sbi portb, 2

	sbic pind, 3
	sbi portb, 3

	sbic pind, 4
	sbi portb, 4

	sbic pind, 5
	sbi portb, 5

	sbic pind, 6
	sbi portb, 6

	sbic pind, 7
	sbi portb, 7
jmp here
*/

;part 2

ldi r16, $ff
out portd, r16
out ddrb, r16

here:
	
	out portb, r17

	sbic pind, 0
	ldi r17, 0b00000000
	
	sbic pind, 1
	ldi r17, 0b00000001
	
	sbic pind, 2
	ldi r17, 0b00000010
	
	sbic pind, 3
	ldi r17, 0b00000011
	
	sbic pind, 4
	ldi r17, 0b00000100
	
	sbic pind, 5
	ldi r17, 0b00000101
	
	sbic pind, 6
	ldi r17, 0b00000110
	
	sbic pind, 7
	ldi r17, 0b00000111

jmp here



/*
;part 3
ldi r16, $ff
out portd, r16
out ddrb, r16

here:
	cbi pind, 0
	sbic pind, 0
	jmp switch0
	sbic pind, 1
	jmp switch1
jmp here

switch0:
	
*/