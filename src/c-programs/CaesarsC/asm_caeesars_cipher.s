	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 12, 1
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$0, -4(%rbp)
	movl	$1024, %edi                     ## imm = 0x400
	callq	_malloc
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	LBB0_2
## %bb.1:
	leaq	L_.str(%rip), %rdi
	callq	_perror
	movl	$1, %edi
	callq	_exit
LBB0_2:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	___stdoutp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	callq	_fflush
	movq	___stdinp@GOTPCREL(%rip), %rax
	movq	-32(%rbp), %rdi
	movq	(%rax), %rdx
	movl	$1024, %esi                     ## imm = 0x400
	callq	_fgets
	cmpq	$0, %rax
	jne	LBB0_4
## %bb.3:
	movl	$1, %edi
	callq	_exit
LBB0_4:
	movq	-32(%rbp), %rdi
	callq	_strlen
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rcx
	subq	$1, %rcx
	movsbl	(%rax,%rcx), %eax
	cmpl	$10, %eax
	jne	LBB0_6
## %bb.5:
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rcx
	subq	$1, %rcx
	movb	$0, (%rax,%rcx)
LBB0_6:
	movq	-16(%rbp), %rax
	subq	$1, %rax
	movq	%rax, -16(%rbp)
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movq	___stdoutp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	callq	_fflush
	movq	___stdinp@GOTPCREL(%rip), %rax
	leaq	-48(%rbp), %rdi
	movq	(%rax), %rdx
	movl	$16, %esi
	callq	_fgets
	cmpq	$0, %rax
	jne	LBB0_8
## %bb.7:
	movl	$1, %edi
	callq	_exit
LBB0_8:
	xorl	%eax, %eax
	movl	%eax, %esi
	xorl	%edx, %edx
	leaq	-48(%rbp), %rdi
	callq	_strtol
                                        ## kill: def $eax killed $eax killed $rax
	movl	%eax, -20(%rbp)
	cmpl	$1, -20(%rbp)
	jl	LBB0_10
## %bb.9:
	cmpl	$26, -20(%rbp)
	jle	LBB0_11
LBB0_10:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	L_.str.3(%rip), %rsi
	xorl	%eax, %eax
                                        ## kill: def $al killed $al killed $eax
	callq	_fprintf
	movl	$1, %edi
	callq	_exit
LBB0_11:
	movl	$0, -52(%rbp)
LBB0_12:                                ## =>This Inner Loop Header: Depth=1
	movslq	-52(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jae	LBB0_19
## %bb.13:                              ##   in Loop: Header=BB0_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movsbl	(%rax,%rcx), %edi
	callq	_isspace
	cmpl	$0, %eax
	je	LBB0_15
## %bb.14:                              ##   in Loop: Header=BB0_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movsbl	(%rax,%rcx), %edi
	callq	_isblank
	cmpl	$0, %eax
	jne	LBB0_16
LBB0_15:                                ##   in Loop: Header=BB0_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movsbl	(%rax,%rcx), %eax
	subl	$97, %eax
	addl	-20(%rbp), %eax
	cltd
	movl	$26, %ecx
	idivl	%ecx
	movl	%edx, %esi
	addl	$97, %esi
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB0_17
LBB0_16:                                ##   in Loop: Header=BB0_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movsbl	(%rax,%rcx), %esi
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
LBB0_17:                                ##   in Loop: Header=BB0_12 Depth=1
	jmp	LBB0_18
LBB0_18:                                ##   in Loop: Header=BB0_12 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	LBB0_12
LBB0_19:
	xorl	%edi, %edi
	callq	_exit
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"malloc"

L_.str.1:                               ## @.str.1
	.asciz	"Input text to be encrypted (lowercase): "

L_.str.2:                               ## @.str.2
	.asciz	"Choose shift number [1-26]: "

L_.str.3:                               ## @.str.3
	.asciz	"Shift number is out of range"

L_.str.4:                               ## @.str.4
	.asciz	"%c"

.subsections_via_symbols
