
# Roger Williams University COMS210
#   Example of a called function
#   Author: Tom Newman
#   Program: Random Array Loader function
################################################################
#   Description:
#
#  This is the function that is used to generate random numbers
#   in an array as part of Exercise 5.1
#  This function expects the caller to pass three parameters on the stack:
#   parameter 1: the upper limit for the random numbers
#   parameter 2: the address of the array to store random numbers
#   parameter 3: the size of the array (how many random numbers to generate)
###################################################################
#   Register Usage
#
#   a1 - upper limit for random numbers ie: 9 for randoms 0 thru 9
#   a2 - address of the array passed in by the caller
#   t1 - size of the array in words ie: how many numbers to generate
###################################################################
#   Settings
#   Both the caller and callee (this program) need to be in the same directory (folder)
#   in MIPS Assembly Simulator > Settings > Assemble all files in directory
#     
####################################################################

  .globl load_array_random
  
load_array_random:
		
		lw $a1, 0($sp) # parameter: random number upper range
		lw $a2, 4($sp) # parameter: address of array
		lw $t1, 8($sp) # parameter: size of array (words)
		
	initLoop:	
      
      	li $a0, 0 		# random number generator id
		
		li $v0, 42		# Syscall to random number generator
		syscall
		
		sw	$a0, 0($a2)	# $t2 = Mem(a0)
		# add	$t0, $t0, $t2  	# $t0 = $t0 + $t2
		addi	$a2, $a2, 4	# Increment address pointer (4 bytes per word)
		addi	$t1, $t1, -1	# Decrement the loop counter
		bgtz	$t1, initLoop 	# if ($t1 > 0) branch  (keep looping till counter = 0)
       	 	     
		jr $ra
