	.file	"main-src.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"0123456789abcdef"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	pushq	%r12
	movq	%rsi, %rax
	movl	$400, %edx
	xorl	%esi, %esi
	pushq	%rbp
	movl	$data, %r12d
	pushq	%rbx
	movq	%r12, %rbx
	subq	$32, %rsp
	movq	(%rax), %rdi
	xorl	%eax, %eax
	call	open
	movl	$20480, %edx
	movl	$data, %esi
	movl	%eax, %edi
	call	read
	movl	$64, %esi
	movq	%rax, %rcx
	movabsq	$-1167088121787636991, %rax
	movq	%rax, 16(%rsp)
	movabsq	$1167088121787636990, %rax
	movq	%rax, 24(%rsp)
	leal	8(%rcx), %eax
	cltd
	idivl	%esi
	sall	$6, %eax
	leal	56(%rax), %ebp
	movslq	%ecx, %rax
	sall	$3, %ecx
	movb	$-128, data(%rax)
	movslq	%ecx, %rcx
	movslq	%ebp, %rax
	movq	%rcx, data(%rax)
.L2:
	movl	%ebx, %eax
	subl	%r12d, %eax
	cmpl	%eax, %ebp
	jle	.L8
	movq	%rbx, %rsi
	leaq	16(%rsp), %rdi
	addq	$64, %rbx
	call	md5_compress
	jmp	.L2
.L8:
	leaq	16(%rsp), %rbx
	leaq	32(%rsp), %rbp
.L4:
	movb	(%rbx), %al
	leaq	13(%rsp), %rsi
	movl	$1, %edi
	incq	%rbx
	movb	$0, 15(%rsp)
	movl	%eax, %edx
	andl	$15, %eax
	shrb	$4, %dl
	movb	.LC0(%rax), %al
	movzbl	%dl, %edx
	movb	.LC0(%rdx), %dl
	movb	%al, 14(%rsp)
	movb	%dl, 13(%rsp)
	movl	$2, %edx
	call	write
	cmpq	%rbx, %rbp
	jne	.L4
	xorl	%edi, %edi
	call	exit
	.size	main, .-main
	.local	data
	.comm	data,20480,32
	.ident	"GCC: (GNU) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
