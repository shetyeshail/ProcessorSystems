;
; ICA6.asm
;
; Created: 10/13/2017 10:24:33 AM
; Author : shail
;


; Replace with your application code
start:
    
	ldi r16, $ff
	out portd, r16
	out ddrb, r16

	out portb, r17

	repeat:
	sbic pind, 0			; if switch 1 is active, display 0-9
		call condition1
	sbic pind, 1			; if switch 2 is active, display 915092727
		call condition2
	sbic pind, 2			; if switch 3 is active, display BEAT UCOnn
		call condition3
	rjmp repeat

	condition1:
		ldi r17, 0b00111111	;0
		out portb, r17
		call delay
		ldi r17, 0b00001100	;1
		out portb, r17
		call delay
		ldi r17, 0b01110101	;2
		out portb, r17
		call delay
		ldi r17, 0b01011101	;3
		out portb, r17
		call delay
		ldi r17, 0b01001110	;4
		out portb, r17
		call delay
		ldi r17, 0b01011011	;5
		out portb, r17
		call delay
		ldi r17, 0b01111010	;6
		out portb, r17
		call delay
		ldi r17, 0b00001101	;7
		out portb, r17
		call delay
		ldi r17, 0b01111111	;8
		out portb, r17
		call delay
		ldi r17, 0b01001111	;9
		out portb, r17
		call delay
	ret

	condition2:
		ldi r17, 0b01001111	;9
		out portb, r17
		call delay
		ldi r17, 0b00001100	;1
		out portb, r17
		call delay
		ldi r17, 0b01011011	;5
		out portb, r17
		call delay
		ldi r17, 0b00111111	;0
		out portb, r17
		call delay
		ldi r17, 0b01001111	;9
		out portb, r17
		call delay
		ldi r17, 0b01110101	;2
		out portb, r17
		call delay
		ldi r17, 0b00001101	;7
		out portb, r17
		call delay
		ldi r17, 0b01110101	;2
		out portb, r17
		call delay
		ldi r17, 0b00001101	;7
		out portb, r17
		call delay
	ret

	condition3:
		ldi r17, 0b01111111	;B
		out portb, r17
		call delay
		ldi r17, 0b00000011	;E
		out portb, r17
		call delay
		ldi r17, 0b11101111	;A
		out portb, r17
		call delay
		ldi r17, 0b01110010	;t
		out portb, r17
		call delay
		ldi r17, 0b10111110	;U
		out portb, r17
		call delay
		ldi r17, 0b00110011	;C
		out portb, r17
		call delay
		ldi r17, 0b10111111	;O
		out portb, r17
		call delay
		ldi r17, 0b01101000	;n
		out portb, r17
		call delay
		ldi r17, 0b01101000	;n
		out portb, r17
		call delay
	ret

	delay:					; 1 second delay
		ldi r20,32
		L1: LDI R21, 200
		L2: LDI R22, 250
		L3: NOP
		NOP
		DEC R22
		BRNE L3
		DEC R21
		BRNE L2
		DEC R20
		BRNE L1
	RET

rjmp start