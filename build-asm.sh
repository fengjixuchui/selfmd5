gcc -Os -fdata-sections -ffunction-sections -flto  md5.s main.s -o selfmd5 -Wl,--gc-sections -Wl,--strip-all -nostdlib -nostdinc
strip -s selfmd5 
sstrip selfmd5
