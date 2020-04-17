./elftoc selfmd5 > selfmd5.h
g++ -g -o trim-elf trim-src.c && ./trim-elf
