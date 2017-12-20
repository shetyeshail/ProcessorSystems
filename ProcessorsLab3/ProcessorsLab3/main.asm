;
; ProcessorsLab3.asm
;
; Created: 9/19/2017 12:50:52 PM
; Author : shail
;


; Replace with your application code
ldi r16, 03					;set r16 to 03
start:						;start loop
    ldi r17, 0b00000000		;sets 0b00000000 into r17
	sts ddrb, r17			;sets port ddrb to what was in r17, which is 0b00000000, which makes portb an input
	ldi r17, 0b11111111		; sets r17 to 0b11111111, so it is now an output
	out ddrd, r17			; sets port ddrd to what was in r17, which is now 0b11111111, so portd is now an output
	in r18, pinb			; sets r18 to pinb
	inc r18					; increments r18 by 1
	dec r16					; decrements r16
	out portd, r18			; sets portd to r18 which is now 1
	cp r16, r18				; compares r16 and r18, and uses that to see if you need to jump to start again
	brne start				; ends branch
end: rjmp end				; ends loop, keeps jumping to this same spot each step
;rjmp st
