jmp main

initial_screen4:  string " @@@@@@ @@@@@@ @@     @ @@@@@@@ @@ @@   "
initial_screen5:  string " @@   @ @@     @@@@   @ @@      @@ @@   " 
initial_screen6:  string " @@   @ @@@@@@ @@ @@  @ @@      @@ @@   "
initial_screen7:  string " @@@@@@ @@     @@  @@ @ @@      @@ @@   "
initial_screen8:  string " @@     @@     @@   @@@ @@      @@ @@   "
initial_screen9:  string " @@     @@@@@@ @@    @@ @@@@@@@ @@ @@@@ "
initial_screen24: string "         APERTE x PARA COMECAR          "

initial1_screen1:  string "                                        "
initial1_screen2:  string "              INSTRUCOES                "
initial1_screen3:  string "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
initial1_screen4:  string "                                        "
initial1_screen5:  string " Pressione w,a,s,d para mover pela tela " 
initial1_screen6:  string " 									   "
initial1_screen7:  string " Pressione q para ativar NO-ACTION      "
initial1_screen8:  string " 									   "
initial1_screen9:  string " Pressione e para ativar ERASER         "
initial1_screen10: string "                                        "
initial1_screen11: string " Pressione x para percorrer o vetor de  "
initial1_screen12: string " cores para tras                        " 
initial1_screen13: string "                                        "
initial1_screen14: string " Pressione c para percorrer o vetor de  "
initial1_screen15: string " cores para frente                      "
initial1_screen16: string "                                        "
initial1_screen17: string " Pressione l para limpar toda a tela    " 
initial1_screen18: string "                                        "
initial1_screen19: string " Pressione k para finalizar o programa  "
initial1_screen20: string "                                        "
initial1_screen21: string "                                        "
initial1_screen22: string "    PRESSIONE x PARA SER UM ARTISTA     "
initial1_screen23: string "                                        "
initial1_screen24: string "                                        "



Yvector_screen: var #30

Xvector_screen1:  string "                                        "
Xvector_screen2:  string "                                        "
Xvector_screen3:  string "                                        "
Xvector_screen4:  string "                                        "
Xvector_screen5:  string "                                        " 
Xvector_screen6:  string "                                        "
Xvector_screen7:  string "                                        "
Xvector_screen8:  string "                                        "
Xvector_screen9:  string "                                        "
Xvector_screen10: string "                                        "
Xvector_screen11: string "                                        "
Xvector_screen12: string "                                        " 
Xvector_screen13: string "                                        "
Xvector_screen14: string "                                        "
Xvector_screen15: string "                                        "
Xvector_screen16: string "                                        "
Xvector_screen17: string "                                        " 
Xvector_screen18: string "                                        "
Xvector_screen19: string "                                        "
Xvector_screen20: string "                                        "
Xvector_screen21: string "                                        "
Xvector_screen22: string "                                        " 
Xvector_screen23: string "                                        "
Xvector_screen24: string "                                        "
Xvector_screen25: string "                                        "
Xvector_screen26: string "                                        "
Xvector_screen27: string "                                        " 
Xvector_screen28: string "                                        "
Xvector_screen29: string "                                        "
Xvector_screen30: string "                                        "

;///////POSICOES DO CURSOR///////
CurrentCursorPosX: var #1
CurrentCursorPosY: var #1

CursorChar: var #1
Option: var #1
Color: var #1
CharPrint: var #1
Letra: var #1

AntCursorPosX: var #1
AntCursorPosY: var #1
;///////////////////////////////

main:
	loadn r0, #0      			; Inicialmente usado para contagem no preenchimento do Yvector_screen da tela
	
	loadn r1, #15
	store CurrentCursorPosY, r1
	store AntCursorPosY, r1
	loadn r1, #20
	store CurrentCursorPosX, r1
	store AntCursorPosX,r1
	
	
	store Color, r0
	loadn r0, #1
	store Option, r0
	loadn r0, #'X'
	store CursorChar, r0
	loadn r0, #'@'
	store CharPrint, r0
	
	call menu
	
	call initialize_vector
	
	call app
	halt

app:
	push fr
	push r0
	push r1 ;Posicao Cursor X Atual
	push r2	;Posicao Cursor Y Atual
	push r3	;Posicao Atual
	push r4	;Char Lido
	push r5	;Char de comparacao
	push r6
	push r7

	load r1, CurrentCursorPosX
	load r2, CurrentCursorPosY 
	
	
	loop:	
		call print_cursor_normal
		call digLetra 	
		
		load r3, Letra
		;inchar r3
		
		eraser:
			loadn r5, #'e'
			cmp r3, r5
			jne no_action
			
			load r0, Option
			loadn r5, #2
			cmp r0, r5
			jne eraser_active
			
			loadn r0, #1
			store Option, r0
			loadn r5, #'X'
			store CursorChar, r5
			loadn r5, #'@'
			store CharPrint, r5
			
			jmp loop
			
			eraser_active:
				store Option, r5
				loadn r5, #'E'
				store CursorChar, r5
				loadn r5, #' '
				store CharPrint, r5
				jmp loop	
			
			jmp loop
			
		no_action:
			loadn r5, #'q'
			cmp r3, r5
			jne up
			
			load r0, Option
			loadn r5, #0
			cmp r0, r5
			jne no_action_active
			
			loadn r0, #1
			store Option, r0
			loadn r5, #'X'
			store CursorChar, r5
			
			jmp loop
			
			no_action_active:
			
				store Option, r5
				loadn r5, #'N'
				store CursorChar, r5
				jmp loop
			
		up:
			loadn r5, #'w'
			cmp r3, r5
			jne down 
			
			loadn r0, #0 ;Limite superior
			cmp r2,r0
			jeq loop
						 
			dec r2
			call change_position
			store CurrentCursorPosY, r2
			
			loadn r0, #0
			load r5, Option
			cmp r0, r5
			cne print_ink
			ceq no_print_ink
			
			jmp loop	
		
		down:
			loadn r5, #'s'
			cmp r3, r5
			jne left 
			
			loadn r0, #29 ;Limite inferior
			cmp r2,r0
			jeq loop
						 
			inc r2
			call change_position
			store CurrentCursorPosY, r2
			
			loadn r0, #0
			load r5, Option
			cmp r0, r5
			cne print_ink
			ceq no_print_ink
		
			jmp loop

		left:
			loadn r5, #'a'
			cmp r3, r5
			jne right 
			
			loadn r0, #0 ;Limite inferior
			cmp r1,r0
			jeq loop
						 
			dec r1
			call change_position
			store CurrentCursorPosX, r1
			
			loadn r0, #0
			load r5, Option
			cmp r0, r5
			cne print_ink
			ceq no_print_ink
			
			jmp loop
		
		right:
			loadn r5, #'d'
			cmp r3, r5
			jne color_change_prox  
			
			loadn r0, #39 ;Limite inferior
			cmp r1,r0
			jeq loop
						 
			inc r1
			call change_position
			store CurrentCursorPosX, r1
			
			loadn r0, #0
			load r5, Option
			cmp r0, r5
			cne print_ink
			ceq no_print_ink
			
			jmp loop
		
		color_change_prox:
			loadn r5, #'c'
			cmp r3, r5
			jne color_change_ant
			
			load r7, Color
			loadn r0, #14		;Maximo que variavel cor pode atingir, pois a cor 15*256 eh invisivel
			cmp r7,r0
			jeq loop
			
			inc r7
			store Color, r7
			
			jmp loop
		
		color_change_ant:
			loadn r5, #'x'
			cmp r3, r5
			jne limpa_tela
			
			load r7, Color
			loadn r0, #0		;Minimo que variavel cor pode atingir, 0 * 256
			cmp r7,r0
			jeq loop
			
			dec r7
			store Color, r7
			
			jmp loop
			
		limpa_tela:
			loadn r5, #'l'
			cmp r3, r5
			jne finalizar
			
			call clean_video_buffer
			call clean_video_memory
			
			jmp loop
			
		finalizar:
			loadn r5, #'k'
			cmp r3, r5
			jne loop
			jeq app_end
			
app_end:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
			
print_ink:
	push fr
	push r0
	push r1
	push r2
	push r3 
	push r4 
	push r5	
	push r6
	
	load r0, CharPrint
	
	load r1, AntCursorPosX
	load r2, AntCursorPosY
	load r4, Color
	
	loadn r3, #40
	mul r2,r2,r3
	add r2,r2,r1
		
	loadn r5, #256
	mul r5, r5, r4
	add r0, r0, r5
	
	outchar r0, r2
	
	call screen_position_address_St
	
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	
	rts
	

change_position:
	push fr
	push r0
	
	load r0, CurrentCursorPosX
	store AntCursorPosX, r0
	
	load r0, CurrentCursorPosY
	store AntCursorPosY, r0
	
	pop r0
	pop fr
	rts


print_cursor_normal: ; Parametros R1 (Posicao X do Cursor) e R2 (Posicao Y do Cursor)
	push fr
	push r0	;Posicao calculada na tela
	push r1	;Coordenada X
	push r2	;Coordenada Y
	push r3	
	push r4
	push r5
	
	load r3, CursorChar
	load r4, Color
	loadn r5, #256
	
	loadn r0, #40
	mul r0, r0, r2 ; pos = y * 40 
	add r0, r0, r1 ; pos = pos + x
	
	mul r5, r4, r5 ; 256 * color
	add r3, r3, r5 ; coloca a cor no cursor
	
	
	outchar r3, r0
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts

no_print_ink:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	
	
	loadn r0, #Yvector_screen
	load r1, AntCursorPosY
	load r2, AntCursorPosX
	loadn r3, #0
	
	no_print_ink_loop1:	;Percorre a matriz de tela na direcao de Y
		cmp r3,r1
		jeq Exit_no_print_ink_loop1
		inc r0
		inc r3
		jmp no_print_ink_loop1
	
	Exit_no_print_ink_loop1:
		loadi r0, r0				; R0 = Yvector_screen[AntCursorPosY]
		loadn r3, #0
	
	no_print_ink_loop2:	;Percorre a matriz de tela na direcao de X
		cmp r3, r2
		jeq Exit_no_print_ink_loop2
		inc r0
		inc r3
		jmp no_print_ink_loop2
	
	Exit_no_print_ink_loop2:
	
	
	loadn r3, #40
	loadi r4, r0
	
	mul r3, r3, r1
	add r3, r3, r2
	
	outchar r4, r3
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	
	rts


screen_position_address_St:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	
	
	loadn r0, #Yvector_screen
	load r1, AntCursorPosY
	load r2, AntCursorPosX
	loadn r3, #0
	
	screen_position_address_loop1:	;Percorre a matriz de tela na direcao de Y
		cmp r3,r1
		jeq Exit_loop1
		inc r0
		inc r3
		jmp screen_position_address_loop1
	
	Exit_loop1:
		loadi r0, r0				; R0 = Yvector_screen[AntCursorPosY]
		loadn r3, #0
	
	screen_position_address_loop2:	;Percorre a matriz de tela na direcao de X
		cmp r3, r2
		jeq Exit_loop2
		inc r0
		inc r3
		jmp screen_position_address_loop2
	
	Exit_loop2:
	
	load r3, Color ; Cor
	load r4, CharPrint ; Char de pintura
	loadn r5, #256
	
	mul r5, r5, r3
	add r4, r4, r5
	storei r0, r4
	 
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	
	rts
	
initialize_vector:
	push r0
	push r1
	
	loadn r0, #Yvector_screen     ; R0 = endereco de Yvector_screen[0]
	
	
	loadn r1, #Xvector_screen1	; R1 = endereco de Xvector_screen1
	storei r0, r1				; MEM[R0] = R1
	inc r0						; R0 = endereco de Yvector_screen[1] (Yvector_screen++)	
	
	loadn r1, #Xvector_screen2	; R1 = endereco de Xvector_screen2
	storei r0, r1               ; MEM[R0] = R1
	inc r0						; R0 = endereco de Yvector_screen[2] (Yvector_screen++)
	
	loadn r1, #Xvector_screen3	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen4	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen5	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen6	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen7	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen8	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen9	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen10	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen11	
	storei r0, r1				
	inc r0						
	
	
	loadn r1, #Xvector_screen12	
	storei r0, r1               
	inc r0						
	
	loadn r1, #Xvector_screen13	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen14	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen15	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen16	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen17	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen18	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen19	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen20	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen21	
	storei r0, r1				
	inc r0						
	
	
	loadn r1, #Xvector_screen22	
	storei r0, r1               
	inc r0						
	
	loadn r1, #Xvector_screen23	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen24	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen25	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen26	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen27	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen28	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen29	
	storei r0, r1              
	inc r0
	
	loadn r1, #Xvector_screen30	
	storei r0, r1              
	
	pop r1
	pop r0
	rts
	
	
	
	; Novo DigLetra para o teclado da FPGA:

	;------------------------		
	;********************************************************
	;                   DIGITE UMA LETRA
	;********************************************************

	digLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
		push fr		; Protege o registrador de flags
		push r0
		push r1
		loadn r1, #255	; Se nao digitar nada vem 255

	   digLetra_Loop:
			inchar r0			; Le o teclado, se nada for digitado = 255
			cmp r0, r1			;compara r0 com 255
			jeq digLetra_Loop	; Fica lendo ate' que digite uma tecla valida

		store Letra, r0			; Salva a tecla na variavel global "Letra"

			; Bloco novo para aguardar que o user solte a tecla pressionada!!
				   digLetra_Loop2:	
						inchar r0			; Le o teclado, se nada for digitado = 255
						cmp r0, r1			;compara r0 com 255
						jne digLetra_Loop2	; Fica lendo ate' que digite uma tecla valida
					
		
		pop r1
		pop r0
		pop fr
		rts



	;-------------------------- 	
	
	menu:
		push fr
		push r0
		push r1
		push r2
		push r3
		push r4
		push r5
		push r6
		push r7
		
		loadn r0, #120
		loadn r1, #initial_screen4
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #160
		loadn r1, #initial_screen5
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #200
		loadn r1, #initial_screen6
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #240
		loadn r1, #initial_screen7
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #280
		loadn r1, #initial_screen8
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #320
		loadn r1, #initial_screen9
		loadn r2, #2304
		call ImprimeStr2
		
		
		loadn r0, #960
		loadn r1, #initial_screen24
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #'x'
		
		waitLoop:
			call digLetra
			load r1, Letra
			cmp r0, r1
			jeq waitLoopOut
			jne waitLoop
		
		waitLoopOut:
		
		call clean_video_buffer
		
		loadn r0, #40
		loadn r1, #initial1_screen2
		loadn r2, #2816
		call ImprimeStr2
		
		
		loadn r0, #80
		loadn r1, #initial1_screen3
		loadn r2, #2816
		call ImprimeStr2
		
		
		loadn r0, #160
		loadn r1, #initial1_screen5
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #240
		loadn r1, #initial1_screen7
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #320
		loadn r1, #initial1_screen9
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #400
		loadn r1, #initial1_screen11
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #440
		loadn r1, #initial1_screen12
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #520
		loadn r1, #initial1_screen14
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #560
		loadn r1, #initial1_screen15
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #640
		loadn r1, #initial1_screen17
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #720
		loadn r1, #initial1_screen19
		loadn r2, #0
		call ImprimeStr2
		
		
		loadn r0, #840
		loadn r1, #initial1_screen22
		loadn r2, #1280
		call ImprimeStr2
		
		
		loadn r0,#'x'
		waitLoop1:
			call digLetra
			load r1, Letra
			cmp r0, r1
			jeq waitLoopOut1
			jne waitLoop1
		
		waitLoopOut1:
		
		call clean_video_buffer
		
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop fr
		rts
		
clean_video_buffer:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r0, #0
	loadn r1, #initial1_screen24
	loadn r2, #0
	
	loadn r5, #40
	
	loadn r6, #0
	loadn r7, #30
	
	clean_video_bufferLoop:
		cmp r6, r7
		jeq clean_video_bufferLoopOut 
		
		call Imprimestr
		
		add r0, r0, r5
		inc r6
		
		jmp clean_video_bufferLoop
		
	clean_video_bufferLoopOut:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
clean_video_memory:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	 
	loadn r0, #Yvector_screen
	loadn r1, #0
	loadn r2, #0
	
	loadn r3, #30
	loadn r4, #40
	loadn r7, #' '
	
	clean_video_memory_loop1:
		cmp r1, r3
		jeq clean_video_memory_loop1Out
		loadi r5, r0
		loadn r2, #0
		clean_video_memory_loop2:
			cmp r2, r4
			jeq clean_video_memory_loop2Out
			
			storei r5, r7
			
			inc r5
			inc r2
			jmp clean_video_memory_loop2
		clean_video_memory_loop2Out:
		
		inc r0
		inc r1
		jmp clean_video_memory_loop1
	clean_video_memory_loop1Out:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
	
	
	Imprimestr:		;  Rotina de Impresao de Mensagens:    
					; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
					; r1 = endereco onde comeca a mensagem
					; r2 = cor da mensagem
					; Obs: a mensagem sera' impressa ate' encontrar "/0"
					
	;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor				
		push r0	; Posicao da tela que o primeiro caractere da mensagem sera' impresso
		push r1	; endereco onde comeca a mensagem
		push r2	; cor da mensagem
		push r3	; Criterio de parada
		push r4	; Recebe o codigo do caractere da Mensagem
		
		loadn r3, #'\0'	; Criterio de parada

	ImprimestrLoop:	
		loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
		cmp r4, r3			; compara o codigo do caractere buscado com o criterio de parada
		jeq ImprimestrSai	; goto Final da rotina
		add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
		outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
		inc r0				; incrementa a posicao que o proximo caractere sera' escrito na tela
		inc r1				; incrementa o ponteiro para a mensagem na memoria
		jmp ImprimestrLoop	; goto Loop
		
	ImprimestrSai:	
	;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
		pop r4	
		pop r3
		pop r2
		pop r1
		pop r0
		rts		; retorno da subrotina
		
		
ImprimeStr3:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5
	
	loadn r3, #40	; Criterio de parada
	loadn r5, #0	; Criterio de parada

   ImprimeStr3_Loop:	
		cmp r5, r3		; If (Char == \0)  vai Embora
		jeg ImprimeStr3_Sai
		loadi r4, r1
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r5
		jmp ImprimeStr3_Loop
	
   ImprimeStr3_Sai:	
	pop r5
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6			; Incrementa o ponteiro da String da Tela 0
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts