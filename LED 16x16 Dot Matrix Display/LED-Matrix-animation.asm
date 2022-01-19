        
        CODE SEGMENT
        ASSUME CS:CODE
        ORG 2000H
        
        START:
        
        MOV DX , 0FF2BH   ;Address for Config Reg at the 8255 IC
        MOV AL , 80H      ;Calculated configuration for 8255 IC
        OUT DX , AL       ;Transfering 80H to 8255 Config Reg
        
        
        
        MOV DI , OFFSET ARRAYC  ;DI pointing at the columns array
        MOV DX , 0FF2AH         ;address of PORT C
        MOV AL , 0FFH           ;ALL ones, because we need all of the rows
        OUT DX , AL             ;Transfering FFH to Port C (to the ROWS) (ALL ROWS = 1)
        
        ZERO_LABEL:
        MOV DX , 0FF29H   ;Address of PORT B (Columns of the second 8x8 LED Dot Matrix)
        MOV AL , 0FFH     ;Turn off all the columns at the second 8x8 LED Matrix
        OUT DX , AL       ;Transfering FFH to PORT B
        MOV BX , 0        ;BX = 0
        
        LOOP1:
        MOV DX , 0FF28H   ;PORT A Address (DOT MATRIX #1)
        MOV AL , [DI + BX];index of Array of columns based on counter BX
        OUT DX , AL       ;the value in AL, for the first coloumn it will be 0FEH
                          ;Transfer it to Port A, which will turn on the first column in DOT MATRIX #1
                          
        INC BX            ;Increment for THE NEXT column 
        
        
        MOV CX , 5FFFH  ;Simple Delay code
        DELAY1:
        LOOP DELAY1   
        
        CMP BX , 8     ;if BX = 8 , then we need to make it zero and go the DOT MATRIX #2
        JE LOOP2_ZERO  ;JUMP LOOP2_ZERO for DOT MATRIX #2
        JMP LOOP1      ;IF BX != 8 , then repeat the process for DOT MATRIX #1
        
        
        LOOP2_ZERO:
        MOV BX , 0      ;BX = 0
        MOV DX , 0FF28H ;Address of PORT A (Columns of the first 8x8 LED Dot Matrix)
        MOV AL , 0FFH   ;Turn off all the columns at the first 8x8 LED Matrix 
        OUT DX , AL     ;Transfering FFH to PORT A
        
        
        LOOP2:  
        MOV DX , 0FF29H  ;PORT B Address (DOT MATRIX #2)
        MOV AL , [DI + BX];index of Array of columns based on counter BX
        OUT DX , AL       ;the value in AL, for the first coloumn it will be 0FEH
                          ;Transfer it to Port A, which will turn the first column in DOT MATRIX #2
                                        
        INC BX          ;Increment for THE NEXT columns
        
        MOV CX , 5FFFH  ;Simple Delay code
        DELAY2:
        LOOP DELAY2   
        
        CMP BX , 8    ;if BX = 8 , then we need to make it zero and go the DOT MATRIX #1 again
        JE ZERO_LABEL  ;JUMP ZERO_LABEL for DOT MATRIX #1
        JMP LOOP2     ;IF BX != 8 , then repeat the process for DOT MATRIX #2
        
        
        ARRAYC DB 0FEH, 0FDH , 0FBH , 0F7H , 0EFH , 0DFH , 0BFH , 7FH   ;Each Column Value C1-C8
        END START
        CODE ENDS                       
        
        
        
        
        
        
