	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r14
	#movq	%rsi, %rax
	movl	$400, %edx
	xorl	%esi, %esi
	#pushq	%r13
	#pushq	%r12
	movabsq	$1517442620720155396, %r12
	#pushq	%rbp
	movabsq	$1445102447882210311, %rbp
	#pushq	%rbx
	subq	$1104, %rsp
	#movq	(%rax), %rdi
	xorl	%eax, %eax
	leaq	80(%rsp), %rbx
	movl	$2, %eax
    syscall #call	open

	leaq	80(%rsp), %rdi
	movl	$256, %ecx
	movq	%rbx, %rsi
	movl	%eax, %r8d
	xorl	%eax, %eax
	movl	$1024, %edx
	rep stosl
	movl	%r8d, %edi
	movl	$0, %eax
    syscall #call	read

	movl	$64, %esi
	movq	%rbx, %r8
	movl	$16, %r11d
	movq	%rax, %rcx
	movabsq	$-1167088121787636991, %rax
	movq	%rax, 32(%rsp)
	movabsq	$1167088121787636990, %rax
	movq	%rax, 40(%rsp)
	leal	8(%rcx), %eax
	cltd
	idivl	%esi
	sall	$6, %eax
	leal	56(%rax), %r10d
	movslq	%ecx, %rax
	sall	$3, %ecx
	movb	$-128, 80(%rsp,%rax)
	movslq	%ecx, %rcx
	movslq	%r10d, %rax
	movq	%rcx, 80(%rsp,%rax)
.L2:
	movl	%r8d, %eax
	subl	%ebx, %eax
	cmpl	%eax, %r10d
	jle	.L19
	movq	32(%rsp), %rax
	movq	%rbp, 64(%rsp)
	xorl	%ecx, %ecx
	movl	$16909056, 20(%rsp)
	movq	%rax, 48(%rsp)
	movq	40(%rsp), %rax
	movl	$327936, 24(%rsp)
	movq	%rax, 56(%rsp)
	movl	$117638401, 28(%rsp)
	movq	%r12, 72(%rsp)
.L7:
	leal	3(%rcx), %eax
	leal	1(%rcx), %r9d
	movl	%ecx, %r13d
	andl	$3, %eax
	sarl	$4, %r13d
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %edi
	leal	2(%rcx), %eax
	andl	$3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %esi
	movl	%r9d, %eax
	andl	$3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %eax
	cmpl	$2, %r13d
	je	.L3
	cmpl	$3, %r13d
	je	.L4
	cmpl	$1, %r13d
	je	.L5
	xorl	%eax, %esi
	andl	%edi, %esi
	jmp	.L17
.L5:
	movl	%edi, %edx
	xorl	%esi, %edx
	andl	%edx, %eax
	jmp	.L17
.L3:
	xorl	%edi, %esi
	jmp	.L17
.L4:
	notl	%eax
	orl	%edi, %eax
.L17:
	movslq	%r13d, %r14
	xorl	%eax, %esi
	movl	%ecx, %eax
	andl	$3, %ecx
	movsbl	28(%rsp,%r14), %edx
	andl	$15, %eax
	movl	%r9d, 8(%rsp)
	fildl	8(%rsp)
	imull	%edx, %eax
	movsbl	24(%rsp,%r14), %edx
	addl	%edx, %eax
	cltd
	idivl	%r11d
	movslq	%edx, %rax
	leal	(%rcx,%r13,4), %edx
	movslq	%edx, %rdx
	movl	(%r8,%rax,4), %eax
	movsbl	64(%rsp,%rdx), %r13d
#APP
# 23 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC0(%rip)
	movslq	%ecx, %rcx
	movsbq	20(%rsp,%rcx), %rdx
	movl	%r13d, %ecx
	addl	48(%rsp,%rdx,4), %eax
	fnstcw	14(%rsp)
	addl	%eax, %esi
	movw	14(%rsp), %ax
	orb	$12, %ah
	movw	%ax, 12(%rsp)
	fldcw	12(%rsp)
	fistpq	(%rsp)
	fldcw	14(%rsp)
	movq	(%rsp), %rax
	addl	%eax, %esi
	roll	%cl, %esi
	movl	%r9d, %ecx
	addl	%esi, %edi
	movl	%edi, 48(%rsp,%rdx,4)
	cmpl	$64, %r9d
	jne	.L7
	movl	48(%rsp), %eax
	addq	$64, %r8
	addl	%eax, 32(%rsp)
	movl	52(%rsp), %eax
	addl	%eax, 36(%rsp)
	movl	56(%rsp), %eax
	addl	%eax, 40(%rsp)
	movl	60(%rsp), %eax
	addl	%eax, 44(%rsp)
	jmp	.L2
.L19:
	leaq	32(%rsp), %rbx
	leaq	16(%rbx), %rbp
.L13:
	movb	(%rbx), %al
	movl	%eax, %edx
	andl	$15, %eax
	shrb	$4, %dl
	leal	48(%rdx), %ecx
	cmpb	$9, %dl
	jbe	.L10
	leal	87(%rdx), %ecx
.L10:
	movb	%cl, 64(%rsp)
	leal	48(%rax), %edx
	cmpb	$9, %al
	jbe	.L12
	leal	87(%rax), %edx
.L12:
	movb	%dl, 65(%rsp)
	leaq	64(%rsp), %rsi
	movl	$2, %edx
	incq	%rbx
	movl	$1, %edi
	movl    $1, %eax
    syscall #call	write
	cmpq	%rbx, %rbp
	jne	.L13
	xorl	%edi, %edi
	movl    $60, %eax
    syscall #call	exit
	.align 4
.LC0:
	.long	1333788672
