# 说明
selfmd5项目为参加公司一个内部比赛所写，要求输出自身md5的最小程序，必须是64位ELF文件，
不能使用socket系统调用。

最终以大小决定名次，越小的排名越高。本项目最终大小**498**字节。

下面是运行效果:
```
# md5sum selfmd5-test
0936155ee1938f74bc28457f3370437a  selfmd5-test
# ./selfmd5-test
0936155ee1938f74bc28457f3370437a
```

# 原理
实现无外乎两种：
1. 打开自己文件，读取，计算md5，输出。这也是最容易想到的方式。
2. 某种算法构造出这样一种ELF，恰好能输出自己的md5。

由于本人不会第二种方法，所以只能采用第一种方法，用纯工程的方式来构造最小ELF。

# 实现
实现很简单，分为下面3步：
1. 代码编写，又分成了读取文件、MD5算法、打印结果三个部分。
2. 代码优化
3. ELF裁剪

# 代码编写
## 读取文件
最简单的也最容易想到的读取代码如下：
```
char data[1024];
short len = read(open(argv[0], 0, 0), data, sizeof(data));
```
这里不再赘述，后面优化的时候会再动到这里。

## MD5算法
从github上随便找点md5的算法，基本都类似下面这样:
```
FF (a, b, c, d, x[ 0], s11, 0xd76aa478);
FF (d, a, b, c, x[ 1], s12, 0xe8c7b756);
FF (c, d, a, b, x[ 2], s13, 0x242070db);
FF (b, c, d, a, x[ 3], s14, 0xc1bdceee);
FF (a, b, c, d, x[ 4], s11, 0xf57c0faf);
FF (d, a, b, c, x[ 5], s12, 0x4787c62a);
FF (c, d, a, b, x[ 6], s13, 0xa8304613);
FF (b, c, d, a, x[ 7], s14, 0xfd469501);
FF (a, b, c, d, x[ 8], s11, 0x698098d8);
FF (d, a, b, c, x[ 9], s12, 0x8b44f7af);
FF (c, d, a, b, x[10], s13, 0xffff5bb1);
FF (b, c, d, a, x[11], s14, 0x895cd7be);
FF (a, b, c, d, x[12], s11, 0x6b901122);
FF (d, a, b, c, x[13], s12, 0xfd987193);
FF (c, d, a, b, x[14], s13, 0xa679438e);
FF (b, c, d, a, x[15], s14, 0x49b40821);
...
...
```
可以看到，这种写法固然速度很快，但是编译出来的字节码会很多，大小不符合要求，
那么很容易想到，改成循环的是不是就好了呢？

通过md5 wiki，可以看到官方实现的算法，基本就是我们最终想要的
```
for each 512-bit chunk of padded message do
    break chunk into sixteen 32-bit words M[j], 0 ≤ j ≤ 15
    // Initialize hash value for this chunk:
    var int A := a0
    var int B := b0
    var int C := c0
    var int D := d0
    // Main loop:
    for i from 0 to 63 do
        var int F, g
        if 0 ≤ i ≤ 15 then
            F := (B and C) or ((not B) and D)
            g := i
        else if 16 ≤ i ≤ 31 then
            F := (D and B) or ((not D) and C)
            g := (5×i + 1) mod 16
        else if 32 ≤ i ≤ 47 then
            F := B xor C xor D
            g := (3×i + 5) mod 16
        else if 48 ≤ i ≤ 63 then
            F := C xor (B or (not D))
            g := (7×i) mod 16
        // Be wary of the below definitions of a,b,c,d
        F := F + A + K[i] + M[g]  // M[g] must be a 32-bits block
        A := D
        D := C
        C := B
        B := B + leftrotate(F, s[i])
    end for
    // Add this chunk's hash to result so far:
    a0 := a0 + A
    b0 := b0 + B
    c0 := c0 + C
    d0 := d0 + D
end for
```
根据wiki的伪码，优化后最终的C代码为:
```
for (short off = 0; off < new_len; off += BLOCK_LEN) {
    unsigned int *m = (unsigned int *) &data[off];

    unsigned int A = hash[0];
    unsigned int B = hash[1];
    unsigned int C = hash[2];
    unsigned int D = hash[3];

    const char ss[] = {7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21};

    for (char i = 0; i < 64; ++i) {

        unsigned int F;
        char g;
        switch (i / 16) {
            case 0:
                F = FF(B, C, D);
                g = i;
                break;
            case 1:
                F = GG(B, C, D);
                g = (5 * i + 1) % 16;
                break;
            case 2:
                F = HH(B, C, D);
                g = (3 * i + 5) % 16;
                break;
            case 3:
                F = II(B, C, D);
                g = (7 * i) % 16;
                break;
        }

        unsigned int K = (unsigned int) (((unsigned long long) 1 << 32) * fsin_my(i + 1));

        F += A + K + m[g];

        A = D;
        D = C;
        C = B;
        B = B + ROTLEFT(F, ss[(i / 16) * 4 + (i % 4)]);
    }

    hash[0] += A;
    hash[1] += B;
    hash[2] += C;
    hash[3] += D;
}
```
这就是MD5算法的主要部分。

## 打印结果
从网上随便找点代码，打印16进制的字符串如下:
```
for (int i = 0; i < sizeof arr; i ++) {
    printf("%2x", arr[i]);
}
```
这里不再赘述，后面优化的时候会再动到这里。

# 代码优化
## 思路
前面的写法，写完用gcc编译，编译出来的大小基本就是8KB+，显然很大，那么需要优化。

从网上查点资料，比如搜索"最小的hello world"，里面就会有介绍，不能使用libc，用汇编+syscall的方式来减少体积。

那改为用纯汇编来写吗？那应该大概率写的不如gcc好，那么我们就下载最新的gcc 9.3.0，请它帮我们把.c编译成.s汇编代码

转换的指令如下：
```
gcc -S main-src.c  -Os -mavx -msse -mavx2 -ffast-math -fsingle-precision-constant -fno-verbose-asm -fno-unroll-loops -fno-asynchronous-unwind-tables
```
会生成main-src.s的汇编文件，然后我们只需要修改这个main-src.s即可。

## 汇编优化
观察生成的原始汇编文件，如下:
```
	.file	"main-src.c"
	.text
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	movabsq	$-1167088121787636991, %rax
	pushq	%r14
	movabsq	$1445102447882210311, %r8
	movabsq	$1517442620720155396, %r9
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
```
既然我们要不依赖libc，那么入口必须改为_start，同时一些没用的指令，如pushq都可以干掉。

我们再观察原始的函数调用：
```
	movl	$1, %edi
	call	write
	cmpb	$32, %bl
	jne	.L11
	xorl	%edi, %edi
	call	exit
	.size	main, .-main
```
里面的call write和call exit，都要改成syscall的方式，例如：
```
	movl	$1, %edi
	mov	$1, %al
	syscall
	cmpb	$32, %bl
	jne	.L11
	xorl	%edi, %edi
	mov	$60, %al
	syscall
```
最终优化汇编的操作放到了./change-asm.sh里，每次gcc转换完汇编后，执行一下即可。

## 读取文件优化
前面提到，读取文件是用的open、read，但是其实有更简单的方法读取自己，如下：
```
#define START 0x400000
char *data = (char *) START;
const short len = 504;
```
这个0x400000是ELF头里指定的Segment virtual address，从这里就能直接开始读自己在内存中的映射。

并且最终文件大小是固定的，所以len可以直接写死。

但是MD5算法有一个写buffer的操作，如下：
```
// Pre-processing: adding a single 1 bit
append "1" bit to message    
// Notice: the input bytes are considered as bits strings,
//  where the first bit is the most significant bit of the byte.[50]

// Pre-processing: padding with zeros
append "0" bit until message length in bits ≡ 448 (mod 512)
append original length in bits mod 264 to message
```
text段是无法写的，如果copy出来，又会多余一些操作指令，网上搜一搜，gcc添加一条编译指令即可
```
-Wl,--omagic 
```
所以最后gcc编译汇编的指令如下：
```
gcc -Wl,--omagic -Os -fdata-sections -ffunction-sections -flto main-src.s -o selfmd5 -Wl,--gc-sections -Wl,--strip-all -nostdlib -nostdinc
```

## 打印结果优化
前面说到不能使用libc，所以printf也不能用了，因此必须自己实现一个打印16进制的代码。如下：
```
for (unsigned char i = 0; i < 32; i++) {
    char a = (buf[i / 2] >> (4 * (1 - i % 2))) & 0xF;
    char c = a >= 10 ? a + ('a' - 10) : a + '0';
    write(1, &c, 1);
}
```
注意这里每次循环只打印一个字符，也是为了缩减代码指令的考虑。

# ELF裁剪
前面汇编，编译出的结果基本在1k以内了。所以现在开始对ELF下手。

网上搜一搜相关工具，有个[ELFkickers](https://github.com/BR903/ELFkickers)工具集，里面有很多小工具。

我们需要用到的工具有两个：
1. sstrip，类似于strip，去掉ELF没用的东西
2. elftoc，把ELF文件转成C源文件定义

## sstrip裁剪
很简单，直接运行  
```
sstrip ./selfmd5  
```
能去掉200字节左右

## ELF头裁剪
ELF头部其实有很多字节是可以被修改的，不影响运行，所以可以把code移到ELF头里，通过JMP串联起来

先用elftoc把ELF转成selfmd5.h文件
```
elftoc ./selfmd5 > selfmd5.h
```
这时候观察selfmd5.h，代码如下：
```
#include <stddef.h>
#include <elf.h>

#define ADDR_TEXT 0x00400000

typedef struct elf
{
  Elf64_Ehdr      ehdr;
  Elf64_Phdr      phdrs[1];
  unsigned char   text[400];
} elf;

elf foo =
{
  /* ehdr */
  {
    { 0x7F, 'E', 'L', 'F', ELFCLASS64, ELFDATA2LSB, EV_CURRENT, ELFOSABI_SYSV,
      0, 0, 0, 0, 0, 0, 0, 0 },
    ET_EXEC, EM_X86_64, EV_CURRENT, ADDR_TEXT + offsetof(elf, text),
    offsetof(elf, phdrs), 0, 0, sizeof(Elf64_Ehdr), sizeof(Elf64_Phdr), 1,
    sizeof(Elf64_Shdr), 0, SHN_UNDEF
  },
  /* phdrs */
  {
    { PT_LOAD, PF_R | PF_W | PF_X, offsetof(elf, text),
      ADDR_TEXT + offsetof(elf, text), ADDR_TEXT + offsetof(elf, text),
      sizeof foo.text, sizeof foo.text, 4 }
  },
  /* text */
  {
    0x48, 0x83, 0xEC, 0x38, 0x31, 0xDB, 0x48, 0xB8, 0x01, 0x23, 0x45, 0x67,
    ...
    ...
    0x00, 0x00, 0x80, 0x4F
  }
};
```
可以看到，elftoc把ELF文件以一种易读懂、易操作的方式展现出来了，只需要把foo整块内存写成文件，就是一个ELF可执行程序。

然后通过查阅资料和试验，可以得出修改ELF头的foo.ehdr.e_ident[8]-e_ident[15]、foo.ehdr.e_version、foo.ehdr.e_shoff、foo.ehdr.e_flags不影响运行。ELF的定义在/usr/include/elf.h中。

那么剩下的就是把text里的code挪入到上面的那几个空位，然后再用2字节JMP回来。

写一个trim-src.c完成这些事情，部分代码如下：
```
// copy 4 bytes
foo.ehdr.e_ident[8] = foo.text[0];
foo.ehdr.e_ident[9] = foo.text[1];
foo.ehdr.e_ident[10] = foo.text[2];
foo.ehdr.e_ident[11] = foo.text[3];
foo.ehdr.e_ident[12] = 0xEB;
foo.ehdr.e_ident[13] = (offsetof(elf, ehdr) + offsetof(Elf64_Ehdr, e_version)) - (offsetof(elf, ehdr) + 14);
printf("jmp %d\n", foo.ehdr.e_ident[13]);

for (int i = 0; i < sizeof(foo.text) - 4; ++i) {
    foo.text[i] = foo.text[i + 4];
}
size -= 4;
```
需要注意的是，填坑的时候，要注意汇编指令的完整性，比如一条指令10个字节，不能只copy 5个过去。

所以最终的需要对main-src.s汇编文件的前几句汇编指令做下顺序的挪动。

# 编译
下面是具体的操作步骤
1. 下载最新gcc9.3，也可用docker
2. 编译汇编main-src.s
```
gcc -S main-src.c  -Os -mavx -msse -mavx2 -ffast-math -fsingle-precision-constant -fno-verbose-asm -fno-unroll-loops -fno-asynchronous-unwind-tables
```
3. 优化汇编main-src.s
```
./change-asm.sh
```
4. 手调main-src.s，原始如下
```
movabsq	$-1167088121787636991, %rax
movabsq	$1445102447882210311, %r8
movabsq	$1517442620720155396, %r9
xorl	%ebx, %ebx
subq	$56, %rsp
```
调整成:
```
subq	$56, %rsp
xorl	%ebx, %ebx
movabsq	$-1167088121787636991, %rax
movabsq	$1445102447882210311, %r8
movabsq	$1517442620720155396, %r9
```

5. 编译main-src.s，并sstrip
```
./build-asm.sh
```
6. ELF头裁剪
```
./trim-asm.sh
```
7. 最终结果
```
# md5sum selfmd5-test
0936155ee1938f74bc28457f3370437a  selfmd5-test
# ./selfmd5-test
0936155ee1938f74bc28457f3370437a
# ll selfmd5-test 
-rwxr-xr-x 1 root root 498 4月  18 13:08 selfmd5-test
```
