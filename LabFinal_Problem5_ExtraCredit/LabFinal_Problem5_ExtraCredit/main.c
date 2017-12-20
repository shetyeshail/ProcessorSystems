/*
 * LabFinal_Problem5_ExtraCredit.c
 *
 * Created: 12/15/2017 8:53:39 PM
 * Author : shail
 */ 

									//import libraries
#include <avr/io.h>
#include <avr/interrupt.h>
#include "LCD_driver.h"
#include "util\delay.h"

									//definitions
#define PINB_MASK ((1<<PINB4)|(1<<PINB6)|(1<<PINB7))
#define PINE_MASK ((1<<PINE2)|(1<<PINE3))

									//initialize variables
unsigned char counter;
unsigned char str[];
unsigned char pause;

int main(void){

	LCD_Init();						// initialize LCD screen

									//initialize port pins
	PORTB |= PINB_MASK;
	DDRE = 0x00;
	PORTE |= PINE_MASK;				//pin change interrupt for ports B and E
	PCMSK0 = PINE_MASK;
	PCMSK1 = PINB_MASK;
	EIFR = (1<<6)|(1<<7);
	EIMSK = (1<<6)|(1<<7);
	DDRD = 0xFF;					//PORTD = output
	DDRB = 0X00;					//PORTB = input
	sei();							//set global interrupt
	counter = 0;					//set counter
	while(1)
	{
		if(pause){}
		else{
			counter++;				//if pause=0, increment counter
		}
		
		_delay_ms(1000);
		sprintf(str, "%d", counter);//print count
		LCD_puts(str);
		
		if(counter == 100){			//once counter gets to 100 reset to 0
			counter = 0;
		}
	}
}
ISR(PCINT1_vect,ISR_BLOCK) {

	if (!(PINB &(1<<PINB6))) {		//up button disables pause
		pause = 0;
		return;
	}
	if (!(PINB &(1<<PINB4))) {		//center button enables pause
		pause = 1;
		return;
	}
	if (!(PINB &(1<<PINB7))) {		//down button disables pause
		pause = 0;
		return;
	}

}
ISR(PCINT0_vect,ISR_BLOCK) {
	
	if(!(PINE &(1<<PINE3))){		//right button disables pause
		pause = 0;
		return;
	}
	if(!(PINE &(1<<PINE2))){		//left button disables pause
		pause = 0;
		return;
	}

}