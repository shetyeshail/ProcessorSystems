;
; LabFinal_Program1.asm
;
; Created: 12/13/2017 9:40:05 AM
; Author : shail
;


; Replace with your application code
start:
    .include <m169pdef.inc>
	.cseg
	.org 0x0010					;program memory at 0x20
	DATA1: .db $45, $17, $6a	;store into program memory
								;store each value into GPRs
	ldi r17, $45
	ldi r18, $17
	ldi r19, $6a
								;store each into data memory
	sts 0x0200, r17
	sts 0x0201, r18
	sts 0x0202, r19

here: jmp here					;end
