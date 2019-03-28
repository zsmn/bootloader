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

dica0 db "  ESTADO  ", 13
dica1 db "  LEGUMES ", 13
dica2 db "LAVANDERIA", 13
dica3 db "   LEITE  ", 13
dica4 db "MOVEL     ", 13
dica5 db " PARECIDO ", 13
dica6 db "  NHECONH ", 13
dica7 db "  NHECONH ", 13
dica8 db "  NHECONH ", 13
dica9 db "  NHECONH ", 13

dica_text db "DICA SOBRE A PALAVRA", 13

lastc_text db "Letra digitada: ", 13
vidas_text db "Vidas restantes: ", 13
qt_vidas db "5", 13

qt_vidas_aux db "5"

random_chosen db 0

start:
	xor ax, ax
	mov ds, ax

	mov byte[qt_vidas], '5'

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
	call draw_dica
	call draw_lastc
	call draw_life
	call esperarCaracteres

	jmp exit

draw_dica:
	mov ah, 2
	mov bh, 0
	mov dl, 27
	mov dh, 2
	int 10h
	call printDelayStr

	mov si, dica_text
	mov ah, 2
	mov bh, 0
	mov dl, 19
	int 10h
	call printDelayStr

draw_lastc:
	mov ah, 02h
	mov bh, 00h
	mov dh, 25
	mov dl, 21
	int 10h
	mov si, lastc_text
	call printStr
	ret

draw_life:
	cmp byte[qt_vidas], '0'
	je menu
	mov ah, 02h
	mov bh, 00h
	mov dh, 28
	mov dl, 21
	int 10h
	mov si, vidas_text
	call printStr
	mov si, qt_vidas
	call printStr
	ret

getchar:
    mov ah, 0
    int 16h
    ret

putchar:
    mov ah, 0xe
	mov bx, 0x7
	mov bh, 0
	int 10h
	ret

esperarCaracteres:
	call getchar
	cmp al, 0x0d
	je start

	mov ah, 02h
	mov bh, 00h
	mov dh, 25
	mov dl, 52
	int 10h
	call putchar
	sub byte[qt_vidas], 1
	call draw_life

	jmp esperarCaracteres

printCommand: ;printa o que está em al
	mov ah, 0xe
	mov bx, 0x7
	mov bh, 0
	int 10h
ret

printStr:
	lodsb
	cmp al, 13
	je .bixinha2

	call printCommand
	mov al, ' ' ; move um espaço para printar a palavra separada por espaços
	call printCommand

	jmp printStr

	.bixinha2:
		ret

printDelayStr:
	lodsb
	cmp al, 13
	je .bixinha

	call printCommand
	mov al, ' ' ; move um espaço para printar a palavra separada por espaços
	call printCommand

	call delay

	jmp printDelayStr

	.bixinha:
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
        mov AH, 00h  ; interru	pts to get system time        
        int 1AH      ; CX:DX now hold number of clock ticks since midnight      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; here dx contains the remainder of the division - from 0 to 9

        ;add  dl, '0'  ; to ascii from '0' to '9'
		mov byte[random_chosen], dl
ret

move_random:
	cmp byte[random_chosen], 0
	je .sub0
	cmp byte[random_chosen], 1
	je .sub1
	cmp byte[random_chosen], 2
	je .sub2
	cmp byte[random_chosen], 3
	je .sub3
	cmp byte[random_chosen], 4
	je .sub4
	cmp byte[random_chosen], 5
	je .sub5
	cmp byte[random_chosen], 6
	je .sub6
	cmp byte[random_chosen], 7
	je .sub7
	cmp byte[random_chosen], 8
	je .sub8
	cmp byte[random_chosen], 9
	je .sub9

ret
	.sub0:
		mov si, dica0
		ret
	.sub1:
		mov si, dica1
		ret
	.sub2:
		mov si, dica2
		ret
	.sub3:
		mov si, dica3
		ret
	.sub4:
		mov si, dica4
		ret
	.sub5:
		mov si, dica5
		ret
	.sub6:
		mov si, dica6
		ret
	.sub7:
		mov si, dica7
		ret
	.sub8:
		mov si, dica8
		ret
	.sub9:
		mov si, dica9
		ret 
ret

menu:
;Setando a posição do disco onde kernel.asm foi armazenado(ES:BX = [0x7E00:0x0])
	mov ax,0x7E0	;0x7E0<<1 + 0 = 0x7E00
	mov es,ax
	xor bx,bx		;Zerando o offset

;Setando a posição da Ram onde o menu será lido
	mov ah, 0x02	;comando de ler setor do disco
	mov al,4		;quantidade de blocos ocupados pelo menu
	mov dl,0		;drive floppy

;Usaremos as seguintes posições na memoria:
	mov ch,0		;trilha 0
	mov cl,3		;setor 3
	mov dh,0		;cabeca 0
	int 13h
	jc menu	;em caso de erro, tenta de novo

break:	
	jmp 0x7e00		;Pula para a posição carregada

exit:

