/*
 * LabFinal_Problem5_NormalTimer.c
 *
 * Created: 12/15/2017 6:14:34 PM
 * Author : shail
 */ 

#include <avr/io.h>
int main(void)
{
	DDRD = 1;			//set portd as output
	while (1)
	{
		PORTD = (1<<1); //pin1 = high
		delay();		//call delay
		PORTD = (0<<1); //pin1 = low
		delay();		//call delay
	}
}

int delay(){						//normal mode
	TCCR1B = (1<<CS10)|(1<<CS12);	//1024 prescaler
	TCNT1 = 61628;					//FFFF = 65535 - (500k nanosec)/(1024 prescaler/8mhz)
	while (TIFR1 == 0){};			//loop until overflow flag is enabled
	TIFR1 = (1<<TOV1)|(1<<OCF1B);	//disable flag again
	TCCR1B = 0;						//disable timer
}
