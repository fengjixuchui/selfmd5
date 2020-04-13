# selfmd5
计算自身md5的最小程序，最终大小约676字节.
```
# ll selfmd5 
-rwxr-xr-x 1 root root 676 4月   9 09:52 selfmd5
```

# 编译
* 下载最新gcc9.3，先写c，然后编译成汇编main-src.s
```
gcc -S main-src.c  -Os -mavx -msse -mavx2 -ffast-math -fsingle-precision-constant -fno-verbose-asm -fno-unroll-loops -fno-asynchronous-unwind-tables
```
* 然后把main.s的依赖libc的部分干掉，换成直接syscall
* 精简main-src.s的无用代码，编译，并sstrip
```
./build-asm.sh
```
