#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

#define BLOCK_LEN 64  // In bytes

/****************************** MACROS ******************************/
#define ROTLEFT(a, b)  ((a << b) | (a >> (32 - b)))

#define FF(x, y, z)  ((x & y) | (~x & z))

#define GG(x, y, z)  ((x & z) | (y & ~z))

#define HH(x, y, z) (x ^ y ^ z)

#define II(x, y, z)  (y ^ (x | ~z))

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
    char data[700];
    short len = read(open(argv[0], 0, 0), data, sizeof(data));

    unsigned int hash[] = {(unsigned int) (0x67452301), (unsigned int) (0xEFCDAB89), (unsigned int) (0x98BADCFE),
                           (unsigned int) (0x10325476)};

    const short new_len = 568;
    data[len] = 0x80;
    *(unsigned long long *) (data + new_len) = len << 3;

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

    unsigned char *buf = (unsigned char *) &hash[0];
    for (unsigned char i = 0; i < 32; i++) {
        char a = (buf[i / 2] >> (4 * (1 - i % 2))) & 0xF;
        char c = a >= 10 ? a + ('a' - 10) : a + '0';
        write(1, &c, 1);
    }

    exit(0);
}
