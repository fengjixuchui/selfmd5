#include "md5.h"

static inline long syscall1(long code, long arg1) {
    asm volatile (
    "movq %%rdi, %%rax\n"
    "movq %%rsi, %%rdi\n"
    "syscall\n"
    :
    :
    : "memory"
    );
}

static inline long syscall3(long code, long arg1, long arg2, long arg3) {
    asm volatile (
    "movq %%rdi, %%rax\n"
    "movq %%rsi, %%rdi\n"
    "movq %%rdx, %%rsi\n"
    "movq %%rcx, %%rdx\n"
    "syscall\n"
    :
    :
    : "memory"
    );
}

#define __NR_read 0
#define __NR_write 1
#define __NR_open 2
#define __NR_exit 60

#define write(fd, buf, count) syscall3(__NR_write, fd, (long) (buf), count)

#define read(fd, buf, count) syscall3(__NR_read, (long) fd, (long) (buf), (long) count)

#define open(name, flag, mode) syscall3(__NR_open, (long) name, (long) flag, (long) mode)

#define exit(status) syscall1(__NR_exit, status)

#define O_RDONLY 0

void _start() {
    char *curname;
    asm volatile (
    "movq 16(%%rbp), %0\n"
    :"=r" (curname)
    :
    : "memory"
    );
    int filedesc = open(curname, O_RDONLY, 400);

    char message[20 * 1024];
    int len = read(filedesc, message, 20 * 1024);

    unsigned char buf[16] = {0};

    MD5_CTX ctx;
    md5_init(&ctx);
    md5_update(&ctx, (const BYTE *)(message), len);
    md5_final(&ctx, (BYTE *)(buf));

    const char *hex = "0123456789abcdef";
    int i;
    for (i = 0; i < 16; i++) {
        char tmp[3] = {0};
        tmp[0] = hex[(buf[i] >> 4) & 0xF];
        tmp[1] = hex[(buf[i]) & 0xF];
        write(1, tmp, 2);
    }

    exit(0);
}
