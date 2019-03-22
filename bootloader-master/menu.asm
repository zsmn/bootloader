;Jogo da Velha: ULTRA
org 0x7E00
jmp 0x0000:start

data:
	forca1 db "@@@@@  @@@@@  @@@@@  @@@@@  @@@@@", 13
	forca2 db "@      @   @  @   @  @      @   @", 13
	forca3 db "@@@    @   @  @@@@   @      @@@@@ ", 13
	forca4 db "@      @   @  @  @   @      @   @", 13
	forca5 db "@      @@@@@  @   @  @@@@@  @   @", 13

	origins1 db "@@@@@@@@@@@@@@@", 13
	origins2 db "@@ @      @", 13
	origins3 db "@@@     @@@@@", 13
	origins4 db "@@        @", 13
	origins5 db "@@        @", 13
	origins6 db "@@       @ @", 13
	origins7 db "@@      @   @", 13
	origins8 db "@@", 13
	origins9 db "@@@@@@@@@@@@@@@", 13
	origins10 db "@@@@@@@@@@@@@@@", 13

	
	subtitle db "A Software Infrastructure Game", 13
	pressEnter db "Pressione > ", 13
	pressEnterInter db "ENTER", 13
	pressEnter2 db " < para comecar o jogo", 13
	pressMenu db "Pressione > ", 13
	pressMenu2 db " < para visualizar as instrucoes", 13
	pressMenuInter db "I", 13

	info1 db "1 -- O jogo consiste em adivinhar certas palavras dada a quantidade de letras existentes em cada uma delas", 13
	info2 db "2 -- A cada iteracao o jogador pode escolher uma letra (letras maiusculas e minusculas serao consideradas iguais). Caso a letra escolhida faca parte da palavra, ela sera preenchida na tela. Caso contrario, a forca ira ser preenchida. A cada erro na escolha da letra o usuario perdera uma vida. A cada nivel, o usuario tera 5 vidas, ou seja, 5 chances de completar a palavra em questao.", 13
	info4 db "3 -- Uma dica sera dada para cada palavra a ser adivinhada. Sera mostrado na tela quais letras foram usadas pelo jogador para que lee nao as repita", 13
	info5 db "4 -- Boa sorte! =D", 13
	info6 db "Pressione ESC para voltar ao menu inicial", 13
	instructions db "INSTRUCOES", 13

start:
	; Modo vídeo.
	mov ah, 0
	mov al, 12h
	int 10h

	call telaInicial

	jmp exit


printDelayStr:
	lodsb

	mov ah, 0xe
	mov bh, 0
	int 10h

	call delay

	cmp al, 13
	jne printDelayStr
ret

printDelayStrTitle:
	lodsb

	mov ah, 0xe
	mov bh, 0
	int 10h

	call delay_fast

	cmp al, 13
	jne printDelayStrTitle
ret

printStr:
	lodsb

	mov ah, 0xe
	mov bh, 0
	mov bl, 0xf
	int 10h

	cmp al, 13
	jne printStr
ret


colorirTela:
	mov ah, 0xb
	mov bh, 0
	mov bl, 0
	int 10h
	call delay_window

	mov ah, 0xb
	mov bh, 0
	mov bl, 1
	int 10h
	call delay_window

	mov ah, 0xb
	mov bh, 0
	mov bl, 2
	int 10h
	call delay_window

	mov ah, 0xb
	mov bh, 0
	mov bl, 4
	int 10h
	call delay_window

	ret

auxiliar_titulo:
	mov ah, 02h
	mov bh, 00h
	int 10h

	mov bl, 3
	call printDelayStrTitle
	ret

telaInicial:

	; chamar o modo video para limpar a tela
	mov ah, 0
	mov al, 12h
	int 10h

	call colorirTela
	mov dl, 15h
	mov si, forca1
	mov dh, 1
	call auxiliar_titulo
	mov si, forca2
	mov dh, 2
	mov dl, 15h
	call auxiliar_titulo
	mov si, forca3
	mov dh, 3
	mov dl, 15h
	call auxiliar_titulo
	mov si, forca4
	mov dh, 4
	mov dl, 15h
	call auxiliar_titulo
	mov si, forca5
	mov dh, 5
	mov dl, 15h
	call auxiliar_titulo

	mov si, subtitle

	;Setando o cursor (subtitulo).
	mov ah, 02h
	mov bh, 00h
	mov dh, 7
	mov dl, 16h
	int 10h

	mov bl, 0xf
	call printDelayStr

	mov dl, 30
	mov si, origins1
	mov dh, 11
	call auxiliar_titulo
	mov si, origins2
	mov dh, 12
	mov dl, 30
	call auxiliar_titulo
	mov si, origins3
	mov dh, 13
	mov dl, 30
	call auxiliar_titulo
	mov si, origins4
	mov dh, 14
	mov dl, 30
	call auxiliar_titulo
	mov si, origins5
	mov dh, 15
	mov dl, 30
	call auxiliar_titulo
	mov si, origins6
	mov dh, 16
	mov dl, 30
	call auxiliar_titulo
	mov si, origins7
	mov dh, 17
	mov dl, 30
	call auxiliar_titulo
	mov si, origins8
	mov dh, 18
	mov dl, 30
	call auxiliar_titulo
	mov si, origins9
	mov dh, 19
	mov dl, 30
	call auxiliar_titulo
	mov si, origins10
	mov dh, 20
	mov dl, 30	
	call auxiliar_titulo

	mov si, pressEnter
	;Setando o cursor (bora jogar).
	mov ah, 02h
	mov bh, 00h
	mov dh, 24
	mov dl, 19
	int 10h

	mov bl, 0xf
	call printDelayStr

	mov si, pressEnterInter
	mov ah, 02h
	mov bh, 00h
	mov dh, 24
	mov dl, 31
	int 10h
	mov bl, 2
	call printDelayStr

	mov si, pressEnter2
	mov ah, 02h
	mov bh, 00h
	mov dh, 24
	mov dl, 36
	int 10h
	mov bl, 0xf
	call printDelayStr

	mov si, pressMenu
	;Setando o cursor (bora jogar).
	mov ah, 02h
	mov bh, 00h
	mov dh, 26
	mov dl, 16
	int 10h

	mov bl, 0xf
	call printDelayStr

	mov si, pressMenuInter
	mov ah, 02h
	mov bh, 00h
	mov dh, 26
	mov dl, 28
	int 10h
	mov bl, 2
	call printDelayStr
	
	mov si, pressMenu2
	mov ah, 02h
	mov bh, 00h
	mov dh, 26
	mov dl, 29
	int 10h
	mov bl, 0xf
	call printDelayStr

	.loop:
		mov ah, 0
		int 16h

		cmp al, 13;if enter
		je jogo

		cmp al, 73;if 'I'
		je telaRegras

		cmp al, 105;if 'i'
		je telaRegras

		jmp .loop

	jmp exit

telaRegras:
	; chamar o modo video para limpar a tela
	mov ah, 0
	mov al, 12h
	int 10h

	; cor cinza
	mov ah, 0xb
	mov bh, 0
	mov bl, 1
	int 10h

	; mover ponteiro
	mov ah, 02h
	mov bh, 00h
	mov dh, 05h
	mov dl, 01h
	int 10h
	mov si, info1
	call printStr

	;printando a segunda instrucao
	mov ah, 02h
	mov bh, 00h
	mov dh, 07h
	mov dl, 01h
	int 10h
	mov si, info2
	call printStr

	;printando a quarta instrucao
	mov ah, 02h
	mov bh, 00h
	mov dh, 12
	mov dl, 01h
	int 10h
	mov si, info4
	call printStr

	;printando a quinta instrucao
	mov ah, 02h
	mov bh, 00h
	mov dh, 14
	mov dl, 01h
	int 10h
	mov si, info5
	call printStr

	;printando a frase para voltar ao menu inicial
	mov ah, 02h
	mov bh, 00h
	mov dh, 20
	mov dl, 01h
	int 10h
	mov si, info6
	call printStr

	esperaEsc:
		mov ah, 0
		int 16h

		cmp al, 27
		jne esperaEsc
	
	call telaInicial
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

delay_fast:
	mov bp, 75
	mov dx, 75
	delay2_fast:
		dec bp
		nop
		jnz delay2_fast
	dec dx
	jnz delay2_fast

ret

delay_window:
	mov bp, 700
	mov dx, 700
	delay2_window:
		dec bp
		nop
		jnz delay2_window
	dec dx
	jnz delay2_window

ret

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

break:	
	jmp 0x8600 		;Pula para a posição carregada


exit:
