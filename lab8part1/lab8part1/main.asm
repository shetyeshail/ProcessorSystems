;
; lab8part1.asm
;
; Created: 11/16/2017 7:32:14 PM
; Author : shail
;


; Replace with your application code
start:
	.include <m169pdef.inc>
	.org 0x0020				;set starting point of storing data sets
	DATA1: .db 0x12, 0x58, 0x33, 0x45,0x3a, 0x21
	DATA2: .db 'G', 'O', 'O', 'D'
	DATA3: .db "Engineering"
							;setting pointers to where we want to store data
	ldi R16, 22
	ldi zl, LOW(DATA1<<1)
	ldi zh, HIGH(DATA1<<1)
	ldi R17, LOW(0x0100)
	ldi R18, HIGH(0x0100)

	WAIT:					;wait for the last write to complete
		SBIC	EECR,EEWE	;check EEWE to see if last write is finished
	RJMP	WAIT
	dec R16
	cpi R16, 0
	breq here
 
	C1: 
		OUT	EEARH, R18		;high stack pointer
		OUT	EEARL, R17		;low stack pointer
		inc R17
 
	EEPROM:
		lpm R20, z+
		OUT	EEDR,R20		;load R20 to data reg
		SBI	EECR,EEMWE		;master write enable set
		SBI	EECR,EEWE		;write enable set
	rjmp WAIT

here: jmp here
