	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 1
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
	subq	$448, %rsp                      ## imm = 0x1C0
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -420(%rbp)
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	leaq	-424(%rbp), %rsi
	movb	$0, %al
	callq	_scanf
	movl	-424(%rbp), %esi
	leaq	L_.str.2(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -428(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-428(%rbp), %eax
	cmpl	-424(%rbp), %eax
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movslq	-428(%rbp), %rax
	shlq	$2, %rax
	leaq	-416(%rbp), %rsi
	addq	%rax, %rsi
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_scanf
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-428(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -428(%rbp)
	jmp	LBB0_1
LBB0_4:
	movl	$0, -428(%rbp)
LBB0_5:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_7 Depth 2
	movl	-428(%rbp), %eax
	movl	-424(%rbp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	LBB0_14
## %bb.6:                               ##   in Loop: Header=BB0_5 Depth=1
	movl	$0, -432(%rbp)
LBB0_7:                                 ##   Parent Loop BB0_5 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	-432(%rbp), %eax
	movl	-424(%rbp), %ecx
	subl	-428(%rbp), %ecx
	subl	$1, %ecx
	cmpl	%ecx, %eax
	jge	LBB0_12
## %bb.8:                               ##   in Loop: Header=BB0_7 Depth=2
	movslq	-432(%rbp), %rax
	movl	-416(%rbp,%rax,4), %eax
	movl	-432(%rbp), %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	cmpl	-416(%rbp,%rcx,4), %eax
	jle	LBB0_10
## %bb.9:                               ##   in Loop: Header=BB0_7 Depth=2
	movslq	-432(%rbp), %rax
	movl	-416(%rbp,%rax,4), %eax
	movl	%eax, -436(%rbp)
	movl	-432(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	-416(%rbp,%rax,4), %ecx
	movslq	-432(%rbp), %rax
	movl	%ecx, -416(%rbp,%rax,4)
	movl	-436(%rbp), %ecx
	movl	-432(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	%ecx, -416(%rbp,%rax,4)
LBB0_10:                                ##   in Loop: Header=BB0_7 Depth=2
	jmp	LBB0_11
LBB0_11:                                ##   in Loop: Header=BB0_7 Depth=2
	movl	-432(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -432(%rbp)
	jmp	LBB0_7
LBB0_12:                                ##   in Loop: Header=BB0_5 Depth=1
	jmp	LBB0_13
LBB0_13:                                ##   in Loop: Header=BB0_5 Depth=1
	movl	-428(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -428(%rbp)
	jmp	LBB0_5
LBB0_14:
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	$0, -428(%rbp)
LBB0_15:                                ## =>This Inner Loop Header: Depth=1
	movl	-428(%rbp), %eax
	cmpl	-424(%rbp), %eax
	jge	LBB0_18
## %bb.16:                              ##   in Loop: Header=BB0_15 Depth=1
	movslq	-428(%rbp), %rax
	movl	-416(%rbp,%rax,4), %esi
	leaq	L_.str.4(%rip), %rdi
	movb	$0, %al
	callq	_printf
## %bb.17:                              ##   in Loop: Header=BB0_15 Depth=1
	movl	-428(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -428(%rbp)
	jmp	LBB0_15
LBB0_18:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_20
## %bb.19:
	xorl	%eax, %eax
	addq	$448, %rsp                      ## imm = 0x1C0
	popq	%rbp
	retq
LBB0_20:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"\nEnter number of elements: "

L_.str.1:                               ## @.str.1
	.asciz	"%d"

L_.str.2:                               ## @.str.2
	.asciz	"\nEnter %d integers:\n"

L_.str.3:                               ## @.str.3
	.asciz	"Sorted list in ascending order:\n"

L_.str.4:                               ## @.str.4
	.asciz	"%d\n"

.subsections_via_symbols
