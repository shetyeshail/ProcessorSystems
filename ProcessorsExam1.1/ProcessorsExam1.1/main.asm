;
; ProcessorsExam1.1.asm
;
; Created: 10/22/2017 12:20:23 PM
; Author : shail
;


; Replace with your application code

.include "m169pdef.inc"

	ldi r16, 0b00000000
	out ddrb, r16				;set port B to be inputs
	ldi r16, 0b11111111
	out ddrd, r16				;set port D to be outputs

start:
 

	repeat:
		in r17, pinb			;set r17 to input from port B switches
	
		cpi r17, 0b00000000		;if it equals 0000 then go to branch to print 0
		breq c0
		cpi r17, 0b00000001		;if it equals 0001 then go to branch to print 1
		breq c1
		cpi r17, 0b00000010		;if it equals 0010 then go to branch to print 2
		breq c2
		cpi r17, 0b00000011		;if it equals 0011 then go to branch to print 3
		breq c3
		cpi r17, 0b00000100		;if it equals 0100 then go to branch to print 4
		breq c4
		cpi r17, 0b00000101		;if it equals 0101 then go to branch to print 5
		breq c5
		cpi r17, 0b00000110		;if it equals 0110 then go to branch to print 6
		breq c6
		cpi r17, 0b00000111		;if it equals 0111 then go to branch to print 7
		breq c7
		cpi r17, 0b00001000		;if it equals 1000 then go to branch to print 8
		breq c8
		cpi r17, 0b00001001		;if it equals 1001 then go to branch to print 9
		breq c9
	rjmp repeat

	c0:
		ldi r18, 0b00111111		;0
		out portd, r18
		;call delay
		rjmp repeat
	c1:
		ldi r18, 0b00001100		;1
		out portd, r18
		;call delay
		rjmp repeat
	c2:
		ldi r18, 0b01110101		;2
		out portd, r18
		;call delay
		rjmp repeat
	c3:
		ldi r18, 0b01011101		;3
		out portd, r18
		;call delay
		rjmp repeat
	c4:
		ldi r18, 0b01001110		;4
		out portd, r18
		;call delay
		rjmp repeat
	c5:
		ldi r18, 0b01011011		;5
		out portd, r18
		;call delay
		rjmp repeat
	c6:
		ldi r18, 0b01111010		;6
		out portd, r18
		;call delay
	c7:
		ldi r18, 0b00001101		;7
		out portd, r18
		;call delay
		rjmp repeat
	c8:
		ldi r18, 0b01111111		;8
		out portd, r18
		;call delay
	c9:
		ldi r18, 0b01001111		;9
		out portd, r18
		;call delay
		rjmp repeat


rjmp start
