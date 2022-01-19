    
    
    CODE SEGMENT
    ASSUME CS:CODE
    ORG 2000H
    START:
    
    
    
    MOV DX , 0FF2BH ;DX = Configuration Register Address for the 8255 IC
    MOV AL , 80H    ;our calculated configuration value (PA-out)
    OUT DX , AL     ;Transfer 80H to 8255 Config Reg
    
    
    MOV AL , 0EEH   ; store => |1110|1110| in register AL to rotate it in loop
    MOV DX , 0FF28H ;DX = Address for the PORT A which is connected to the 
                    ;Stepper Mottor 
    
    
    ;Infinite LOOP
    
    LP:        
    
    ;Simple Delay for the stepper motor to take the value and act on it
    MOV CX , 05FFH
    DELAY:
    LOOP DELAY
     
    ;Transfer the value in AL to the Port A which is connected to 
    ;The stepper motor, to make it moves with full-step mode 
    OUT DX , AL
    ROL AL , 1 ;Rotate Left
    
    JMP LP ;Jmp to LP and repeat the process
    
    
    
    
    
    END START
    CODE ENDS             
    
    
    
    
    
