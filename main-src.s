	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r14
	#movq	%rsi, %r8
	mov 	$400, %dx
	xorl	%esi, %esi
	#pushq	%r13
	xorl	%eax, %eax
	#pushq	%r12
	mov	    $16, %r12b
	#pushq	%rbp
	#pushq	%rbx
	subq	$1104, %rsp
	#movq	(%r8), %rdi
	leaq	80(%rsp), %rbx
	mov	    $2, %al
    syscall #call	open

	mov 	$1024, %dx
	movq	%rbx, %rsi
	movl	%eax, %edi
	mov	    $0, %al
    syscall #call	read

	movl	$64, %esi
	movq	%rbx, %r11
	movabsq	$1445102447882210311, %r8
	movabsq	$1517442620720155396, %r9
	movq	%rax, %rcx
	movabsq	$-1167088121787636991, %rax
	movq	%rax, 32(%rsp)
	movabsq	$1167088121787636990, %rax
	movq	%rax, 40(%rsp)
	leal	8(%rcx), %eax
	cltd
	idivl	%esi
	sal	    $6, %ax
	leal	56(%rax), %ebp
	movslq	%ecx, %rax
	sal 	$3, %cx
	movb	$-128, 80(%rsp,%rax)
	movslq	%ecx, %rcx
	movslq	%ebp, %rax
	movq	%rcx, 80(%rsp,%rax)
.L2:
	movl	%r11d, %eax
	subl	%ebx, %eax
	cmpl	%eax, %ebp
	jle	.L19
	movq	32(%rsp), %rax
	movq	%r8, 64(%rsp)
	xorl	%edi, %edi
	movl	$16909056, 20(%rsp)
	movq	%rax, 48(%rsp)
	movq	40(%rsp), %rax
	movl	$327936, 24(%rsp)
	movq	%rax, 56(%rsp)
	movl	$117638401, 28(%rsp)
	movq	%r9, 72(%rsp)
.L7:
	leal	3(%rdi), %eax
	movl	%edi, %r13d
	movl	%edi, %ecx
	and 	$3, %eax
	sarl	$4, %r13d
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %r10d
	leal	2(%rdi), %eax
	incl	%edi
	and	    $3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %esi
	movl	%edi, %eax
	and	    $3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %eax
	cmp	    $2, %r13d
	je	.L3
	cmp	    $3, %r13d
	je	.L4
	cmp	    $1, %r13d
	je	.L5
	xorl	%eax, %esi
	andl	%r10d, %esi
	jmp	.L17
.L5:
	movl	%r10d, %edx
	xorl	%esi, %edx
	andl	%edx, %eax
	jmp	.L17
.L3:
	xorl	%r10d, %esi
	jmp	.L17
.L4:
	notl	%eax
	orl	%r10d, %eax
.L17:
	movslq	%r13d, %r14
	xorl	%eax, %esi
	movl	%ecx, %eax
	and 	$3, %ecx
	movsbl	28(%rsp,%r14), %edx
	andl	$15, %eax
	movl	%edi, 8(%rsp)
	fildl	8(%rsp)
	imull	%edx, %eax
	movsbl	24(%rsp,%r14), %edx
	addl	%edx, %eax
	cltd
	idivl	%r12d
	movslq	%edx, %rax
	movslq	%ecx, %rdx
	leal	(%rdx,%r13,4), %ecx
	movl	(%r11,%rax,4), %eax
	movslq	%ecx, %rcx
	movsbl	64(%rsp,%rcx), %ecx
#APP
# 24 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC0(%rip)
	movsbq	20(%rsp,%rdx), %rdx
	addl	48(%rsp,%rdx,4), %eax
	addl	%eax, %esi
	fisttpq	8(%rsp)
	movq	8(%rsp), %r14
	addl	%r14d, %esi
	roll	%cl, %esi
	addl	%esi, %r10d
	movl	%r10d, 48(%rsp,%rdx,4)
	cmpl	$64, %edi
	jne	.L7
	movl	48(%rsp), %eax
	addq	$64, %r11
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
	leaq	48(%rsp), %rbp
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
	mov	    $2, %dl
	incq	%rbx
	mov 	$1, %di
	mov     $1, %al
    syscall #call	write

	cmpq	%rbx, %rbp
	jne	.L13
	xorl	%edi, %edi
	mov     $60, %al
    syscall #call	exit

	.align 4
.LC0:
	.long	1333788672
