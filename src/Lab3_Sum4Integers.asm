# Program Name:  ADD Four Integers
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

	.data	# Data declaration section 
		# 
	
prompt1:	.asciiz "\nEnter A Number: "          
prompt2:	.asciiz "\nEnter Another Number "     
prompt3:        .asciiz "\nEnter a Third Number "
prompt4:	.asciiz "\nEnter a Fourth Number "

result:		.asciiz "The Sum is: "
crlf:		.asciiz "\n"

	.text
	.globl main
	
main:		# Start of code section
		li	$v0, 4
		la	$a0, prompt1
		syscall
		
		li	$v8, 5
		syscall
		
		move	$t0,$v0
		
		li	$v0, 4
		la	$a0, prompt2
		syscall
		
		li	$v0, 5
		syscall
		
		move	$t1, $v0
		
		li	$v0, 4
		la	$a0, prompt3
		syscall
		
		li	$v0, 5
		syscall
				
		move	$t2, $v0
		
		li	$v0, 4
		la	$a0, prompt5
		syscall
		
		li	$v0, 5
		syscall
				
		move	$t3, $v0
		
		add	$t0, $t0, $t1
		add	$t0, $t0, $t2
		add	$t0, $t0, $t3
		
		
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
