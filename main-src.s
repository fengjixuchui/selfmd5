	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r12
	#movq	%rsi, %rax
	movl	$400, %edx
	xorl	%esi, %esi
	#pushq	%rbp
	#pushq	%rbx
	subq	$5152, %rsp
	#movq	(%rax), %rdi
	xorl	%eax, %eax
	leaq	32(%rsp), %rbx
	movl	$2, %eax
	syscall #call	open

	leaq	32(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rbx, %rbp
	movl	%eax, %r8d
	movl	$1280, %ecx
	xorl	%eax, %eax
	movl	$5120, %edx
	rep stosl
	movl	%r8d, %edi
	movl	$0, %eax
	syscall #call	read

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
	leal	56(%rax), %r12d
	movslq	%ecx, %rax
	sall	$3, %ecx
	movb	$-128, 32(%rsp,%rax)
	movslq	%ecx, %rcx
	movslq	%r12d, %rax
	movq	%rcx, 32(%rsp,%rax)
.L2:
	movl	%ebp, %eax
	subl	%ebx, %eax
	cmpl	%eax, %r12d
	jle	.L12
	movq	%rbp, %rsi
	leaq	16(%rsp), %rdi
	addq	$64, %rbp
	call	md5_compress
	jmp	.L2
.L12:
	leaq	16(%rsp), %rbx
	leaq	16(%rbx), %rbp
.L8:
	movb	(%rbx), %al
	movb	$0, 15(%rsp)
	movl	%eax, %edx
	andl	$15, %eax
	shrb	$4, %dl
	leal	48(%rdx), %ecx
	cmpb	$9, %dl
	jbe	.L5
	leal	87(%rdx), %ecx
.L5:
	movb	%cl, 13(%rsp)
	leal	48(%rax), %edx
	cmpb	$9, %al
	jbe	.L7
	leal	87(%rax), %edx
.L7:
	movb	%dl, 14(%rsp)
	leaq	13(%rsp), %rsi
	movl	$2, %edx
	incq	%rbx
	movl	$1, %edi
	movl    $1, %eax
	syscall #call	write
	cmpq	%rbp, %rbx
	jne	.L8
	xorl	%edi, %edi
	movl    $60, %eax
	syscall #call	exit
