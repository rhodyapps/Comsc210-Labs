Program 1: Hello World

# Roger Williams University COMS210
# My First Assembly Language Program
# Author: *** Put in your Name ***
# Program: Hello World - Assembly Language
#

.data

# This is the section of the program where we establish data components such
# as prompts and responses to be displayed on the console.

message: .asciiz "hello world\n" # Here is the message we will display
.text

# This is the section of the program containing our executable code
# declare a procedure main that can be referenced from other files (global)

.globl main 

main: # This is the marker for the first line of code

la $a0,message       # here is the first line of code...
# first instruction: la - Load Address (message) into register $a0

li $v0,4 
# Second instruction: Load Immediate, value '4' into register $v0

syscall 
# Third instruction: execute the system call for Print String

li $v0,10 

# Fourth instruction: Load Immediate, value '10' into register $v0

syscall 

# Fifth (and final) Instruction: execute the system call for terminate program execution
