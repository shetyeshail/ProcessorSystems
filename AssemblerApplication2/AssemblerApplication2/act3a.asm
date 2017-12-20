;
; AssemblerApplication2.asm
;
; Created: 9/12/2017 7:12:17 AM
; Author : shail
;


; Replace with your application code
start:
	LDI R22, $85
	LDI R21, $AA
	SUB R22, R21
rjmp start
