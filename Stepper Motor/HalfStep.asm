    
    CODE SEGMENT
    ASSUME CS:CODE
    ORG 2000H
    START:



    MOV DX , 0FF2BH ;DX = Configuration Register Address for the 8255 IC
    MOV AL , 80H    ;our calculated configuration value (PA-out)
    OUT DX , AL     ;Transfer 80H to 8255 Config Reg
    
    
    ;Reset the value of SI and the counter BX
    ZERO:
    MOV SI , OFFSET ARRAY
    MOV BX , 0
     
    ;Inginit loop 
    LP:
    ;Simple Delay for the stepper motor to take the value and act on it
    MOV CX , 05FFH
    DELAY:
    LOOP DELAY
     
    ;Read the Values from the Array 
    MOV AL , [SI+BX]
    OUT DX , AL ;Transfer the value to the stepper motor
    INC BX   ;inc 
    CMP BX , 8  ;cmp if the we did all the values in the array
    JE ZERO     ;jump on zero of all the values in the Array are done
    JMP LP
    
    ARRAY DB 0EH , 0CH , 0DH , 09H , 0BH , 03H , 07H , 06H
    
    
    END START
    CODE ENDS   
    
    
    
    
    
    
    
    
