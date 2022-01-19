    CODE SEGMENT
    ASSUME CS:CODE
    ORG 2000H
    
    START:
    
    MOV DX , 0FF2BH  ;DX = Address of the 8255 IC configuration register
    MOV AL , 80H     ;Configure the 8255 IC with 80H
    OUT DX , AL      ;Transfer 80H to Config Register of the 8255 IC
    


    ;Enter infinite loop
    LP:
    MOV DX , 8000H  ;DX = the ADC0809 port address
    MOV AL , 00H    ;start the ADC by sending 00H to it
    OUT DX , AL     ;Transfering 00H to the ADC Port Address
     
    ;Simple needed delay for the ADC  
    MOV CX , 600H
    DELAY:
    LOOP DELAY
     
     
     
    MOV DX , 8000H ;;DX = the ADC0809 port address
    IN AL , DX     ;Transfering the Digital DATA from the ADC to AL
    ;the Value will be from 0H to FFH (0-255)  
    
    ;we multiply our value with 5 then devide it by 255
    MOV BL , 5  ;BL = 5
    MUL BL      ;AL = BL * AL 
  
    ;Devided (old al*5) by 255
    MOV BL , 255 ; BL = 255
    DIV BL       ; AL = AL / BL
    
    
    ;THE REMINDER IN AH
    MOV CL , AH ;CL = AH (REMINDER)
    MOV CH , 0  ;CH = 0 to be able to push it
    PUSH CX     ;PUSH TO THE STACK

    MOV CL , AL  ;SAVING AL (THE Quotient) IN CL
    
    MOV DX , 0FF29H    ;ADDRESS FOR PORT B AT THE 8255 (CHOSING THE 7 segment)
    MOV AL , 11011111B ;CHOSING THE FIRST 7 SEGMENT
    OUT DX , AL        ;TRANSFERING THE WANTED VALUE TO PORT B
    
    
    MOV AL , CL    ;MOV OUR WANTED VALUE FROM CL BACK TO AL
    MOV BX , OFFSET ARRAY ;BX = the ARRAY OF CONFIGURATION
    XLAT             ;AL = ARRAY[AL]
    MOV DX , 0FF28H  ;address for port A at the 8255 ic
    OUT DX , AL      ;Transfering the value in AL
    ;which is the config 7 segment value from the array 
    ;to the wanted 7 segment 
     
    ;simple delay for the 7 segment 
    MOV CX , 0FFH
    DELAY1:
    LOOP DELAY1
    
     
  
     
    MOV DX , 0FF29H    ;ADDRESS FOR PORT B AT THE 8255 (CHOSING THE 7 segment)
    MOV AL , 11101111B ;CHOSING THE SECOND 7 SEGMENT
    OUT DX , AL        ;TRANSFERING THE WANTED VALUE TO PORT B
    
    MOV AL , 07FH      ;configuration display value for the decimal point 
    MOV DX , 0FF28H    ;address for port A at the 8255 ic
    OUT DX , AL        ;Transfering the value in AL
    ;which is the config 7 segment value from the array 
    ;to the wanted 7 segment 
          
    ;simple delay for the 7 segment       
    MOV CX , 400H
    DELAY2:
    LOOP DELAY2
    
   
    
    ;now we need to display the reminder
    MOV DX , 0FF29H ;ADDRESS FOR PORT B AT THE 8255 (CHOSING THE 7 segment)
    MOV AL , 11110111B ;CHOSING THE THIRD 7 SEGMENT
    OUT DX , AL        ;TRANSFERING THE WANTED VALUE TO PORT B
            
            
    POP CX       ;pop the reminded, which will be at CL
    MOV AL , 10  ;AL = 10
    MUL CL       ;(REMINDER) AL = CL * 10 
    MOV BL , 255 ; BL = 255
    DIV BL       ; AL = AL/BL
    MOV BX , OFFSET ARRAY  ;BX = the ARRAY OF CONFIGURATION
    XLAT  ; AL = ARRAY[AL]
    
    MOV DX , 0FF28H ;address for port A at the 8255 ic
    OUT DX , AL     ;Transfering the value in AL
    ;which is the config 7 segment value from the array 
    ;to the wanted 7 segment 
      
    ;simple delay for the 7 segment   
    MOV CX , 0FFH
    DELAY3:
    LOOP DELAY3
    
    
    ;get back to the loop
    JMP LP
    
    ARRAY DB 0C0H , 0F9H , 0A4H , 0B0H , 99H , 92H , 082H , 0F8H , 80H , 90H
    
    
    END START
    CODE ENDS
