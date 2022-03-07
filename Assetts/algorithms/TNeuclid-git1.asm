# COMSC210 - Euclid Algorithm - Iterative
# 2/22/2021
# TNewman
#  Based on programs posted by Mike Dank at https://github.com/Famicoman/Euclidean-MIPS


############ Data Section #######################

.data             		# Assembly Language programs have two sections:
				# 1)  'data' section is used for delcaring data such as strings and arrays
				# 2)  'text' section contains the program instructions
				
				 # This is the data section 

prompt1:                    			# Prompt for first integer 'a'
	.asciiz "Enter the first integer: "  	# Assembly directive used to create a null terminated ASCII string


prompt2:                    			# Prompt for second integer 'b'
	.asciiz "Enter the second integer: "  	# Assembly directive used to create a null terminated ASCII string

result:                    			# Display string for result GCD 'c'
	.asciiz "the GCD is:  "  		# Assembly directive used to create a null terminated ASCII string

########## Text (Code) Section ##################

	.text             		# Assembly Language programs have two sections 'data' and 'text'
	.globl  main      		# This is the 'text' section which contains program instructions
	
main:                   		# assembly label
	sub	$sp,$sp,8		# push stack to save registers needed by the system code that called main
	sw	$ra,0($sp)		# save return address


	li	$v0,4       		# Ready for string output
	la	$a0,  prompt1		# Load address of pow
	syscall         		# Print string
	
	li $v0,5        		# Ready for integer input
	syscall         		# Read integer from console
	move $t2,$v0    		# Move into to $t2 temporarily
		
	li	$v0,4       		# Ready for string output
	la	$a0, prompt2     		# Load address of bas
	syscall         		# Print string
	
	li $v0,5        		# Ready for integer input
	syscall         		# Read integer from console
	move $a0,$t2    		# Move into to $a0
	move $a1,$v0    		# Move power integer to $a1
	
	
	jal	euclid			# call subroutine power to compute the exponent
	sw	$v0,4($sp)  		# result returned in $v0 and stored on the stack

# print the result 
	
	li	$v0,4       		# the argument to a system call is placed in register $v0
                        		# The value 4 tells syscall to print a string
	la	$a0,result    		# pseudo-instruction to load the address of the label str
                        		# The address of the string must be placed in register $a0
	syscall           		# system call to print the string at address str

	li	$v0,1       		# The value 1 tells syscall to print an integer
	lw	$a0,4($sp)  		# Load the sum from the stack to register $a0 
	syscall           		# System call to print the integer in register $a0
	
	lw	$ra,0($sp)		# restore return address used to jump back to system
	add	$sp,$sp,8		# pop stack to prepare for the return to the system
	j 	HALT       		# [jump register] return to the system 



################ End of Program ##################################
HALT:				# finish with syscall(10) 

	li $v0, 10
	syscall



################# Euclids Algorithm - MIPS Function ####################################

euclid:
	sub	$sp,$sp,4   		# Push stack to create room to save register $s0
	sw	$s0,0($sp)  		# save $s0 on stack
							
	bne $a1,$zero,L1 		# if (b == 0), if not go to L1
		j EXIT       		# jump to EXIT
	
	L1:   
		beq  $a1, $zero, EXIT 	# branch loop
		move $t4,$a1          	# set up c = b
		rem $a1,$a0,$a1       	# b = a % b
		move $a0,$t4          	# a = c
		j    L1               	# jump back to top of loop 
	EXIT: 

	move $v0,$a0    # Move a to $v0

	lw	$s0,0($sp)  # restore $s0 to value prior to function call
	add	$sp,$sp,4   # pop stack
	jr	$ra         # return to calling procedure
	





	





