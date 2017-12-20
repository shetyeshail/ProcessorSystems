;
; AssemblerApplication1.asm
;
; Created: 9/11/2017 2:31:44 PM
; Author : shail
;


; Replace with your application code
start:
    ; store values in memory
	lds R4, 0xA2
	lds R5, 0x3C

	; swap with general purpose registers
	SWAP R4,R5

    rjmp start
