# MIPS Assembly Language PROGRAM - COMSC210 - Lab Assignment #2
#
#  Instructions:
#               1. Type in the program as written
#               2. Compile, find and fix the bugs (hint there is 1 bug in this program)
#               3. Document each instruction (ie: put a comment line at each Instruction)
#               4. Create a PDF with your code and screenshots showing the program working


                   	
	.data
prompt1 :	.asciiz	"\nEnter A Number:   "              
prompt2:	.asciiz	"\nEnter Another Number:   "
prompt3:	.asciiz	"\nThe Sum is: "

crlf:   .asciiz	"\n"

	.text
	
	.globl	main
main:
	li	$v0,4		
	la	$a0, prompt1
	syscall
	li	$v0,5		
	syscall	
	move	$t0,$v0		
	li	$v0,4		
	la	$a0, prompt2
	syscall
	li	$v0,5		    
	syscall	
	move	$t1,$v0		
	add	$t0, $t0, $t1	
	li	$v0, 4	
	la	$a0, prompt3
	syscall
	li	$v0,1		
	move	$a0, $t0
	syscall
	li	$v0,4	
	li	$a0, crlf    
	syscall

	li	$v0,10	
	syscall
	
