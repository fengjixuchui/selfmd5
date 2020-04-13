	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r14
	#movq	%rsi, %r8
	xorl	%edx, %edx
	xorl	%esi, %esi
	#pushq	%r13
	#xorl	%eax, %eax
	#pushq	%r12
	mov 	$16, %r12b
	#pushq	%rbp
	#xorl	%ebp, %ebp
	#pushq	%rbx
	subq	$1104, %rsp
	#movq	(%r8), %rdi
	mov	    $2, %al
    syscall #syscall#call	open

	mov 	$1024, %dx
	leaq	80(%rsp), %rsi
	movl	%eax, %edi
	mov 	$0, %al
    syscall #syscall#call	read

	movl	$64, %esi
	vmovdqa	.LC0(%rip), %xmm0
	movabsq	$1445102447882210311, %r10
	movabsq	$1517442620720155396, %r11
	movswl	%ax, %ecx
	leal	8(%rcx), %eax
	vmovaps	%xmm0, 32(%rsp)
	cltd
	idivl	%esi
	sall	$6, %eax
	leal	56(%rax), %r8d
	movslq	%ecx, %rax
	sall	$3, %ecx
	movb	$-128, 80(%rsp,%rax)
	movslq	%ecx, %rcx
	movswq	%r8w, %rax
	movq	%rcx, 80(%rsp,%rax)
.L2:
	cmpw	%r8w, %bp
	jge	.L19
	vmovdqa	32(%rsp), %xmm1
	movq	%r10, 64(%rsp)
	xorl	%r9d, %r9d
	movswq	%bp, %r13
	movl	$16909056, 20(%rsp)
	movl	$327936, 24(%rsp)
	movl	$117638401, 28(%rsp)
	movq	%r11, 72(%rsp)
	vmovaps	%xmm1, 48(%rsp)
.L7:
	leal	3(%r9), %eax
	movl	%r9d, %r14d
	movl	%r9d, %ecx
	andl	$3, %eax
	sarl	$4, %r14d
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %ebx
	leal	2(%r9), %eax
	incl	%r9d
	andl	$3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %esi
	movl	%r9d, %eax
	andl	$3, %eax
	movsbq	20(%rsp,%rax), %rax
	movl	48(%rsp,%rax,4), %eax
	cmpl	$2, %r14d
	je	.L3
	cmpl	$3, %r14d
	je	.L4
	cmpl	$1, %r14d
	je	.L5
	xorl	%eax, %esi
	andl	%ebx, %esi
	jmp	.L17
.L5:
	movl	%ebx, %edx
	xorl	%esi, %edx
	andl	%edx, %eax
	jmp	.L17
.L3:
	xorl	%ebx, %esi
	jmp	.L17
.L4:
	notl	%eax
	orl	%ebx, %eax
.L17:
	movslq	%r14d, %rdi
	xorl	%eax, %esi
	movl	%ecx, %eax
	movl	%r9d, 8(%rsp)
	movsbl	28(%rsp,%rdi), %edx
	fildl	8(%rsp)
	andl	$15, %eax
	imull	%edx, %eax
	movsbl	24(%rsp,%rdi), %edx
	addl	%edx, %eax
	cltd
	idivl	%r12d
	movslq	%edx, %rax
	leaq	1104(%rsp,%rax,4), %rax
	movl	-1024(%r13,%rax), %edi
	movl	%ecx, %eax
	andl	$3, %eax
	leal	(%rax,%r14,4), %edx
	movslq	%edx, %rdx
	movsbl	64(%rsp,%rdx), %ecx
#APP
# 24 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC1(%rip)
	cltq
	movsbq	20(%rsp,%rax), %rax
	addl	48(%rsp,%rax,4), %edi
	fisttpq	8(%rsp)
	movq	8(%rsp), %rdx
	addl	%edi, %esi
	addl	%edx, %esi
	roll	%cl, %esi
	addl	%esi, %ebx
	movl	%ebx, 48(%rsp,%rax,4)
	cmpl	$64, %r9d
	jne	.L7
	vmovdqa	32(%rsp), %xmm2
	vpaddd	48(%rsp), %xmm2, %xmm0
	addl	$64, %ebp
	vmovaps	%xmm0, 32(%rsp)
	jmp	.L2
.L19:
	xorl	%ebx, %ebx
.L12:
	movl	%ebx, %eax
	movl	%ebx, %edx
	shrb	%al
	andl	$1, %edx
	cmpb	$1, %dl
	movzbl	%al, %eax
	sbbl	%ecx, %ecx
	movzbl	32(%rsp,%rax), %eax
	andl	$4, %ecx
	sarl	%cl, %eax
	andl	$15, %eax
	leal	48(%rax), %edx
	cmpb	$9, %al
	jle	.L11
	leal	87(%rax), %edx
.L11:
	movb	%dl, 64(%rsp)
	leaq	64(%rsp), %rsi
	mov 	$1, %dl
	incl	%ebx
	mov 	$1, %edi
	mov     $1, %al
	syscall#call	write
	cmpb	$32, %bl
	jne	.L12
	xorl	%edi, %edi
	mov     $60, %al
	syscall#call	exit
	.align 16
.LC0:
	.long	1732584193
	.long	-271733879
	.long	-1732584194
	.long	271733878
	.align 4
.LC1:
	.long	1333788672
