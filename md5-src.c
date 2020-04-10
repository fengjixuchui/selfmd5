
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

/*********************** FUNCTION DEFINITIONS ***********************/
void md5_compress(unsigned int *input, unsigned int *m) {

    unsigned int tmp[4];

    tmp[0] = input[0];
    tmp[1] = input[1];
    tmp[2] = input[2];
    tmp[3] = input[3];

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

    input[0] += tmp[0];
    input[1] += tmp[1];
    input[2] += tmp[2];
    input[3] += tmp[3];
}

