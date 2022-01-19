    
    
    CODE SEGMENT
    ASSUME CS:CODE
    ORG 100H
    
    
    START:
    
    
    MOV DX , 8000H ;Address of the DAC
    MOV AL , 00H   ;MOV 00H to the DAC
    OUT DX , AL    ;Transfer 00 to the DAC Address 
    
    ;Simple Delay
    MOV CX , 600H
    DELAY:
    LOOP DELAY
     
    
    ;Infinite LOOP 
    LP:
    
    MOV AL , 255  ;AL = 255 which is the highest DIGITAL value we have
    OUT DX , AL   ;Transfer it to the DAC IC
    
    MOV CX , 0FFH ;Simple delay
    DELAY1:
    LOOP DELAY1
    
    
    MOV AL , 0  ;AL = 0 which is the lowest DIGITAL value we have on the DAC
    OUT DX , AL ;Transfer it to the DAC IC
    
    MOV CX , 0FFH ;simple delay
    DELAY2:
    LOOP DELAY2
    
    JMP LP
    
    
    
    
    END START
    CODE ENDS                  
    
    
    
    
    
    
    
    
    
