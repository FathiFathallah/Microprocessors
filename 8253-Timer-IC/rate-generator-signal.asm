CODE SEGMENT
ASSUME CS:CODE
ORG 100H 


START:


    MOV DX , 0043H ; Control word register address
    MOV AL , 14H   ; 00010100 |14H| => for config the control register
    OUT DX , AL    ; Transfer 14H to the address stored in DX => 0043H
                   ; which is the address for the 8253 config register
   
   
   
   LOOP1:
    
    MOV DX , 0040H ; Store the address for counter-0 in DX =>0040H
    MOV AL , 50    ; Store the calculated frequency in AL
    OUT DX , AL    ; Transfer 50Hz as an output to the address stored in DX
                   ; which is for counter-0 =>0040H
    
   
   
   JMP LOOP1
   
   

END START
CODE ENDS
                 
                 
                 
                 
                 
                 
                 
