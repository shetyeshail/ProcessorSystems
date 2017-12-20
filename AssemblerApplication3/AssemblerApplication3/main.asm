;
; AssemblerApplication3.asm
;
; Created: 9/12/2017 7:45:32 AM
; Author : shail
;


; Replace with your application code
start:
	LDI R25, $85
	LDI R21, $AA
	SUB R22, R21
rjmp start
