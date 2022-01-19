CODE SEGMENT
ASSUME CS:CODE
ORG 2000H



    START:
    
    MOV DX , 8001H  ; 8279 IC Control Port Address stored in DX
    
    
    MOV AL , 0H ;keyboard/display command with the wanted display and keyboard mode
    OUT DX , AL ;Transfer 0H to the 8279 control port Address
    
    MOV AL , 32H;Program Clock Command configuration value with scale = 18
    OUT DX , AL ;Transfer 32H to the 8279 control port Address
    
    MOV AL , 0DFH;Clear Command configuration value to clear everything
    OUT DX , AL  ;Transfer 0DFH to the 8279 control port Address
    
    MOV CX , 0FFH;Delay simple loop with iterations = 256 (0-255)
    DELAY:
    LOOP DELAY
     
     
     

        MOV DX , 8001H; 8279 IC Control Port Address stored in DX
        MOV AL , 080H ; display on the first 7-segment
        OUT DX , AL   ; Transfer our configuration to the Control port
        
        MOV DX , 8000H; 8279 IC DATA port Address stored in DX
        MOV AL , 4AH  ; to display the character "2" on the 7-segment
        OUT DX , AL   ; Transfer the 4AH (2) to our data port address
       
       
        
        MOV DX , 8001H; 8279 IC Control Port Address stored in DX
        MOV AL , 081H ; display on the second 7-segment
        OUT DX , AL   ; Transfer our configuration to the Control port
        
        MOV DX , 8000H; 8279 IC DATA port Address stored in DX
        MOV AL , 7FH  ; to display the character "_" on the 7-segment
        OUT DX , AL   ; Transfer the 7FH (_) to our data port address
        
        
        
        
        MOV DX , 8001H; 8279 IC Control Port Address stored in DX
        MOV AL , 082H ; display on the third 7-segment
        OUT DX , AL   ; Transfer our configuration to the Control port
        
        MOV DX , 8000H; 8279 IC DATA port Address stored in DX
        MOV AL , 0C8H ; to display the character "P" on the 7-segment
        OUT DX , AL   ; Transfer the C8H (P) to our data port address
        
        
        
        
        MOV DX , 8001H; 8279 IC Control Port Address stored in DX
        MOV AL , 083H ; display on the fourth 7-segment
        OUT DX , AL   ; Transfer our configuration to the Control port
        
        MOV DX , 8000H; 8279 IC DATA port Address stored in DX
        MOV AL , 09H  ; to display the character "G" on the 7-segment
        OUT DX , AL   ; Transfer the 09H (G) to our data port address   
        
        
        
        
        
        
        
        
        
        
;-----------------------------------------------------------------------

    MOV DX , 8001H  ; 8279 IC Control Port Address stored in DX
    MOV AL , 085H   ; display on the sixth 7-segment
    OUT DX , AL     ; Transfer our configuration to the Control port
    
    
    
    MOV SI , OFFSET ARRAY ; Index Register (SI) pointing at the first index of the array  
    
    LABEL_1:    ;BX=0 and displaying the ARRAY FROM 0 index
    MOV BX , 0H ;BX=0
    
    COUNTER:    
    MOV DX , 8000H ; 8279 IC DATA port Address stored in DX
    MOV AL , [SI+BX] ; store the value from our array that has index equal to BX, in AL 
    OUT DX , AL      ; ; Transfer value (0-9) to our data port address 
    
   
    ;Delay for BCD counter
    MOV CX , 0FFFFH ;simple delay for the BCD counter from 0 - 0FFFFH (65536 iterations) (0-65535)
    DELAY_LOOP1:
    LOOP DELAY_LOOP1
    
    
    INC BX  ; INC the BX to read the next index
    
    CMP BX , 0AH ; compare the BX to 10 
    JE LABEL_1   ; if its equal then we need to jump to label_1 (BX=0)
    JMP COUNTER  ; if it's not then we repeat the same process and jump to counter
    
    
    
    
    
    
    


ARRAY DB 0CH , 9FH , 4AH , 0BH , 99H , 29H , 28H , 8FH , 08H , 09H

END START
CODE ENDS 


