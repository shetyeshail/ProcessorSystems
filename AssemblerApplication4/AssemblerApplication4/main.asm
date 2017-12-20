;
; AssemblerApplication4.asm
;
; Created: 9/12/2017 8:39:45 AM
; Author : shail
;


; Replace with your application code
start:
	; question 1
	ldi r16, 7
	ldi r17, 6
	ldi r18, 5

    sts 0x103, r16
	sts 0x105, r17
	sts 0x107, r18

	; question 2
	inc r16
	inc r16
	inc r16
	inc r17
	inc r17
	inc r17
	inc r18
	inc r18
	inc r18

	sts 0x200, r16
	sts 0x201, r17
	sts 0x202, r18

	; question 3
	ldi r19, 8
	sub r16, r19
	sub r17, r19
	sub r18, r19

	; question 4
	ldi r26, 12
	mov r3, r26
	ldi r27, 42
	mov r5, r27

	swap r3
	swap r5

rjmp start
