# QUICKSORT with print method

# The SLT instruction sets the destination register's content to the value 1 if the first source register's contents are 
# less than the second source register's contents. Otherwise, it is set to the value 0.
# It's syntax is: 
# SLT $destination register's address, $first source register's address, $second source register's address.

# The sample SLT instruction demonstrated in the datapath above is SLT $17, $19, $22.

# The ADDI instruction performs an addition on both the source register's contents and the immediate data, 
# and stores the result in the destination register.

It's syntax is: 
ADDI $destination register's address, $source register's address, immediate data.


################################################################################################
#    Quicksort program
#
#    MIPS Assembly Language
#  
#   based on code posted by Bharath Karumudi available at:  https://github.com/bharathkarumudi/MIPS   
#
################################################################################################
#
#   Pseudocode: https://www.geeksforgeeks.org/quick-sort/

#	/* low  --> Starting index,  high  --> Ending index */
#	quickSort(arr[], low, high)
#	{
#	    if (low < high)
#	    {
#	        /* pi is partitioning index, arr[pi] is now
#	           at right place */
#	        pi = partition(arr, low, high);

#	        quickSort(arr, low, pi - 1);  // Before pi
#	        quickSort(arr, pi + 1, high); // After pi
#	    }
#	}
#
###############################################################################################
#
#  History:	https://en.wikipedia.org/wiki/Quicksort
#
#     Quicksort is an efficient sorting algorithm. Developed by British computer scientist Tony Hoare in 1959[1] 
#     and published in 1961,[2] it is still a commonly used algorithm for sorting. When implemented well, it can be 
#     somewhat faster than merge sort and about two or three times faster than heapsort.
#
#
################################################################################################
#
#     Data Section
#
#     Array values in this example match the video presentation available
#     at this video:
#     https://www.youtube.com/watch?v=MZaf_9IZCrc
#
##################################   Data Section ###################
.data # Defines variable section of an assembly routine.

array: .word 7,2,1,8,6,3,5,4 # Define a variable named array as a word (integer) array.


# After your program has run, the integers in this array
# should be sorted.

################################   Text Section #####################

.text # Defines the start of the code section for the program .

.globl main

###############################   Main Method #######################

main:
	la $t0, array 		# Moves the address of array into register $t0.
	addi $a0, $t0, 0 	# Set argument 1 to the array.
	addi $a1, $zero, 0 	# Set argument 2 to (low = 0)
	addi $a2, $zero, 7 	# Set argument 3 to (high = 7, last index in array)
	jal quicksort 		# Call quick sort
	li $v0, 10 		# Terminate program run and
	syscall # Exit

######################### Quicksort Method #########################


quicksort:				#quicksort method

	addi $sp, $sp, -16		# Make room for 4

	sw $a0, 0($sp)			# a0
	sw $a1, 4($sp)			# low
	sw $a2, 8($sp)			# high
	sw $ra, 12($sp)			# return address

	move $t0, $a2			#saving high in t0
        # Next we use shift less than SlT instruction o compare the low and high values
	# a1 has the low value and a2 has the high value
	
	slt $t1, $a1, $t0		# set t1=1 if low < high, else set t1=0
	beq $t1, $zero, endif		# if t1=0 low >= high, endif
	
	# if low is less than high jump to the partition method
	jal partition			# call partition 
	
	# v0 has the pivot value returned from the partition method 
	# move the pivot value to s0
	move $s0, $v0			# pivot, s0= v0

	lw $a1, 4($sp)			#a1 = low
	addi $a2, $s0, -1		#a2 = pi -1
	jal quicksort			#call quicksort

	addi $a1, $s0, 1		#a1 = pi + 1
	lw $a2, 8($sp)			#a2 = high
	jal quicksort			#call quicksort

 endif:

 	lw $a0, 0($sp)			#restore a0
 	lw $a1, 4($sp)			#restore a1
 	lw $a2, 8($sp)			#restore a2
 	lw $ra, 12($sp)			#restore return address
 	addi $sp, $sp, 16		#restore the stack
 	jr $ra				#return to caller
 	

########################  Partition Method #########################

partition: 			# The partition method is called from quicksort if low < high

	addi $sp, $sp, -16	# make room on stack to save array address, low, high and return address

	sw $a0, 0($sp)		#store a0
	sw $a1, 4($sp)		#store a1
	sw $a2, 8($sp)		#store a2
	sw $ra, 12($sp)		#store return address
	
	move $s1, $a1		#s1 = low
	move $s2, $a2		#s2 = high

	sll $t1, $s2, 2		# t1 = 4*high
	add $t1, $a0, $t1	# t1 = arr + 4*high
	lw $t2, 0($t1)		# t2 = arr[high] //pivot

	addi $t3, $s1, -1 	#t3, i=low -1
	move $t4, $s1		#t4, j=low
	addi $t5, $s2, -1	#t5 = high - 1

	forloop: 
		slt $t6, $t5, $t4	#t6=1 if j>high-1, t7=0 if j<=high-1
		bne $t6, $zero, endfor	#if t6=1 then branch to endfor

		sll $t1, $t4, 2		#t1 = j*4
		add $t1, $t1, $a0	#t1 = arr + 4j
		lw $t7, 0($t1)		#t7 = arr[j]

		slt $t8, $t2, $t7	#t8 = 1 if pivot < arr[j], 0 if arr[j]<=pivot
		bne $t8, $zero, endfif	#if t8=1 then branch to endfif
		addi $t3, $t3, 1	#i=i+1

		move $a1, $t3		#a1 = i
		move $a2, $t4		#a2 = j
		jal swap		#swap(arr, i, j)
		
		addi $t4, $t4, 1	#j++
		j forloop

	    endfif:
		addi $t4, $t4, 1	#j++
		j forloop		#junp back to forloop

	endfor:
		addi $a1, $t3, 1		#a1 = i+1
		move $a2, $s2			#a2 = high
		add $v0, $zero, $a1		#v0 = i+1 return (i + 1);
		jal swap			#swap(arr, i + 1, high);

		lw $ra, 12($sp)			#return address
		addi $sp, $sp, 16		#restore the stack
		jr $ra				#junp back to the caller


################  Swap Method ##########################
swap:				#swap label

	addi $sp, $sp, -12	# Make stack room for three

	sw $a0, 0($sp)		# Store a0
	sw $a1, 4($sp)		# Store a1
	sw $a2, 8($sp)		# store a2

	sll $t1, $a1, 2 	#t1 = 4a
	add $t1, $a0, $t1	#t1 = arr + 4a
	lw $s3, 0($t1)		#s3  t = array[a]

	sll $t2, $a2, 2		#t2 = 4b
	add $t2, $a0, $t2	#t2 = arr + 4b
	lw $s4, 0($t2)		#s4 = arr[b]

	sw $s4, 0($t1)		#arr[a] = arr[b]
	sw $s3, 0($t2)		#arr[b] = t 


	addi $sp, $sp, 12	#Restoring the stack size
	jr $ra			#jump back to the caller


##################### Print Array ###########################
print:

      # Put code here to print out the contents of the array
      # put a space after printing each integer
      
      jr $ra
      
