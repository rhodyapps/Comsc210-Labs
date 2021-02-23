# COMSC210 - Euclid Algorithm - Recursive
# 2/22/2021
# TNewman
# Based on programs posted by Mike Dank at https://github.com/Famicoman/Euclidean-MIPS


############ Data Section #######################

.data             		# Assembly Language programs have two sections:
				# 1)  'data' section is used for delcaring data such as strings and arrays
				# 2)  'text' section contains the program instructions
				
				 # This is the data section 

integera:                    			# Prompt for first integer 'a'
	.asciiz "Enter the first integer = "  	# Assembly directive used to create a null terminated ASCII string


integerb:                    			# Prompt for second integer 'b'
	.asciiz "Enter the second integer = "  	# Assembly directive used to create a null terminated ASCII string

result:                    			# Display string for result GCD 'c'
	.asciiz "the GCD is:  "  		# Assembly directive used to create a null terminated ASCII string

########## Text (Code) Section ##################

	.text             		# Assembly Language programs have two sections 'data' and 'text'
	.globl  main      		# This is the 'text' section which contains program instructions
main:
	sub	$sp,$sp,12			# push stack
	sw	$ra,4($sp)			# save return address

	li	$v0,4       			# Ready for string output
	la	$a0,integera     		# Load address of pow
	syscall         			# Print string
	
	li $v0,5        			# Ready for integer input
	syscall         			# Read integer from console
	move $t2,$v0    			# Move into to $t2 temporarily
		
	li	$v0,4       			# Ready for string output
	la	$a0,integerb     		# Load address of bas
	syscall         			# Print string
	
	li $v0,5        			# Ready for integer input
	syscall         			# Read integer from console
	move $a0,$t2    			# Move into to $a0
	move $a1,$v0    			# Move power integer to $a1
	
	jal euc
	sw	$v0,8($sp)

# print the result
	
	li	$v0,4
	la	$a0,result
	syscall

	li	$v0,1
	lw	$a0,8($sp)
	syscall
	
	lw	$ra,4($sp)	# restore return address
	add	$sp,$sp,12	# pop stack
	j	HALT

################ End of Program ##################################
HALT:				# finish with syscall(10) 

	li $v0, 10
	syscall

################# Euclids Algorithm - MIPS Function - Recursive ####################################
euc:
	sub	$sp,$sp,8	# push stack
	sw	$ra,4($sp)	# save return address

	bne $a1, $zero, L1 # if b!=0 then exit
	add	$v0,$zero,$a0	# return a0
	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
L1:
	move $t4,$a1         # set up c = b
	rem $a1,$a0,$a1      # b = a % b
	move $a0,$t4         # a = c
	jal euc            # recurse

	lw	$ra,4($sp)	# restore previous return addr
	move $v0,$a0    # Move a to $v0

	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure