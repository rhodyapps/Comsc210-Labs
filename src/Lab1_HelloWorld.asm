# Lab Assignment 1 : Assembly Language Program 1: Hello World

# Roger Williams University COMS210
# My First Assembly Language Program
# Author: *** Put in your Name ***
# Program: Hello World - Assembly Language
#

.data

# Every assembly language program will have two sections: .data and .text
# the '.data' section is the section of the program where we tell the compiler where to find our data components such
# as prompts and responses to be displayed on the console.

# In this program we will have one data component to hold the ascii string 'hello world'
# Note that the way we declare a variable (or constant) is with a label such as the following:

message: .asciiz "hello world\n" # Here is the message we will display

# Next we have our '.text' section where we will tell the compiler which instructions to follow.

.text

# The '.text' section is the section of the program containing our executable code
# Assembler language instructions are executed one at a time, following the sequence that
# we have used in our program. 

# The next statement is a directive '.globl' that tells the compiler the function
# that is being identified (in theis case 'main' can be referenced from other files (global)

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
