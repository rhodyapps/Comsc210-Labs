# Program Name:  Sum Eight Integers
# Programmer:    Tom Newman
# Date:     
#
# COMSC210 Computer Organization and Lab RWU
#
#  This version has the code from the first Lab3 example sum 4 integers
#   if you put this in the MIPS simulator you will see that the code
# after the unconditional branch is highlighted in green because it
# will not be executed (or compiled) since it is being skipped by the branch instructions

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

		li 	$t7, 8
		li 	$t0, 0

enterNum:
		blez    $t7, end
		li	$v0, 4
		la	$a0, prompt1
		syscall
		
		li	$v0, 5
		syscall
		
		add	$t0,$t0,$v0
		addi	$t7, $t7, -1
		b 	enterNum
		
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
