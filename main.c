#include "md5.h"
#include<stdio.h>
#include<stdlib.h>

int main(int argc, const char *argv[]) {
    FILE *ptr_myfile = fopen(argv[0], "rb");
    if (!ptr_myfile) {
        printf("Unable to open file!");
        return 1;
    }

    char *buffer = (char *) malloc(1024 * 1024);
    int n = fread(buffer, 1, 1024 * 1024, ptr_myfile);

    unsigned char buf[16] = {0};

    MD5_CTX ctx;
    md5_init(&ctx);
    md5_update(&ctx, (const BYTE *)(buffer), n);
    md5_final(&ctx, (BYTE *)(buf));

    char out[32] = {0};
    for (int i = 0; i < 16; i++) {
        sprintf(out + (i * 2), "%02x", buf[i]);
    }

    printf("%s\n", out);
    return 0;
}