	.file	"md5-src.c"
	.text
	.globl	FF
	.type	FF, @function
FF:
	xorl	%ecx, %edx
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	andl	%esi, %edx
	xorl	%ecx, %edx
	movl	%r9d, %ecx
	addl	%r8d, %edx
	roll	%cl, %edx
	addl	%esi, %edx
	movl	%edx, (%rdi)
	ret
	.size	FF, .-FF
	.globl	GG
	.type	GG, @function
GG:
	movl	%esi, %eax
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	xorl	%edx, %eax
	andl	%ecx, %eax
	movl	%r9d, %ecx
	xorl	%edx, %eax
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	GG, .-GG
	.globl	HH
	.type	HH, @function
HH:
	xorl	%ecx, %edx
	addl	8(%rsp), %r8d
	movl	%r9d, %ecx
	xorl	%esi, %edx
	addl	%r8d, %edx
	addl	(%rdi), %edx
	roll	%cl, %edx
	addl	%esi, %edx
	movl	%edx, (%rdi)
	ret
	.size	HH, .-HH
	.globl	II
	.type	II, @function
II:
	movl	%ecx, %eax
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	movl	%r9d, %ecx
	notl	%eax
	orl	%esi, %eax
	xorl	%edx, %eax
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	II, .-II
	.globl	md5_compress
	.type	md5_compress, @function
md5_compress:
	movq	%rsi, %r12
	pushq	%rbp
	movq	%rdi, %rbp
	pushq	%rbx
	subq	$112, %rsp
	movq	(%rdi), %rax
	movq	$FF, 80(%rsp)
	movq	%rax, 48(%rsp)
	movq	8(%rdi), %rax
	movq	$GG, 88(%rsp)
	movq	%rax, 56(%rsp)
	movabsq	$1445102447882210311, %rax
	movq	$HH, 96(%rsp)
	movq	$II, 104(%rsp)
	movl	$16909056, 24(%rsp)
	movl	$33751041, 28(%rsp)
	movl	$50331906, 32(%rsp)
	movl	$66051, 36(%rsp)
	movl	$327936, 40(%rsp)
	movl	$117638401, 44(%rsp)
	movq	%rax, 64(%rsp)
	movabsq	$1517442620720155396, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
.L7:
	leal	1(%rax), %ebx
	movl	%ebx, 8(%rsp)
	fildl	8(%rsp)
#APP
# 39 "md5-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fldz
	fxch	%st(1)
	fcomi	%st(1), %st
	fstp	%st(1)
	ja	.L6
	fchs
.L6:
	movl	%eax, %r10d
	fmuls	.LC1(%rip)
	movl	%eax, %edi
	andl	$15, %eax
	sarl	$4, %r10d
	andl	$3, %edi
	movl	$16, %ecx
	leal	(%rdi,%r10,4), %r9d
	movslq	%r10d, %r10
	movslq	%edi, %rdi
	movsbl	44(%rsp,%r10), %edx
	movsbq	28(%rsp,%rdi), %rsi
	movslq	%r9d, %r9
	imull	%edx, %eax
	movsbl	40(%rsp,%r10), %edx
	movl	48(%rsp,%rsi,4), %esi
	addl	%edx, %eax
	cltd
	idivl	%ecx
	movslq	%edx, %rax
	movsbq	36(%rsp,%rdi), %rdx
	movl	48(%rsp,%rdx,4), %ecx
	movsbq	32(%rsp,%rdi), %rdx
	movsbq	24(%rsp,%rdi), %rdi
	movl	48(%rsp,%rdx,4), %edx
	leaq	48(%rsp,%rdi,4), %rdi
	pushq	%r8
	fnstcw	22(%rsp)
	movw	22(%rsp), %r8w
	orw	$3072, %r8w
	movw	%r8w, 20(%rsp)
	fldcw	20(%rsp)
	fistpq	8(%rsp)
	fldcw	22(%rsp)
	movq	8(%rsp), %r8
	pushq	%r8
	movl	(%r12,%rax,4), %r8d
	movsbl	80(%rsp,%r9), %r9d
	call	*96(%rsp,%r10,8)
	popq	%r9
	movl	%ebx, %eax
	popq	%r10
	cmpl	$64, %ebx
	jne	.L7
	movl	48(%rsp), %eax
	addl	%eax, 0(%rbp)
	movl	52(%rsp), %eax
	addl	%eax, 4(%rbp)
	movl	56(%rsp), %eax
	addl	%eax, 8(%rbp)
	movl	60(%rsp), %eax
	addl	%eax, 12(%rbp)
	addq	$112, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.align 1
.LC1:
	.long	1333788672

