#############################
#
#  COMSC210 Computer Architecture and Assembly Language
#
#  Example program using ROT 13 Encryption with File I/O

#  Programmer: Tom Newman

#  Date: 2/10/2022

#  Location: COMSC210

#####################################

#  Description:

# This is an example program for Caesars Cipher which saves the messages and ROT 13 Encrypted output into two different files

# 

# ############################################################

# File Input/Output Example Program

######  Data Section #########################

	.data
	
	fout:	.asciiz	"EncrytedMessageOutput.txt"
	fout2:	.asciiz "OriginalMessageInput.txt"
	
	
	prompt: 	.asciiz "Please enter your message: "  # Ask the user to enter a string
    	output: 	.asciiz "Your Encrypted Message is: "  # Show the encrypted message based on ROT 13 encryption
    	
       message:  .space 128

######  Text/ Code Section ######################
    	
	.text
	
	jal InputMessage
	jal SaveOriginalMessage
	jal EncryptMessages
	jal OutputEncryptedMessage
	jal Exit
	

InputMessage:
		
	# Prompt the user to enter a secret message

    	li      $v0, 4     	    # load the value 4 into register $v0
    				            # syscall(4) is print a string
   	la      $a0, prompt    	    # load the address of the prompt that we want to display
       	syscall             	# Display the prompt using the Print string syscall(4)
    
    	li      $v0, 4     	    # Load the value 8 into register $v0
                       		    # syscall 8 is Read a String
                       
    	la      $a0, message 	# | => Ask for string message
    	li      $a1, 256        # |
    	syscall             	# | => read a string with max. 256 chars
    
    	li      $t2, 10        	# Stop reading the message when user presses 'enter' key => \n

	jr $ra
	
	# la $a3, message
	
	# jal SaveMessage

SaveOriginalMessage:
    # save a copy of original message
    
    # Open file for writing
	
	li	$v0, 12
	la	$a0, fout2
	li	$a1, 1
	li	$a2, 0
	syscall
	
	move $s6, $v0	# save the file descriptor in $s6
	
	#Write to file just opened
	li	$v0, 15
	move	$a0, $s6
	la	$a1, message
	li	$a2, 256
	syscall
			
	# close the file
	
	li	$v0, 16
	move	$a0, $s6
	syscall
	
	jr $ra


EncryptMessage:	
	la $a0, message
	
	# Loop over all characters
    		la      $t1, ($a0)	    #=>$t1:the current address that gets modified

	s:  	lb      $t0, ($t1)  	# => $t0: the current value (char)
    		beq $t0, $t2, out     	# while $t1 != '\n'
    		li $t3, 64
    		bge $t3, $t0, w       	# if $t0 <= 64: jump to w
    		li $t3, 123
    		bge $t0, $t3, w      	 # if $t0 >= 123: jump to w
    		li $t3, 90
    		bge $t3, $t0, big 	# if $t0 <= 90: jump to big
    		li $t3, 96
    		bge $t3, $t0, w      	 # if $t0 <= 96: jump to w
    		j small
	w:  	addi $t1, $t1, 1  	# $t1++
    		j s                	# /endwhile 

	small:
    		addi    $t0,$t0, -84 	# -97 + 13
    		rem     $t0, $t0, 26 	# $t0 %= 26
    		addi    $t0,$t0, 97
    		sb      $t0, ($t1)
    		j w

	big:
    		addi    $t0,$t0 -52   # -65 + 13
    		rem     $t0, $t0, 26 # $t0 %= 26
    		addi    $t0, $t0,65
    		sb      $t0, ($t1)
    		j w

	out:
    		li      $v0, 4     # |
    		la      $a0, output    # |
    		syscall             # |=> Print string "output"

    		la      $v0, 4     # |
    		la      $a0, message # |
    		syscall             # |=> Print message
	
		jr $ra

OutputEncryptedMessage:

	# Open file for writing
	
	li	$v0, 13
	la	$a0, fout
	li	$a1, 1
	li	$a2, 0
	syscall
	
	move $s6, $v0	# save the file descriptor in $s6
	
	#Write to file just opened
	li	$v0, 15
	move	$a0, $s6
	la	$a1, message
	li	$a2, 256
	syscall
	
	# close the file
	
	li	$v0, 16
	move	$a0, $s6
	syscall
	
	jr $ra

Exit:	

	# Exit
	
	li $v0, 10
    	syscall
    	
   
    
    
	
	