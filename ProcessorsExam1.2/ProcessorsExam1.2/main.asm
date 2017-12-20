;
; ProcessorsExam1.2.asm
;
; Created: 10/22/2017 5:08:09 PM
; Author : shail
;


; Replace with your application code

.include "m169pdef.inc"
								;set stack pointer to $203
ldi r16, high($203)
out sph, r16
ldi r16, low($203)
out spl, r16
								;start pushing the first number to stack
ldi r17, 0xAF
push r17
ldi r17, 0x1C
push r17
ldi r17, 0xFD
push r17
ldi r17, 0x02
push r17
	
								;set stack pointer to $207
ldi r16, high($207)
out sph, r16
ldi r16, low($207)
out spl, r16
								;start pushing the second number to stack
ldi r17, 0x1C
push r17
ldi r17, 0xB3
push r17
ldi r17, 0x4A
push r17
ldi r17, 0x5D
push r17

pop r18							;pop fourth digit of second number
pop r19							;pop third digit of second number
pop r20							;pop second digit of second number
pop r21							;pop first digit of second number
	    
								;switch back to first number's stack
ldi r16, high($1FF)
out sph, r16
ldi r16, low($1FF)
out spl, r16

pop r22							;pop fourth digit of first number
pop r23							;pop third digit of first number
pop r24							;pop second digit of first number
pop r25							;pop first digit of first number

add r18, r22					;add fourth digits
adc r19, r23					;add third digits and the carry
adc r20, r24					;add second digits and the carry
adc r21, r25					;add first digits and the carry

ldi r16, high($20D)				;change stack pointer to store result
out sph, r16
ldi r16, low($20D)
out spl, r16
								;push results to stack
push r18
push r19
push r20
push r21