#############################
#
#  COMSC210 Computer Architecture and Lab
#
#  Example program using ROT 13 Encryption with File I/O

#  Programmer:  T. Newman

#  Date: 9/13/2015

#  Location: RWU

#####################################

#  Description:

# This is an example program which:
#  1. Ask the user for a message
#  2. Save the message into a source file 'secret_message.text'
#  3. Encrypt and save the encrypted message in another file 'encrypted_secret_message.txt'
#  4. Open the encrypted message file and decrypt the message, store the result in another file 'decrypted_message.txt' 

# Type in this program and get it running, add documentation and change the file names as you wish

# ############################################################

# File Input/Output Example Program




######  Register Usage ########

# $s5  - Source File Address 			- The file containing the source message
# $s6  - Encrypted Message File Address		- The file that will contain the encrypted message
# $s6  - Decrypted Message File Address		- The file that will contain the decrypted message



######  Data Section #########################

	.data
	
	fin:	.asciiz	"secret_message.txt"         # This is the name of the source file that will be in the same directory/folder as the program
	fout1:	.asciiz "encryopted_message.txt"     # This is the name of the encrypted message file that will be in the same directory/folder as the program
	fout2: 	.asciiz  "decrypted_message.txt"     # This is the name of the decrypted message file that will be in the same directory/folder as the program
	
	prompt1: 	.asciiz "Please enter source file name: "  # Ask the user to enter a string
    	messageIn: 	.asciiz "Encryption in Progress ...This may take awhile...Please chill: "  # Show the encrypted message based on ROT 13 encryption
    	messageOut:  	.asciiz "Encryption in Progress ...This may take awhile...Please chill: "
    	
 	sourcefilename: .space 128
      	buffer:  	.space 128


######  Text/ Code Section ######################
    	
	.text
	
	# jal GetSourceFileName
	jal OpenFiles
	# jal OpenSourceFile
	jal GetSecretMessage
	jal EncryptMessage
	jal DecryptMessage
	# jal Finish
	j Exit
	
	
	
	######## SubRoutines ###########
	
	OpenFiles:
	jr $ra
	
	
	GetSecretMessage:
	jr $ra
	
	EncryptMessage:
	
	jr $ra
	
	DecryptMessage:
	
	jr $ra
	
	
	
	
	GetSourceFileName:
	
	# Prompt the user to enter the source file name

    	li      $v0, 4     	# load immediate the value 4 into register $v0
    				# syscall(4) is print a string
   	la      $a0, prompt1   	# load the address of the prompt that we want to display
       	syscall             	# Display the prompt using the Print string syscall(4)
    
    	li      $v0, 8     	# Load immediate the value 8 into register $v0
                       		# syscall 8 is Read a String
                       
    	la      $a0, sourcefilename # | => Ask for name of source file
    	li      $a1, 128        # |
    	syscall             # | => read a string with max. 128 chars
    
    	li      $t2, 10        # Stop by \n

	

	
	
	
#### See if you can figure out what is going on in the next line of code
	
	# jal OpenSourceFile
	
	la $a0, messageIn
	
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
    		la      $a0, messageOut   # |
    		syscall             # |=> Print string "output"

    		la      $v0, 4     # |
    		la      $a0, messageOut # |
    		syscall             # |=> Print message
	
	
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
	la	$a1, messageOut
	li	$a2, 44
	syscall
	
	#Write to file just opened
	#li	$v0, 15
	#move	$a0, $s6
	#la	$a1, output
	#li	$a2, 44
	#syscall
	
	
	# close the file
	
	li	$v0, 16
	move	$a0, $s6
	syscall
	
	# Exit
	
	li $v0, 10
    	syscall
    	
    SaveMessage:
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
	la	$a1, messageOut
	li	$a2, 44
	syscall
			
	# close the file
	
	li	$v0, 16
	move	$a0, $s6
	syscall
	
	jr $ra
	
	
	Exit:
	li $v0, 10
	syscall
	
