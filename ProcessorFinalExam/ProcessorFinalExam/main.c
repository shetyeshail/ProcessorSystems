/*
 * ProcessorFinalExam.c
 *
 * Created: 12/17/2017 10:42:54 PM
 * Author : shail
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#define VCC 1100UL
volatile unsigned char servo	= 0b0000001;	//pin0
volatile unsigned char ping		= 0b0000010;	//pin1
volatile unsigned char led		= 0b1000000;	//pin2
volatile int counter;							//counter
volatile int distance;							//distance
volatile unsigned char str [100];				//display string
volatile unsigned char normalB = 0;
volatile int delay_count;						//delay counter
int valueADC;									//result of the a2d converter
int volts;									//voltage


int main(void)
{
	LCD_Init();									//setup screen
	ADC_setup();								//setup a2d converter
	
	PCMSK1 = (1<<PINB1);						//pin1 interrupt
	EIMSK = (1<<PCIE1);							//portb interrupt
	
	TCCR2A = (1<<CS01)|(1<<CS02);
	TIMSK2 = (1<<OCIE2A);
	

	DDRB = normalB|servo|led|ping;				//portb setup
	PORTB = (0<<1);
	Delay2us();								//call delay of 2us
	PORTB = ping;
	Delay5us();								//call delay of 5us
	DDRB = normalB|servo|led;
	sei();										//set global interrupt enable
	
	while (1){
		valueADC = readADC();				//read a2d converter result
		volts = (valueADC * VCC * 6)/1024;	//solve for voltage
		
		if (volts > 0 && volts <= 1000){	//if voltage bw 0 and 1
			sei();
			if (distance > 0 && distance <= 10){//if distance bw 0 and 10 then ccw
				cclockwise_control();
				_1sec();
			}
			else if (distance > 30){			//if distance greater than 30 then cw
				clockwise_control();
			}
		}
		else if (volts > 1000 && volts <= 2000){	//if voltage bw 1000 and 2000
			sprintf(str,"%d MV",volts);
			LCD_puts(str);
			cli();
			PORTB = led;								//set LED
			_2sec();
			PORTB = 0;
			_2sec();
			sei();										//global interrupt
		}
		else if (volts > 2000 && volts < 3000){		//if voltage bw 2000 and 3000
			sprintf(str,"%d MV",volts);				//print to screen
			LCD_puts(str);
			cli();
			PORTB = led;
			_5sec();
			PORTB = normalB;
			_5sec();
			sei();
		}
	}
}
												//ping sensor delays
int Delay2us(){
	TCCR0A = (1<<CS00);
	TCNT0 = 240;
	while(TIFR0 == 0);
	TCCR0A = 0;
	TIFR0 = (1<<TOV0)|(1<<OCF0A);
}
int Delay5us(){
	TCCR0A = (1<<CS00);
	TCNT0 = 216;
	while(TIFR0 == 0);
	TCCR0A = 0;
	TIFR0 = (1<<TOV0)|(1<<OCF0A);
}

int delay_20(){									//20ms pulse for motor
	TCNT0 = 0;
	TCCR0A = (1<<CS00)|(1<<CS02)|(1<<3);
	OCR0A = 156;
	while(TIFR0 == 0);
	TCCR0A = 0;
	TIFR0 = (1<<TOV0)|(1<<OCF0A);
}
int counter_clockwise(){						//1.7ms pulse for motor
	TCNT0 = 0;
	TCCR0A = (1<<CS00)|(1<<CS02)|(1<<3);
	OCR0A = 13;
	while(TIFR0 == 0);
	TCCR0A = 0;
	TIFR0 = (1<<TOV0)|(1<<OCF0A);
}
int clockwise(){								//1.3ms pulse for motor
	TCNT0 = 0;
	TCCR0A = (1<<CS00)|(1<<CS02)|(1<<3);
	OCR0A =	10;
	while(TIFR0 == 0);
	TCCR0A = 0;
	TIFR0 = (1<<TOV0)|(1<<OCF0A);
}

ISR(PCINT1_vect,ISR_BLOCK){						//ping sensor interrupt
	counter++;
	
	if (counter == 3){
		TCNT2 = 0;
	}
	if (counter == 4){
		distance = (TCNT2 * .214);
		sprintf(str,"%d IN",distance);
		LCD_puts(str);
		TCNT2 = 0;
		counter = 0;
	}
	
	if (distance > 10 && distance <= 15){	//pretending to gradually blink LED at different speeds
		PORTB = ping;
		_1sec();
		PORTB = ping|led;
		_1sec();
	}
	else if (distance > 15 && distance <= 20){//gradually changing speeds but it is tiered
		PORTB = ping;
		delay_count = 0;
		while (delay_count != 2){
			_1sec();
			delay_count++;
		}
		PORTB = ping|led;
		delay_count = 0;
		while (delay_count != 2){
			_1sec();
			delay_count++;
		}
	}
	
	else if (distance > 20 && distance <= 30){	//if distance bw 20 and 30
		PORTB = ping;
		delay_count = 0;
		while (delay_count != 3){
			_1sec();
			delay_count++;
		}
		delay_count = 0;
		PORTB = ping|led;
		while (delay_count != 3){
			_1sec();
			delay_count++;
		}
	}
	
}

int clockwise_control(){
	PORTB = servo|ping|led;
	clockwise();
	PORTB = ping|led;
	delay_20();
}
int cclockwise_control(){
	PORTB = servo|ping;
	counter_clockwise();
	PORTB = ping;
	delay_20();
}

int _1sec(){
	TCCR1B = (1<<CS10)|(1<<CS12);
	TCNT1 = 57722;
	while (TIFR1 == 0){
	}
	TCCR1B = 0;
	TIFR1 = (1<<OCF1B)|(1<<TOV1)|(1<<OCF1A);
	return;
}
												//setup a2d converter
int ADC_setup(){
	ADCSRA |= (1<<ADEN)|(1<<ADSC)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);
	ADMUX |= (1<<REFS1)|(1<<REFS0)|(1<<MUX0);
}
int readADC(){									//reading from a2d converter
	ADCSRA |= (1<<ADSC);
	while(ADCSRA & (1<<ADSC));
	return(ADC);
}
int _2sec(){
	TCCR1B = (1<<CS10)|(1<<CS12);
	TCNT1 = 49910;								//2 sec
	while (TIFR1 == 0){
	}
	TCCR1B = 0;
	TIFR1 = (1<<OCF1B)|(1<<TOV1)|(1<<OCF1A);
	return;
}
int _5sec(){
	TCCR1B = (1<<CS10)|(1<<CS12);
	TCNT1 = 26472;								//5 sec
	while (TIFR1 == 0){
	}
	TCCR1B = 0;
	TIFR1 = (1<<OCF1B)|(1<<TOV1)|(1<<OCF1A);
	return;
}