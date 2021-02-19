# Program Name:  Sum Eight Integers
# Programmer:    Tom Newman
# Date:     2/18/2021
#
# COMSC210 Computer Organization and Lab RWU
#
#  Description::
#              
#
#               This program shows how to use branch instructions and a countdown variable
#               to create a loop and exit condition when the countdown variable reaches a limit

	.data	# Data declaration section 
		# 
	
prompt1:	.asciiz "\nEnter Number "          # This is the only prompt we need for entering numbers

filler:		.asciiz " :  "			# This will be used to help show which number we are asking for

result:		.asciiz "The Sum is: "
crlf:		.asciiz "\n"

	.text
	.globl main
	
main:		# Start of code section

# initialize loop variables
		li 	$t7, 8   # Set the counter to 0
		li 	$t0, 0   # Set the accumulator to 0
		li	$t6, 0   # Set the display count variable to 0
		
		
# This is the top of the loop 
 
enterNum:
		blez    $t7, end		# End the loop if we have reached the number of iterations
		addi	$t6, $t6, 1		# Add 1 to the display counter $t6
		li	$v0, 4			# Load immediate 4 (print string) to v0
		la	$a0, prompt1		# Load address of prompt1 to a0
		syscall				# Syscall(4) print prompt1 to console
		
		li	$v0, 1			# Load immediate 1 to v0
		move	$a0, $t6		# move display count variable to a0
		syscall				# Syscall(1) to print the integer in the display count variable
		
		li	$v0, 4			# Load immediate 4 to v0
		la	$a0, filler		# Load the address of filler to a0
		syscall				# Syscall(4) to print filler after the display count
		
		li	$v0, 5			# Load immediate 5 to v0
		syscall				# Syscall(5) to read an integer
		
		add	$t0,$t0,$v0		# Add the integer read to the accoumulator in t0
		addi	$t7, $t7, -1		# Decrement the loop counter by 1
		b 	enterNum		# go back to enterNum to get the next integer
		
		
end:		# This is the branch point where our loop will land after it finishes
		
		li	$v0, 4			# Load immediate syscall 4 print string
		la	$a0, result		# print the 'sum is' message
		syscall
		
		li	$v0, 1			# print the sum
		move	$a0, $t0
		syscall
		
		li	$v0, 4
		la	$a0, crlf
		syscall
		
		li	$v0, 10
		syscall
		
	

# END OF PROGRAM
