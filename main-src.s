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
	movabsq	$1167088121787636990, %rbx
	subq	$752, %rsp
	#movq	(%r8), %rdi
	leaq	628(%rsp), %r12
	mov	    $2, %al
    syscall #call	open

	mov	    $700, %dx
	leaq	52(%rsp), %rsi
	movl	%eax, %edi
	xor	    %al, %al
    syscall #call	read

	movq	%rbx, 28(%rsp)
	leaq	52(%rsp), %rbx
	movabsq	$-1167088121787636991, %rcx
	movswq	%ax, %rdx
	movq	%rcx, 20(%rsp)
	movabsq	$1445102447882210311, %r8
	movabsq	$1517442620720155396, %r9
	movq	%rdx, %rax
	movb	$-128, 52(%rsp,%rdx)
	sall	$3, %eax
	cltq
	movq	%rax, 620(%rsp)
.L7:
	movl	20(%rsp), %ebp
	movl	24(%rsp), %r10d
	movq	%r8, 36(%rsp)
	xorl	%esi, %esi
	movl	28(%rsp), %edi
	movl	32(%rsp), %r11d
	movq	%r9, 44(%rsp)
.L6:
	movl	%esi, %eax
	movl	%esi, %ecx
	sarb	$4, %al
	movsbl	%al, %r13d
	cmpb	$2, %al
	je	.L2
	cmpb	$3, %al
	je	.L3
	decb	%al
	je	.L4
	movl	%edi, %eax
	movl	%esi, %edx
	xorl	%r11d, %eax
	andl	%r10d, %eax
	xorl	%r11d, %eax
	jmp	.L5
.L4:
	movl	%r10d, %eax
	leal	(%rsi,%rsi,4), %edx
	xorl	%edi, %eax
	incl	%edx
	andl	%r11d, %eax
	xorl	%edi, %eax
	jmp	.L17
.L2:
	movl	%r10d, %eax
	leal	(%rsi,%rsi,2), %edx
	xorl	%edi, %eax
	addl	$5, %edx
	xorl	%r11d, %eax
	jmp	.L17
.L3:
	movl	%r11d, %eax
	imull	$7, %esi, %edx
	notl	%eax
	orl	%r10d, %eax
	xorl	%edi, %eax
.L17:
	andl	$15, %edx
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
	movsbq	%dl, %rdx
	andl	$3, %ecx
	fisttpq	8(%rsp)
	movq	8(%rsp), %r14
	addl	%r14d, %eax
	addl	(%rbx,%rdx,4), %eax
	leal	(%rcx,%r13,4), %edx
	movslq	%edx, %rdx
	addl	%ebp, %eax
	movl	%r11d, %ebp
	movsbl	36(%rsp,%rdx), %ecx
	roll	%cl, %eax
	addl	%r10d, %eax
	cmpl	$64, %esi
	je	.L19
	movl	%edi, %r11d
	movl	%r10d, %edi
	movl	%eax, %r10d
	jmp	.L6
.L19:
	addq	$64, %rbx
	addl	%r11d, 20(%rsp)
	addl	%eax, 24(%rsp)
	addl	%r10d, 28(%rsp)
	addl	%edi, 32(%rsp)
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
	movzbl	20(%rsp,%rax), %eax
	andl	$4, %ecx
	sarl	%cl, %eax
	andl	$15, %eax
	leal	48(%rax), %edx
	cmpb	$9, %al
	jle	.L10
	leal	87(%rax), %edx
.L10:
	movb	%dl, 36(%rsp)
	leaq	36(%rsp), %rsi
	mov	    $1, %dl
	incl	%ebx
	movl	$1, %edi
	mov	    $1, %al
    syscall #call	write
	cmpb	$32, %bl
	jne	.L11
	xorl	%edi, %edi
	mov	    $60, %al
    syscall #call	exit
.LC0:
	.long	1333788672
