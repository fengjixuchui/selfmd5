	.file	"md5-asm.c"
	.text
	.section	.rodata
.LC0:
	.string	"0123456789abcdef"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$20560, %rsp
	movl	%edi, -20548(%rbp)
	movq	%rsi, -20560(%rbp)
	movq	-20560(%rbp), %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -8(%rbp)
	leaq	-20512(%rbp), %rcx
	movl	-8(%rbp), %eax
	movl	$20480, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rcx
	leaq	-20528(%rbp), %rdx
	leaq	-20512(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	md5_hash
	movq	$.LC0, -24(%rbp)
	leaq	-20528(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movw	$0, -20531(%rbp)
	movb	$0, -20529(%rbp)
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$15, %eax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -20531(%rbp)
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -20530(%rbp)
	leaq	-20531(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	addl	$1, -4(%rbp)
.L2:
	cmpl	$15, -4(%rbp)
	jle	.L3
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	md5_hash
	.type	md5_hash, @function
md5_hash:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	movq	-120(%rbp), %rax
	movl	$1732584193, (%rax)
	movq	-120(%rbp), %rax
	addq	$4, %rax
	movl	$-271733879, (%rax)
	movq	-120(%rbp), %rax
	addq	$8, %rax
	movl	$-1732584194, (%rax)
	movq	-120(%rbp), %rax
	addq	$12, %rax
	movl	$271733878, (%rax)
	movq	$0, -8(%rbp)
	jmp	.L6
.L7:
	movq	-104(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	addq	$64, -8(%rbp)
.L6:
	movq	-112(%rbp), %rax
	subq	-8(%rbp), %rax
	cmpq	$63, %rax
	ja	.L7
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	-112(%rbp), %rax
	subq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L8
.L9:
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movq	-104(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-12(%rbp), %eax
	cltq
	movb	%dl, -96(%rbp,%rax)
	addl	$1, -12(%rbp)
.L8:
	movl	-12(%rbp), %eax
	cltq
	cmpq	%rax, -24(%rbp)
	ja	.L9
	leaq	-96(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$-128, (%rax)
	addq	$1, -24(%rbp)
	movl	$64, %eax
	subq	-24(%rbp), %rax
	cmpq	$7, %rax
	ja	.L10
	leaq	-96(%rbp), %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movl	$0, -12(%rbp)
	jmp	.L11
.L12:
	movl	-12(%rbp), %eax
	cltq
	movb	$0, -96(%rbp,%rax)
	addl	$1, -12(%rbp)
.L11:
	movl	-12(%rbp), %eax
	cmpl	$63, %eax
	jbe	.L12
.L10:
	movq	-112(%rbp), %rax
	sall	$3, %eax
	movb	%al, -40(%rbp)
	shrq	$5, -112(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L13
.L14:
	movl	-12(%rbp), %eax
	addl	$56, %eax
	movq	-112(%rbp), %rdx
	cltq
	movb	%dl, -96(%rbp,%rax)
	addl	$1, -12(%rbp)
	shrq	$8, -112(%rbp)
.L13:
	cmpl	$7, -12(%rbp)
	jle	.L14
	leaq	-96(%rbp), %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
