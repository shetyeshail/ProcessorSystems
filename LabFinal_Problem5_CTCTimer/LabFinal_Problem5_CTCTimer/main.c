/*
 * LabFinal_Problem5_CTCTimer.c
 *
 * Created: 12/15/2017 8:09:29 PM
 * Author : shail
 */ 

#include <avr/io.h>
int main(void)
{
	DDRD = 1;			//set portd as output
	while (1)
	{
		PORTD = (1<<0); //pin1 = high
		pulse();		//call delay
		PORTD = (0<<0); //pin1 = low
		pulse();		//call delay
	}
}

int pulse(){			//CTC mode
	TCCR1B = (1<<CS10)|(1<<CS12)|(1<<WGM12);	//1024 prescaler
	TCNT1 = 0;			//start timer at 0
	OCR1B = 3907;		//(500k nanosec)/(1024 prescaler/8mhz)
	while (TIFR1 == 0){}//loop until overflow flag is enabled
	TIFR1 = (1<<TOV1)|(1<<OCF1B);				//disable flag again
	TCCR1B = 0;			//disable timer
}
