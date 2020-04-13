	.file	"main-new.c"
	.text
	.globl	_start
	.type	_start, @function
_start:
    movq	8(%rsp), %rdi

	#pushq	%r12
	#movq	%rsi, %r8
	#xorl	%edx, %edx
	#xorl	%esi, %esi
	#pushq	%rbp
	#xorl	%eax, %eax
	#pushq	%rbx
	subq	$1104, %rsp
	#movq	(%r8), %rdi
	mov	$2, %al
    syscall #call	open

	movl	$1024, %edx
	leaq	80(%rsp), %rsi
	movl    %eax, %edi
	xor	    %al, %al
    syscall #call	read

	movl	$64, %edi
	vmovdqa	.LC0(%rip), %xmm0
	movabsq	$1445102447882210311, %r8
	movswl	%ax, %esi
	movl	$16, %r10d
	movabsq	$1517442620720155396, %r9
	leal	8(%rsi), %eax
	vmovaps	%xmm0, 32(%rsp)
	cltd
	vmovaps	%xmm0, 48(%rsp)
	idivl	%edi
	xorl	%edi, %edi
	sall	$6, %eax
	leal	56(%rax), %ecx
	movslq	%esi, %rax
	sall	$3, %esi
	movb	$-128, 80(%rsp,%rax)
	movslq	%esi, %rsi
	movswq	%cx, %rax
	movl	%ecx, %edx
	movq	%rsi, 80(%rsp,%rax)
	sarw	$15, %dx
	movl	$64, %esi
	movl	%ecx, %eax
	idivw	%si
	subl	%edx, %ecx
	movswq	%cx, %rsi
.L6:
	leal	3(%rdi), %eax
	movl	%edi, %ecx
	movl	$16909056, 20(%rsp)
	andl	$3, %eax
	movl	%ecx, %ebp
	movl	$327936, 24(%rsp)
	movsbq	20(%rsp,%rax), %rax
	sarb	$4, %bpl
	movq	%r8, 64(%rsp)
	movl	$117638401, 28(%rsp)
	movsbl	%bpl, %ebx
	movl	48(%rsp,%rax,4), %r11d
	leal	2(%rdi), %eax
	incl	%edi
	movq	%r9, 72(%rsp)
	movl	%edi, %edx
	andl	$3, %eax
	andl	$3, %edx
	movsbq	20(%rsp,%rax), %rax
	movsbq	20(%rsp,%rdx), %rdx
	movl	48(%rsp,%rax,4), %eax
	movl	48(%rsp,%rdx,4), %edx
	cmpb	$2, %bpl
	je	.L2
	cmpb	$3, %bpl
	je	.L3
	decb	%bpl
	je	.L4
	xorl	%edx, %eax
	andl	%r11d, %eax
	jmp	.L16
.L4:
	movl	%r11d, %ebp
	xorl	%eax, %ebp
	andl	%edx, %ebp
	jmp	.L15
.L2:
	xorl	%r11d, %eax
.L16:
	xorl	%edx, %eax
	movl	%eax, %ebp
	jmp	.L5
.L3:
	notl	%edx
	movl	%edx, %ebp
	orl	%r11d, %ebp
.L15:
	xorl	%eax, %ebp
.L5:
	movslq	%ebx, %r12
	movl	%ecx, %eax
	movl	%edi, 8(%rsp)
	movsbl	28(%rsp,%r12), %edx
	fildl	8(%rsp)
	andl	$15, %eax
	imull	%edx, %eax
	movsbl	24(%rsp,%r12), %edx
	addl	%edx, %eax
	cltd
	idivl	%r10d
	movslq	%edx, %rax
	leaq	1104(%rsp,%rax,4), %rax
	movl	-1024(%rsi,%rax), %edx
	movl	%ecx, %eax
	andl	$3, %eax
	leal	(%rax,%rbx,4), %ecx
	movslq	%ecx, %rcx
	movsbl	64(%rsp,%rcx), %ecx
#APP
# 21 "main-new.c" 1
	fsin

# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC1(%rip)
	cltq
	movsbq	20(%rsp,%rax), %rbx
	addl	48(%rsp,%rbx,4), %edx
	leal	(%rdx,%rbp), %eax
	fisttpq	8(%rsp)
	movq	8(%rsp), %rdx
	addl	%edx, %eax
	roll	%cl, %eax
	addl	%r11d, %eax
	movl	%eax, 48(%rsp,%rbx,4)
	cmpl	$64, %edi
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
	mov	$1, %dl
	incl	%ebx
	mov	$1, %dil
	mov	$1, %al
        	syscall #call	write
	cmpb	$32, %bl
	jne	.L10
	xorl	%edi, %edi
	mov	    $60, %al
        	syscall #call	exit
	.align 16
.LC0:
	.long	1683346178
	.long	1463545587
	.long	572621651
	.long	-303801772
	.align 4
.LC1:
	.long	1333788672
