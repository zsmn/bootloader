;Jogo

org 0x8600
jmp 0x0000:start

debug db "fudeu suruba", 13

palavras0 db "FEDERACAO", 13
palavras1 db "RABANETE", 13
palavras2 db "ROUPA", 13
palavras3 db "CONDENSADO", 13
palavras4 db "ESTANTE", 13
palavras5 db "SEMELHANTE", 13
palavras6 db "p6", 13
palavras7 db "p7", 13
palavras8 db "p8", 13
palavras9 db "p9", 13

dica0 db "ESTADO", 13
dica1 db "LEGUMES", 13
dica2 db "LAVANDERIA", 13
dica3 db "LEITE", 13
dica4 db "MOVEL", 13
dica5 db "PARECIDO", 13
dica6 db "d6", 13
dica7 db "d7", 13
dica8 db "d8", 13
dica9 db "d9", 13


start:

	xor ax, ax
	mov ds, ax

	;Modo vídeo.
	mov ah, 0
	mov al, 12h
	int 10h

	mov ah, 0xb
	mov bh, 0
	mov bl, 0
	int 10h

	call random_number
	call move_random
	call printDelayStr

	jmp exit

printDelayStr:
	lodsb

	mov ah, 0xe
	mov bx, 0x7
	mov bh, 0
	int 10h

	call delay

	cmp al, 13
	jne printDelayStr
ret

delay:
	mov bp, 350
	mov dx, 350
	delay2:
		dec bp
		nop
		jnz delay2
	dec dx
	jnz delay2

ret

random_number:
	random_start:
        mov AH, 00h  ; interrupts to get system time        
        int 1AH      ; CX:DX now hold number of clock ticks since midnight      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; here dx contains the remainder of the division - from 0 to 9

        ;add  dl, '0'  ; to ascii from '0' to '9'
ret

move_random:
	mov si, debug

	cmp dl, 0
	je .sub0
	cmp dl, 1
	je .sub1
	cmp dl, 2
	je .sub2
	cmp dl, 3
	je .sub3
	cmp dl, 4
	je .sub4
	cmp dl, 5
	je .sub5
	cmp dl, 6
	je .sub6
	cmp dl, 7
	je .sub7
	cmp dl, 8
	je .sub8
	cmp dl, 9
	je .sub9

ret
	.sub0:
		mov si, palavras0
		ret
	.sub1:
		mov si, palavras1
		ret
	.sub2:
		mov si, palavras2
		ret
	.sub3:
		mov si, palavras3
		ret
	.sub4:
		mov si, palavras4
		ret
	.sub5:
		mov si, palavras5
		ret
	.sub6:
		mov si, palavras6
		ret
	.sub7:
		mov si, palavras7
		ret
	.sub8:
		mov si, palavras8
		ret
	.sub9:
		mov si, palavras9
	ret 
ret

exit:

