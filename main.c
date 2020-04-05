#include "md5.h"
#include<stdio.h>
#include<stdlib.h>

int dododo(const char * name){
    FILE *ptr_myfile = fopen(name, "rb");
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
    int i = 0;
    for (i = 0; i < 16; i++) {
        sprintf(out + (i * 2), "%02x", buf[i]);
    }

    printf("%s\n", out);
}

int main(int argc, const char *argv[]) {
    dododo(argv[0]);
    return 0;
}
