CODE SEGMENT
ASSUME CS:CODE
ORG 100H 


START:


    MOV DX , 0043H ; Control word register address
    MOV AL , 16H   ; 00010110 |16H| => for config the control register
    OUT DX , AL    ; Transfer 16H to the address stored in DX => 0043H
                   ; which is the address for the 8253 config register
   
   
   
   LOOP1:
    
    MOV DX , 0040H ; Store the address for counter-0 in DX =>0040H
    MOV AL , 67    ; Store the calculated frequency in AL
    OUT DX , AL    ; Transfer 67Hz as an output to the address stored in DX
                   ; which is for counter-0 =>0040H
    
   
   
   JMP LOOP1
   
   

END START
CODE ENDS
                 
                 
                 
                 
                 
                 
                 
