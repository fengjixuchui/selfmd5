	.file	"main-src.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%rbp
	#movq	%rsi, %r8
	#xorl	%edx, %edx
	#xorl	%esi, %esi
	#pushq	%rbx
	#xorl	%eax, %eax
	subq	$11120, %rsp
	#movq	(%r8), %rdi
	mov	    $2, %al
    syscall #call	open

	mov	    $1024, %dx
	leaq	80(%rsp), %rsi
	movl	%eax, %edi
	xor	    %al, %al
    syscall #call	read

	vmovdqu	.LC0(%rip), %xmm0
	xorl	%r8d, %r8d
	movabsq	$1445102447882210311, %rsi
	movswq	%ax, %rdx
	mov	    $16, %r9b
	movabsq	$1517442620720155396, %rdi
	movq	%rdx, %rax
	movb	$-128, 80(%rsp,%rdx)
	sall	$3, %eax
	vmovaps	%xmm0, 32(%rsp)
	cltq
	vmovaps	%xmm0, 48(%rsp)
	movq	%rax, 712(%rsp)
.L6:
	leal	3(%r8), %eax
	movl	%r8d, %ecx
	movl	$16909056, 20(%rsp)
	andl	$3, %eax
	movl	%ecx, %r11d
	movl	$327936, 24(%rsp)
	movsbq	20(%rsp,%rax), %rax
	sarb	$4, %r11b
	movq	%rsi, 64(%rsp)
	movl	$117638401, 28(%rsp)
	movsbl	%r11b, %ebx
	movl	48(%rsp,%rax,4), %r10d
	leal	2(%r8), %eax
	incl	%r8d
	movq	%rdi, 72(%rsp)
	movl	%r8d, %edx
	andl	$3, %eax
	andl	$3, %edx
	movsbq	20(%rsp,%rax), %rax
	movsbq	20(%rsp,%rdx), %rdx
	movl	48(%rsp,%rax,4), %eax
	movl	48(%rsp,%rdx,4), %edx
	cmpb	$2, %r11b
	je	.L2
	cmpb	$3, %r11b
	je	.L3
	decb	%r11b
	je	.L4
	xorl	%edx, %eax
	andl	%r10d, %eax
	jmp	.L16
.L4:
	movl	%r10d, %r11d
	xorl	%eax, %r11d
	andl	%edx, %r11d
	jmp	.L15
.L2:
	xorl	%r10d, %eax
.L16:
	xorl	%edx, %eax
	movl	%eax, %r11d
	jmp	.L5
.L3:
	notl	%edx
	movl	%edx, %r11d
	orl	%r10d, %r11d
.L15:
	xorl	%eax, %r11d
.L5:
	movslq	%ebx, %rbp
	movl	%ecx, %eax
	movl	%r8d, 8(%rsp)
	movsbl	28(%rsp,%rbp), %edx
	fildl	8(%rsp)
	andl	$15, %eax
	imull	%edx, %eax
	movsbl	24(%rsp,%rbp), %edx
	addl	%edx, %eax
	cltd
	idivl	%r9d
	movslq	%edx, %rax
	movl	656(%rsp,%rax,4), %edx
	movl	%ecx, %eax
	andl	$3, %eax
	leal	(%rax,%rbx,4), %ecx
	movslq	%ecx, %rcx
	movsbl	64(%rsp,%rcx), %ecx
#APP
# 21 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC1(%rip)
	cltq
	movsbq	20(%rsp,%rax), %rbx
	addl	48(%rsp,%rbx,4), %edx
	leal	(%rdx,%r11), %eax
	fisttpq	8(%rsp)
	movq	8(%rsp), %rdx
	addl	%edx, %eax
	roll	%cl, %eax
	addl	%r10d, %eax
	movl	%eax, 48(%rsp,%rbx,4)
	cmpl	$64, %r8d
	jne	.L6
	vmovdqa	32(%rsp), %xmm1
	vpaddd	48(%rsp), %xmm1, %xmm0
	xorl	%ebx, %ebx
	vmovaps	%xmm0, 32(%rsp)
.L10:
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
	jle	.L9
	leal	87(%rax), %edx
.L9:
	movb	%dl, 64(%rsp)
	leaq	64(%rsp), %rsi
	movl	$1, %edx
	incl	%ebx
	movl	$1, %edi
	mov	    $1, %al
    syscall #call	write

	cmpb	$32, %bl
	jne	.L10
	xorl	%edi, %edi
	mov	    $60, %al
    syscall #call	exit
.LC0:
	.long	1134044735
	.long	1070356677
	.long	-1873822489
	.long	-1117647624
.LC1:
	.long	1333788672
