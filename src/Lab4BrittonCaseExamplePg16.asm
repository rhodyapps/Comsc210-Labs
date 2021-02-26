################### Example Main Program Header ###################
#
# Program : MIPS Assembly Language Programming Example  Page 42
#
# ProgrammerL T Newman		Date: 2/22/2021
#
# Lab Assignment 4
# Due Date :  2/27/2021          Course: Comsc210
#
################################################################
# Overall Program Functional Description:
#
#  This program demonstrates how to implement a 'case/switch' statement in assembly language
#
################################################################
#
#    Register Usage in Main:
#    a0 = Address of prompt to enter an integer value
#    t3 = value of max number of choices in case statement
#
################################################################
# Pseudocode Description:
#      
#     top: cout << “Input a value from 1 to 3”
#      cin >> $v0
#           switch ($v0)
#               {case(1): {$s0 = $s0 << 1; break;}
#                case(2): {$s0 = $s0 << 2; break;}
#                case(3): {$s0 = $s0 << 3; break;}
#                default: goto top; }
#          cout << $s0
#
#

################################################################
# 
#
########################## Data Section ########################
			.data

	.align 2

	jumptable: .word top, case1, case2, case3
	prompt: .asciiz "\n   Input a value from 1 to 3:   "


######################### Text Section ########################

			.text
			
initialize:
	li, $s0, 256  #  Put a starting value in s0	

top:
	li $v0, 4 		# Code to print a string
	la $a0, prompt		# Enter a value 1,2 or 3
	syscall

	li $v0, 5 		# Code to read an integer
	syscall

	blez $v0, top 		# Default for less than one
	li $t3, 3		# the number of choices in the case statement
	bgt $v0, $t3, top 	# Default for greater than 3

	la $a1, jumptable 	# Load address of jumptable
	sll $t0, $v0, 2 	# Compute word offset
	add $t1, $a1, $t0 	# Form a pointer into jumptable
	lw $t2, 0($t1) 		# Load an address from jumptable
	jr $t2 			# Jump to specific case “switch”

case1: sll $s0, $s0, 1 		# Shift left logical one bit
	b output

case2: sll $s0, $s0, 2 		# Shift left logical two bits
	b output

case3: sll $s0, $s0, 3 		# Shift left logical three bits


output:
	li $v0, 1 		# Code to print an integer is 1
	move $a0, $s0 		# Pass argument to system in $a0
	syscall 		# Output results
	b end
	
end: 
	li, $v0,10
	syscall			# Gracefully exit the program
	
	

