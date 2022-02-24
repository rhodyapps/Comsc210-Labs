#  COMSC210
#   Lab 5: Britton exercise 5.1 (page 50) - Arrays: Memory Addressing 

# Programmer: T Newman
# Date: 11/3/2016

# Specifications:

# Write a MIPS  assembly language program to:
# 1. Prompt the user to enter an upper limit that you will
# use to generate random numbers and load a 100-word array called "chico"
# 2. loop through the array and sum the total of the numbers.
# 3. Store the resulting sum in the next memory location beyond the end of the array �chico.�
#  

	
		.data
chico:		.space	400	# create the 100-word array called "chico" (400 bytes)
prompt1:   	.asciiz "Enter a range for Random Numbers: "
resultmsg:	.asciiz " The Sum is: "

result:	.word	0	# Create a place for the result in the next memory location (word)
			# beyond the array

		.globl	main
		.text		
# Registers: 
#		$a3 : Will hold the base address of the array (the starting address)
#		$t0 : will be used to hold the sum
#		$t1 : will be used as the loop counter
#

main:	
			
		jal Initialize
		jal Sum
		jal PrintResult
	
	
		j Exit

#################### Subroutines ###########

Initialize:  				# load the array with random numbers

		la $a0,prompt1   	# prompt for random number range
        	li $v0,4
       	 	syscall 
       	 	
       	 	li $v0, 5
       	 	syscall
       	 	move $a1, $v0
       	 	
       	 	li $t1, 100
		addiu $sp,$sp,-16 # allocate space on the stack
		
       		la $a2, chico
   		sw $a1, 0($sp) # parameter: random number upper range
		sw $a2, 4($sp) # parameter: address of array
		lw $a2, 4($sp)
		sw $t1, 8($sp) # parameter: size of array (words)
    		sw $ra, 12($sp) # store the return address
    		
    		move $s2, $ra
    		
    		jal load_array_random # call the random number loader
    		
    		move $ra, $s2 # restore the return address
    		
       	 	addiu $sp,$sp, 16 # de-allocate space on the stack
   
 
		jr $ra


######################		
Sum:
		la 	$a2, chico	# Load address pointer - this will be used as the base address
		li	$t0, 0	 	# Clear sum
		li	$t1, 100	# Initialize loop count
	
		
	sumLoop:	
		lw  	$t2, 0($a2)	# $t2 = Mem(a0)
		add	$t0, $t0, $t2  	# $t0 = $t0 + $t2
		addi	$a3, $a3, 4	# Increment address pointer (4 bytes per word)
		addi	$t1, $t1, -1	# Decrement the loop counter
		bgtz	$t1, sumLoop 	# if ($t1 > 0) branch  (keep looping till counter = 0)
		
		addiu, $sp, $sp, -4
		
		sw $t0, 0($sp)
		
		jr $ra
#########################		
PrintResult: 

		
		
		la $a0,resultmsg    	# prompt for random number range
        	li $v0,4
       	 	syscall 
       	 	
		
		lw	$a0, 0($sp)
		li	$v0, 1
		syscall
		
		jr $ra
		


Exit:
		li	$v0, 10	 	# End of program	
		syscall
