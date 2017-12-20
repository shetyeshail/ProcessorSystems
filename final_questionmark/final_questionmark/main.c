/*
 * final_project.c
 *
 * Created: 12/8/2017 6:26:52 PM
 * Author : shail
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include "LCD_driver.h"
int counter = 0;
char str[256];
int rpm;
int intervals;


int main(){
	LCD_Init();					//initialize the LCD screen
	
	DDRB =	(1<<1);				//set PORTB pin as motor output
	PORTB = (1<<0);
	
	PCMSK1 = (1<<PINB0);		//set an interrupt pin
	EIMSK = (1<<PCIE1);			//allow access to interrupts
	
	TCCR2A = (1<<CS01);			//counter control register for timers
	OCR2A = 0xF3;				//counter compare regiser
	TCNT2 = 0;
	TIMSK2 = (1<<OCIE2A);
	
	sei();						//set global interrupt
	
	while(1){					//loop to change which PWM to use
		PORTB = (1<<0)|(1<<1);
		Ten();					//REPLACE WITH ANY OTHER PWM METHOD
		PORTB = (1<<0)|(0<<1);
		Ninety();				//REPLACE WITH ANY OTHER PWM METHOD
	}
}

								//PULSE WIDTH MODULATION METHODS
int Ten(){
	TCCR0A = (1<<CS01);			//8 prescaler in normal mode
	TCNT0 = 246;				//256 - 10 = 246
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Twenty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 236;				//256 - 20 = 236
	while (TIFR0  == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Thirty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 226;
	while (TIFR0  == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Forty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 216;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Fifty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 206;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Sixty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 196;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Seventy(){
	TCCR0A = (1<<CS01);
	TCNT0 = 186;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Eighty(){
	TCCR0A = (1<<CS01);
	TCNT0 = 176;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

int Ninety(){
	TCCR0A = (1<<CS01);
	TCNT0 = 166;
	while (TIFR0 == 0){
	}
	TCCR0A = 0;
	TIFR0 = (1<<OCF0A)|(1<<TOV0);
}

ISR(PCINT1_vect,ISR_BLOCK){		//function that works the display
	counter++;					//number of rotations
	sprintf(str,"%d",rpm);		//print to lcd screen
	LCD_puts(str);				//also print to lcd screen
	return;
}

ISR(TIMER2_COMP_vect,ISR_BLOCK){//converting from microseconds to 1 minute intervals
	intervals++;
	if (intervals == 1000){
		rpm = (counter/2) * 600;//divides counter by 2 and multiplies by 600 to get RPM
		intervals = 0;			//Reset counter
		TCNT2 = 0;				//Reset timer
		counter = 0;			//Reset counter
	}
	return;
}