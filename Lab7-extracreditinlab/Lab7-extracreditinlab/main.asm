;
; Lab7-extracreditinlab.asm
;
; Created: 10/17/2017 1:03:38 PM
; Author : shail
;


; Replace with your application code
.cseg								;create code segment
.org 0x0020							;start memory address
data1: .DB 0x10,0x11,0x12			;filling in data
data2: .DB 'A','B','C'
data3: .DB 'h','e','l','l','o'

ldi zl,0x40							;z pointer at 0x0040
ldi zh,0x00
									;load byte that z register points to from data1,2,3 into registers
lpm r0,z+
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
									;the address of data11 is loaded into x registers
ldi xl,LOW(data11)
ldi xh,HIGH(data11)

st x+,r0
st x+,r1
st x+,r2

ldi xl,LOW(data22)
ldi xh,HIGH(data22)
st x+,r3
st x+,r4
st x+,r5

ldi xl,LOW(data33)
ldi xh,HIGH(data33)
st x+,r6
st x+,r7
st x+,r8
st x+,r9
st x+, r10

.dseg
.org 0x0300
Data11: .byte 3
Data22: .byte 3
Data33: .byte 5
