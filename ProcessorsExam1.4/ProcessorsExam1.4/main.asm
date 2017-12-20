;
; ProcessorsExam1.4.asm
;
; Created: 10/23/2017 12:13:16 AM
; Author : shail
;


; Replace with your application code
.include "m169pdef.inc"

;set the stack pointer
ldi r16, high($101)
out sph, r16
ldi r16, low($101)
out spl, r16

;store numbers
ldi r20, $3f
ldi r21, $d6

;compare numbers and branch if it's greater or less
cp r20, r21
brge greater
brlt lesser

greater:
	push r20
	pop r21
ret

lesser:
	push r21
	pop r20
ret
