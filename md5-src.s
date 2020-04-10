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
	pushq	%r12
	movq	%rsi, %r12
	xorl	%esi, %esi
	pushq	%rbp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$96, %rsp
	movq	(%rdi), %rax
	movq	$FF, 64(%rsp)
	movq	%rax, 32(%rsp)
	movq	8(%rdi), %rax
	movq	$GG, 72(%rsp)
	movq	%rax, 40(%rsp)
	movabsq	$1445102447882210311, %rax
	movq	%rax, 48(%rsp)
	movabsq	$1517442620720155396, %rax
	movq	$HH, 80(%rsp)
	movq	$II, 88(%rsp)
	movl	$16909056, 20(%rsp)
	movl	$327936, 24(%rsp)
	movl	$117638401, 28(%rsp)
	movq	%rax, 56(%rsp)
.L6:
	leal	1(%rsi), %ebp
	movl	%ebp, 8(%rsp)
	fildl	8(%rsp)
#APP
# 39 "md5-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	movl	%esi, %r10d
	movl	%esi, %edi
	movl	%esi, %eax
	movl	$16, %ecx
	fabs
	sarl	$4, %r10d
	andl	$3, %edi
	andl	$15, %eax
	leal	(%rdi,%r10,4), %r9d
	fmuls	.LC0(%rip)
	movslq	%r10d, %r10
	movslq	%edi, %rdi
	movsbl	28(%rsp,%r10), %edx
	movsbq	20(%rsp,%rdi), %rdi
	movslq	%r9d, %r9
	imull	%edx, %eax
	movsbl	24(%rsp,%r10), %edx
	leaq	32(%rsp,%rdi,4), %rdi
	addl	%edx, %eax
	cltd
	idivl	%ecx
	movslq	%edx, %rax
	movl	%ebp, %edx
	andl	$3, %edx
	movsbq	20(%rsp,%rdx), %rdx
	movl	32(%rsp,%rdx,4), %ecx
	leal	2(%rsi), %edx
	addl	$3, %esi
	andl	$3, %edx
	andl	$3, %esi
	movsbq	20(%rsp,%rdx), %rdx
	movsbq	20(%rsp,%rsi), %rsi
	movl	32(%rsp,%rdx,4), %edx
	movl	32(%rsp,%rsi,4), %esi
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
	movsbl	64(%rsp,%r9), %r9d
	call	*80(%rsp,%r10,8)
	popq	%r9
	movl	%ebp, %esi
	popq	%r10
	cmpl	$64, %ebp
	jne	.L6
	movl	32(%rsp), %eax
	addl	%eax, (%rbx)
	movl	36(%rsp), %eax
	addl	%eax, 4(%rbx)
	movl	40(%rsp), %eax
	addl	%eax, 8(%rbx)
	movl	44(%rsp), %eax
	addl	%eax, 12(%rbx)
	addq	$96, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.size	md5_compress, .-md5_compress
	.align 4
.LC0:
	.long	1333788672
