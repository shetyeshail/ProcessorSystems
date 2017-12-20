/*
 * ICA10_C.c
 *
 * Created: 11/17/2017 2:24:20 PM
 * Author : shail
 */ 

#include <avr/io.h>

int main(void)
{
	unsigned char I = 0b00100000;
	unsigned char O = 0b00000000;
	
	DDRD = 0xff;
	PORTB = 7;
	
	long int count = 0;

	do{
		PORTD = PORTD|I;
		pulse_17();
		PORTD = PORTD&O;
		delay_20ms();
		count++;
	}while (count < 60000);

	count = 0;
	do{
		PORTD = PORTD|I;
		pulse_13();
		PORTD = PORTD&O;
		delay_20ms();
		count++;
	}while (count < 1200);

	
	
	
	
	while (1) {
		
		if (PINB == 1){ //Move clk wise
			PORTD = PORTD|I;
			pulse_17();
			PORTD = PORTD&O;
			delay_20ms();
		}
		
		if (PINB == 3){ //move CLKWISE
			PORTD = PORTD|I;
			pulse_13();
			PORTD = PORTD&O;
			delay_20ms();
			
			if (PINB == 7){ //clockwise stop
				
				do{
					PORTD = PORTD|I;
					pulse_17();
					PORTD = PORTD&O;
					delay_20ms();
					count++;
				}while (count < 60000);
				
				if (PINB == 7){
					PORTD = PORTD|I;
					pulse_15();
					PORTD = PORTD&O;
					delay_20ms();
				}
			}
		}
	}
}

int delay_20ms(void){
	TCNT0 = 0;
	OCR0A = 0x63;
	TCCR0A = 0xD;
	while(TIFR0<<TOV0 == 1){
	}
	TCCR0A = 0;
	TIFR0 = 0x1<<OCF0A;
	return;
}

int pulse_13(void){
	TCNT0 = 0;
	OCR0A = 40;
	TCCR0A = 0xC;
	while(TIFR0<<TOV0 == 0){
		
	}
	TCCR0A = 0;
	TIFR0 = 0x1<<OCF0A;
	return;
}

int pulse_15(void){
	TCNT0 = 0;
	OCR0A = 0x44;
	TCCR0A = 0xB;
	while(TIFR0<<TOV0 == 1){
		
	}
	TCNT0 = 0;
	TIFR0 = 0x1<<OCF0A;
}

int pulse_17(void){
	TCNT0 = 0;
	OCR0A = 0x2B;
	TCCR0A = 0xB;
	while(TIFR0<<TOV0 == 1){
		
	}
	TIFR0 = 0x1<<OCF0A;
}
