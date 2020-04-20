	.file	"main-src.c"
	.text
	
	.globl	_start
	.type	_start, @function
_start:

	subq	$64, %rsp
	xorl	%edx, %edx
	movb	$-128, 4194778
	vmovdqu	.LC0(%rip), %xmm0
	vmovaps	%xmm0, 32(%rsp)
	vmovdqu	.LC2(%rip), %xmm0
	movl	36(%rsp), %edi
	movl	32(%rsp), %r9d
	movl	40(%rsp), %esi
	movq	$3792, 4194808
	movl	44(%rsp), %r8d
	vmovaps	%xmm0, 48(%rsp)
.L6:
	movl	%edx, %eax
	movl	%edx, %ecx
	sarb	$4, %al
	movsbl	%al, %r10d
	cmpb	$2, %al
	je	.L2
	cmpb	$3, %al
	je	.L3
	decb	%al
	je	.L4
	movl	%esi, %eax
	movl	%edx, %r11d
	xorl	%r8d, %eax
	andl	%edi, %eax
	xorl	%r8d, %eax
	jmp	.L5
.L4:
	movl	%edi, %eax
	leal	(%rdx,%rdx,4), %r11d
	xorl	%esi, %eax
	incl	%r11d
	andl	%r8d, %eax
	xorl	%esi, %eax
	jmp	.L15
.L2:
	movl	%edi, %eax
	leal	(%rdx,%rdx,2), %r11d
	xorl	%esi, %eax
	addl	$5, %r11d
	xorl	%r8d, %eax
	jmp	.L15
.L3:
	movl	%r8d, %eax
	imull	$7, %edx, %r11d
	notl	%eax
	orl	%edi, %eax
	xorl	%esi, %eax
.L15:
	andl	$15, %r11d
.L5:
	incl	%edx
	movl	%edx, 8(%rsp)
	fildl	8(%rsp)
#APP
# 21 "main-src.c" 1
	fsin
	
# 0 "" 2
#NO_APP
	fabs
	fmuls	.LC1(%rip)
	andl	$3, %ecx
	
	leal	(%rcx,%r10,4), %ecx
	
	movsbl	48(%rsp,%rcx), %ecx
	fisttpq	8(%rsp)
	movq	8(%rsp), %rbx
	addl	%ebx, %eax
	addl	4194752(,%r11,4), %eax
	addl	%r9d, %eax
	movl	%r8d, %r9d
	roll	%cl, %eax
	addl	%edi, %eax
	cmpl	$64, %edx
	je	.L17
	movl	%esi, %r8d
	movl	%edi, %esi
	movl	%eax, %edi
	jmp	.L6
.L17:
	addl	%r8d, 32(%rsp)
	xorl	%ebx, %ebx
	addl	%eax, 36(%rsp)
	addl	%edi, 40(%rsp)
	addl	%esi, 44(%rsp)
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
	movb	%dl, 31(%rsp)
	leaq	31(%rsp), %rsi
	mov $1, %dl
	incl	%ebx
	movl	$1, %edi
	mov	$1, %al
  syscall
	cmpb	$32, %bl
	jne	.L10
	xorl	%edi, %edi
	mov	$60, %al
  syscall
	
	

	
.LC1:
	.long	1333788672

.LC2:
	.quad	1445102447882210311
	.quad	1517442620720155396

.LC0:
	.long	1552271408
	.long	1380605251
	.long	293175058
	.long	-760172391
