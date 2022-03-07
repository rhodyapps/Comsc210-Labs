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
    prompt: .asciiz "Please enter your secret message: "  # Ask the user to enter a string
    output: .asciiz "Your Encrypted Message is: "  # Show the encrypted message based on ROT 13 encryption
    
    message:  .space 128  # Reserve a buffer of 128 bytes to hold the string
    

################ Text Section ########################
    
.text
.globl main

main:
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
    li      $v0, 4     # |
    la      $a0, output    # |
    syscall             # |=> Print string "output"

    la      $v0, 4     # |
    la      $a0, message # |
    syscall             # |=> Print message
    
    li $v0, 10
    syscall
    