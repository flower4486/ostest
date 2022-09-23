    org    0x7c00            ; 告诉编译器程序加载到7c00处
    mov    ax, cs
    mov    ds, ax
    mov    es, ax
    call   DispStr           ; 调用显示字符串例程
    jmp    $                 ; 无限循环
DispStr:
   ;清除屏幕上所有字符.
   mov ax,00600h       ;
   mov bh,00h
   mov cx,00000h
   mov dx,02060h
   int  10h
    ;
    mov    ax, BootMessage
    mov    bp, ax            ; ES:BP = 串地址
    mov    cx, 4            ; CX = 串长度
    mov    ax, 01301h        ; AH = 13,  AL = 01h
    mov    bx, 00f9h         ; 页号为0(BH = 0) 
    mov    dx, 01326
    int    10h               ; 10h 号中断
    ;
    mov ah,02h
    mov bh,00h
   mov  dx,00000h
    int 10h
   
    ret
BootMessage:             db    "NWPU"
times      510-($-$$)    db    0    ; 填充剩下的空间，使生成的二进制代码恰好为512字节
dw         0xaa55                   ; 结束标志
