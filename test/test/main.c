/*
 * test.c
 *
 * Created: 11/30/2017 9:27:51 PM
 * Author : shail
 */ 

#include <avr/io.h>

int main(void){

	DDRD = 0xFF; // PORTD output
	unsigned char x = 0; //Tens place Integer
	unsigned char z = 0; //Ones place Integer
	PORTD = x|z; //Create output
	//delay(); //Call 1 second delay
	
	while(1){
		unsigned char x = 0;
		unsigned char z = 0;
		int ii = 10; //Counter for tens place value
		int i = 0; //Counter for ones place value
		while (ii > 0){
			while (i < 9){
				z = z + 1;//Increment ones place by 1
				i++; //Increment counter
				PORTD = x|z;//Output binary value
				//delay();
			}
			z = 0x0;//If there is a 9 in ones place make 0
			x = x + 16;//Controlling the top 4 bits for tens place
			if ( x == 0xa0 ){
				x = 0;//If tens place is equal to ten, reset to 0
			}
			PORTD = x|z;
			//delay();
			i = 0;//Reset counter after counting to 99
			ii = ii - 1;//Decrement the tens place counter

		}
	}
}

int delay(void){
	unsigned long n = 0;
	do {
		n = n+1;
	} while(n < 255000);//Execute this while this is less than
	
}