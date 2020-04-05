gcc -Os -fdata-sections -ffunction-sections -flto  main.c md5.c -o selfmd5 -Wl,--gc-sections -Wl,--strip-all
