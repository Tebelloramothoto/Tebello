#include <stdio.h>

//PRIME FUNCTION
int is_prime(int number1){						//a function to check for prime numbers
	int i;
	for(i=2;i<number1;i++){
		if(number1%i==0){
			return 0;						//returns zero if it is not prime 
		}
	}
	return 1;								//and 1 if its prime number
}

//REVERSE FUNCTION											
int reverse(int number2){							//a function that reverses any integer number 
  int  reverse=0, remender;        
  while(number2!=0)    
  {    											//this reverse function is archived by using the remenders to form a reversed number  
     remender=number2%10;      
     reverse=reverse*10+remender;    			//by using 10 to find the remender by dividing the number by 10 and finding the modulo of that ,this is done by looping till the quotient is zero
     number2/=10;    
  }    
 return reverse;   								//returns the value reversed 
} 

//THE OUTPUT OF THIS FUNCTION GIVES THE reversibLe_prime_square
void reversibLe_prime_square(){
	int counting_number,reversed_square,square_number,i;
 	int counter=0;
	printf( " %s %s" ,"REVERSABLE PRIME SQUARE NUMBERS ARE:" ,"\n" );
	for (counting_number = 2; counter<10; counting_number++)										//the for loop is used to check for each counting_number if it met the conditions inside the the loop,and its terminated by if the numbers are 10 which is the counter
	
		if (is_prime(counting_number)){																//this says for a counting_number if is prime then it gets inside the if statement
			
			square_number= counting_number*counting_number;											//if that counting_number is a prime number then we square it 
			reversed_square=reverse(square_number);													//then we reverse the squared number by making the square number an argument in reverse function
			
			 for( i=1;	i< reversed_square/2	;i++){												// the loop is used to check for square root(square number)
			 	
			 	
			 	if(reversed_square==i*i &&  square_number!=reversed_square  && is_prime(i)){		//checking if reversed_square is a square number,checking if its a palindrome,checking if the square_root if a prime number ,then if all this conditions are met the we output square_number
			 	 
			 			printf( "%d %d %s" ,counter+1, square_number ,"\n"  );						//outputing square_number
			 			counter++;																	//incremanting couter once if finds a reversibLe_prime_square
					 
				 }
			 }
	}
	
}
int main() {

	reversibLe_prime_square();					//the call of the function inside main 
	return 0;

}
