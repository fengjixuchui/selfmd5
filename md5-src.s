	.file	"md5-src.c"
	.text
	.globl	md5_compress
	.type	md5_compress, @function
md5_compress:
	pushq	%rbp
	movq	(%rdi), %rax
	xorl	%ecx, %ecx
	movl	$16, %r10d
	pushq	%rbx
	movq	%rax, -40(%rsp)
	movq	8(%rdi), %rax
	movl	$16909056, -52(%rsp)
	movq	%rax, -32(%rsp)
	movabsq	$1445102447882210311, %rax
	movq	%rax, -24(%rsp)
	movabsq	$1517442620720155396, %rax
	movl	$327936, -48(%rsp)
	movl	$117638401, -44(%rsp)
	movq	%rax, -16(%rsp)
.L6:
	leal	3(%rcx), %eax
	leal	1(%rcx), %r9d
	movl	%ecx, %r8d
	andl	$3, %eax
	movl	%r9d, %edx
	sarl	$4, %r8d
	movsbq	-52(%rsp,%rax), %rax
	andl	$3, %edx
	movsbq	-52(%rsp,%rdx), %rdx
	movl	-40(%rsp,%rax,4), %r11d
	leal	2(%rcx), %eax
	andl	$3, %eax
	movl	-40(%rsp,%rdx,4), %ebx
	movsbq	-52(%rsp,%rax), %rax
	movl	-40(%rsp,%rax,4), %eax
	cmpl	$2, %r8d
	je	.L2
	cmpl	$3, %r8d
	je	.L3
	cmpl	$1, %r8d
	je	.L4
	xorl	%ebx, %eax
	andl	%r11d, %eax
	jmp	.L9
.L4:
	movl	%r11d, %edx
	xorl	%eax, %edx
	andl	%edx, %ebx
	jmp	.L9
.L2:
	xorl	%r11d, %eax
	jmp	.L9
.L3:
	notl	%ebx
	orl	%r11d, %ebx
.L9:
	movslq	%r8d, %rbp
	xorl	%eax, %ebx
	movl	%ecx, %eax
	movl	%r9d, -64(%rsp)
	movsbl	-44(%rsp,%rbp), %edx
	fildl	-64(%rsp)
	andl	$15, %eax
	imull	%edx, %eax
	movsbl	-48(%rsp,%rbp), %edx
	addl	%edx, %eax
	cltd
	idivl	%r10d
	movslq	%edx, %rax
	movl	(%rsi,%rax,4), %edx
	movl	%ecx, %eax
	andl	$3, %eax
	leal	(%rax,%r8,4), %ecx
	movslq	%ecx, %rcx
	movsbl	-24(%rsp,%rcx), %ecx
#APP
# 38 "md5-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC0(%rip)
	cltq
	movsbq	-52(%rsp,%rax), %rbp
	fnstcw	-58(%rsp)
	movw	-58(%rsp), %ax
	orb	$12, %ah
	movw	%ax, -60(%rsp)
	fldcw	-60(%rsp)
	fistpq	-72(%rsp)
	fldcw	-58(%rsp)
	movq	-72(%rsp), %r8
	addl	-40(%rsp,%rbp,4), %edx
	leal	(%rdx,%rbx), %eax
	addl	%r8d, %eax
	roll	%cl, %eax
	movl	%r9d, %ecx
	addl	%r11d, %eax
	movl	%eax, -40(%rsp,%rbp,4)
	cmpl	$64, %r9d
	jne	.L6
	movl	-40(%rsp), %eax
	addl	%eax, (%rdi)
	movl	-36(%rsp), %eax
	addl	%eax, 4(%rdi)
	movl	-32(%rsp), %eax
	addl	%eax, 8(%rdi)
	movl	-28(%rsp), %eax
	popq	%rbx
	addl	%eax, 12(%rdi)
	popq	%rbp
	ret
	.size	md5_compress, .-md5_compress
	.align 4
.LC0:
	.long	1333788672
