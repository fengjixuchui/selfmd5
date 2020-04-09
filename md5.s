	.file	"md5-src.c"
	.text
	.globl	FF
	.type	FF, @function
FF:
	xorl	%ecx, %edx
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	andl	%esi, %edx
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
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	xorl	%edx, %eax
	andl	%ecx, %eax
	movl	%r9d, %ecx
	xorl	%edx, %eax
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	GG, .-GG
	.globl	HH
	.type	HH, @function
HH:
	xorl	%ecx, %edx
	addl	8(%rsp), %r8d
	movl	%r9d, %ecx
	xorl	%esi, %edx
	addl	%r8d, %edx
	addl	(%rdi), %edx
	roll	%cl, %edx
	addl	%esi, %edx
	movl	%edx, (%rdi)
	ret
	.size	HH, .-HH
	.globl	II
	.type	II, @function
II:
	movl	%ecx, %eax
	addl	8(%rsp), %r8d
	addl	(%rdi), %r8d
	movl	%r9d, %ecx
	notl	%eax
	orl	%esi, %eax
	xorl	%edx, %eax
	addl	%r8d, %eax
	roll	%cl, %eax
	addl	%esi, %eax
	movl	%eax, (%rdi)
	ret
	.size	II, .-II
	.section	.rodata
	.align 1
.LC0:
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
	movl	$64, %ecx
	movq	%rsi, %r12
	movl	$.LC0, %esi
	pushq	%rbp
	xorl	%ebp, %ebp
	pushq	%rbx
	movq	%rdi, %rbx
	subq	$352, %rsp
	movq	(%rdi), %rax
	movq	$FF, 64(%rsp)
	movq	%rax, 32(%rsp)
	movq	8(%rdi), %rax
	leaq	96(%rsp), %rdi
	rep movsl
	movq	$GG, 72(%rsp)
	movq	%rax, 40(%rsp)
	movabsq	$1445102447882210311, %rax
	movq	%rax, 48(%rsp)
	movabsq	$1517442620720155396, %rax
	movq	$HH, 80(%rsp)
	movq	$II, 88(%rsp)
	movl	$16909056, 8(%rsp)
	movl	$33751041, 12(%rsp)
	movl	$50331906, 16(%rsp)
	movl	$66051, 20(%rsp)
	movl	$327936, 24(%rsp)
	movl	$117638401, 28(%rsp)
	movq	%rax, 56(%rsp)
.L6:
	movl	%ebp, %r10d
	movl	%ebp, %edi
	movl	%ebp, %eax
	movl	$16, %ecx
	sarl	$4, %r10d
	andl	$3, %edi
	andl	$15, %eax
	leal	(%rdi,%r10,4), %r8d
	movslq	%r10d, %r10
	movslq	%edi, %rdi
	movsbl	28(%rsp,%r10), %edx
	movsbq	12(%rsp,%rdi), %rsi
	movslq	%r8d, %r8
	imull	%edx, %eax
	movsbl	24(%rsp,%r10), %edx
	movl	32(%rsp,%rsi,4), %esi
	addl	%edx, %eax
	cltd
	idivl	%ecx
	movslq	%edx, %rax
	movsbq	20(%rsp,%rdi), %rdx
	movl	32(%rsp,%rdx,4), %ecx
	movsbq	16(%rsp,%rdi), %rdx
	movsbq	8(%rsp,%rdi), %rdi
	movl	32(%rsp,%rdx,4), %edx
	leaq	32(%rsp,%rdi,4), %rdi
	pushq	%r9
	movl	104(%rsp,%rbp,4), %r9d
	incq	%rbp
	pushq	%r9
	movsbl	64(%rsp,%r8), %r9d
	movl	(%r12,%rax,4), %r8d
	call	*80(%rsp,%r10,8)
	popq	%r10
	popq	%r11
	cmpq	$64, %rbp
	jne	.L6
	movl	32(%rsp), %eax
	addl	%eax, (%rbx)
	movl	36(%rsp), %eax
	addl	%eax, 4(%rbx)
	movl	40(%rsp), %eax
	addl	%eax, 8(%rbx)
	movl	44(%rsp), %eax
	addl	%eax, 12(%rbx)
	addq	$352, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.size	md5_compress, .-md5_compress
