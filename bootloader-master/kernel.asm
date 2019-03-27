;Jogo

org 0x8600
jmp 0x0000:start

palavras0 db "FEDERACAO"
palavras1 db "RABANETE"
palavras2 db "ROUPA"
palavras3 db "CONDENSADO"
palavras4 db "ESTANTE"
palavras5 db "SEMELHANTE"
palavras6 db ""
palavras7 db ""
palavras8 db ""
palavras9 db ""

dica0 db "ESTADO"
dica1 db "LEGUMES"
dica2 db "LAVANDERIA"
dica3 db "LEITE"
dica4 db "MOVEL"
dica5 db "PARECIDO"
dica6 db ""
dica7 db ""
dica8 db ""
dica9 db ""


start:

	xor ax, ax
	mov ds, ax

	;Modo vídeo.
	mov ah, 0
	mov al, 12h
	int 10h

	mov ah, 0xb
	mov bh, 0
	mov bl, 7
	int 10h

	call random_number
	call move_random

random_number:
	random_start:
        mov AH, 00h  ; interrupts to get system time        
        int 1AH      ; CX:DX now hold number of clock ticks since midnight      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; here dx contains the remainder of the division - from 0 to 9

        add  dl, '0'  ; to ascii from '0' to '9'
ret

move_random:
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

	.sub0:
		mov si, palavras0
	.sub1:
		mov si, palavras1
	.sub2:
		mov si, palavras2
	.sub3:
		mov si, palavras3
	.sub4:
		mov si, palavras4
	.sub5:
		mov si, palavras5
	.sub6:
		mov si, palavras6
	.sub7:
		mov si, palavras7
	.sub8:
		mov si, palavras8
	.sub9:
		mov si, palavras9

exit:
