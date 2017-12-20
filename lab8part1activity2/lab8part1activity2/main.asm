;
; lab8part1activity2.asm
;
; Created: 11/16/2017 8:52:29 PM
; Author : shail
;


; Replace with your application code
.include <m169pdef.inc>
.org 0x0020								;store data staring at 0020
DATA1: .db $12, $58, $33, $45,$3a, $21	;storing data sets
DATA2: .db 'G', 'O', 'O', 'D'
DATA3: .db "Engineering"

ldi R21, LOW(RAMEND)					;setting pointers
out spl, R21
ldi R21, HIGH(RAMEND)
out sph, R21
ldi R22, 6								;setting counters for each dataset
ldi R23, 4
ldi R24, 11
ldi R25, 0
ldi zl, LOW(DATA1<<1)					;stack pointers
ldi zh, HIGH(DATA1<<1)
ldi xl, LOW(0x100)
ldi xh, HIGH(0x100)

SUM1:									;first sum
	lpm R16, z+							;add up all the values
	add R25, R16
	dec R22								;decrease counter
	cpi R22, 0							;keep looping until counter=0
	brne SUM1
	call CHECKSUM

SUM2:
	lpm R16, z+
	add R25, R16
	dec R23
	cpi R23, 0
	brne SUM2
	call CHECKSUM 

SUM3:
	lpm R16, z+
	add R25, R16
	dec R24
	cpi R24, 0
	brne SUM3
	call CHECKSUM

here: jmp here

CHECKSUM:								;checksum
	mov R18, R25						;copy sum into r18
	com R25								;2s compliment
	st x+, R25							;store compliment
	adc R18, R25						;adding
	ret

