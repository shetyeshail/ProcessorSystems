;
; Lab8.asm
;
; Created: 11/14/2017 3:28:45 PM
; Author : shail
;


; Replace with your application code

											;store data in flash starting at 0x20
.cseg
.org 0x20
DataSet1: .db $12,$58,$33,$45,$3A,$21
DataSet2: .db 'G','O','O','D'
DataSet3: .db "Engineering"

											;set stack pointer to ramend
ldi r16,high(ramend)
out sph,r16
ldi r16,low(ramend)
out spl,r16

											;set portd to inputs
ldi r16, $ff
out ddrd,r16

ldi zl,$40									;Pointing to FLASH

ldi xh,$1									;Pointing to EEPROM

ldi r18,21									;Counter

here:

	clear:
		sbic eecr,eewe
	jmp clear								;Clear Write

	lpm r16,z+
	out eearl,xl
	out eearh,xh

	out eedr,r16
	sbi eecr,eemwe
	sbi eecr,eewe

	out eearl,xl
	out eearh,xh

	inc xl
	dec r18
	breq done
	jmp here

done:
//////////////
//STORING CHECKSUM BYTE IN RAM
ldi zl,$40

ldi r19,3 //Counter for DATA1
here1: //Data1 Counter Stored to r18
lpm r16,z+
lpm r17,z+
add r16,r17
add r18,r16
dec r19
breq doneData1
jmp here1
doneData1:
neg r18
sts 0x100,r18

ldi r16,0
ldi r17,0
ldi r18,0

ldi r19,2
here2: //Data1 Counter Stored to r18
lpm r16,z+
lpm r17,z+
add r16,r17
add r18,r16
dec r19
breq doneData2
jmp here2

doneData2:
neg r18
sts 0x101,r18


ldi r16,0
ldi r17,0
ldi r18,0


ldi r19,6
here3: //Data1 Counter Stored to r18
lpm r16,z+
lpm r17,z+
add r16,r17
add r18,r16
dec r19
breq doneData3
jmp here3

doneData3:
neg r18
sts 0x102,r18
//////////////
//Reading from eeprom

ldi zl,$00
ldi zh,$1
ldi r18,6 //counter
//write to register 17

read:
sbic eecr,eewe
jmp read //Clear Write
out eearl,zl
out eearh,zh
sbi eecr,eere
in r17,eedr
add r0,r17 // addition of bit
inc zl
dec r18
breq nextread
jmp read

nextread: 
ldi r18,4
read2:
out eearl,zl
out eearh,zh
sbi eecr,eere
in r17,eedr
add r1,r17
inc zl
dec r18
breq nextread2
jmp read2

nextread2:
ldi r18,11
read3:
out eearl,zl
out eearh,zh
sbi eecr,eere
in r17,eedr
add r2,r17
inc zl
dec r18
breq finish
jmp read3

finish:
neg r0
neg r1
neg r2

lds r15,0x100
lds r16,0x101
lds r17,0x102

decidedtosub:
call compareD1
call delay
ldi r18,0
out portd,r18
call delay

call compareD2
call delay
ldi r18,0
out portd,r18
call delay

call compareD3
call delay
ldi r18,0
out portd,r18
call delay

jmp decidedtosub

compareD1:
cp r0,r15
breq PrintO1
ldi r18, 0b01001111
out portd,r18
return1:
ret

compareD2:
cp r1,r16
breq PrintO2
ldi r18, 0b01001111
out portd,r18
return2:
ret


compareD3:
cp r2,r17
breq PrintO3
ldi r18, 0b01001111
out portd,r18
return3:
ret


printO1:
ldi r18, 0b00111111
out portd, r18
jmp return1

printO2:
ldi r18, 0b00111111
out portd, r18
jmp return2

printO3:
ldi r18, 0b00111111
out portd, r18
jmp return3

delay:
ldi R24,32
L1: 
ldi R25,200 
L2: 
ldi R26,250
L3: 
nop
nop
dec R26
brne L3
dec R25
brne L2
dec R24 
brne L1
ret
