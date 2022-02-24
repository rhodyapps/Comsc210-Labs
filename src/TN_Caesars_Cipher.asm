#############################
#
#  COMSC210 Computer Architecture and Assembly Language
#
#  Example program using ROT 13 Encryption with File I/O

#  Programmer: Tom Newman

#  Date: 2/10/2022

#  Location: COMSC210

#####################################

#  Description: Caesars Cipher 

# Version 3: 

# This is an example program for Caesars Cipher which saves the messages and ROT 13 Encrypted output into two different files

# This version asks the user for the filename of the encrypted message and decrypts the message found in the file

# ############################################################


###  PseudoCode

# Enter Pseudocode here




######  Data Section #########################

	.data
	
	fout:	.asciiz	"EncryptedMessageOutput.txt"
	fout2:	.asciiz "OriginalMessageInput.txt"
	
	
	prompt: 	.asciiz "Please enter your message: "  # Ask the user to enter a string
    	output: 	.asciiz "Your Encrypted Message is: "  # Show the encrypted message based on ROT 13 encryption
    	
    	prompt2: 	.asciiz "Enter the encrypted file name: "  #   Ask the user for the name of the file containing the encrypted message
    	output2:	.asciiz "Encrypted message in file: "
    	
    	
    	
       message:  .space 128
       filename: .space 32		# The user will enter a filename to decrypt a message in the file

######  Text/ Code Section ######################
    	
	.text
	
	jal InputMessage
	jal SaveOriginalMessage
	jal EncryptMessage
	jal OutputEncryptedMessage
	jal GetEncryptedMessageFromFile
	jal OutputEncryptedMessage
	jal EncryptMessage
	jal Exit
	

InputMessage:
		
	# Prompt the user to enter a secret message

    	li      $v0, 4     	# load the value 4 into register $v0
    				# syscall(4) is print a string
   	la      $a0, prompt    	# load the address of the prompt that we want to display
       	syscall             	# Display the prompt using the Print string syscall(4)
    
    	li      $v0, 8     	# Load the value 8 into register $v0
                       		# syscall 8 is Read a String
                       
    	la      $a0, message 	# | => Ask for string message
    	li      $a1, 256        # |
    	syscall             	# | => read a string with max. 256 chars
    
    	# li      $t2, 10        	# Stop reading the message when user presses 'enter' key => \n

	jr $ra
	
	# la $a3, message
	
	# jal SaveMessage

SaveOriginalMessage:
    # save a copy of original message
    
    # Open file for writing
	
	li	$v0, 13
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

#######################################
GetEncryptedMessageFromFile:

# Prompt the user to enter filename containing an encrypted message

    	li      $v0, 4     	# load the value 4 into register $v0
    				# syscall(4) is print a string
   	la      $a0, prompt2    	# load the address of the prompt that we want to display
       	syscall             	# Display the prompt using the Print string syscall(4)
    
    	li      $v0, 8     	# Syscall 8 is Read String 
    	la      $a0, filename 	# | => Ask user for filename
    	li      $a1, 32        # |
    	syscall             	# | => read a string with max.32 chars
    
    	# Open file and read the message
    	li $v0, 14		# Open file for reading $ao has the name of the file
    	la $a1, message		# Note: this is the same buffer we used before
    	li $a2, 256		# the max size of the message 256 characters
    	
    	# Print the message
    	li $v0, 4
    	la $a0, output2
    	syscall
    	
    	move $a0, $a1
    	syscall
    	
    	# li      $t2, 10        	# Stop reading the message when user presses 'enter' key => \n

	jr $ra




#######################################
Exit:	

	# Exit
	
	li $v0, 10
    	syscall
    	
   
    
    
	
	
