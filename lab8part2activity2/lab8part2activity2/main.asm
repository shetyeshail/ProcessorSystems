;
; lab8part2activity2.asm
;
; Created: 11/16/2017 11:08:40 PM
; Author : shail
;


; Replace with your application code
.cseg
.org 0x20				;storing to flash
DATA1: .DB $12,$58,$33,$45,$3A,$21
DATA2: .DB 'G','O','O','D'
DATA3: .DB "Engineering"
INC_DATA1: .DB $12,$28,$33,$45,$3A,$21
INC_DATA2: .DB 'G','O','O','D'
INC_DATA3: .DB "Enginering"

						;stack pointers
ldi r16,$ff
out spl,r16
ldi r16,$4
out sph,r16
						;I/O
ldi r16,3
out portb,r16
ldi r16,$ff
out ddrd,r16
						;checksum bytes
ldi r16,$c3
sts 0x106,r16
ldi r16,$d7
sts 0x107,r16
ldi r16,$95
sts 0x107,r16
						;switches
switch:
in r16,pinb
cpi r16,0
breq switch0
cpi r16,1
breq switch1
cpi r16,2
breq switch2_Far
cpi r16,3
breq switch3_Far
jmp switch

switch2_Far: rjmp switch2
switch3_Far: rjmp switch3

switch0:
ldi r16,21				;correct data
ldi zl,$40
ldi zh,0				;flash memory pointer
ldi xl,0
ldi xh,1				;eeprom pointer
call storage			;storing
ldi r16, 0b00111001		;ascii for C
out portd,r16
jmp switch

switch1:
ldi xl,$00
ldi xh,$1
ldi zl,$40
ldi zh,0
ldi r19,3
call CheckCorrect
neg r0
sts 0x100,r0
ldi r19,2
mov r0,r24
call CheckCorrect
neg r0
sts 0x101,r0
ldi r19,6
mov r0,r24
call CheckCorrect
neg r0
sts 0x102,r0
						;doing exclusive or
lds r16,0x100
lds r17,0x101
lds r18,0x102
mov r16,r0
mov r17,r1
mov r18,r2
lds r16,0x106
lds r17,0x107
lds r18,0x108
eor r16,r0
eor r17,r1
eor r18,r2
						;outputting O
ldi r16,0b00111111
out portd,r16
jmp switch

switch2:
ldi xl,$00
ldi xh,$1
ldi zl,$56
ldi zh,0
ldi r19,3
call CheckCorrect
neg r0
sts 0x103,r0
ldi r19,2
mov r0,r24
call CheckCorrect
neg r0
sts 0x104,r0
ldi r19,6
mov r0,r24
call CheckCorrect
neg r0
sts 0x105,r0
						;exclusive or
lds r16,0x103
lds r17,0x104
lds r18,0x105
mov r16,r0
mov r17,r1
mov r18,r2
lds r16,0x106
lds r17,0x107
lds r18,0x108
eor r16,r0
eor r17,r1
eor r18,r2
						;outputting E
ldi r16,0b01111001
out portd,r16
jmp switch

switch3:
ldi r16,20				;correct data counter
ldi zl,$56
ldi zh,0				;flash pointer
ldi xl,0
ldi xh,1				;eeprom pointer
call storage
ldi r16, 0b00110000		;outputting ascii I
out portd,r16
jmp switch

storage:
sbic eecr,eewe
jmp storage
lpm r17,z+
out eearl,xl
out eearh,xh
out eedr,r17
sbi eecr,eemwe
sbi eecr,eewe
inc xl
dec r16
breq FinStore
jmp storage
FinStore:
ret

CheckCorrect:
here:
lpm r17,z+
lpm r18,z+
add r17,r18
add r0,r17
dec r19
breq return
jmp here

return:
ret