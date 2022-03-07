#####################################################################
#
#   Program: Encrypt a String using Caesar's Cipher (ROT 13)
#
#   Programmer: T Newman
#
# 
#   Location: Roger Williams University

# #####################################################
#
#  Specifications:
#     1.  Ask the user to enter a string of text and hit <enter>
#     2. Perform a ROT-13 encryption on the string and return the result
#                                                           
#####################################################################

################ Data Section #######################

.data
	menuPrompt: .asciiz "Please enter 1) Enter a message 2) read message from File, 3)Exit: "  # Ask the user to choose an option
	
    	prompt: .asciiz "Please enter your secret message: "  # Ask the user to enter a string
    	output: .asciiz "Your Encrypted Message is: " 	  # Show the encrypted message based on ROT 13 encryption
    
    message:  .space 128  # Reserve a buffer of 128 bytes to hold the string
    
    
	fin:	.asciiz	"secret_message.txt"         # This is the name of the source file that will be in the same directory/folder as the program
	fout1:	.asciiz "encryopted_message.txt"     # This is the name of the encrypted message file that will be in the same directory/folder as the program
	fout2: 	.asciiz  "decrypted_message.txt"     # This is the name of the decrypted message file that will be in the same directory/folder as the program
	
	prompt1: 	.asciiz "Please enter source file name: "  # Ask the user to enter a string
    	messageIn: 	.asciiz "Encryption in Progress ...This may take awhile...Please chill: "  # Show the encrypted message based on ROT 13 encryption
    	messageOut:  	.asciiz "Encryption in Progress ...This may take awhile...Please chill: "
    	
 	sourcefilename: .space 128
      	buffer:  	.space 128

    

################ Text Section ########################
    
.text
.globl main

main:
	jal Menu
	jal GetSecretMessageFromUser
	jal EncryptMessage
	jal OutputEncryptedMessage
	jal Exit


############################## Subroutines ###############################

Menu:

top:
li $v0, 4 # Code to print a string
la $a0, menuPrompt # Enter a value 1,2 or 3
syscall

li $v0, 5 # Code to read an integer
syscall

blez $v0, top # Default for less than one
li $t3, 3 # the number of choices in the case statement
bgt $v0, $t3, top # Default for greater than 3

# We now have a valid choice 1,2,or 3 in $v0
beq $v0, 3, Exit
beq $v0, 2, FileIO

jr $ra

#### Get Message

GetSecretMessageFromUser:

    li      $v0, 4    		# syscall(4) is print the prompt		
    la      $a0, prompt   	# load the address of the Secret Message prompt
    syscall             	# Display the prompt using the Print string syscall(4)
    
    li      $v0, 8     		# syscall (8) is used to read the string into the message buffer               
    la      $a0, message 
    li      $a1, 128        
    syscall            		# read in the secret message, max 128 characters
    li      $t2, 10        	# Ascii 10 is the 'newline' character ... google 'ascii collating sequence' to learn more

    # Loop over all characters
    la      $t1, ($a0)    	# start with the base address of our string in $t1
    
    jr $ra
    
#### FileIO Get the message from a file

FileIO:

	jr $ra

#### Encrypt Message

EncryptMessage:

while:  lb      $t0, ($t1)  	# load byte: get the current character into $t0
    beq $t0, $t2, done   	# keep looping until we hit the end of string '\n'
    li $t3, 64			# Capital letters start at Ascii 65 so we skip any that are less
    bge $t3, $t0, next       	# if $t0 <= 64: branch to next
    li $t3, 123
    bge $t0, $t3, next       	# if $t0 >= 123: branch to next
    li $t3, 90
    bge $t3, $t0, uppercase 		# if $t0 <= 90: branch to uppercase
    li $t3, 96
    bge $t3, $t0, next       # if $t0 <= 96: jump to next
    b lowercase
    
next:  addi $t1, $t1, 1    # increment $t1 to gpoint at the next character in the buffer
   # j while               # /endwhile 
   b while

lowercase:
    addi    $t0,$t0, -84  # -97 + 13
    rem     $t0, $t0, 26 # $t0 %= 26
    addi    $t0,$t0, 97
    sb      $t0, ($t1)
    j next

uppercase:
    addi    $t0,$t0 -52   # -65 + 13
    rem     $t0, $t0, 26 # $t0 %= 26
    addi    $t0, $t0,65
    sb      $t0, ($t1)
    j next

done: 
	jr $ra

#### Output Encrypted Message 


OutputEncryptedMessage:
    li      $v0, 4     # |
    la      $a0, output    # |
    syscall             # |=> Print string "output"

    la      $v0, 4     # |
    la      $a0, message # |
    syscall             # |=> Print message
    
    jr $ra
    
#### Exit Program
    
Exit:

    li $v0, 10
    syscall
    
    