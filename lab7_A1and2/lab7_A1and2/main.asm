ldi r16,high(ramend)
out sph,r16
ldi r16,low(ramend)
out spl,r16

LDI R16,$FF
out ddrd,r16

ldi r16, 'L'
sts 0x201,r16
ldi r16, 'I'
sts 0x202,r16
ldi r16, 'G'
sts 0x204,r16
ldi r16, 'H'
sts 0x208,r16
ldi r16, 'T'
sts 0x210,r16
ldi r16, 'O'
sts 0x220,r16
ldi r16, 'N'
sts 0x240,r16

LDI ZL,LOW(0X0101<<0)
LDI Zh,high(0X0101<<1)
OUT PORTD,ZL
//CALL delay
LD R17,Z
OUT PORTD,R17
//call delay // L

LDI ZL,LOW(0X0102<<0)
LDI zh,high(0X0102<<1)
OUT PORTD,zL
//CALL delay
LD R17,z
OUT PORTD,R17
;call delay // I 

LDI zL,LOW(0X0204)
LDI zh,high(0x0204)
OUT PORTD,zL
;CALL delay
LD R17,z
OUT PORTD,R17
;call delay // G

LDI zL,LOW(0X0208)
LDI zh,high(0x0208)
OUT PORTD,zL
;CALL delay
LD R17,z
OUT PORTD,R17
;call delay // H

LDI zL,LOW(0X0210)
LDI zh,high(0x0210)
OUT PORTD,zL
;CALL delay
LD R17,z
OUT PORTD,R17
;call delay // T

LDI zL,LOW(0X0220)
LDI zh,high(0x0220)
OUT PORTD,zL
;CALL delay
LD R17,z
OUT PORTD,R17
;call delay // O

LDI zL,LOW(0X0240)
LDI zh,high(0x0240)
OUT PORTD,zL
;CALL delay
LD R17,z
OUT PORTD,R17
;call delay // N

;delay:
;ldi R24,64
;L1:ldi R25,200 
;L2:ldi R26,250
;L3: 
;nop
;nop
;dec R26 
;brne L3 
;dec R25
;brne L2
;dec R24
;brne L1
;ret



//CODE FOR QUESTION 1:
.cseg 
SAMPLE_FLASH: .db "Hello"

LDI R16,$FF
STS $0,R16
LDI R16,0

LPM R16,Z
LD R16,Z

HERE: JMP HERE