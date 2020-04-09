# selfmd5
计算自身md5的最小程序，最终大小约992字节.
```
# ll selfmd5 
-rwxr-xr-x 1 root root 992 4月   9 09:52 selfmd5
```

# 编译
* 先写c，然后编译成汇编
```
gcc -S -o main.s main-src.c -fno-asynchronous-unwind-tables -Os
gcc -S -o md5.s md5-src.c -fno-asynchronous-unwind-tables -Os
```
* 然后把main.s的依赖libc的部分干掉，换成直接syscall
* 精简两个.s的无用代码，编译，并sstrip
```
gcc -Os -fdata-sections -ffunction-sections -flto md5.s main.s -o selfmd5 -Wl,--gc-sections -Wl,--strip-all -nostdlib -nostdinc
strip -s selfmd5 
sstrip selfmd5
```
