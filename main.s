	.file	"md5-asm.c"
	.text
	.type	syscall1, @function
syscall1:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
#APP
# 38 "md5-asm.c" 1
	movq %rdi, %rax
movq %rsi, %rdi
syscall

# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	syscall1, .-syscall1
	.type	syscall3, @function
syscall3:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
#APP
# 49 "md5-asm.c" 1
	movq %rdi, %rax
movq %rsi, %rdi
movq %rdx, %rsi
movq %rcx, %rdx
syscall

# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	syscall3, .-syscall3
	.type	write, @function
write:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -8(%rbp)
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %eax
	cltq
	movq	%rax, %rsi
	movl	$1, %edi
	call	syscall3
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	write, .-write
	.type	read, @function
read:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -8(%rbp)
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %eax
	cltq
	movq	%rax, %rsi
	movl	$0, %edi
	call	syscall3
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	read, .-read
	.type	open, @function
open:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	-16(%rbp), %eax
	movslq	%eax, %rcx
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	syscall3
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	open, .-open
	.type	exit, @function
exit:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	cltq
	movq	%rax, %rsi
	movl	$60, %edi
	call	syscall1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	exit, .-exit
	.section	.rodata
.LC0:
	.string	"0123456789abcdef"
	.text
	.globl	_start
	.type	_start, @function
_start:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$20624, %rsp
#APP
# 87 "md5-asm.c" 1
	movq 16(%rbp), %rax

# 0 "" 2
#NO_APP
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$400, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	open
	movl	%eax, -28(%rbp)
	leaq	-20528(%rbp), %rcx
	movl	-28(%rbp), %eax
	movl	$20480, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -4(%rbp)
	movl	$1732584193, -20544(%rbp)
	movl	$-271733879, -20540(%rbp)
	movl	$-1732584194, -20536(%rbp)
	movl	$271733878, -20532(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L11
.L12:
	leaq	-20528(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	addq	%rax, %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	addl	$64, -8(%rbp)
.L11:
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	cmpl	$63, %eax
	jg	.L12
	movq	$0, -20608(%rbp)
	movq	$0, -20600(%rbp)
	movq	$0, -20592(%rbp)
	movq	$0, -20584(%rbp)
	movq	$0, -20576(%rbp)
	movq	$0, -20568(%rbp)
	movq	$0, -20560(%rbp)
	movq	$0, -20552(%rbp)
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L13
.L14:
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	cltq
	movzbl	-20528(%rbp,%rax), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	cltq
	movb	%dl, -20608(%rbp,%rax)
	addl	$1, -12(%rbp)
.L13:
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L14
	movl	-32(%rbp), %eax
	cltq
	movb	$-128, -20608(%rbp,%rax)
	addl	$1, -32(%rbp)
	movl	$64, %eax
	subl	-32(%rbp), %eax
	cmpl	$7, %eax
	jg	.L15
	leaq	-20608(%rbp), %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movl	$0, -12(%rbp)
	jmp	.L16
.L17:
	movl	-12(%rbp), %eax
	cltq
	movb	$0, -20608(%rbp,%rax)
	addl	$1, -12(%rbp)
.L16:
	movl	-12(%rbp), %eax
	cmpl	$63, %eax
	jbe	.L17
.L15:
	movl	-4(%rbp), %eax
	sall	$3, %eax
	movb	%al, -20552(%rbp)
	sarl	$5, -4(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L18
.L19:
	movl	-12(%rbp), %eax
	addl	$56, %eax
	movl	-4(%rbp), %edx
	cltq
	movb	%dl, -20608(%rbp,%rax)
	addl	$1, -12(%rbp)
	sarl	$8, -4(%rbp)
.L18:
	cmpl	$7, -12(%rbp)
	jle	.L19
	leaq	-20608(%rbp), %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movq	$.LC0, -40(%rbp)
	leaq	-20544(%rbp), %rax
	movq	%rax, -48(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L20
.L21:
	movw	$0, -20611(%rbp)
	movb	$0, -20609(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$15, %eax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -20611(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -20610(%rbp)
	leaq	-20611(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
	addl	$1, -12(%rbp)
.L20:
	cmpl	$15, -12(%rbp)
	jle	.L21
	movl	$0, %edi
	call	exit
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	_start, .-_start
	.ident	"GCC: (GNU) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
