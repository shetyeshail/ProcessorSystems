/*
 * LCD_test00.c
 *
 * Created: 11/12/2013 10:36:47 AM
 *  Author: Me, myself and I
 */ 
#include <avr/io.h>
#include <avr/interrupt.h>
#include "LCD_driver.h"
int main(void)
{
// three buttons of joystick pins with pullup resistors
PORTB |= (1<<4)|(1<<7)|(1<<6);
LCD_Init();// initialize the LCD
// enable interrupts
PCMSK1 |= (1<<PINB4)|(1<<PINB7)|(1<<PINB6);
EIMSK |= (1<<PCIE1);
sei();// enable global interrupt

while(1)
{
// wait until interrupt
}
}





ISR(PCINT1_vect,ISR_BLOCK) {
	char joystick;// joystick port
	unsigned char temp;
	joystick = ~PINB & ((1<<4)|(1<<7)|(1<<6));// read the port and mask it

	if (joystick == (1<<4)) {// if center pressed toggle flag
		LCD_puts("CENTER");
		return;// and return
	}
	if (joystick == (1<<7)) {// if DOWN pressed toggle flag
		LCD_puts("DOWN");
		return;// and return
	}
	if (joystick == (1<<6)) {// if UP pressed toggle flag
		LCD_puts("UP");
		return;// and return
	}

	if (joystick == 0) return;// if nothing pressed, return doing nothing
}

