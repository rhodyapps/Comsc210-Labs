# Program Name:  Sum Eight Integers
# Programmer:    Tom Newman
# Date:     
#
# COMSC210 Computer Organization and Lab RWU
#
#  Instructions:
#               1. Type in the program as written
#               2. Compile, find and fix the bugs (hint there are 2 bugs in this program)
#               3. Document each instruction (ie: put a comment line at each Instruction)
#               4. Create a PDF with your code and screenshots showing the program working
#
#               This program shows how to use branch instructions and a countdown variable
#               to create a loop and exit condition when the countdown variable reaches a limit

	.data	# Data declaration section 
		# 
	
prompt1:	.asciiz "\nEnter Number "          
prompt2:	.asciiz "\nEnter Another Number "     
prompt3:        .asciiz "\nEnter a Third Number "
prompt4:	.asciiz "\nEnter a Fourth Number "
filler:		.asciiz " :  "

result:		.asciiz "The Sum is: "
crlf:		.asciiz "\n"

	.text
	.globl main
	
main:		# Start of code section

		li 	$t7, 8   # Set the counter to 0
		li 	$t0, 0   # Set the accumulator to 0
		li	$t6, 0   # Set the display count variable to 0

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
		
		#li	$v0, 4
		#la	$a0, prompt2
		#syscall
		
		#li	$v0, 5
		#syscall
		
		#move	$t1, $v0
		
		#li	$v0, 4
		#la	$a0, prompt3
		#syscall
		
		#li	$v0, 5
		#syscall
				
		#move	$t2, $v0
		
		#li	$v0, 4
		#la	$a0, prompt4
		#syscall
		
		#li	$v0, 5
		#syscall
				
		#move	$t3, $v0
		
		#add	$t0, $t0, $t1
		#add	$t0, $t0, $t2
		#add	$t0, $t0, $t3
end:		
		
		li	$v0, 4
		la	$a0, result
		syscall
		
		li	$v0, 1
		move	$a0, $t0
		syscall
		
		li	$v0, 4
		la	$a0, crlf
		syscall
		
		li	$v0, 10
		syscall
		
	

# END OF PROGRAM
