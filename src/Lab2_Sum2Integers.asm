# MIPS Assembly Language PROGRAM - COMSC210 - Lab Assignment #2
    #
    #   Specifications: 
    #       As a Computer Scientist you must learn to Debug and Document programs
    #       This program has two issues first, there are two bugs that prevent it from 
    #       executing properly. Secondly, the program has no code documentation.
    #
    #       Your mission is to resolve the bugs and properly document the code using
    #        the Hello World program as your guide insert a '#' comment symbol next to
    #        each program instruction and write a short sentence that explains what the instruction
    #        is doing...
    #
    #            Procedure:
    #  
    #               1. Type in the program as written
    #               2. Compile, find and fix the bugs (hint there are 2 bugs in this program)
    #               3. Document each instruction (ie: put a comment line at each Instruction)
    #               4. Upload a working version to Dropbox
    #               
    #
    #
    
                       	
    	
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
    	la	$a0, prompt
    	syscall
    
    	li	$v0,1		
    	move	$a0, $t0
    	syscall
    
    	li	$v0,4	
    	la	$a0, crlf    
    	syscall
    
    	li	$v0,10	
    	syscall
