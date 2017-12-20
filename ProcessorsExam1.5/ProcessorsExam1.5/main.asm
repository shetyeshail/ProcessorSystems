;
; ProcessorsExam1.5.asm
;
; Created: 10/23/2017 8:00:42 AM
; Author : shail
;


; Replace with your application code

.include "m169pdef.inc"

ldi r16, 0b00000000
out ddrb, r16				;set port B to be inputs
ldi r16, 0b11111111
out ddrd, r16				;set port D to be outputs

start:
	in r17, pinb			;set r17 to input from portB switches

	cpi r17, 0b00000000		;if input is this go to a certain branch
	breq c0
	cpi r17, 0b00000001
	breq c1
	cpi r17, 0b00000010
	breq c2
	cpi r17, 0b00000011
	breq c3
rjmp start

c0:							;changes the output signals based on the input switches
	ldi r18, 0b00100001
	out portd, r18
rjmp start

c1:
	ldi r18, 0b00010001
	out portd, r18
rjmp start

c2:
	ldi r18, 0b00001100
	out portd, r18
rjmp start

c3:
	ldi r18, 0b00001010
	out portd, r18
rjmp start