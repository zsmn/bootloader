;Jogo

org 0x8600
jmp 0x0000:start

freq_char times 26 db 0

debug db "fudeu suruba", 13

palavras0 db "FEDERACAO", 13, 0
palavras1 db "RABANETE", 13, 0
palavras2 db "ROUPA", 13, 0
palavras3 db "CONDENSADO", 13, 0
palavras4 db "ESTANTE", 13, 0
palavras5 db "SEMELHANTE", 13, 0
palavras6 db "VELOCIMETRO", 13, 0
palavras7 db "CORTINA", 13, 0
palavras8 db "LAMINA", 13, 0
palavras9 db "PLANTA", 13, 0

preencher0 db "  _ _ _ _ _ _ _ _ _  ", 13, 0
preencher1 db "   _ _ _ _ _ _ _ _   ", 13, 0
preencher2 db "      _ _ _ _ _      ", 13, 0 
preencher3 db " _ _ _ _ _ _ _ _ _ _ ", 13, 0 
preencher4 db "    _ _ _ _ _ _ _    ", 13, 0 
preencher5 db " _ _ _ _ _ _ _ _ _ _ ", 13, 0 
preencher6 db "_ _ _ _ _ _ _ _ _ _ _", 13, 0 
preencher7 db "    _ _ _ _ _ _ _    ", 13, 0 
preencher8 db "     _ _ _ _ _ _     ", 13, 0 
preencher9 db "     _ _ _ _ _ _     ", 13, 0 

dica0 db "  ESTADO        ", 13, 0 
dica1 db " LEGUMES        ", 13, 0 
dica2 db " LAVANDERIA     ", 13, 0 
dica3 db "   LEITE        ", 13, 0 
dica4 db "    MOVEL       ", 13, 0 
dica5 db "  PARECIDO      ", 13, 0 
dica6 db "PARTE DO CARRO  ", 13, 0 
dica7 db "   JANELA       ", 13, 0 
dica8 db "   ROSTO        ", 13, 0 
dica9 db "    VASO        ", 13, 0 

dica_text db "DICA SOBRE A PALAVRA", 13, 0 
lastc_text db "Letra digitada: ", 13, 0 
vidas_text db "Vidas restantes: ", 13, 0 

qt_vidas db "5", 13
qt_vidas_aux db "5"

last_char db 0
random_chosen db 0

flag db 0
qt_caracteres db 0
contador db 0
nletr db 0

la db 0
lb db 0
lc db 0
ld db 0
le db 0
lf db 0
lg db 0
lh db 0
li db 0
lj db 0
lk db 0
ll db 0
lm db 0
ln db 0
lo db 0
lp db 0
lq db 0
lr db 0
ls db 0
lt db 0
lu db 0
lv db 0
lw db 0
lx db 0
ly db 0
lz db 0


barra0	db  "_____",13,0
barra1	db  "|   |",13,0
barra6	db  "|   O",13,0
barra8	db  "|  /|\",13,0	
barra10	db  "|  / \",13,0	
barra5	db "_|_",13,0
	 

barra2  db"|",13,0	 
barra3  db"|",13,0		
barra4  db"|",13,0
barra7  db"|   |",13,0
barra9  db"|  /",13,0		
	

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
    call draw_hang
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

printstring:
    .loop:
        lodsb ; bota o caractere em AL
        cmp al, 0 ; se tiver chegado ao final da string acabou
        je .endloop

        mov ah, 0xe
        mov bx, 0x7
        int 10h
        jmp .loop
    .endloop:
        ret

printstringforca:
    .loop:
        lodsb ; bota o caractere em AL
        
        mov ah, 02h
		mov bh, 00h
		mov dh, 19
		add dl, 2
		int 10h
		

		cmp al, 0 ; se tiver chegado ao final da string acabou
        je .endloop
		cmp al, byte[last_char]
        je .printar
		
		jmp .loop
		.printar:
			call putchar
			mov byte[flag], 1
			add byte[contador], 1
            cmp al, 'A'
            je .certezaa
            cmp al, 'B'
            je .certezab
            cmp al, 'C'
            je .certezac
            cmp al, 'D'
            je .certezad
            cmp al, 'E'
            je .certezae
            cmp al, 'F'
            je .certezaf
            cmp al, 'G'
            je .certezag
            cmp al, 'H'
            je .certezah
            cmp al, 'I'
            je .certezai
            cmp al, 'J'
            je .certezaj
            cmp al, 'K'
            je .certezak
            cmp al, 'L'
            je .certezal
            cmp al, 'M'
            je .certezam
            cmp al, 'N'
            je .certezan
            cmp al, 'O'
            je .certezao
            cmp al, 'P'
            je .certezap
            cmp al, 'Q'
            je .certezaq
            cmp al, 'R'
            je .certezar
            cmp al, 'S'
            je .certezas
            cmp al, 'T'
            je .certezat
            cmp al, 'U'
            je .certezau
            cmp al, 'V'
            je .certezav
            cmp al, 'W'
            je .certezaw
            cmp al, 'X'
            je .certezax
            cmp al, 'Y'
            je .certezay
            cmp al, 'Z'
            je .certezaz
            jmp .terminar;
        .certezaa:
            cmp byte[la], 1
            je .diminuas
            mov byte[la], 1
            jmp .terminar
        .certezab:
            cmp byte[lb], 1
            je .diminuas
            mov byte[lb], 1
            jmp .terminar
        .certezac:
            cmp byte[lc], 1
            je .diminuas
            mov byte[lc], 1
            jmp .terminar
        .certezad:
            cmp byte[ld], 1
            je .diminuas
            mov byte[ld], 1
            jmp .terminar
        .certezae:
            cmp byte[le], 1
            je .diminuas
            mov byte[le], 1
            jmp .terminar
        .certezaf:
            cmp byte[lf], 1
            je .diminuas
            mov byte[lf], 1
            jmp .terminar
        .certezag:
            cmp byte[lg], 1
            je .diminuas
            mov byte[lg], 1
            jmp .terminar
        .certezah:
            cmp byte[lh], 1
            je .diminuas
            mov byte[lh], 1
            jmp .terminar
        .certezai:
            cmp byte[li], 1
            je .diminuas
            mov byte[li], 1
            jmp .terminar
        .certezaj:
            cmp byte[lj], 1
            je .diminuas
            mov byte[lj], 1
            jmp .terminar
        .certezak:
            cmp byte[lk], 1
            je .diminuas
            mov byte[lk], 1
            jmp .terminar
        .certezal:
            cmp byte[ll], 1
            je .diminuas
            mov byte[ll], 1
            jmp .terminar
        .certezam:
            cmp byte[lm], 1
            je .diminuas
            mov byte[lm], 1
            jmp .terminar
        .certezan:
            cmp byte[ln], 1
            je .diminuas
            mov byte[ln], 1
            jmp .terminar
        .certezao:
            cmp byte[lo], 1
            je .diminuas
            mov byte[lo], 1
            jmp .terminar
        .certezap:
            cmp byte[lp], 1
            je .diminuas
            mov byte[lp], 1
            jmp .terminar
        .certezaq:
            cmp byte[lq], 1
            je .diminuas
            mov byte[lq], 1
            jmp .terminar
        .certezar:
            cmp byte[lr], 1
            je .diminuas
            mov byte[lr], 1
            jmp .terminar
        .certezas:
            cmp byte[ls], 1
            je .diminuas
            mov byte[ls], 1
            jmp .terminar
        .certezat:
            cmp byte[lt], 1
            je .diminuas
            mov byte[lt], 1
            jmp .terminar
        .certezau:
            cmp byte[lu], 1
            je .diminuas
            mov byte[lu], 1
            jmp .terminar
        .certezav:
            cmp byte[lv], 1
            je .diminuas
            mov byte[lv], 1
            jmp .terminar
        .certezaw:
            cmp byte[lw], 1
            je .diminuas
            mov byte[lw], 1
            jmp .terminar
        .certezax:
            cmp byte[lx], 1
            je .diminuas
            mov byte[lx], 1
            jmp .terminar
        .certezay:
            cmp byte[ly], 1
            je .diminuas
            mov byte[ly], 1
            jmp .terminar
        .certezaz:
            cmp byte[lz], 1
            je .diminuas
            mov byte[lz], 1
	        jmp .terminar
        .diminuas:
            dec byte[contador];
            jmp .terminar;
        .terminar:
        jmp .loop
    .endloop:
        ret

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
draw_hang:
    cmp byte[qt_vidas], '5'
    je d5
    cmp byte[qt_vidas], '4'
    je d4
    cmp byte[qt_vidas], '3'
    je d3
    cmp byte[qt_vidas], '2'
    je d2
    cmp byte[qt_vidas], '1'
    je d1
    cmp byte[qt_vidas], '0'
    je d0
    jmp tehan
    d5:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra2
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra3
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra4
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    jmp tehan
    d4:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra6
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra3
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra4
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    jmp tehan
    d3:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra6
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra7
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra4
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    jmp tehan
    d2:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra6
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra8
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra4
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    jmp tehan
    d1:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra6
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra8
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra9
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    jmp tehan
    d0:
    mov ah, 2;
    mov bh, 0
    mov dh, 7
    mov dl, 25
    int 10h
    mov si, barra0
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 8
    mov dl, 25
    int 10h
    mov si, barra1
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 9
    mov dl, 25
    int 10h
    mov si, barra6
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 10
    mov dl, 25
    int 10h
    mov si, barra8
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 11
    mov dl, 25
    int 10h
    mov si, barra10
    call printStr
    mov ah, 2;
    mov bh, 0
    mov dh, 12
    mov dl, 23
    int 10h
    mov si, barra5
    call printStr
    call delay
    call delay
    call delay
    call delay
    call delay
    jmp tehan
    tehan:
    ret
    ;cmp byte[qt_vidas], '0'
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

printar_Caracteres:
	mov byte[last_char], al
    mov ah, 02h
    mov bh, 00h
    mov dh, 25
    mov dl, 52
    int 10h
    call putchar
    ;funcao que vai fazer a checagem da letra com a palavra
    call checaletrapalavra
	mov ah, 02h
    mov bh, 00h
    mov dh, 19
    mov dl, 30
	int 10h
	call printstringforca
	cmp byte[flag], 1
	jne .subtrair

	mov byte[flag], 0

	ret	

    .subtrair:
		mov byte[flag], 0
		sub byte[qt_vidas], 1
        call draw_hang
   		call draw_life

ret

esperarCaracteres:
    call getchar
    cmp al, 0x0d
    je jogo
	cmp al, 'a'
	jge .tratamento

	call printar_Caracteres

    jmp esperarCaracteres

	.tratamento:
		sub al, ' '
		call printar_Caracteres
	
	xor dx, dx
	mov dl, byte[nletr]
	cmp byte[contador], dl
	jge menu 

	jmp esperarCaracteres

checaletrapalavra:
    ;o caractere pressionado vai ta armazenado no registrador al
    mov ch, al; agora o caractere pressionado vai ta em ch
    xor cx, cx
    mov cl, 0 ;vou supor q a letra nao ta presente. Se estiver, entao cl = 1
    ;Primeira coisa que devemos fazer: Identificar qual é a palavra que será usada na forca
    cmp byte[random_chosen], 0
    je .carrega0
    cmp byte[random_chosen], 1
    je .carrega1
    cmp byte[random_chosen], 2
    je .carrega2
    cmp byte[random_chosen], 3
    je .carrega3
    cmp byte[random_chosen], 4
    je .carrega4
    cmp byte[random_chosen], 5
    je .carrega5
    cmp byte[random_chosen], 6
    je .carrega6
    cmp byte[random_chosen], 7
    je .carrega7
    cmp byte[random_chosen], 8
    je .carrega8
    cmp byte[random_chosen], 9
    je .carrega9

    ret

	.carrega0:
		xor si, si
		mov si, palavras0
		mov byte[qt_caracteres], 9
        mov byte[nletr], 7 ;federacao
		ret

	.carrega1:
		xor si, si
		mov si, palavras1
		mov byte[qt_caracteres], 8
        mov byte[nletr], 6 ;
		ret

	.carrega2:
		xor si, si
		mov si, palavras2
		mov byte[qt_caracteres], 5
        mov byte[nletr], 5 ;
		ret

	.carrega3:
		xor si, si
		mov si, palavras3
		mov byte[qt_caracteres], 10
        mov byte[nletr], 7
		ret

	.carrega4:
		xor si, si
		mov si, palavras4
		mov byte[qt_caracteres], 7
        mov byte[nletr], 5
		ret

	.carrega5:
		xor si, si
		mov si, palavras5
		mov byte[qt_caracteres], 10
        mov byte[nletr], 8
		ret  

	.carrega6:
		xor si, si
		mov si, palavras6
		mov byte[qt_caracteres], 11
        mov byte[nletr], 9
		ret

	.carrega7:
		xor si, si
		mov si, palavras7
		mov byte[qt_caracteres], 7
        mov byte[nletr], 7
		ret

	.carrega8:
		xor si, si
		mov si, palavras8
		mov byte[qt_caracteres], 6
        mov byte[nletr], 5
		ret

	.carrega9:
		xor si, si
		mov si, palavras9
		mov byte[qt_caracteres], 6
        mov byte[nletr], 5
		ret

ret

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
        mov AH, 00h  ; interru  pts to get system time        
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
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher0
        mov ah, 2
        mov bh, 0
        mov dl, 30
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica0
        ret
    .sub1:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher1
        mov ah, 2
        mov bh, 0
        mov dl, 29
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica1
        ret
    .sub2:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher2
        mov ah, 2
        mov bh, 0
        mov dl, 26
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica2
        ret
    .sub3:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher3
        mov ah, 2
        mov bh, 0
        mov dl, 31
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica3
        ret
    .sub4:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher4
        mov ah, 2
        mov bh, 0
        mov dl, 28
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica4
        ret
    .sub5:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher5
        mov ah, 2
        mov bh, 0
        mov dl, 31
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica5
        ret
    .sub6:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher6
        mov ah, 2
        mov bh, 0
        mov dl, 32
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica6
        ret
    .sub7:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher7
        mov ah, 2
        mov bh, 0
        mov dl, 28
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica7
        ret
    .sub8:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher8
        mov ah, 2
        mov bh, 0
        mov dl, 27
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica8
        ret
    .sub9:
        ;printando os underlines da forca
        ;;ok;;
        mov si, preencher9
        mov ah, 2
        mov bh, 0
        mov dl, 27
        mov dh, 20
        int 10h
        call printstring
        ;cabou-se
        xor si, si
        mov si, dica9
        ret 
ret

menu:
;Setando a posição do disco onde kernel.asm foi armazenado(ES:BX = [0x7E00:0x0])
    mov ax,0x7E0    ;0x7E0<<1 + 0 = 0x7E00
    mov es,ax
    xor bx,bx       ;Zerando o offset

;Setando a posição da Ram onde o menu será lido
    mov ah, 0x02    ;comando de ler setor do disco
    mov al,4        ;quantidade de blocos ocupados pelo menu
    mov dl,0        ;drive floppy

;Usaremos as seguintes posições na memoria:
    mov ch,0        ;trilha 0
    mov cl,3        ;setor 3
    mov dh,0        ;cabeca 0
    int 13h
    jc menu ;em caso de erro, tenta de novo

break:  
    jmp 0x7e00      ;Pula para a posição carregada

jogo:
;Setando a posição do disco onde kernel.asm foi armazenado(ES:BX = [0x500:0x0])
	mov ax,0x860		;0x50<<1 + 0 = 0x500
	mov es,ax
	xor bx,bx		;Zerando o offset

;Setando a posição da Ram onde o jogo será lido
	mov ah, 0x02	;comando de ler setor do disco
	mov al,8		;quantidade de blocos ocupados por jogo
	mov dl,0		;drive floppy

;Usaremos as seguintes posições na memoria:
	mov ch,0		;trilha 0
	mov cl,7		;setor 2
	mov dh,0		;cabeca 0
	int 13h
	jc jogo	;em caso de erro, tenta de novo

break2:	
	jmp 0x8600 		;Pula para a posição carregada

exit: