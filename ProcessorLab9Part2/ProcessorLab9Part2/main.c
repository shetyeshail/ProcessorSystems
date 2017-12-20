/*
 * ProcessorLab9Part2.c
 *
 * Created: 11/30/2017 2:14:08 PM
 * Author : shail
 */ 

#include <avr/io.h>


int main(void)
{
	DDRD = 0xFF;
	unsigned char tens = 0;
	unsigned char ones = 0;
	PORTD = tens|ones;
	delay();
	
    /* Replace with your application code */
    while (1) 
    {
		unsigned char tens = 0;
		unsigned char ones = 0;
		int tens_counter = 0;
		int ones_counter = 0;
		while (tens_counter > 0)
		{
			while (ones_counter < 9)
			{
				ones++;
				ones_counter++;
				PORTD = tens|ones;
				delay();
			}
			ones = 0x0;
			tens = tens+16;
			if(tens==0xA0){
				tens=0;
			}
			PORTD = tens|ones;
			delay();
			ones_counter = 0;
			tens_counter--;
		}
    }
}

int delay(void){
	unsigned long n = 0;
	do{
		n++;
	}while(n<255000);
}