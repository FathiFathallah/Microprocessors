        CODE SEGMENT
        ASSUME CS:CODE
        ORG 2000H
        
        START:
        
        MOV DX , 0FF2BH  ;8255 Control word Reg Address
        MOV AL , 80H     ;The Calculated Config
        OUT DX , AL      ;Transfering 80H to 8255 config Reg
        
        MOV SI , OFFSET ARRAYR   ; SI points at the Rows ARRAY
        MOV DI , OFFSET ARRAYC   ; DI Points at the Columns ARRAY
        
        
        LOOP1:
        MOV DX , 0FF2AH ;Port C Address
        MOV AL , [SI]   ;44H
        OUT DX , AL     ;Transfering 44H to Port C
        
        MOV DX , 0FF28H ;Port A Address
        MOV AL , [DI]   ;F7H 
        OUT DX , AL     ;Transfering F7H to Port A
        
        MOV CX , 0FFH  ;Simple Delay Code
        DELAY1:
        LOOP DELAY1
        ;-------------------------------------------
        MOV DX , 0FF2AH  ;Port C Address
        MOV AL , [SI+1]  ;92H
        OUT DX , AL      ;Transfering 92H to Port C
        
        MOV DX , 0FF28H  ;Port A Address
        MOV AL , [DI+1]  ;EFH
        OUT DX , AL      ;Transfering EFH to Port A
        
        MOV CX , 0FFH  ;Simple Delay Code
        DELAY2:
        LOOP DELAY2
        ;--------------------------
        MOV DX , 0FF2AH  ;Port C Address
        MOV AL , [SI+1]  ;92H
        OUT DX , AL      ;Transfering 92H to Port C
        
        MOV DX , 0FF28H  ;Port A Address
        MOV AL , [DI+2]  ;DFH
        OUT DX , AL      ;Transfering DFH to Port A
        
        MOV CX , 0FFH   ;Simple Delay Code
        DELAY3:
        LOOP DELAY3
        ;---------------------
        MOV DX , 0FF2AH  ;Port C Address
        MOV AL , [SI+1]  ;92H
        OUT DX , AL      ;Transfering 92H to Port C
        
        MOV DX , 0FF28H  ;Port A Address
        MOV AL , [DI+3]  ;BFH
        OUT DX , AL      ;Transfering BFH to Port A 
        
        MOV CX , 0FFH    ;Simple Delay Code
        DELAY4:
        LOOP DELAY4
        ;----------------------------
        MOV DX , 0FF2AH ;Port C Address
        MOV AL , [SI+2] ;6CH
        OUT DX , AL     ;Transfering 6CH to Cort C  
        
        MOV DX , 0FF28H ;Port A Address
        MOV AL , [DI+4] ;7FH
        OUT DX , AL     ;Transfering 7FH to Port A
        
        MOV CX , 0FFH  ;Simple Delay Code
        DELAY5:
        LOOP DELAY5
        
        JMP LOOP1     ;Jump again on loop1 and repeat the process 
                      ;to have the shape displayed all the time
        
        ARRAYR DB 44H , 92H , 6CH
        ARRAYC DB 0F7H , 0EFH , 0DFH , 0BFH , 7FH             
        
        
          
        END START
        CODE ENDS           
        
        
         
