#include "selfmd5.h"
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

//typedef struct {
//    unsigned char e_ident[EI_NIDENT];     /* Magic number and other info */
//    Elf64_Half e_type;                 /* Object file type */
//    Elf64_Half e_machine;              /* Architecture */
//    Elf64_Word e_version;              /* Object file version */
//    Elf64_Addr e_entry;                /* Entry point virtual address */
//    Elf64_Off e_phoff;                /* Program header table file offset */
//    Elf64_Off e_shoff;                /* Section header table file offset */
//    Elf64_Word e_flags;                /* Processor-specific flags */
//    Elf64_Half e_ehsize;               /* ELF header size in bytes */
//    Elf64_Half e_phentsize;            /* Program header table entry size */
//    Elf64_Half e_phnum;                /* Program header table entry count */
//    Elf64_Half e_shentsize;            /* Section header table entry size */
//    Elf64_Half e_shnum;                /* Section header table entry count */
//    Elf64_Half e_shstrndx;             /* Section header string table index */
//} Elf64_Ehdr;

//typedef struct
//{
//    Elf64_Word    p_type;                 /* Segment type */
//    Elf64_Word    p_flags;                /* Segment flags */
//    Elf64_Off     p_offset;               /* Segment file offset */
//    Elf64_Addr    p_vaddr;                /* Segment virtual address */
//    Elf64_Addr    p_paddr;                /* Segment physical address */
//    Elf64_Xword   p_filesz;               /* Segment size in file */
//    Elf64_Xword   p_memsz;                /* Segment size in memory */
//    Elf64_Xword   p_align;                /* Segment alignment */
//} Elf64_Phdr;

int main(int argc, char *argv[]) {

    size_t size = sizeof(foo);// - sizeof(foo._end);

    for (int i = 8; i < 16; ++i) {
        foo.ehdr.e_ident[i] = 0xFF;
    }
    foo.ehdr.e_version = 0xFFFFFFFF;
    foo.ehdr.e_shoff = 0xFFFFFFFFFFFFFFFF;
    foo.ehdr.e_flags = 0xFFFFFFFF;

    printf("text offset %d\n", offsetof(elf, text));

    foo.ehdr.e_entry = ADDR_TEXT + offsetof(elf, ehdr) + 8;
    printf("new entry %d\n", offsetof(elf, ehdr) + 8);

    // copy 4 bytes
    foo.ehdr.e_ident[8] = foo.text[0];
    foo.ehdr.e_ident[9] = foo.text[1];
    foo.ehdr.e_ident[10] = foo.text[2];
    foo.ehdr.e_ident[11] = foo.text[3];
    foo.ehdr.e_ident[12] = 0xEB;
    foo.ehdr.e_ident[13] = (offsetof(elf, ehdr) + offsetof(Elf64_Ehdr, e_version)) - (offsetof(elf, ehdr) + 14);
    printf("jmp %d\n", foo.ehdr.e_ident[13]);

    for (int i = 0; i < sizeof(foo.text) - 4; ++i) {
        foo.text[i] = foo.text[i + 4];
    }
    size -= 4;

    // copy 2 bytes
    ((char *) (&foo.ehdr.e_version))[0] = foo.text[0];
    ((char *) (&foo.ehdr.e_version))[1] = foo.text[1];
    ((char *) (&foo.ehdr.e_version))[2] = 0xEB;
    ((char *) (&foo.ehdr.e_version))[3] =
            (offsetof(elf, ehdr) + offsetof(Elf64_Ehdr, e_shoff)) -
            (offsetof(elf, ehdr) + offsetof(Elf64_Ehdr, e_version) + 4);

    for (int i = 0; i < sizeof(foo.text) - 2; ++i) {
        foo.text[i] = foo.text[i + 2];
    }
    size -= 2;

    // copy 8 bytes
    memcpy(&foo.ehdr.e_shoff, &foo.text[0], 8);
    ((char *) (&foo.ehdr.e_shoff))[8] = 0xEB;
    ((char *) (&foo.ehdr.e_shoff))[9] = offsetof(elf, text) -
                                         (offsetof(elf, ehdr) + offsetof(Elf64_Ehdr, e_shoff) + 10);
    printf("jmp %d\n", ((char *) (&foo.ehdr.e_shoff))[9]);

    for (int i = 0; i < sizeof(foo.text) - 8; ++i) {
        foo.text[i] = foo.text[i + 8];
    }
    size -= 8;

    // output
    FILE *fd = fopen("selfmd5-test", "wb");
    size_t n = fwrite(&foo, size, 1, fd);
    printf("%d %d\n", size, n);
    return 0;
}
