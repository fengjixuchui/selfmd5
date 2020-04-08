	.text
	.globl	FF
	.type	FF, @function
FF:
	xorl	%ecx, %edx
	movl	(%rdi), %eax
	addl	8(%rsp), %eax
	andl	%esi, %edx
	addl	%eax, %r8d
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
	xorl	%edx, %eax
	andl	%ecx, %eax
	movl	%r9d, %ecx
	xorl	%edx, %eax
	movl	(%rdi), %edx
	addl	8(%rsp), %edx
	addl	%edx, %r8d
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	GG, .-GG
	.globl	HH
	.type	HH, @function
HH:
	movl	(%rdi), %eax
	xorl	%ecx, %edx
	addl	8(%rsp), %eax
	movl	%r9d, %ecx
	addl	%eax, %r8d
	xorl	%esi, %edx
	addl	%edx, %r8d
	roll	%cl, %r8d
	addl	%esi, %r8d
	movl	%r8d, (%rdi)
	ret
	.size	HH, .-HH
	.globl	II
	.type	II, @function
II:
	movl	%ecx, %eax
	movl	%r9d, %ecx
	notl	%eax
	orl	%esi, %eax
	xorl	%edx, %eax
	movl	(%rdi), %edx
	addl	8(%rsp), %edx
	addl	%edx, %r8d
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	II, .-II
	.globl	ROTLEFT
	.type	ROTLEFT, @function
ROTLEFT:
	movl	%edi, %eax
	movl	%esi, %ecx
	roll	%cl, %eax
	ret
	.size	ROTLEFT, .-ROTLEFT
	.globl	F
	.type	F, @function
F:
	xorl	%edx, %esi
	andl	%edi, %esi
	movl	%esi, %eax
	xorl	%edx, %eax
	ret
	.size	F, .-F
	.globl	G
	.type	G, @function
G:
	xorl	%esi, %edi
	andl	%edx, %edi
	movl	%edi, %eax
	xorl	%esi, %eax
	ret
	.size	G, .-G
	.globl	H
	.type	H, @function
H:
	xorl	%edx, %esi
	movl	%esi, %eax
	xorl	%edi, %eax
	ret
	.size	H, .-H
	.globl	I
	.type	I, @function
I:
	notl	%edx
	orl	%edi, %edx
	movl	%edx, %eax
	xorl	%esi, %eax
	ret
	.size	I, .-I
	.section	.rodata
	.align 32
.LC0:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	1
	.byte	6
	.byte	11
	.byte	0
	.byte	5
	.byte	10
	.byte	15
	.byte	4
	.byte	9
	.byte	14
	.byte	3
	.byte	8
	.byte	13
	.byte	2
	.byte	7
	.byte	12
	.byte	5
	.byte	8
	.byte	11
	.byte	14
	.byte	1
	.byte	4
	.byte	7
	.byte	10
	.byte	13
	.byte	0
	.byte	3
	.byte	6
	.byte	9
	.byte	12
	.byte	15
	.byte	2
	.byte	0
	.byte	7
	.byte	14
	.byte	5
	.byte	12
	.byte	3
	.byte	10
	.byte	1
	.byte	8
	.byte	15
	.byte	6
	.byte	13
	.byte	4
	.byte	11
	.byte	2
	.byte	9
	.align 32
.LC1:
	.byte	7
	.byte	12
	.byte	17
	.byte	22
	.byte	7
	.byte	12
	.byte	17
	.byte	22
	.byte	7
	.byte	12
	.byte	17
	.byte	22
	.byte	7
	.byte	12
	.byte	17
	.byte	22
	.byte	5
	.byte	9
	.byte	14
	.byte	20
	.byte	5
	.byte	9
	.byte	14
	.byte	20
	.byte	5
	.byte	9
	.byte	14
	.byte	20
	.byte	5
	.byte	9
	.byte	14
	.byte	20
	.byte	4
	.byte	11
	.byte	16
	.byte	23
	.byte	4
	.byte	11
	.byte	16
	.byte	23
	.byte	4
	.byte	11
	.byte	16
	.byte	23
	.byte	4
	.byte	11
	.byte	16
	.byte	23
	.byte	6
	.byte	10
	.byte	15
	.byte	21
	.byte	6
	.byte	10
	.byte	15
	.byte	21
	.byte	6
	.byte	10
	.byte	15
	.byte	21
	.byte	6
	.byte	10
	.byte	15
	.byte	21
	.align 32
.LC2:
	.long	-680876936
	.long	-389564586
	.long	606105819
	.long	-1044525330
	.long	-176418897
	.long	1200080426
	.long	-1473231341
	.long	-45705983
	.long	1770035416
	.long	-1958414417
	.long	-42063
	.long	-1990404162
	.long	1804603682
	.long	-40341101
	.long	-1502002290
	.long	1236535329
	.long	-165796510
	.long	-1069501632
	.long	643717713
	.long	-373897302
	.long	-701558691
	.long	38016083
	.long	-660478335
	.long	-405537848
	.long	568446438
	.long	-1019803690
	.long	-187363961
	.long	1163531501
	.long	-1444681467
	.long	-51403784
	.long	1735328473
	.long	-1926607734
	.long	-378558
	.long	-2022574463
	.long	1839030562
	.long	-35309556
	.long	-1530992060
	.long	1272893353
	.long	-155497632
	.long	-1094730640
	.long	681279174
	.long	-358537222
	.long	-722521979
	.long	76029189
	.long	-640364487
	.long	-421815835
	.long	530742520
	.long	-995338651
	.long	-198630844
	.long	1126891415
	.long	-1416354905
	.long	-57434055
	.long	1700485571
	.long	-1894986606
	.long	-1051523
	.long	-2054922799
	.long	1873313359
	.long	-30611744
	.long	-1560198380
	.long	1309151649
	.long	-145523070
	.long	-1120210379
	.long	718787259
	.long	-343485551
	.text
	.globl	md5_compress
	.type	md5_compress, @function
md5_compress:
	pushq	%r12
	movl	$16, %ecx
	movq	%rsi, %r12
	movl	$.LC0, %esi
	pushq	%rbp
	xorl	%ebp, %ebp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$448, %rsp
	movq	(%rdi), %rax
	movq	$FF, 32(%rsp)
	movq	%rax, 16(%rsp)
	movq	8(%rdi), %rax
	leaq	64(%rsp), %rdi
	rep movsl
	movl	$.LC1, %esi
	leaq	128(%rsp), %rdi
	movl	$16, %ecx
	rep movsl
	movl	$.LC2, %esi
	leaq	192(%rsp), %rdi
	movl	$64, %ecx
	rep movsl
	movq	%rax, 24(%rsp)
	movq	$GG, 40(%rsp)
	movq	$HH, 48(%rsp)
	movq	$II, 56(%rsp)
	movl	$16909056, (%rsp)
	movl	$33751041, 4(%rsp)
	movl	$50331906, 8(%rsp)
	movl	$66051, 12(%rsp)
.L11:
	movq	%rbp, %rax
	movsbq	64(%rsp,%rbp), %r8
	andl	$3, %eax
	movsbq	12(%rsp,%rax), %rdx
	movsbq	4(%rsp,%rax), %rsi
	movl	(%r12,%r8,4), %r8d
	movl	16(%rsp,%rdx,4), %ecx
	movsbq	8(%rsp,%rax), %rdx
	movsbq	(%rsp,%rax), %rax
	movl	16(%rsp,%rsi,4), %esi
	movl	16(%rsp,%rdx,4), %edx
	leaq	16(%rsp,%rax,4), %rdi
	pushq	%rax
	movl	%ebp, %eax
	movl	200(%rsp,%rbp,4), %r9d
	sarl	$4, %eax
	pushq	%r9
	cltq
	movsbl	144(%rsp,%rbp), %r9d
	incq	%rbp
	call	*48(%rsp,%rax,8)
	popq	%rdx
	popq	%rcx
	cmpq	$64, %rbp
	jne	.L11
	movl	16(%rsp), %eax
	addl	%eax, (%rbx)
	movl	20(%rsp), %eax
	addl	%eax, 4(%rbx)
	movl	24(%rsp), %eax
	addl	%eax, 8(%rbx)
	movl	28(%rsp), %eax
	addl	%eax, 12(%rbx)
	addq	$448, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret

