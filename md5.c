/*********************************************************************
* Filename:   md5.c
* Author:     Brad Conte (brad AT bradconte.com)
* Copyright:
* Disclaimer: This code is presented "as is" without any guarantees.
* Details:    Implementation of the MD5 hashing algorithm.
				  Algorithm specification can be found here:
				   * http://tools.ietf.org/html/rfc1321
				  This implementation uses little endian byte order.
*********************************************************************/

/*************************** HEADER FILES ***************************/

#include "md5.h"

/****************************** MACROS ******************************/
WORD ROTLEFT(WORD a, WORD b) { return ((a << b) | (a >> (32 - b))); }

WORD F(WORD x, WORD y, WORD z) { return ((x & y) | (~x & z)); }

WORD G(WORD x, WORD y, WORD z) { return ((x & z) | (y & ~z)); }

WORD H(WORD x, WORD y, WORD z) { return (x ^ y ^ z); }

WORD I(WORD x, WORD y, WORD z) { return (y ^ (x | ~z)); }

void FF(WORD *a, WORD b, WORD c, WORD d, WORD m, WORD s, WORD t) {
    *a += F(b, c, d) + m + t;
    *a = b + ROTLEFT(*a, s);
}

void GG(WORD *a, WORD b, WORD c, WORD d, WORD m, WORD s, WORD t) {
    *a += G(b, c, d) + m + t;
    *a = b + ROTLEFT(*a, s);
}

void HH(WORD *a, WORD b, WORD c, WORD d, WORD m, WORD s, WORD t) {
    *a += H(b, c, d) + m + t;
    *a = b + ROTLEFT(*a, s);
}

void II(WORD *a, WORD b, WORD c, WORD d, WORD m, WORD s, WORD t) {
    *a += I(b, c, d) + m + t;
    *a = b + ROTLEFT(*a, s);
}

/*********************** FUNCTION DEFINITIONS ***********************/
void md5_transform(MD5_CTX *ctx, const BYTE data[]) {

    WORD tmp[4], m[16], i, j;

    // MD5 specifies big endian byte order, but this implementation assumes a little
    // endian byte order CPU. Reverse all the bytes upon input, and re-reverse them
    // on output (in md5_final()).
    for (i = 0, j = 0; i < 16; ++i, j += 4)
        m[i] = (data[j]) + (data[j + 1] << 8) + (data[j + 2] << 16) + (data[j + 3] << 24);

    tmp[0] = ctx->state[0];
    tmp[1] = ctx->state[1];
    tmp[2] = ctx->state[2];
    tmp[3] = ctx->state[3];

    typedef void (*FuckFunc)(WORD *a, WORD b, WORD c, WORD d, WORD m, WORD s, WORD t);
    FuckFunc ff[] = {&FF, &GG, &HH, &II};

    const char p1[] = {0, 3, 2, 1};
    const char p2[] = {1, 0, 3, 2};
    const char p3[] = {2, 1, 0, 3};
    const char p4[] = {3, 2, 1, 0};
    const char mm[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 6, 11, 0, 5, 10, 15, 4, 9, 14, 3, 8, 13,
                       2, 7, 12, 5, 8, 11, 14, 1, 4, 7, 10, 13, 0, 3, 6, 9, 12, 15, 2, 0, 7, 14, 5, 12, 3, 10, 1, 8, 15,
                       6, 13, 4, 11, 2, 9};
    const char ss[] = {7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14,
                       20, 5, 9, 14, 20, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 6, 10, 15, 21, 6,
                       10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21};
    const WORD tt[] = {0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
                       0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be, 0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
                       0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa, 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
                       0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed, 0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
                       0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c, 0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
                       0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
                       0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
                       0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1, 0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391};
    for (int i = 0; i < 64; ++i) {
        FuckFunc f = ff[i / 16];
        f(&tmp[p1[i % 4]], tmp[p2[i % 4]], tmp[p3[i % 4]], tmp[p4[i % 4]], m[mm[i]], ss[i], tt[i]);
    }

    ctx->state[0] += tmp[0];
    ctx->state[1] += tmp[1];
    ctx->state[2] += tmp[2];
    ctx->state[3] += tmp[3];
}

void md5_init(MD5_CTX *ctx) {
    ctx->datalen = 0;
    ctx->bitlen = 0;
    ctx->state[0] = 0x67452301;
    ctx->state[1] = 0xEFCDAB89;
    ctx->state[2] = 0x98BADCFE;
    ctx->state[3] = 0x10325476;
}

void md5_update(MD5_CTX *ctx, const BYTE data[], int len) {
    int i;

    for (i = 0; i < len; ++i) {
        ctx->data[ctx->datalen] = data[i];
        ctx->datalen++;
        if (ctx->datalen == 64) {
            md5_transform(ctx, ctx->data);
            ctx->bitlen += 512;
            ctx->datalen = 0;
        }
    }
}

void md5_final(MD5_CTX *ctx, BYTE hash[]) {
    int i;

    i = ctx->datalen;

    // Pad whatever data is left in the buffer.
    if (ctx->datalen < 56) {
        ctx->data[i++] = 0x80;
        while (i < 56)
            ctx->data[i++] = 0x00;
    } else if (ctx->datalen >= 56) {
        ctx->data[i++] = 0x80;
        while (i < 64)
            ctx->data[i++] = 0x00;
        md5_transform(ctx, ctx->data);
        int k;
        for (k = 0; k < 56; ++k) {
            ctx->data[k] = 0;
        }
    }

    // Append to the padding the total message's length in bits and transform.
    ctx->bitlen += ctx->datalen * 8;
    ctx->data[56] = ctx->bitlen;
    ctx->data[57] = ctx->bitlen >> 8;
    ctx->data[58] = ctx->bitlen >> 16;
    ctx->data[59] = ctx->bitlen >> 24;
    ctx->data[60] = ctx->bitlen >> 32;
    ctx->data[61] = ctx->bitlen >> 40;
    ctx->data[62] = ctx->bitlen >> 48;
    ctx->data[63] = ctx->bitlen >> 56;
    md5_transform(ctx, ctx->data);

    // Since this implementation uses little endian byte ordering and MD uses big endian,
    // reverse all the bytes when copying the final state to the output hash.
    for (i = 0; i < 4; ++i) {
        hash[i] = (ctx->state[0] >> (i * 8)) & 0x000000ff;
        hash[i + 4] = (ctx->state[1] >> (i * 8)) & 0x000000ff;
        hash[i + 8] = (ctx->state[2] >> (i * 8)) & 0x000000ff;
        hash[i + 12] = (ctx->state[3] >> (i * 8)) & 0x000000ff;
    }
}
