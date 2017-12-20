;
; LabFinal_Problem3.asm
;
; Created: 12/15/2017 2:00:21 PM
; Author : shail
;


; Replace with your application code
.cseg
.org 0x10			//location in flash

DATA1: .db 0x12, 0x58, 0x33, 0x45, 0x3a, 0x21; //data

ldi zl,0x20			//store data starting at 20
ldi xh,1			//setting x reg to point to RAM
ldi r16,6			//Counter to loop the load from flash

loop1:				//this loop adds values and stores from flash to RAM
	lpm r0,z+		//load value from flash to R0
	add r1,r0		//add to total 
	st x+,r0		//store from R0 to RAM
	dec r16			//decrement counter
	breq loop2		//break loop if counter = 0
jmp loop1

loop2:
	neg r1			//2's compliment
	ldi xl,0		//pointer to value 1
	ld r16,x		//load value 1
	inc xl			//pointer to value 2
	ld r17,x		//load value 2
	inc xl			//pointer to value 3
	ld r18,x		//load value 3
	inc xl			//pointer to value 4
	ld r19,x		//load value 4
	inc xl			//pointer to value 5
	ld r20,x		//load value 5
	inc xl			//pointer to value 6
	ld r21,x		//load value 6


	add r16,r17		// add data 
	add r16,r18
	add r16,r19
	add r16,r20
	add r16,r21

	add r16,r1		//add checksum byte
	mov r0,r16		//move to compare

jmp loop2
