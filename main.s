	
	.text

	.type	syscall3, @function
syscall3:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq %rdi, %rax
    movq %rsi, %rdi
    movq %rdx, %rsi
    movq %rcx, %rdx
    syscall
	nop
	popq	%rbp
	ret
	.size	syscall3, .-syscall3

	.section	.rodata
.LC0:
	.string	"0123456789abcdef"
	.text
	.globl	_start
	.type	_start, @function
_start:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$20624, %rsp
#APP
# 78 "md5-asm.c" 1
	movq 16(%rbp), %rax

# 0 "" 2
#NO_APP
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$400, %ecx
	movl	$0, %edx
	movq	%rax, %rsi
	movl	$2, %edi
	call	syscall3
	movl	%eax, -28(%rbp)
	leaq	-20528(%rbp), %rdx
	movl	-28(%rbp), %eax
	cltq
	movl	$20480, %ecx
	movq	%rax, %rsi
	movl	$0, %edi
	call	syscall3
	movl	%eax, -4(%rbp)
	movl	$1732584193, -20544(%rbp)
	movl	$-271733879, -20540(%rbp)
	movl	$-1732584194, -20536(%rbp)
	movl	$271733878, -20532(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L4
.L5:
	leaq	-20528(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	addq	%rax, %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	addl	$64, -8(%rbp)
.L4:
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	cmpl	$63, %eax
	jg	.L5
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
	jmp	.L6
.L7:
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
.L6:
	movl	-12(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	.L7
	movl	-32(%rbp), %eax
	cltq
	movb	$-128, -20608(%rbp,%rax)
	addl	$1, -32(%rbp)
	movl	$64, %eax
	subl	-32(%rbp), %eax
	cmpl	$7, %eax
	jg	.L8
	leaq	-20608(%rbp), %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movl	$0, -12(%rbp)
	jmp	.L9
.L10:
	movl	-12(%rbp), %eax
	cltq
	movb	$0, -20608(%rbp,%rax)
	addl	$1, -12(%rbp)
.L9:
	movl	-12(%rbp), %eax
	cmpl	$63, %eax
	jbe	.L10
.L8:
	movl	-4(%rbp), %eax
	sall	$3, %eax
	movb	%al, -20552(%rbp)
	sarl	$5, -4(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L11
.L12:
	movl	-12(%rbp), %eax
	addl	$56, %eax
	movl	-4(%rbp), %edx
	cltq
	movb	%dl, -20608(%rbp,%rax)
	addl	$1, -12(%rbp)
	sarl	$8, -4(%rbp)
.L11:
	cmpl	$7, -12(%rbp)
	jle	.L12
	leaq	-20608(%rbp), %rdx
	leaq	-20544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	md5_compress
	movq	$.LC0, -40(%rbp)
	leaq	-20544(%rbp), %rax
	movq	%rax, -48(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L13
.L14:
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
	movl	$2, %ecx
	movq	%rax, %rdx
	movl	$1, %esi
	movl	$1, %edi
	call	syscall3
	addl	$1, -12(%rbp)
.L13:
	cmpl	$15, -12(%rbp)
	jle	.L14
	movq $60, %rax
    movq $0, %rdi
    syscall
	nop
	leave
	ret

