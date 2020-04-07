/* 
 * MD5 hash in C and x86 assembly
 * 
 * Copyright (c) 2017 Project Nayuki. (MIT License)
 * https://www.nayuki.io/page/fast-md5-hash-implementation-in-x86-assembly
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * - The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 * - The Software is provided "as is", without warranty of any kind, express or
 *   implied, including but not limited to the warranties of merchantability,
 *   fitness for a particular purpose and noninfringement. In no event shall the
 *   authors or copyright holders be liable for any claim, damages or other
 *   liability, whether in an action of contract, tort or otherwise, arising from,
 *   out of or in connection with the Software or the use or other dealings in the
 *   Software.
 */

//#include <stdio.h>


/* Function prototypes */

#define BLOCK_LEN 64  // In bytes
#define STATE_LEN 4  // In words

// Link this program with an external C or x86 compression function
extern void md5_compress(unsigned int state[static STATE_LEN], const unsigned char block[static BLOCK_LEN]);

#define LENGTH_SIZE 8  // In bytes

static inline long syscall1(long code, long arg1) {
    long ret;
    asm volatile (
    "movq %1, %%rax\n"
    "movq %2, %%rdi\n"
    "syscall\n"
    "movq %%rax, %0\n"
    :"=r" (ret)
    :"r"(code), "r"(arg1)
    :"%rax", "%rdi", "memory"
    );
    return ret;
}

static inline long syscall3(long code, long arg1, long arg2, long arg3) {
    long ret;
    asm volatile (
    "movq %1, %%rax\n"
    "movq %2, %%rdi\n"
    "movq %3, %%rsi\n"
    "movq %4, %%rdx\n"
    "syscall\n"
    "movq %%rax, %0\n"
    :"=r" (ret)
    :"r"(code), "r"(arg1), "r"(arg2), "r"(arg3)
    :"%rax", "%rdi", "%rsi", "%rdx", "memory"
    );
    return ret;
}

#define __NR_read 0
#define __NR_write 1
#define __NR_open 2
#define __NR_exit 60

int write(int fd, const void *buf, int count) {
    return syscall3(__NR_write, fd, (long) buf, count);
}

int read(int fd, void *buf, int count) {
    return syscall3(__NR_read, (long) fd, (long) buf, (long) count);
}

int open(const void *name, int flag, int mode) {
    return syscall3(__NR_open, (long) name, (long) flag, (long) mode);
}

void exit(int status) {
    syscall1(__NR_exit, status);
}

#define O_RDONLY 0

void _start() {
    int filedesc = open("./selfmd5", O_RDONLY, 400);

    char message[20 * 1024];
    int len = read(filedesc, message, 20 * 1024);

    unsigned int hash[STATE_LEN];

    hash[0] = (unsigned int) (0x67452301);
    hash[1] = (unsigned int) (0xEFCDAB89);
    hash[2] = (unsigned int) (0x98BADCFE);
    hash[3] = (unsigned int) (0x10325476);

    int off;
    for (off = 0; len - off >= BLOCK_LEN; off += BLOCK_LEN)
        md5_compress(hash, &message[off]);

    unsigned char block[BLOCK_LEN] = {0};
    int rem = len - off;
    int i;
    for (i = 0; i < rem; i++) {
        block[i] = message[off + i];
    }

    block[rem] = 0x80;
    rem++;
    if (BLOCK_LEN - rem < LENGTH_SIZE) {
        md5_compress(hash, block);
        for (i = 0; i < sizeof(block); i++) {
            block[i] = 0;
        }
    }

    block[BLOCK_LEN - LENGTH_SIZE] = (unsigned char) ((len & 0x1FU) << 3);
    len >>= 5;
    for (i = 1; i < LENGTH_SIZE; i++, len >>= 8)
        block[BLOCK_LEN - LENGTH_SIZE + i] = (unsigned char) (len & 0xFFU);
    md5_compress(hash, block);

    const char *hex = "0123456789abcdef";
    unsigned char *buf = (unsigned char *) &hash;
    for (i = 0; i < 16; i++) {
        char tmp[3] = {0};
        tmp[0] = hex[(buf[i] >> 4) & 0xF];
        tmp[1] = hex[(buf[i]) & 0xF];
        write(1, tmp, 2);
    }

    exit(0);
}

