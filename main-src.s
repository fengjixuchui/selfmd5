	.file	"main-src.c"
	.text
	
	.globl	_start
	.type	_start, @function
_start:
	subq	$56, %rsp
	xorl	%ebx, %ebx
	movabsq	$-1167088121787636991, %rax
	movabsq	$1445102447882210311, %r8
	movabsq	$1517442620720155396, %r9
	
	

	movq	%rax, 16(%rsp)
	movabsq	$1167088121787636990, %rax
	movq	%rax, 24(%rsp)
	movb	$-128, 4194808
	movq	$4032, 4194872
.L7:
	movl	16(%rsp), %ebp
	movl	20(%rsp), %r10d
	movq	%r8, 32(%rsp)
	xorl	%esi, %esi
	movl	24(%rsp), %edi
	movl	28(%rsp), %r11d
	movq	%r9, 40(%rsp)
.L6:
	movl	%esi, %eax
	movl	%esi, %ecx
	sarb	$4, %al
	movsbl	%al, %r12d
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
	addl	4194304(%rbx,%rdx,4), %eax
	leal	(%rcx,%r12,4), %edx
	movslq	%edx, %rdx
	addl	%ebp, %eax
	movl	%r11d, %ebp
	movsbl	32(%rsp,%rdx), %ecx
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
	addl	%r11d, 16(%rsp)
	addl	%eax, 20(%rsp)
	addl	%r10d, 24(%rsp)
	addl	%edi, 28(%rsp)
	cmpq	$576, %rbx
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
	movzbl	16(%rsp,%rax), %eax
	andl	$4, %ecx
	sarl	%cl, %eax
	andl	$15, %eax
	leal	48(%rax), %edx
	cmpb	$9, %al
	jle	.L10
	leal	87(%rax), %edx
.L10:
	movb	%dl, 32(%rsp)
	leaq	32(%rsp), %rsi
	movl	$1, %edx
	incl	%ebx
	movl	$1, %edi
	mov	$1, %al
  syscall
	cmpb	$32, %bl
	jne	.L11
	xorl	%edi, %edi
	mov	$60, %al
  syscall
	
	
	.align 4
.LC0:
	.long	1333788672
	
	
