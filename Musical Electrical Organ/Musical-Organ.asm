CODE SEGMENT
ASSUME CS:CODE
ORG 2000H
START:


MOV AL , 76H   ; Config register value => 76H in AL
MOV DX , 0043H ; 8253 Control Word Register address stored in DX
OUT DX , AL    ; Transfer 76H to the 8253 Config Regester


MOV AL , 90H   ; Config register value => 90H in AL
MOV DX , 0FF2BH; 8255 Control Word Register address stored in DX
OUT DX , AL    ; Transfer 90H to the 8255 Config Regester


LOOP1:
MOV AL , 0H    ; 0 as an output at Port B0 to disable the 8253 timer
MOV DX , 0FF29H; Port B Address at 8255 IC stored in DX
OUT DX , AL    ; Transfer 0 to Port B which is connected the GATE1 at 8253
MAIN:
MOV DX , 0FF28H; Port A address at 8255 IC stored in DX
IN AL , DX     ; Transfer the data at port-A which is connected to push buttons
CMP AL , 0FFH  ; compare it to 11111111 , that means nothing is pressed
JE LOOP1       ; jmp again to LOOP1 if nothing is pressed

        
        
        
        CMP AL , 07FH ; button 1 is pressed (0111 1111)
        JE S1         
        CMP AL , 0BFH ; button 2 is pressed (1011 1111)
        JE S2         
        CMP AL , 0DFH ; button 3 is pressed (1101 1111)
        JE S3         
        CMP AL , 0EFH ; button 4 is pressed (1110 1111)
        JE S4         
        CMP AL , 0F7H ; button 5 is pressed (1111 0111)
        JE S5         
        CMP AL , 0FBH ; button 6 is pressed (1111 1011)
        JE S6         
        CMP AL , 0FDH ; button 7 is pressed (1111 1101)
        JE S7         
        JMP LOOP1     









    ; 1MHz/440 = 2273 = 08E1H
    S1:
    MOV AL , 0E1H ;Store E1H in AL  
    MOV DX , 0041H;Address of counter-1 8253 stored in DX
    OUT DX , AL   ;Transfer it the address 41H which is counter-1
    
    MOV AL , 08H  ;Store 08H in AL
    MOV DX , 0041H;Address of counter-1 at 8253 stored in DX
    OUT DX , AL   ;Transfer it the address 41H which is counter-1
    
    ; (ENABLING THE 8253 TIMER TO GENERATE THE SIGNAL THEN GET THE AUDIO)
    MOV AL , 01H  ;Store 01H in AL 
    MOV DX , 0FF29H;Store the Address of Port B at 8255 in DX
    OUT DX , AL    ;Transfer 1 to the address 0FF29H which is Port B connected to GATE1 
    
    JMP MAIN       ; jump again to the main and determine if there is any push button pressed 
    

          
       
       
          
          


        S2: ; 1MHz/493.88 = 2025 = 07E9H
        MOV AL , 0E9H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 07H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN
        S3: ; 1MHz/554.37 = 1804 = 070CH
        MOV AL , 0CH
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 07H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN
        S4: ; 1MHz/587.33 = 1703 = 06A7
        MOV AL , 0A7H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 06H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN
        S5: ; 1MHz/659.26 = 1517 = 05ED
        MOV AL , 0EDH
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 05H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN
        S6: ; 1MHz/739.99 = 2273 = 08E1H
        MOV AL , 48H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 05H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN
        S7: ; 1MHz/830.61 = 2273 = 08E1H
        MOV AL , 0B4H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 04H
        MOV DX , 0041H
        OUT DX , AL
        MOV AL , 01H
        MOV DX , 0FF29H
        OUT DX , AL
        JMP MAIN






END START
CODE ENDS
