;
; processorlab3.asm
;
; Created: 9/27/2017 8:37:53 PM
; Author : shail
;


; Replace with your application code
.EQU FinalCounter = 0x100
.EQU EvenNumberCounter = 0x101

start:
	ldi r20, 0x04				;stores 0x04 to r20
	ldi r21, 0					;Counter for even numbers.

loop:
	inc r20						;increment r20 twice
	inc r20
	inc r21						;increment r21 once
	cpi r20, 0x6e				;compare statement
brne loop						;loop if compare is equal

	sts FinalCounter, r20		;stored at 0x100 in memory
	sts EvenNumberCounter, r21	;stored at 0x101 in memoryend: rjmp end