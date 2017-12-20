;
; LabFinal_Problem2.asm
;
; Created: 12/13/2017 1:52:56 PM
; Author : shail
;


; Replace with your application code
ldi r16, high(ramend)	//set stack pointer
out sph, r16
ldi r16, low(ramend)
out spl, r16
						//set portb as output
ldi r16, 0xff
out ddrb, r16

ldi r17, 0x00


start:
	out portb, r16
	ldi r18, 10			//loop counter
	loop1:				//loops 10 times, 100ms each
		call DELAY_100MS//calls delay
		dec r18			//decrement counter
		breq loop2		//break out of loop if r18 = 0
	jmp loop1
	
	loop2:				
		out portb, r17	//turn off LEDs
		ldi r18, 10		//reset counter
		
		loop3:
			call DELAY_100MS	//delay
			dec r18				//decrement counter again
			breq start			//break when r18 = 0
		jmp loop3

jmp start
 


DELAY_100MS:
	ldi r24, 32
	L1: ldi r25, 99
	L2: ldi r26, 50
	L3:
		nop
		nop
		dec r26
		brne L3
		dec r25
		brne L2
		dec r24
		brne L1
		ret
