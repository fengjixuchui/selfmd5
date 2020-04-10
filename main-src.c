#include <fcntl.h>
#include <unistd.h>

#define BLOCK_LEN 64  // In bytes
#define STATE_LEN 4  // In words

extern void md5_compress(unsigned int state[static STATE_LEN], const unsigned char block[static BLOCK_LEN]);

#define LENGTH_SIZE 8  // In bytes

int main(int argc, char *argv[]) {
    int filedesc = open(argv[0], O_RDONLY, 400);

    char data[5 * 1024] = {0};
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
        md5_compress(hash, &data[off]);
    }

    unsigned char *buf = (unsigned char *) &hash;
    int i;
    for (i = 0; i < 16; i++) {
        char tmp[3] = {0};
        int a = (buf[i] >> 4) & 0xF;
        int b = (buf[i]) & 0xF;
        tmp[0] = a >= 10 ? 'a' + (a - 10) : '0' + a;
        tmp[1] = b >= 10 ? 'a' + (b - 10) : '0' + b;
        write(1, tmp, 2);
    }

    exit(0);
}

