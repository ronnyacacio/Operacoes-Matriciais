%include "io.inc"
section .data
menu DB 1
    DD f1
    tamanho EQU ($ - menu)
    DB 2
    DD f2
    DB 3
    DD f3
    DB 4
    DD f4
    DB 5
    DD f5
    DB 6
    DD f6
    DB 7
    DD f7
    DB 8
    DD f8
    DB 9
    DD f9
    DB 10
    DD f10
    entrada EQU ($ - menu)/tamanho
section .bss
 array1 RESD 100
 linha1 RESD 1
 coluna1 RESD 1
 array2 RESD 100
 linha2 RESD 1
 coluna2 RESD 1
 op RESB 1
 transposta RESD 100
 m3 RESD 100
 v RESD 10
 v_size RESD 1
section .text
global CMAIN
CMAIN:

     mov ebp, esp; for correct debugging
      
     GET_DEC 1,al ; Recebendo operação do usuario
    
     
     mov esi,menu ;Movendo o Endereço inicial do menu 
     mov ecx,entrada ;Movendo o Tamanho necessario para andar no vetor menu

     L1:
        cmp al,[esi] ;Comparando a opção do usuario com o primeiro elemento do vetor
        jne L2 ;Caso nao seja igual pula para L2
        call [esi+1] ; caso seja igual soma + 1 no endereço de menu para acessar o nome da função
        jmp L3 ;Pula para L3 quando retornar
        
     L2: ;Caso a comparação "cmp al,[esi]" não seja igual
        add esi, tamanho ;soma Esi com Tamanho
        dec ecx ;Decrementa o ECX para encerrar o laço
        jnz L1 ; volta para L1 caso ecx n seja 0
        jmp L3 ; Pula para L3

        
    L3:;Encerra o codigo
        xor eax, eax
        ret
    f1: ;Funçao Auxiliar para determinar os parametros da primeira função caso a opção tenha sido 1
        pushad ;Jogando os registradores de uso geral para a pilha para uso futuro
        GET_DEC 4, [linha1];Determinar o tamanho da Linha da Matriz
        GET_DEC 4,[coluna1];Determinar o tamanho da Coluna da Matriz
        mov esi,array1;Movendo o Endereço de array1 para Esi para percorrer
        mov ecx,[linha1]
        mov ebx,[coluna1]
        CALL Criar;Chamando Funçao Criar para inicializar uma Matriz
        CALL Imprimir;Chamando F2
        popad;Trazendo de volta os Registradores da pilha
  
        ret
    f2:;Funçao Auxiliar para determinar os parametros da segunda função caso a opção tenha sido 2
        
        pushad
        GET_DEC 4,[linha1]
        GET_DEC 4,[coluna1]
        mov esi,array1 
        mov ecx,[linha1]
        mov ebx,[coluna1]
        CALL Criar ;chamando a função Criar para inicializar uma Matriz
        CALL Imprimir;Chamando a função imprimir para exibir a Matriz recem criada
        popad
        ret
    f3:;Funçao Auxiliar para determinar os parametros da terceira função caso a opção tenha sido 3
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4, [linha2]
        GET_DEC 4,[coluna2]
        mov ecx,[linha1]
        mov ebx,[coluna1]
        mov esi,array2  ; Movendo para ESI o endereço do array2, ja que a função seguinte usa ESI como parametro
        CALL Criar ;Cria Matriz
        mov esi,array1 ; Movendo para ESI o endereço do array1, ja que a função seguinte usa ESI como parametro
        CALL Criar 
        mov edx,array2        
        CALL Soma ;Chama Soma
        ;PRINT_DEC 4,3
        popad
        ret
    f4:;Funçao Auxiliar para determinar os parametros da quarta função caso a opção tenha sido 4
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4, [linha2]
        GET_DEC 4,[coluna2]
        mov ecx,[linha1]
        mov ebx,[coluna1]
        mov esi,array2
        CALL Criar
        mov esi,array1
        CALL Criar
        mov edx,array2        
        CALL Subtracao
        popad
        ret
    f5:;Funçao Auxiliar para determinar os parametros da quinta função caso a opção tenha sido 5
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4,[linha2]
        GET_DEC 4,[coluna2]
        mov ecx,[linha1]
        mov ebx,[coluna1]
        mov edi,[linha2]
        mov ebp,[coluna2]
        mov esi,array2
        CALL Criar
        mov esi,array1
        CALL Criar
        mov edx,array2        
        CALL Igualdade
        popad
        ret
    f6:;Funçao Auxiliar para determinar os parametros da sexta função caso a opção tenha sido 6
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        mov esi,array1
        mov ecx,[linha1]
        mov ebx,[coluna1]
        CALL Criar
        CALL Negacao
        CALL f2
        ;PRINT_DEC 4,6
        popad
        ret
    f7:;Funçao Auxiliar para determinar os parametros da setima função caso a opção tenha sido 7
        pushad
        ;PRINT_DEC 4,7
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        mov esi,array1
        mov ecx,[linha1]
        mov ebx,[coluna1]
        CALL Criar
        CALL Transposta
        popad
        ret
    f8:;Funçao Auxiliar para determinar os parametros da oitava função caso a opção tenha sido 8
        pushad
        GET_DEC 4,[linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4, edx
        mov esi,array1
        mov ecx, [linha1]
        mov ebx,[coluna1]
        CALL Criar
        ;GET_DEC 4,eax
        CALL Escalar
        CALL Imprimir
        popad
        ;PRINT_DEC 4,8
        ret    
    f9:;Funçao Auxiliar para determinar os parametros da nona função caso a opção tenha sido 9
        ;PRINT_DEC 4,9
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4,[v_size]
        mov ecx, [linha1]
        mov ebx, [coluna1]
        mov esi,array1
        CALL Criar
        popad
        pushad
        mov esi,array2
        CALL Criar_vetor
        mov ecx,[linha1]
        mov ebx,1
        CALL Multiplicar_Vetor
        popad
        ret    
    f10:;Funçao Auxiliar para determinar os parametros da decima função caso a opção tenha sido 10
        ;PRINT_DEC 4,10
        pushad
        GET_DEC 4, [linha1]
        GET_DEC 4,[coluna1]
        GET_DEC 4,[linha2] 
        GET_DEC 4,[coluna2]
        mov esi,array1
        mov ecx,[linha1]
        mov ebx,[coluna1]
        CALL Criar
        mov esi,array2
        mov ecx,[linha2]
        mov ebx,[coluna2]
        CALL Criar
        mov esi, [linha1]
        mov edi,[coluna2]
        CALL Multiplicar_matriz
        popad
        ret    
        
        
        
     Criar:
        pushad
        mov edi, 0 ;Inicializando os iteradores do laço com 0;
        mov ebp, 0;                                           ;
        .forI:
            cmp edi, ecx ;Realizando comparação de EDI com ECX(Numero de linhas Definido em F1)
            jge .EXIT ;Caso seja maior ou igual pula para Exit
            .forJ:
                cmp ebp, ebx ;Realizando comparação de EBP com EBX(Numero de Colunas Definido em F1)
                jge .S;Caso seja maior ou igual pula para S
                mov eax, edi ;Movendo para EAX para poder realizar uma multiplicação em seguida
                mul ebx;Realizando Multiplicaçao 
                add eax, ebp ;Somando o valor com EBP 
                GET_DEC 4, [esi + eax*4] ;Recebendo do usuario o valor a ser inserido
                inc ebp ; Incrementa EBP para outra interação
                jmp .forJ ; Volta a realizar as operaçoes anteriores (i*N° colunas+j)*4
                .S:
            mov ebp, 0 ; Move 0 para EBP para reiniciar o laço interno
            inc edi ; Incrementa 1 em EDI para outra interação
            jmp .forI ;Volta a realizar os passos anteriores
            .EXIT:;Quando finalizade vem para EXIT e retorna os registradores e a matriz criada
                popad  
                ret
        Criar_vetor:
                mov ecx, [v_size] ;Move para ECX o tamanho do Vetor para poder interagir no LOOP
                .V1:
                    GET_DEC 4, [esi];Recebe o valor do usuario e armazena em ESI que esta com o endereço do vetor
                    add esi,4;Soma 4 com ESI para andar uma posição no vetor
                    loop .V1;Pula para .V1 até ECX chegar em 0
                    ret 
       
         Imprimir:;Mesma forma de funcionamento da função anterior porém com um "PRINT_DEC" no lugar do "GET_DEC"
         ;xchg ecx,ebx
         mov edi, 0
         mov ebp, 0
        .for2I:
            cmp edi, ecx
            jge .EXIT2
            .for2J:
                cmp ebp, ebx
                jge .S2
                mov eax, edi
                mul ebx
                add eax, ebp
                PRINT_DEC 4, [esi + eax*4]
                PRINT_STRING "  "
                inc ebp
                jmp .for2J
                .S2:
            NEWLINE
            mov ebp, 0
            inc edi
            jmp .for2I
            .EXIT2:  
                ret
                
     Soma:
        mov edi,[linha2]
        mov ebp,[coluna2]
        cmp edi,ecx ;Comparação para verificar se é possivel a soma
        jne .EXITE3
        cmp ebp,ebx ;Comparação para verificar se é possivel a soma
        jne .EXITE3 
        mov edi, 0 ;Inicializa os iterandos
        mov ebp, 0;                        ;
        .for3I:
            cmp edi, ecx ;Comparaçao do primeiro laço
            jge .EXIT3
            .for3J:
                cmp ebp, ebx ;Comparaçao do segundo laço
                jge .S3
                mov eax, edi
                push edx ;Jogando na pilha o valor de EDX(endereço do array2), para realizar uma mul
                mul ebx
                pop edx ;Resgatando o valor anterior de EDX
                add eax, ebp
                push ebx ;Joga o valor de EBX na pilha para poder utilizar o registrador
                mov ebx, [edx + eax*4]  ;Move o valor do Array2 para EBX 
                add [esi + eax*4], ebx ;Soma o valor com o valor do Array1
                pop ebx ;Retorna o valor de EBX para iterar o laço
                inc ebp ; Incrementa EBP para iterar o laço
                jmp .for3J
                .S3:
            mov ebp, 0
            inc edi
            jmp .for3I
            .EXIT3: 
              CALL f2 ;Chama F2 para imprimir o resultado
              ret           
            .EXITE3:
                PRINT_STRING "Incompativel";Imprime caso não seja possivel a soma
                ret
                
        Subtracao:  ;Mesma forma de funcionamento da função acima porém com "Sub" no lugar de "Add"
        mov edi,[linha2]
        mov ebp,[coluna2]
        cmp edi,ecx
        jne .EXITE4
        cmp ebp,ebx
        jne .EXITE4
         mov edi, 0
         mov ebp, 0
         .for4I:
            cmp edi, ecx
            jge .EXIT4
            .for4J:
                cmp ebp, ebx
                jge .S4
                mov eax, edi
                push edx
                mul ebx
                pop edx
                add eax, ebp
                push ebx
                mov ebx, [edx + eax*4]  
                sub [esi + eax*4], ebx 
                pop ebx
                inc ebp
                jmp .for4J
                
                .S4:
            mov ebp, 0
            inc edi
            jmp .for4I
            .EXIT4: 
                CALL f2
                ret
            .EXITE4:
                PRINT_STRING "Incompativel"
                ret
                    
       Igualdade:  ;Mesma logica de acesso das funções acima porém com uma comparação no lugar de uma operação matematica
        cmp ecx,edi
        jne .exits
        cmp ebx,ebp
        jne .exits
        mov edi, 0
        mov ebp, 0
        .for5I:
            cmp edi, ecx
            jge .EXIT5
            .for5J:
                cmp ebp, ebx
                jge .S5
                mov eax, edi
                push edx
                mul ebx
                pop edx
                add eax, ebp
                push ebx
                mov ebx, [edx + eax*4]  
                cmp [esi + eax*4], ebx ;Comparação entre os elementos de 2 matrizes na mesma posição
                pop ebx
                jne .exits    ;Pula caso Sejam diferentes
                inc ebp
                jmp .for5J
                
                .S5:
            mov ebp, 0
            inc edi
            jmp .for5I
            .EXIT5: 
                PRINT_DEC 4,1 ;Printa 1 caso elas tenha as mesmas dimensões e os mesmos valores
                ret
                
             .exits:
                    PRINT_DEC 4,0 ;Printa 0 caso sejam diferentes
                    ret
    
                       
                                     
      Negacao:  ;Mesma Logica de acesso das funções de Soma e subtração porém com a instrução "neg"
        mov edi, 0
        mov ebp, 0
        .for6I:
            cmp edi, ecx
            jge .EXIT6
            .for6J:
                cmp ebp, ebx
                jge .S6
                mov eax, edi
                mul ebx
                add eax, ebp
                mov edx, [esi + eax*4]
                neg edx
                mov [esi + eax*4], edx
                inc ebp
                jmp .for6J
                .S6:
            mov ebp, 0
            inc edi
            jmp .for6I
            .EXIT6: 
               ret
               
       Transposta:  ;Percorre a matriz utilizando (j*N°linhas +i)*4 e salva os valores em EDX
             mov edi, 0
             mov ebp, 0
          .for7I:
            cmp edi, ecx
            jge .EXIT7
            .for7J:
                cmp ebp, ebx
                jge .S7
                mov eax, edi
                mul ebx
                add eax, ebp
                mov edx, [esi + eax*4]
                ;Percorre a matriz utilizando (i * N°Colunas +j)*4 e move os valores de EDX para cada posição
                push edx
                mov eax, ebp
                mul ecx
                pop edx
                add eax, edi
                push esi
                mov esi, transposta           
                mov [esi+eax*4], edx
                pop esi
                inc ebp
                jmp .for7J
                .S7:
            mov ebp, 0
            inc edi
            jmp .for7I
            
            .EXIT7:
                mov esi, transposta
                xchg ebx,ecx ;Trocando os valores para exibir de forma mais clara
                CALL Imprimir;Chamando função imprimir
                ret
               
        Escalar: ;Mesma Logica de acesso das funções de soma e subtração porém com uma multiplicação por um valor
        mov edi, 0
        mov ebp, 0
        .for8I:
            cmp edi, ecx
            jge .EXIT8
            .for8J:
             cmp ebp, ebx
                jge .S8
                mov eax, edi
                push edx ;Movendo o valor de EDX(Escalar que será multiplicado pela matriz) para a pilha
                ;para realizar uma multiplicação
                mov edx,0
                mul ebx
                pop edx
                add eax, ebp
                push ecx ; Salvando o valor de ECX na pilha
                push eax ; Salvando o valor de EAX na pilha
                mov ecx, [esi + eax*4] ; Movendo para ECX o valor de ESI(Endereço que contem o elemento da matriz)
                mov eax, edx ; movendo o escalar(EDX) para EAX, para realizar a multiplicação
                push edx ;Salvando o valor de EDX na pilha
                mov edx,0 ; Movendo 0 para realizar a operação "mul"
                mul ecx
                pop edx ;retornando o valor de EDX
                mov ecx, eax ; Movendo para ECX o valor de EAX
                pop eax ; Recuperando o valor para determinar o endereço
                mov [esi + eax*4], ecx ; Salvando o valor multiplicado na matriz
                pop ecx;Recuperando o valor de ECX
                inc ebp
                jmp .for8J
                .S8:
            mov ebp, 0
            inc edi
            jmp .for8I
            .EXIT8:
                ret  
    Multiplicar_Vetor:
      mov esi,[linha1]      
      cmp [v_size],esi
      jne .EXITE20
      .C:
      mov esi, 0;i
      mov edi, 0;j
      mov ebp, 0;k
     .G1:
    
        cmp esi, [linha1]
        je .EXIT9
        mov edi, 0
        mov ebp, 0
    
     .G2:
        ;inc edi
        cmp edi, 1
        jne .P1
        inc esi
        jmp .G1
        .P1:
        mov ebp, 0
        
    .G3:
    
        ;inc ebp
        cmp ebp, [coluna1]
        jne .B
        inc edi
        jmp .G2
        
        .B:
        mov ecx, esi
        mov ebx, [coluna1]
        mov eax, ecx
        mul ebx
        add eax, ebp
        mov ecx, 4
        mul ecx
        mov ecx,eax
        mov eax, [array1+ecx]
        
        ;mov eax, [m1+(((esi*l1l3)+ebp)*4)]
        
        
        mov ebx, [array2+ebp*4]
        mul ebx
        
        ;mul [m2+((ebp*c1l2)+edi)*4] 
        push eax
        mov eax, esi
        mov ebx, 1
        mul ebx
        add eax, edi
        mov ecx, 4
        mul ecx
        mov ecx, eax
        pop eax
        
        add [m3+ecx], eax
        
        ;add [m3+((esi*l1l3)+edi)*4], eax
        inc ebp
        jmp .G3
    
    .EXIT9:        
        mov esi,m3
        mov ecx,[v_size]
        CALL Imprimir
        ret
     .EXITE20:
           mov esi,[coluna1]
           cmp [v_size],esi
           je .C
           PRINT_STRING "Vetor e matriz incompativeis"
           ret
            
                
                
                             
                                          
                                                       
                                                                                 
   Multiplicar_matriz:           
      cmp esi,edi
      jne EXITE
                
                          
                                              
      mov esi, 0;i
      mov edi, 0;j
      mov ebp, 0;k
      
    
    
     Q1:
    
        cmp esi, [linha1] ;Comparaçao do Primeiro laço
        je EXIT10    ;jmp caso igual
        mov edi, 0 ;zera os iteradores internos
        mov ebp, 0 ;
    
    Q2:
        cmp edi, [coluna2] ;Comparação do Segundo laço
        jne P ;jmo se nao igual
        inc esi ; caso igual incrementa o iterador do primeiro laço
        jmp Q1  ;Sai de Q2
        P:
        mov ebp, 0 ; Zera o interador mais interno
        
    Q3:
    
        cmp ebp, [linha2] ;Comparação do laço interno
        jne Q ;Sai do laço
        inc edi ; incrementa o iterador de Q2
        jmp Q2 ; Sai de Q3 para Q2
        
        Q: ; (i * N° Colunas +j)*4
        mov ecx, esi 
        mov ebx, [linha2]
        mov eax, ecx
        mul ebx
        add eax, ebp
        mov ecx, 4
        mul ecx
        
        mov eax, [array1+eax] ;Move Elemento da Matriz 1 para Eax
        
        push eax ;Salva valor obtido na operação anterior
        
        mov ecx, ebp;(i * N° Colunas +j)*4
        mov ebx, [coluna2]
        mov eax, ebx
        mul ecx
        add eax, edi
        mov ecx, 4
        mul ecx
        mov ecx, eax;ECX recebe localização do elemento na matriz
        
        pop eax;Obtem o valor que foi salvo anteriormente em EAX
        
        push ebx;Salva valor de EBX na pilha
        
        mov ebx, [array2+ecx]
        mul ebx; Salva endereço do vetor em EAX
        pop ebx;Obtem o valor que foi salvo anteriormente em EBX
         
        push eax;Salva valor de EAX na pilha
        
        mov eax,esi;(i * N° Colunas +j)*4
        mov ebx, [coluna2]
        mul ebx
        add eax, edi
        mov ecx, 4
        mul ecx
        mov ecx, eax;Move a localização da matriz para o ECX
        pop eax;Obtem o valor que foi salvo anteriormente em EAX
        
        add [m3+ecx], eax;Adiciona na localizaçãoda matriz resultante o valor de EAX
        
        inc ebp
        jmp Q3
    
    EXIT10:       
           mov esi,m3 
           mov ecx,[linha1]
           mov ebx,[coluna2]
           CALL Imprimir
           ret
    EXITE:;Em caso de incompatibilidade
        PRINT_STRING "Matriz incompativeis"
        ret       
        
        
        
        
        