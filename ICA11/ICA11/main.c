/*
 * ICA11.c
 *
 * Created: 12/8/2017 10:41:22 AM
 * Author : shail
 */ 

#include <avr/io.h>				//import files
#include <avr/interrupt.h>
#include "avr/delay.h"


int count = 0;					//set global variables
int dist;
char str[100];

int main(void)					//main function
{
	DDRB = 0x2;					//set input/output
	LCD_Init();					//initialize LCD screen
	
	PCMSK1 = (1<<PINB0);		//pin change interrupt
	EIMSK = (1<<PCIE1);			//external interrupts
	
	TCCR0A = (1<<CS02);			//timer interrupts
	TIMSK0 = (1<<OCIE0A);
	
	DDRB = 3;					//turns on and off with a delay in the middle				
	PORTB = 0;
	_delay_us(2);
	PORTB = 1;
	_delay_us(5);
	DDRB = 2;
	
	sei();						// Set the interrupt
	
	while(1){
	}
}


ISR(PCINT1_vect){
	count++;
	
	if (count == 3){
		TCNT0 = 0;
	}
	
	if (count == 4){
		dist = TCNT0 * .214;
		sprintf(str,"%d IN",dist);
		LCD_puts(str);
		count = 0;
		TCNT0 = 0;
		
		if (dist > 30){							//if portb is greater than 30, do nothing
			PORTB = 0x0;
		}
		
		else if (dist <= 5){					//if portb is less than or equal to 5 turn on
			PORTB = 0x2;
		}
		
		else if (dist > 5 && dist <= 10){		//if portb is between 5 and 10 blink with 300 delay
			PORTB = 0x2;
			_delay_ms(300);
			PORTB = 0x0;
			_delay_ms(300);
		}
		
		else if (dist > 10 && dist <= 15){		//if portb is between 10 and 15 blink with 450 delay
			PORTB = 0x2;
			_delay_ms(450);
			PORTB = 0x0;
			_delay_ms(450);
		}
		
		else if (dist > 15 && dist <= 20){		//if portb is between 10 and 20 blink with 600 delay
			PORTB = 0x2;
			_delay_ms(600);
			PORTB = 0x0;
			_delay_ms(600);
		}
		
		else if (dist > 20 && dist <= 25){		//if portb is between 20 and 25 blink with 750 delay
			PORTB = 0x2;
			_delay_ms(750);
			PORTB = 0x0;
			_delay_ms(750);
		}
		
		else if (dist > 25 && dist <= 30){		//if portb is between 25 and 30 blink with 1000 delay
			PORTB = 0x2;
			_delay_ms(1000);
			PORTB = 0x0;
			_delay_ms(1000);
		}

		return;
	}
}