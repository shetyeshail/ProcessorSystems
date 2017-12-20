;
; Processors_Lab2.asm
;
; Created: 9/19/2017 11:43:04 PM
; Author : shail
;


; Replace with your application code
start:
		ldi r16, 50
		ldi r17, 9
change:
		inc r17
		cp r16,r17
		brne change
		here: jmp here




