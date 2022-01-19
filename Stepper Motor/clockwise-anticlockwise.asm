    
    
    CODE SEGMENT
    ASSUME CS:CODE
    ORG 2000H
    START:
    
    
    
    MOV DX , 0FF2BH ;DX = Address for the configuration Reg of the 8255 IC
    MOV AL , 82H    ;Our calculated value stored in AL
    OUT DX , AL     ;Transfer 82H to the config reg Address
    
    MOV BL , 0EEH   ;BL = 1110|1110 (FOR ROTATION)
     
    ;infinite loop 
    LP:
    
    MOV DX , 0FF29H   ;DX = The Address in the port B at the 8255 IC (PUSH BUTTONS)
    IN AL , DX        ;Transfer Data from Port B which is connected to Push buttons 
                      ;To AL (AL = Push Bottons DATA)
                      
    AND AL , 00000011B  ;Masking for the first least seg two bits
    CMP AL , 00000011B  ;check if the 2 bits equal 1 then nothing is pressed
    JE LP               ;JMP back on the lp and repeat the process
    
    
    
    CMP AL , 00000010B    ;if the first button was pressed (S0) 
    JE ROTATER            ;Jump on ROTATER
    
    CMP AL , 00000001B   ;if the second button was pressed (S1) 
    JE ROTATEL           ;Jump on ROTATER
    

    ROTATER:
    ROR BL , 1       ;Rotation right
    MOV DX , 0FF28H  ;ADDRESS FOR PORT A which is connected to stepper motor
    MOV AL , BL      ;AL = BL to Transfer Data to the stepper motor 
    OUT DX , AL      ;Transfer Data to the stepper motor 
    ;Simple Delay
    MOV CX , 05FFH
    DELAY:
    LOOP DELAY
    JMP LP     ;get back to the loop and repeat the process
            
            
    ROTATEL:
    ROL BL , 1     ;Rotation right
    MOV DX , 0FF28H ;ADDRESS FOR PORT A which is connected to stepper motor
    MOV AL,BL        ;AL = BL to Transfer Data to the stepper motor
    OUT DX , AL      ;Transfer Data to the stepper motor
    ;Simple Delay
    MOV CX , 05FFH
    DELAY1:
    LOOP DELAY1
    JMP LP  ;get back to the loop and repeat the process  
    
    END START
    CODE ENDS            
    
    
    
    
    
    
    
