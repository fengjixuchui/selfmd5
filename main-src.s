	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r14
	#movq	%rsi, %r8
	#xorl	%edx, %edx
	#xorl	%esi, %esi
	#pushq	%r13
	#xorl	%eax, %eax
	#pushq	%r12
	#pushq	%rbp
	#pushq	%rbx
	movabsq	$-1167088121787636991, %rbx
	subq	$1072, %rsp
	#movq	(%r8), %rdi
	leaq	624(%rsp), %r12
	mov	    $2, %al
    syscall #call	open

	movl	$1024, %edx
	leaq	48(%rsp), %rsi
	movl	%eax, %edi
	xor	    %al, %al
    syscall #call	read

	movq	%rbx, 16(%rsp)
	movabsq	$1167088121787636990, %rbx
	movabsq	$1445102447882210311, %r8
	movswq	%ax, %rdx
	movq	%rbx, 24(%rsp)
	movabsq	$1517442620720155396, %r9
	leaq	48(%rsp), %rbx
	movq	%rdx, %rax
	movb	$-128, 48(%rsp,%rdx)
	sall	$3, %eax
	cltq
	movq	%rax, 616(%rsp)
.L7:
	movl	16(%rsp), %r13d
	movl	24(%rsp), %edi
	movq	%r8, 32(%rsp)
	xorl	%esi, %esi
	movl	20(%rsp), %r10d
	movl	28(%rsp), %r11d
	movq	%r9, 40(%rsp)
.L6:
	movl	%esi, %eax
	movl	%esi, %ebp
	movl	%esi, %ecx
	sarb	$4, %al
	movsbl	%al, %r14d
	cmpb	$2, %al
	je	.L2
	cmpb	$3, %al
	je	.L3
	decb	%al
	je	.L4
	movl	%edi, %eax
	xorl	%r11d, %eax
	andl	%r10d, %eax
	xorl	%r11d, %eax
	jmp	.L5
.L4:
	movl	%r10d, %eax
	leal	(%rsi,%rsi,4), %ecx
	xorl	%edi, %eax
	incl	%ecx
	andl	%r11d, %eax
	xorl	%edi, %eax
	jmp	.L17
.L2:
	movl	%r10d, %eax
	leal	(%rsi,%rsi,2), %ecx
	xorl	%edi, %eax
	addl	$5, %ecx
	xorl	%r11d, %eax
	jmp	.L17
.L3:
	movl	%r11d, %eax
	imull	$7, %esi, %ecx
	notl	%eax
	orl	%r10d, %eax
	xorl	%edi, %eax
.L17:
	andl	$15, %ecx
.L5:
	incl	%esi
	movl	%esi, 8(%rsp)
	fildl	8(%rsp)
#APP
# 21 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC0(%rip)
	andl	$3, %ebp
	movslq	%ecx, %rcx
	fisttpq	8(%rsp)
	movq	8(%rsp), %rdx
	addl	%edx, %eax
	leal	0(%rbp,%r14,4), %edx
	addl	(%rbx,%rcx,4), %eax
	movslq	%edx, %rdx
	addl	%r13d, %eax
	movl	%r11d, %r13d
	movsbl	32(%rsp,%rdx), %ecx
	roll	%cl, %eax
	leal	(%rax,%r10), %ecx
	cmpl	$64, %esi
	je	.L19
	movl	%edi, %r11d
	movl	%r10d, %edi
	movl	%ecx, %r10d
	jmp	.L6
.L19:
	addq	$64, %rbx
	addl	%r11d, 16(%rsp)
	addl	%ecx, 20(%rsp)
	addl	%r10d, 24(%rsp)
	addl	%edi, 28(%rsp)
	cmpq	%rbx, %r12
	jne	.L7
	xorl	%ebx, %ebx
.L11:
	movl	%ebx, %eax
	movl	%ebx, %edx
	shrb	%al
	andl	$1, %edx
	cmpb	$1, %dl
	movzbl	%al, %eax
	sbbl	%ecx, %ecx
	movzbl	16(%rsp,%rax), %eax
	andl	$4, %ecx
	sarl	%cl, %eax
	andl	$15, %eax
	leal	48(%rax), %edx
	cmpb	$9, %al
	jle	.L10
	leal	87(%rax), %edx
.L10:
	movb	%dl, 32(%rsp)
	leaq	32(%rsp), %rsi
	mov	    $1, %dl
	incl	%ebx
	movl	$1, %edi
	mov     $1, %al
    syscall #call	write

	cmpb	$32, %bl
	jne	.L11
	xorl	%edi, %edi
	mov     $60, %al
    syscall #call	exit
	.align 4
.LC0:
	.long	1333788672
