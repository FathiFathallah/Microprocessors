    CODE SEGMENT
    ASSUME CS:CODE
    ORG 1000H
    
    
    START:
    
    
    ZERO:
    MOV BX , 0  ;Counter 
    MOV SI , OFFSET ARRAY ; SI is now pointing at the ARRAY WE HAVE
    
    
    LP:
    MOV AL , [SI + BX] ; AL = ARRAY[BX] , AL = value stored in the array
    INC BX             ;INC THE COUNTER
    
    MOV DX , 8000H     ;DX = Address of the DAC IC
    OUT DX , AL        ;Transfer the AL which is the value to the DAC 
    
    NOP ;Simple Delay
    
    CMP BX , 20  ;If we have transfered all values then the
                 ; wave is done, repeat it by jumping to lavel ZERO
    JE ZERO 
    
    JMP LP  ;if not jump to LP
    
    
    ;VALUES 
    ARRAY DB 128 , 167 , 202 , 230 , 248 , 255 , 248 , 230 , 202 , 167 , 128
          DB 88, 53 , 25 ,7 , 1 , 7 , 25 , 53 , 88 , 128
    
    
    
    END START
    CODE ENDS       
    
    
    
    
    
