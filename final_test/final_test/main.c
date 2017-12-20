/*
 * final_questionmark.c
 *
 * Created: 12/10/2017 6:26:52 PM
 * Author : shail
 */ 

#include <stdlib.h>


#include <avr/io.h>
#include <avr/interrupt.h>
#include "LCD_driver.h"
int counter = 0;
char str[256];
int rpm;
int intervals;

int main(){
	LCD_Init();
	
	DDRB =	(1<<1);									//test LED
	PORTB = (1<<0);
	
	PCMSK1 = (1<<PINB0);							//Interrupt Pin
	EIMSK = (1<<PCIE1);
	
	TCCR2A = (1<<CS01)|(1<<3);
	OCR2A = 0xF3;
	TCNT2 = 0;
	TIMSK2 = (1<<OCIE2A);
	
	sei();											//set interrupt
	
	while(1){										//loop to change which PWM to use
		PORTB = (1<<0)|(1<<1);
		TenPWM();
		PORTB = (1<<0)|(0<<1);
		NinePWM();
	}
}

int TenPWM(){
	TCCR0A = (1<<1)|(1<<3);							// CTC MODE 8 prescaler
	TCNT0 = 0;
	OCR0A = 0xA;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int TwenPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x14;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int ThirPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x1E;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int FourPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x28;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int FiftPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x32;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int SixtPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x3C;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int SevePWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x46;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int EightPWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x50;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

int NinePWM(){
	TCCR0A = (1<<1)|(1<<3);
	TCNT0 = 0;
	OCR0A = 0x5A;
	while (TIFR0 << OCF0A == 0){
	}
	TCCR0A = 0;
	TIFR0 = 1<<OCF0A;
}

ISR(PCINT1_vect,ISR_BLOCK){							//function that works the display
	counter++;										//number of rotations
	int r = rand() % 20;
	sprintf(str, "%d",r);
	//sprintf(str,"%d",rpm);
	LCD_puts(str);
	return;
}

ISR(TIMER2_COMP_vect,ISR_BLOCK){					//converting from microseconds to 1 minute intervals
	intervals++;
	if (intervals == 1000){
		rpm = counter/2 * 600;
		intervals = 0;								//Resets interval counter
		TCNT2 = 0;									//Resets timer
		counter = 0;								//Resets counter
	}
	return;
}