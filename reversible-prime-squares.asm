

#================================================================================================
#	AUTHOR: TEBELLO RAMOTHOTO
#	STUDENT NUMBER:202002687
#	PURPOSE: TO OUTPUT FIRST 10 reversibLe_prime_squares IN ASSEMBLY  LANGUAGE 
#	DATE:	24 OCTOBER 2022
#	EMAIL:ramothototebello@mail.com
#	CONTACTS:266 53707145
#=================================================================================================



.data
	newline:.asciiz "\n"
	output:.asciiz "THE reversibLe_prime_square ARE :"
	tab:.asciiz "\t"
			
.text 
	
main:
	li $v0,4
	la $a0,output 
	syscall 
	
	li $v0,4
	la $a0,newline
	syscall 
	
	jal reversibLe_prime_square								#the call of the procedure reversibLe_prime_square
	
	li $v0,10
	syscall
	
	reversibLe_prime_square:							         #procedure for reversibLe_prime_square
												#memory allocation in stack
			addi 	$sp,$sp,-28
			sw	$ra,24($sp)
			sw	$s5,20($sp)
			sw	$s4,16($sp)
			sw	$s3,12($sp)
			sw	$s2,8($sp)
			sw	$s1,4($sp)
			sw	$s0,0($sp)
		
			li $t2,1								#MY ITERERATOR 
			li $s0,2								#NATURAL NUMBER STARTING AT 2
			li $t3,0								#COUNTER
			
		outer_loop:									#outer loop inside label reversibLe_prime_square
		
			bge  $t3,10,end_program 							#IT ENDS PROGRAM IF COUNTER IS 10 
			
			
			move $a0,$s0								#making natural number $s0 an argument in the function is prime
			jal is_prime								#calling the function is Prime WITH $a0 AS ARGUMENT
			move $s1,$v1								#STORING THE RETURN VALUE FROM $v1 t0 $s1 so that i can easly access it and use it
			
			beqz     $s1,increment_natural_number					#CHECKING IF THE NATURAL NUMBER IS A PRIME IF THE RESULT FROM LABEL IS_PRIME IS 1 THEN IT IS A PRIME NUMBER 
												#IF IT IS NOT PRIME NUMBER THEN INCREMENTING NATUARAL NUMBER by 1 TO START CHECKINGS AGAING
			mult 	$s0,$s0								#square that number if is a prime number  
			mflo 	$s5								#the QUOTIENT squared value IS STORED IN $S5
			
					
			move $a0,$s5								#making arguments for the reverse function and the parameter is the squared value in $s5
			jal reverse								# the call of function reverse
			
			move $s3,$v0								#STORING THE RETURN VALUE FROM $v0 t0 $s3 so that i can easly access it and use it
				
			inside_loop:								#the inside loop inside outer loop inside label reversibLe_prime_square
				div $t5,$s3,2							#taking half of the reversed value
			
				bge   $t2,$t5,increment_natural_number				#perfom the below instructions if i is less than half of  reversed value
				
								
				beq    $s3,$s5,increment_natural_number				#checking if its a palindrome ,if yes  then we increment increment_natural_number	
												#if no  then we continue 
				
				mult $t2,$t2							#squaring that i 
				mflo $t7							#taking the quotient of that squared value
				
						
				bne    $s3,$t7,increment_I					#if its not a square number check another i 
				
				
				move	$a0,$t2							 #making the square root which is i  an argument in label is_prime
				jal is_prime							#checking if the root of reversed is a prime number
				move     $t1,$v1						#STORING THE RETURN VALUE FROM $v1 t0 $t1 so that i can easly access it and use it
				beqz     $t1,increment_natural_number				#CHECKING IF THE NATURAL NUMBER IS A PRIME IF THE RESULT FROM LABEL IS_PRIME IS 1 THEN IT IS A PRIME NUMBER 
				
												#IF IT IS NOT PRIME NUMBER THEN INCREMENTING NATUARAL NUMBER by 1 TO START CHECKINGS AGAING
				
				li $v0,1																									
				move $a0,$s5							#if all the conditions above work then we output that squared value which is in  $s5
				syscall 
				
				li $v0,4
				la $a0,newline
				syscall 
				addi $t3,$t3,1							#then we increment counter
				addi $s0,$s0,1							#incrementing natural number 
				j outer_loop							#returning back to chech for another natural number
					
			
		increment_natural_number:	 
			addi $s0,$s0,1								#once we branch to this label increment natural number
			j outer_loop								#and jump to the outer loop to stat again
		
		increment_I:									
			addi $t2,$t2,1								#once we branch to this label we increment our i
			j inside_loop								#and jump to the outer loop
			
		end_program:									#ends the program once branched to this thi label
		
												#deallocating memory from the stack	
			lw	$s0,0($sp)
			lw	$s1,4($sp)
			lw	$s2,8($sp)
			lw	$s3,12($sp)
			lw	$s4,16($sp)
			lw	$s5,20($sp)
			lw	$ra,24($sp)
			addi 	$sp,$sp,-28
			jr $ra
			
			
	#=========================================================================================================================================================		

						
	is_prime:										#its procedure (function) checks for prime numbers
		
		li $t0,2
		li $t1,0
		li $t2,0
		li $t3,1
		blt $a0,2,is_not_prime								#if the argument is less than 2 then it is not prime number
		
		loop_for_prime:									#label loop_for_prime
			beq	 $t0,$a0,isprime						#if argument is 2 then brench to is prime 
			div	 $t1,$a0,$t0							#else divide the argument by $t0 which is initialy 2
			mfhi	 $t7								#taking the remender 
			beq 	 $t7,$zero,is_not_prime						#if remender is zero then then brench to is_not prime  
			add      $t0,$t0,1 							#else increment $t0 by 1 to check for another number
			j loop_for_prime							#then jump to check with the incremented value
			
					
					
		isprime: 									#this label set $v1 to 1 to show its prime
			li $t3,1
			move $v1,$t3								#moves  1 to $v1 
			 
			
			jr $ra	 								#returns the address
				
		is_not_prime:									#this label set $v1 to 0 ,for not prime
		
			li $t3,0
			move $v1,$t3 								#moves 0 to $v1 
			
			jr $ra									#returns the address
	#=========================================================================================================================================================		
			#REVERSE PROCEDURE
	#===================================================================================================================================================	
			 
	reverse:										#this procedure accepts $a0 as argument,and reverses  the argument 

		li $t4,0									#initializing
		li $t5,0
		li $t6,0
		li $t7,0	
		li $t8,0
		loop_for_reverse:								#the label inside the procedure reverse
			addi $t9,$zero,10							#initializing $t9 to 10
		
			div	 $t4,$a0,$t9							#dividing argument by 10
			mfhi     $t8								#storing the remender
			mult     $t5,$t9							#multiplying 10 by value in  $t5
			mflo     $t7								#taking the quotient 
			add      $t5,$t7,$t8							#adding remender with quotient 
			div      $a0,$a0,$t9							#dividing argument by 10 and storing it in $a0
			mflo     $t6								#taking quotient 
			
			bnez     $t6,loop_for_reverse						#if quotient is not zero repeat the above by jump
			move     $v0,$t5							#else store reversed in $v0
			
			jr $ra									#return address
	#=========================================================================================================================================================