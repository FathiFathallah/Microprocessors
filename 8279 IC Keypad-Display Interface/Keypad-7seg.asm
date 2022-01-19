CODE SEGMENT
ASSUME CS:CODE
ORG 2000H


START:


MOV DX , 8001H


MOV AL , 0H
OUT DX , AL

MOV AL , 32H
OUT DX , AL

MOV AL , 0DFH
OUT DX , AL

MOV CX , 0FFH
DELAY:
LOOP DELAY




    
    RETURN:
    MOV SI , OFFSET ARRAY  ; SI Pointing at ARRAY (7-sig config) 
    MOV DI , OFFSET ARRAY2 ; DI Pointing at ARRAY2 (Scanned-keyboard DATA)
    MOV CL ,0              ; Counter = 0
   
   
    
    READ:          ;Reading from the keyboard
    MOV DX , 8001H ;Cotrol Port stored in DX
    IN AL , DX     ;Read the Data at the control Port 8001H and store it in AL
    AND AL , 07H   ;Anding the data with 07H to get the 3 least sig bits   
    CMP AL , 00H   ;Compare the 3 least sig bits , if 0 nothing is pressed
    JE READ        ;if nothing is pressed jump on read and repeat the process
                 
                 
                   
                   
                   
    MOV DX , 8000H ;if something is pressed move to store DATA PORT in DX
    IN AL , DX     ; Transfer the DATA on the DATA port to AL
    AND AL , 3FH   ;Anding AL with 3FH to mask the first most sig two bits (CNTL,SHIFT)
             
                 
                 
                 
    READ1:
    CMP AL , [DI] ;Comparing the pressed key value with some index from ARRAY2
    JE DIS        ;data = value from the scanned keyboard data ARRAY , display it
    INC SI        ; if the data does not match , move to the other index of ARRAY
    INC DI        ; if the data does not match , move to the other index of ARRAY2
    INC CL        ; INC CL
    CMP CL , 16   ; Compare CL with 16 , if CL=16 then no key pressed fit our calculated keys
    JE RETURN     ;JUMP on return and make SI,DI pointing at the start , and CL = 0
    JMP READ1     ;CL not equal 16 , then read the other compare the other index of both arrays
                  ;compare the key with other index from ARRAY2
    
    DIS:
    MOV DX , 8001H ;Control Port 8001H stored in DX
    MOV AL , 080H  ; Run configuration for the first 7-seg display
    OUT DX , AL    ; Transfer our configuration to the 8279 control port
    
    MOV DX , 8000H ; store the data port 8000H in dx
    MOV AL , [SI]  ; store the character of the key pressed from ARRAY to Register AL
    OUT DX , AL    ; Transfer AL to the data port 8000H
    
    JMP READ       ;Jump on read and repeat the process 

                   
                   
                   
                   

    
    
    

    ARRAY DB 0CH , 9FH , 4AH , 0BH , 99H , 29H , 28H , 8FH , 08H , 09H , 88H , 38H , 6CH , 1AH , 68H , 0E8H
    ARRAY2 DB 09H , 01H , 11H , 21H , 08H , 18H , 28H , 0H , 10H , 20H , 30H , 38H , 31H , 39H , 29H , 19H
    
    
    END START
    CODE ENDS
           
           
           
           
           
