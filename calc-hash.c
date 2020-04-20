#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#define BLOCK_LEN 64  // In bytes
#define STATE_LEN 4  // In words

#define BYTE unsigned char

/****************************** MACROS ******************************/
#define ROTLEFT(a, b)  ((a << b) | (a >> (32 - b)))

#define F(x, y, z)  ((x & y) | (~x & z))

#define G(x, y, z)  ((x & z) | (y & ~z))

#define H(x, y, z) (x ^ y ^ z)

#define I(x, y, z)  (y ^ (x | ~z))

static long double fsin_my(long double a) {
    long double res;
    // prof wiht register
    asm __volatile__("fsin\n\t"
    :"=t"(res)
    :"0"(a)
    :"memory");

    return (res) > 0 ? res : -res;
}

typedef unsigned int v4si __attribute__ ((vector_size (16)));

int main(int argc, char *argv[]) {
    char data[102400];
    short len = read(open(argv[1], 0, 0), data, sizeof(data));

    v4si hash = {(unsigned int) (0x67452301), (unsigned int) (0xEFCDAB89), (unsigned int) (0x98BADCFE),
                 (unsigned int) (0x10325476)};

    unsigned char *buf = (unsigned char *) &hash[0];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[1];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[2];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[3];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);
    write(1, "\n", 1);

    printf("%d\n", (int) hash[0]);
    printf("%d\n", (int) hash[1]);
    printf("%d\n", (int) hash[2]);
    printf("%d\n", (int) hash[3]);

    short new_len = ((((len + 8) / 64) + 1) * 64) - 8;
    data[len] = 0x80;
    *(unsigned long long *) (data + new_len) = len << 3;
    short off = 0;
    for (off = 0; off < new_len - BLOCK_LEN; off += BLOCK_LEN) {
        unsigned int *m = (unsigned int *) &data[off];

        v4si tmp = hash;

        const char p1[] = {0, 3, 2, 1};
        const char mmstart[] = {0, 1, 5, 0};
        const char mmstep[] = {1, 5, 3, 7};
        const char ss[] = {7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21};
        for (int i = 0; i < 64; ++i) {
            unsigned int inc;
            unsigned int b = tmp[p1[(i + 3) % 4]];
            unsigned int c = tmp[p1[(i + 2) % 4]];
            unsigned int d = tmp[p1[(i + 1) % 4]];
            switch (i / 16) {
                case 0:
                    inc = F(b, c, d);
                    break;
                case 1:
                    inc = G(b, c, d);
                    break;
                case 2:
                    inc = H(b, c, d);
                    break;
                case 3:
                    inc = I(b, c, d);
                    break;
            }

            unsigned int mm = m[(mmstart[i / 16] + (i % 16) * mmstep[i / 16]) % 16];
            unsigned int s = ss[(i / 16) * 4 + (i % 4)];
            unsigned int t = (unsigned int) ((unsigned long long) 4294967296 * fsin_my(i + 1));

            tmp[p1[i % 4]] += inc + mm + t;
            tmp[p1[i % 4]] = b + ROTLEFT(tmp[p1[i % 4]], s);
        }

        hash += tmp;
    }

    write(1, "\n", 1);
    printf("off=%d len=%d new_len=%d\n", off, len, new_len);
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[0];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[1];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[2];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);

    buf = (unsigned char *) &hash[3];
    for (char i = 7; i >= 0; i--) {
        char a = (buf[i / 2] >> (4 * (i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }
    write(1, "\n", 1);
    write(1, "\n", 1);

    printf("%d\n", (int) hash[0]);
    printf("%d\n", (int) hash[1]);
    printf("%d\n", (int) hash[2]);
    printf("%d\n", (int) hash[3]);
    write(1, "\n", 1);

    unsigned int *m = (unsigned int *) &data[off];

    v4si tmp = hash;

    const char p1[] = {0, 3, 2, 1};
    const char mmstart[] = {0, 1, 5, 0};
    const char mmstep[] = {1, 5, 3, 7};
    const char ss[] = {7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21};
    for (int i = 0; i < 64; ++i) {
        unsigned int inc;
        unsigned int b = tmp[p1[(i + 3) % 4]];
        unsigned int c = tmp[p1[(i + 2) % 4]];
        unsigned int d = tmp[p1[(i + 1) % 4]];
        switch (i / 16) {
            case 0:
                inc = F(b, c, d);
                break;
            case 1:
                inc = G(b, c, d);
                break;
            case 2:
                inc = H(b, c, d);
                break;
            case 3:
                inc = I(b, c, d);
                break;
        }

        unsigned int mm = m[(mmstart[i / 16] + (i % 16) * mmstep[i / 16]) % 16];
        unsigned int s = ss[(i / 16) * 4 + (i % 4)];
        unsigned int t = (unsigned int) ((unsigned long long) 4294967296 * fsin_my(i + 1));

        tmp[p1[i % 4]] += inc + mm + t;
        tmp[p1[i % 4]] = b + ROTLEFT(tmp[p1[i % 4]], s);
    }

    hash += tmp;

    buf = (unsigned char *) &hash[0];
    for (unsigned char i = 0; i < 32; i++) {
        char a = (buf[i / 2] >> (4 * (1 - i % 2))) & 0xF;
        char c = a >= 10 ? 'a' + (a - 10) : '0' + a;
        write(1, &c, 1);
    }

    write(1, "\n", 1);

    exit(0);
}



