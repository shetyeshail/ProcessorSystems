;
; ProcessorsExam1.3.asm
;
; Created: 10/22/2017 8:20:15 PM
; Author : shail
;


; Replace with your application code

.include "m169pdef.inc"

call place
ldi r30, $FF					;smallest value
ldi r29, $00					;largest value

pop r20							;first value
cp r20, r20

brge greaterthanorequal
brlt lessthan
push r20
call extrema					;rest of the values

place:								;subroutine to place values in memory
									;set stack pointer
	ldi r16, high($300)
	out sph, r16
	ldi r16, low($300)
	out sph, r16
									;push temperatures to stack
	ldi r17, $66
		push r17
	ldi r17, $71
		push r17
	ldi r17, $22
		push r17
	ldi r17, $33
		push r17
	ldi r17, $56
		push r17
	ldi r17, $98
		push r17
	ldi r17, $76
		push r17
	ldi r17, $21
		push r17
	ldi r17, $34
		push r17
	ldi r17, $59
		push r17
ret

extrema:
	loop:							;loop through all 10 numbers
		pop r20						;pop current number from stack
		cp r20, r29					;compare to previous highest number
		brge greaterthanorequal		;if it's greater than the previous highest, go to subroutine
		cp r20, r30					;compare to previous lowest number
		brlt lessthan				;if it's less than previous lowest, go to lessthan subroutine
	rjmp loop

	greaterthanorequal:				;if it's greater than previous max num, replace max num
		mov r29, r20
	ret
	lessthan:						;if it's less than previous min num, replace min num
		mov r30, r20
	ret
		
