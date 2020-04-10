#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

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

int main(int argc, char *argv[]) {
    int filedesc = open(argv[0], O_RDONLY, 400);

    char data[1024] = {0};
    int len = read(filedesc, data, sizeof(data));

    unsigned int hash[STATE_LEN];

    hash[0] = (unsigned int) (0x67452301);
    hash[1] = (unsigned int) (0xEFCDAB89);
    hash[2] = (unsigned int) (0x98BADCFE);
    hash[3] = (unsigned int) (0x10325476);
    int new_len = ((((len + 8) / 64) + 1) * 64) - 8;
    data[len] = 0x80;
    *(unsigned long long *) (data + new_len) = len << 3;
    int off = 0;
    for (off = 0; off < new_len; off += BLOCK_LEN) {
        unsigned int *m = (unsigned int *) &data[off];

        unsigned int tmp[4];

        tmp[0] = hash[0];
        tmp[1] = hash[1];
        tmp[2] = hash[2];
        tmp[3] = hash[3];

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

        hash[0] += tmp[0];
        hash[1] += tmp[1];
        hash[2] += tmp[2];
        hash[3] += tmp[3];
    }

    unsigned char *buf = (unsigned char *) &hash;
    int i;
    for (i = 0; i < 16; i++) {
        char tmp[2];
        int a = (buf[i] >> 4) & 0xF;
        int b = (buf[i]) & 0xF;
        tmp[0] = a >= 10 ? 'a' + (a - 10) : '0' + a;
        tmp[1] = b >= 10 ? 'a' + (b - 10) : '0' + b;
        write(1, tmp, 2);
    }

    exit(0);
}

