;
; lab8part2activity1.asm
;
; Created: 11/16/2017 10:03:36 PM
; Author : shail
;


; Replace with your application code
start:
.org 0x20										;store data starting at 20
data1: .DB 0x12, 0x58, 0x33, 0x45,0x3a, 0x21
data2: .DB 'G', 'O', 'O', 'D'
data3: .DB "Engineering"

ldi zl,0x40
ldi zh,0x00

lpm r0,z+										;load data into registers
lpm r1,z+
lpm r2,z+
lpm r3,z+
lpm r4,z+
lpm r5,z+
lpm r6,z+
lpm r7,z+
lpm r8,z+
lpm r9,z+
lpm r10,z+
lpm r11,z+
lpm r12,z+
lpm r13,z+
lpm r14,z+
lpm r15,z+
lpm r16,z+
lpm r17,z+
lpm r18,z+
lpm r19,z+
lpm r20,z

ldi xl,LOW(0x0200)								;loading from program memory to SRAM
ldi xh,HIGH(0x0200)
st x+,r0
st x+, r1
st x+, r2
st x+, r3
st x+, r4
st x+, r5
st x+, r6
st x+, r7
st x+, r8
st x+, r9
st x+, r10
st x+, r11
st x+, r12
st x+, r13
st x+, r14
st x+, r15
st x+, r16
st x+, r17
st x+, r18
st x+, r19
st x, r20

add r0,r1 ;checksum for dataset 1
add r0,r2
add r0,r3
add r0,r4
add r0,r5
sts 0x0100, r0

add r6, r7 ;checksum for dataset 2
add r6, r8
add r6, r9
sts 0x0101, r6

add r10, r11 ;checksum for dataset 3
add r10, r12
add r10, r13
add r10, r14
add r10, r15
add r10, r16
add r10, r17
add r10, r18
add r10, r19
add r10, r20
sts 0x0102,r10

ldi xl,LOW(0x0200) ;SRAM location
ldi xh,HIGH(0x0200)

ldi r21, 0x01 ;EEPROM pointer
ldi r22, 0x00

ldi r23,21	;counter
out eearh, r21 ;eeprom pointer
out eearl, r22

L_C1: ;SRAM to EEPROM
	W:
		sbic eecr,eewe
		rjmp W
		nop
		out eearl, r22
		ld r24, x+
		out eedr,r24
		sbi eecr, eemwe ;set master write enable
		sbi eecr, eewe ;set write enable
		inc r22
		dec r23 ; dec counter
		brne L_C1
		ldi xl,LOW(0x0150);set counter
		ldi xh,HIGH(0x0150)
		ldi r21, 0x01
		ldi r22, 0x00
		out eearh, r21
		out eearl, r22
		ldi r23, 21

R_C1:
	W1:
		sbic eecr, eewe
		rjmp W1
		nop
		out eearl, r22 
		sbi eecr, eere
		in r24, eedr
		st x+, r24
		inc r22
		dec r23
		brne R_C1

ldi xl,LOW(0x0150);set pointers
ldi xh,HIGH(0x0150)
ldi yl,LOW(0x0250)
ldi yh,HIGH(0x0250)
ldi r23, 3

com_byte:
	ld r22, x+
	com r22 ;taking 2's complement
	ldi r16, 1
	add r22, r16
	st y+, r22
	dec r23
	brne com_byte
	
ldi r16, 0xff
out ddrd, r16
lds r16, 0x0250 ;verifying data set 1
lds r17, 0x0150
add r16,r17
breq correct1
ldi r16,0
breq incorrect1

B1:
	lds r16, 0x0251 ;verifying data set 2
	lds r17, 0x0151
	add r16,r17
	breq correct2
	ldi r16, 0
	breq incorrect2

B2:
	lds r16, 0x0252 ;verifying data set 3
	lds r17, 0x0152
	add r16,r17
	breq correct3
	ldi r16, 0
	breq incorrect3

B3:
	rjmp end

correct1:
	ldi r16, 0b11000000
	out portd, r16 ;output O
	rjmp B1

incorrect1:
	ldi r16, 0b10001100
	out portd, r16 ;output E
	rjmp B1

correct2:
	ldi r16, 0b11000000
	out portd, r16 ;output O
	rjmp B2

incorrect2:
	ldi r16, 0b10001100
	out portd, r16 ;output E
	rjmp B2

correct3:
	ldi r16, 0b11000000
	out portd, r16 ;output O
	rjmp B3

incorrect3:
	ldi r16, 0b10001100
	out portd, r16 ;output E
	rjmp B3


end: rjmp start
