;
; ICA10_assembly.asm
;
; Created: 11/17/2017 1:55:37 PM
; Author : shail
;


; Replace with your application code
start:
ldi r16, high (ramend)
out sph, r16
LDI R16, LOW (RAMEND)
OUT SPL, R16

LDI R16,0b00000111
OUT PORTB, R16					;pullup resistors set
ldi R16,$FF
OUT DDRD, R16

Switch:							;setting up switches
	SBIC PINB, 1
	CALL FWD
	SBIC PINB, 2
	CALL BCK
	SBIC PINB, 3
	CALL STOP
	RJMP Switch

FWD:							;moving forward
	LDI R16,0b00100000
	OUT PORTD,R16
	CALL DELAY1
	LDI R16,0X00
	OUT PORTD,R16
	CALL DELAY2
	RJMP Switch					;jumps backto switch

FWD1:							;moves forward
	LDI R16,0b00100000
	OUT PORTD,R16
	CALL DELAY1
	LDI R16,0X00
	OUT PORTD,R16
	CALL DELAY2
	Ret

DELAY1:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,40
	OUT  OCR0A,R20				;.3ms pulse
	LDI  R20,0x0C
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 256

AGAIN1:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN1
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

DELAY2:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,156
	OUT  OCR0A,R20				;OCR0 = 156 (20 ms pulse)
	LDI  R20,0x0D
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 1024

AGAIN2:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN2
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

BCK:
	MAIN1: 
		LDI R16,0b00100000
		OUT PORTD,R16
		CALL DELAY3
		LDI R16,0X00
		OUT PORTD,R16
		CALL DELAY4
		RJMP Switch

DELAY3:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,53
	OUT  OCR0A,R20				;OCR0 = 40 (1.3ms pulse)
	LDI  R20,0x0C
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 256

AGAIN3:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN3
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

DELAY4:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,156
	OUT  OCR0A,R20				;OCR0 = 156 (20 ms pulse)
	LDI  R20,0x0D
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 1024

AGAIN4:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN4
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

STOP:
	MAIN2: 
		LDI R16,0b00100000
		OUT PORTD,R16
		CALL DELAY5
		LDI R16,0X00
		OUT PORTD,R16
		CALL DELAY6
		RJMP Switch

DELAY5:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,47
	OUT  OCR0A,R20				;OCR0 = 40 (1.3ms pulse)
	LDI  R20,0x0C
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 256

AGAIN5:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN5
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

DELAY6:
	LDI  R20,0
	OUT  TCNT0,R20				;TCNT0 = 0
	LDI  R20,156
	OUT  OCR0A,R20				;OCR0 = 156 (20 ms pulse)
	LDI  R20,0x0D
	OUT  TCCR0A,R20				;Timer0, CTC mode, prescaler = 1024

AGAIN6:
	IN  R20,TIFR0				;read TIFR
	SBRS  R20,OCF0A				;if OCF0 is set skip next instruction
	RJMP  AGAIN6
	LDI  R20,0x0
	OUT  TCCR0A,R20				;stop Timer0
	LDI  R20,1<<OCF0A
	OUT  TIFR0,R20				;clear OCF0 flag
	RET

