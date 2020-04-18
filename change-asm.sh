sed -i "s/.section	.text.startup,\"ax\",@progbits//g" main-src.s
sed -i "s/.globl	main/.globl	_start/g" main-src.s
sed -i "s/.type	main, @function/.type	_start, @function/g" main-src.s
sed -i "s/main:/_start:/g" main-src.s
sed -i "s/.section	.rodata.cst4,\"aM\",@progbits,4//g" main-src.s
sed -i "s/.ident	\"GCC: (GNU) 9.3.0\"//g" main-src.s
sed -i "s/.section	.note.GNU-stack,\"\",@progbits//g" main-src.s
sed -i "s/call	open/mov	\$2, %al\n  syscall/g" main-src.s
sed -i "s/call	read/xor	%al, %al\n  syscall/g" main-src.s
sed -i "s/call	write/mov	\$1, %al\n  syscall/g" main-src.s
sed -i "s/call	exit/mov	\$60, %al\n  syscall/g" main-src.s
sed -i "s/pushq.*//g" main-src.s
sed -i "s/.size	main, .-main//g" main-src.s
