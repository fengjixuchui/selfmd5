	.file	"md5-test.c"
	.text
	.section	.rodata
.LC0:
	.string	"rb"
.LC1:
	.string	"%02x"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$20576, %rsp
	movl	%edi, -20564(%rbp)
	movq	%rsi, -20576(%rbp)
	movq	-20576(%rbp), %rax
	movq	(%rax), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L2
	movl	$1, %eax
	jmp	.L6
.L2:
	movq	-16(%rbp), %rdx
	leaq	-20512(%rbp), %rax
	movq	%rdx, %rcx
	movl	$20480, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	movslq	%eax, %rcx
	leaq	-20528(%rbp), %rdx
	leaq	-20512(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	md5_hash
	leaq	-20528(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -20560(%rbp)
	movq	$0, -20552(%rbp)
	movq	$0, -20544(%rbp)
	movq	$0, -20536(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L4
.L5:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	-4(%rbp), %edx
	addl	%edx, %edx
	movslq	%edx, %rdx
	leaq	-20560(%rbp), %rcx
	addq	%rdx, %rcx
	movl	%eax, %edx
	movl	$.LC1, %esi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	sprintf
	addl	$1, -4(%rbp)
.L4:
	cmpl	$15, -4(%rbp)
	jle	.L5
	leaq	-20560(%rbp), %rax
	movq	%rax, %rdi
	call	puts
	movl	$0, %eax
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.globl	md5_hash
	.type	md5_hash, @function
md5_hash:
.LFB3:
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
	jmp	.L8
.L9:
	movq	-104(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	addq	$64, -8(%rbp)
.L8:
	movq	-112(%rbp), %rax
	subq	-8(%rbp), %rax
	cmpq	$63, %rax
	ja	.L9
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
	jmp	.L10
.L11:
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
.L10:
	movl	-12(%rbp), %eax
	cltq
	cmpq	%rax, -24(%rbp)
	ja	.L11
	leaq	-96(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$-128, (%rax)
	addq	$1, -24(%rbp)
	movl	$64, %eax
	subq	-24(%rbp), %rax
	cmpq	$7, %rax
	ja	.L12
	leaq	-96(%rbp), %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movl	$0, -12(%rbp)
	jmp	.L13
.L14:
	movl	-12(%rbp), %eax
	cltq
	movb	$0, -96(%rbp,%rax)
	addl	$1, -12(%rbp)
.L13:
	movl	-12(%rbp), %eax
	cmpl	$63, %eax
	jbe	.L14
.L12:
	movq	-112(%rbp), %rax
	sall	$3, %eax
	movb	%al, -40(%rbp)
	shrq	$5, -112(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L15
.L16:
	movl	-12(%rbp), %eax
	addl	$56, %eax
	movq	-112(%rbp), %rdx
	cltq
	movb	%dl, -96(%rbp,%rax)
	addl	$1, -12(%rbp)
	shrq	$8, -112(%rbp)
.L15:
	cmpl	$7, -12(%rbp)
	jle	.L16
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
.LFE3:
	.size	md5_hash, .-md5_hash
	.ident	"GCC: (GNU) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
