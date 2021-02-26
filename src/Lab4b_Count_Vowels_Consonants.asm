################################################################################
#
#         Program Name: VowelCounter
#
#         Desription:   Determine How Many Vowels are in a String of Text
#         
#         Programmer: Tom Newman
#               
#
################################################################################

####################################  Data Segment #############################
.data
        

          prompt1: .asciiz "Enter Text: "
          prompt2: .asciiz "\n   There are  "
          prompt3: .asciiz " Vowels in the Text that you entered "
          prompt4: .asciiz " Consonants in the Text"
          text:    .word 4 # make a 4 byte word to hold the address of text


# Register Use:
#
# CountTheVowels is the subroutine used to count the number of vowels
# 
#  a0 - holds string address
#  a1 - holds the max number of characters to read
#  s0 - holds number of vowels
#  v0 - returns number of vowels
#  t3 - this is used to save the result (returned in $v0) 
#  t7 - this will have the number of consonants


######################################  Text Segment #######################
.text
.globl  main

        
main:   
                initialize:    jal Initialize
                 inputtext:    jal InputText
            countthevowels:    jal CountTheVowels
            displayoutput:     jal DisplayOutput
                      exit:    jal Exit
  

######################### Subroutines ################################

######################### Initialize

Initialize:

            li $a0, 0
            li $a1, 0
            li $s0, 0
            li $s1, 0
            li $v0, 0
            li $t3, 0
            li $t7, 0		# consonant counter
            jr $ra
            
######################### Input the Text
InputText:

        li      $v0,4            # print prompt to ask for Text
        la      $a0,prompt1   
        syscall
        
        li      $v0,8            # input the text using syscall 8 read a string
        li      $a1, 80          # allow for 80 characters to be entered
        la      $a0,text         # load the address of Text into $a0
        syscall
        

  # move    $s0,$v0          # save it in $s0
        jr $ra

######################## Count the number of Vowels
   
CountTheVowels:  
        sub $sp,$sp,20    # save registers on stack
        sw $a0,0($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)
        sw $ra,12($sp)
        sw $s2,16($sp)
        
        move $s1,$a0   # address of string

loop:  
         lb $a0,($s1)      # get each character
         beqz $a0,done     # zero marks end
         jal IsAVowel      # call the IsAVowel subroutine
         add $s0,$s0,$v0   # add 0 or 1 to vowel count
         add $s1,$s1,1     # move along string
         add $s2,$s2,$v1   # add 0 or 1 to consonant count
         b loop
done:    
         move $v0, $s0   # use $v0 for result number of vowels
         move $v1, $s2   # use $v1 for result number of consonants

         lw $a0,0($sp)  # restore registers
         lw $s0,4($sp)
         lw $s1,8($sp)
         lw $ra,12($sp)
         lw $s2, 16($sp)
         add $sp,$sp,20
         jr $ra

##################  Check if it IsAVowel 

IsAVowel:   # this will check to see if the character being passed in $a0 is a vowel or not

         li $v0,0  		# is a vowel
         li $v1,0		# is a consonant
         beq  $a0,'a',true
         beq  $a0,'e',true
         beq  $a0,'i',true
         beq  $a0,'o',true
         beq  $a0,'u',true
         
         beq  $a0,'A',true
         beq  $a0,'E',true
         beq  $a0,'I',true
         beq  $a0,'O',true
         beq  $a0,'U',true
        beq  $a0, ' ',space     # don't count spaces
         beq $a0,'\n',space

	 li   $v1, 1 		# is a consonant

space:   jr $ra  # if the character is not a vowel the subroutine will return from here

true:    li $v0,1 # if the character is a vowel it will set the return value in $v0 to 1
                  # and return from here
         jr $ra

##################  Display the Output
DisplayOutput:

        move $t3,$v0   # $v0 has the number of vowels counted, save it to $t3
        move $t4, $v1  # $v1 has the number of consonants, save it to $t4
        

        li      $v0,4            # print first part of the result prompt
        la      $a0,prompt2   
        syscall
        
        move    $a0, $t3         # move the number of vowels saved in $t3 to $a0 for output
        li $v0,1                 # syscall 1 is print integer
        syscall                  # print the number of vowels counted
        
        li      $v0,4            # print second part of the result prompt
        la      $a0,prompt3   
        syscall
        
        li      $v0,4            # print first part of the result prompt
        la      $a0,prompt2   
        syscall
        
        move    $a0, $t4         # move the number of consonants saved in $t3 to $a0 for output
        li $v0,1                 # syscall 1 is print integer
        syscall                  # print the number of vowels counted
        
        li      $v0,4            # print second part of the result prompt
        la      $a0,prompt4   
        syscall
        
        jr $ra

################ Exit Program ######################

Exit:
      
        li      $v0,10           # exit
        syscall

