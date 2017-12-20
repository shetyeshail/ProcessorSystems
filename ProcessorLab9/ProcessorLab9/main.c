/*
 * ProcessorLab9.c
 *
 * Created: 11/30/2017 12:28:29 PM
 * Author : shail
 */ 

#include <avr/io.h>

int main(void)
{
	//unsigned char dataset[] = 'GRADE-A';
	unsigned char csb[] = "CHECKSUMBYTE";				//checksumbyte
	unsigned char sum = 0;								//sum instantiated
	int i = 0;
	//while(int i = 0, i < sizeof(dataset), i++){
		//sum = sum + dataset[i];
	//}
	
	sum = 'G'+'R'+'A'+'D'+'E'+'-'+'A';					//summing the dataset
	sum = ~(sum) + 1;									//2s compliment
	
	EEAR = 0x50;										//setting address to 0050 in EEPROM
	EEDR = sum;											//storing sum
	EECR = 1<<EEMWE;									//enabling write enables
	EECR = 1<<EEWE;
	
	while(i < sizeof(csb)){				//loop through each letter in the dataset
		while(EECR&(EEWE<<1)){								//clearing master write enable each time 
		}
		
		EEAR++;											//increment address pointer
		EEDR = csb[i];									//store each character of string
		EECR = 1<<EEMWE;								//enabling write enables
		EECR = 1<<EEWE;
		i++;
	}
	
    /* Replace with your application code */
    
}

