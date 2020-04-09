#include <fcntl.h>
#include <unistd.h>

#define BLOCK_LEN 64  // In bytes
#define STATE_LEN 4  // In words

extern void md5_compress(unsigned int state[static STATE_LEN], const unsigned char block[static BLOCK_LEN]);

#define LENGTH_SIZE 8  // In bytes

int main(int argc, char* argv[]) {
    int filedesc = open(argv[0], O_RDONLY, 400);

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

