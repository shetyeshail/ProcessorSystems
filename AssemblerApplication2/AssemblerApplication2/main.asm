;
; AssemblerApplication2.asm
;
; Created: 9/12/2017 7:12:17 AM
; Author : shail
;


; Replace with your application code
start:
	ldi r16, $ca
	ldi r17, $3b

	ldi r18, $0a
	ldi r19, $a1
	
	ldi r20, $a0
	ldi r21, $02

	ldi r22, $ff
	ldi r23, $fa

	ldi r24, $fa

	ldi r26, $ad
	ldi r27, $0b
rjmp start
