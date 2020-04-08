	.file	"md5-asm-1.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"0123456789abcdef"
	.section	.text.startup,"ax",@progbits

    .type	syscall3, @function
syscall3:
    movq %rdi, %rax
    movq %rsi, %rdi
    movq %rdx, %rsi
    movq %rcx, %rdx
    syscall
    ret

	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rsp, %r12
	subq	$20584, %rsp

	movl	$400, %edx
	xorl	%esi, %esi
	movl	$2, %eax
	syscall #call	open

	movl	$20480, %edx
	leaq	-20528(%r12), %rsi
	movq	%rsi, %r13
	movl	%eax, %edi
	movl	$0, %eax
	syscall #call	read

	movq	%rax, %rbx
	movabsq	$-1167088121787636991, %rax
	movq	%rax, 16(%rsp)
	movl	%ebx, %ebp
	movabsq	$1167088121787636990, %rax
	movq	%rax, 24(%rsp)
.L2:
	movl	%r13d, %edx
	subl	%r12d, %edx
	cmpl	$63, %ebp
	jle	.L15
	movq	%r13, %rsi
	leaq	16(%rsp), %rdi
	subl	$64, %ebp
	addq	$64, %r13
	call	md5_compress
	jmp	.L2
.L15:
	xorl	%eax, %eax
	leaq	32(%rsp), %rdi
	movl	$16, %ecx
	movslq	%edx, %rdx
	rep stosl
	addq	%rdx, %r12
	xorl	%eax, %eax
.L4:
	cmpl	%eax, %ebp
	jle	.L16
	movb	(%r12,%rax), %dl
	movb	%dl, 32(%rsp,%rax)
	incq	%rax
	jmp	.L4
.L16:
	movslq	%ebp, %rax
	movb	$-128, 32(%rsp,%rax)
	movl	$63, %eax
	subl	%ebp, %eax
	cmpl	$7, %eax
	jg	.L6
	leaq	32(%rsp), %rsi
	leaq	16(%rsp), %rdi
	call	md5_compress
	leaq	32(%rsp), %rax
	leaq	64(%rax), %rdx
.L7:
	movb	$0, (%rax)
	incq	%rax
	cmpq	%rdx, %rax
	jne	.L7
.L6:
	leal	0(,%rbx,8), %eax
	sarl	$5, %ebx
	movb	%al, 88(%rsp)
	leaq	32(%rsp), %rax
	leaq	7(%rax), %rdx
.L8:
	movb	%bl, 57(%rax)
	incq	%rax
	sarl	$8, %ebx
	cmpq	%rax, %rdx
	jne	.L8
	leaq	32(%rsp), %rsi
	leaq	16(%rsp), %rdi
	call	md5_compress
	leaq	16(%rsp), %rbx
	leaq	32(%rsp), %rbp
.L9:
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
	movl    $1, %eax
	syscall #call	write
	cmpq	%rbx, %rbp
	jne	.L9
	xorl	%edi, %edi
	movl    $60, %eax
	syscall #call	exit

