[SECTION .text]

[BITS 32]

global kprintf
;===============================================
; void kprintf(u16 disp_pos, const char *format, ...)
; 参数说明：
; disp_pos: 开始打印的位置，0为0行0列，1为0行1列，80位1行0列
; format: 需要格式化输出的字符串，默认输出的字符颜色为黑底白字
; %c: 输出下一个参数的字符信息（保证参数范围在0~127），输出完打印的位置往下移动一位
; %b: 更改之后输出的字符的背景色（保证参数范围在0~15）
; %f: 更改之后输出的字符的前景色（保证参数范围在0~15）
; %s(提高内容): 参考inc/terminal.h，传进来的是一个结构体，结构体参数足够明确不复赘述，
; 输出是独立的，输出完打印的位置不会往下移动一位，不会影响接下来%c的输出的颜色
; 其余字符：按照字符输出（保证字符里不会有%，\n等奇奇怪怪的字符，都是常见字符，%后面必会跟上述三个参数之一），输出完打印的位置往下移动一位
kprintf:
	jmp $
        push ebp
	mov  ebp,esp
	pusha
	mov esi,[ebp+8]
	mov ebx,[ebp+12]
	mov ah,00fh
	mov edi,0
	mov edx,0
	.4:
	mov al,[ebx+edi]
	cmp al,0
	jz .6     ;字符串结束
	cmp al,'%';格式控制符号
	jz .5  
	sal esi,1
	mov [gs:esi],ax
	sar esi,1
	add esi,1
	add edi,1
	jmp .4
	.6
	popa
	mov esp,ebp
	pop ebp
	ret
	.5
	add edi,1
	mov al,[ebx+edi]
	cmp al,'c'
	jz .1
	cmp al,'f'
	jz .2
	cmp al,'b'
	jz .3
	cmp al,'s'
	jz .7
	.1
	mov al,[ebp+4*edx+16]
	sal esi,1
	mov [gs:esi],ax
	sar esi,1
	add esi,1
	add edi,1;显存位置加一
	add edx,1;读取第几个参数加一
	jmp .4
	.2:
	mov al,[ebp+4*edx+16]
	and ah,00fh
	add ah,ah
	add edi,1
	add edx,1
	jmp .4
	.3
	mov al,[ebp+4*edx+16]
	and ah,00fh
	shl al,4
	add ah,al
	add edi,1
	add edx,1
	jmp .4
	.7
	push eax
	mov al,[ebp+4*edx+16]
	mov ah,al
	mov al,[ebp+4*edx+17]
	shl al,4
	add ah,al
	mov al,[ebp+4*edx+18]
	mov ecx,[ebp+4*edx+20]
	sal ecx,1
	mov [gs:ecx],ax
	add edi,1
	add edx,2
	pop eax
	jmp .4