.MODEL SMALL

NUM_FORM_STACK MACRO                   ; SUPER IMPORTANT => IT WILL TAKE THE NUMBERS PUSHED TO THE STACK AND FORM THEM AS ONE & STORE IT IN DX REGISTER 
LOCAL FINISH_1D , FINISH_2D ,FINISH_3D ,FINISH_4D, FINISH_5D , FINISH

MOV BX , 1
MOV DX , 0


CMP CL , 1 
JE FINISH_1D

CMP CL , 2
JE FINISH_2D

CMP CL , 3
JE FINISH_3D

CMP CL , 4
JE FINISH_4D

CMP CL , 5
JE FINISH_5D
       
       
FINISH_1D:
POP AX
MOV DX , AX
PUSH DX
POP DX
DEC CL
JMP FINISH
       
              
FINISH_2D:
POP AX
MUL BX
ADD DX , AX
POP AX
PUSH DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
POP DX   
MOV CL , 0
JMP FINISH
      
      
FINISH_3D:
POP AX
MUL BX
ADD DX , AX
POP AX
PUSH DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
POP DX
PUSH AX
PUSH DX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
POP DX  
MOV CL , 0
JMP FINISH


FINISH_4D:
POP AX
MUL BX
ADD DX , AX
POP AX
PUSH DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
POP DX
PUSH AX
PUSH DX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP DX
POP AX
PUSH DX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
POP DX   
MOV CL , 0
JMP FINISH


FINISH_5D:
POP AX
MUL BX
ADD DX , AX
POP AX
PUSH DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
POP DX
PUSH AX
PUSH DX
MOV AX , 10
MUL BX
MOV BX , AX
POP AX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
MOV AX , 10
MUL BX
MOV BX , AX
POP DX
POP AX
PUSH DX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX 
MOV AX , 10
MUL BX
MOV BX , AX
POP DX
POP AX
PUSH DX
MOV DX , 0
MUL BX
POP DX
ADD AX , DX
PUSH AX
POP DX   
MOV CL , 0
JMP FINISH

FINISH:
ENDM
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CALCULATE MACRO CALCULATION_STRING , RESULT
LOCAL FIRST_CALC , SUM , SUBT , MULTIPLY , DIVIDE

FIRST_CALC:
MOV SI , OFFSET CALCULATION_STRING 
MOV AX , [SI]
ADD SI , 2
MOV BX , [SI]
ADD SI , 2
MOV DX , [SI]
ADD SI , 2

CMP BX , '+'
JE SUM
CMP BX , '-'
JE SUBT
CMP BX , '*'
JE MULTIPLY
CMP BX , '/'
JE DIVIDE

SUM:
ADD AX , DX
MOV RESULT , AX
JMP SEC_CALC

SUBT:
SUB AX , DX
MOV RESULT , AX
JMP SEC_CALC

MULTIPLY:
MOV BX , DX
MOV DX , 0
MUL BX
PUSH DX
PUSH AX
MOV CL , 2
NUM_FORM_STACK
MOV RESULT , DX
JMP SEC_CALC

DIVIDE:
MOV BX , DX
MOV DX , 0
DIV BX
MOV RESULT , AX
JMP SEC_CALC

SEC_CALC:
MOV BX , [SI]
ADD SI , 2
CMP BX , 0
JE DONE
MOV AX , [SI]
ADD SI , 2

CMP BX , '+'
JE SUM_NEW
CMP BX , '-'
JE SUBT_NEW
CMP BX , '*'
JE MULTIPLY_NEW
CMP BX , '/'
JE DIVIDE_NEW

SUM_NEW:
ADD RESULT , AX
JMP SEC_CALC

SUBT_NEW:
SUB RESULT , AX
JMP SEC_CALC

MULTIPLY_NEW:
MOV BX , RESULT
MOV DX , 0
MUL BX
PUSH DX
PUSH AX
MOV CL , 2
NUM_FORM_STACK
MOV RESULT , DX
JMP SEC_CALC


DIVIDE_NEW:
MOV BX , AX
MOV AX , RESULT
MOV DX , 0
DIV BX
MOV RESULT , AX
JMP SEC_CALC

DONE:
ENDM

;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
.DATA
FINAL_RESULT DW 0
CALC_ARRAY DW ?


.CODE
MOV AX , @DATA
MOV DS , AX
MOV SI , OFFSET CALC_ARRAY
MOV CL , 0


INSERTION:
MOV AH , 01H
INT 21H

CMP AL , '=' 
JE C_RESULT

CMP AL , '+'
JE ADDITION

CMP AL , '-'
JE SUBTRACTION

CMP AL , '*'
JE MULTIPLICATION

CMP AL , '/'
JE DIVISION

CMP AL , '0'
JB INSERTION

CMP AL , '9'
JA INSERTION

PUSH_NUM:
MOV AH , 0
SUB AL , 30H
PUSH AX
INC CL
JMP INSERTION


ADDITION:
NUM_FORM_STACK
MOV [SI] , DX
ADD SI , 2
MOV AX , '+'
MOV [SI] , AX
ADD SI , 2
JMP INSERTION

SUBTRACTION:
NUM_FORM_STACK
MOV [SI] , DX
ADD SI , 2
MOV AX , '-'
MOV [SI] , AX
ADD SI , 2
JMP INSERTION

MULTIPLICATION:
NUM_FORM_STACK
MOV [SI] , DX
ADD SI , 2
MOV AX , '*'
MOV [SI] , AX
ADD SI , 2
JMP INSERTION

DIVISION:
NUM_FORM_STACK
MOV [SI] , DX
ADD SI , 2
MOV AX , '/'
MOV [SI] , AX
ADD SI , 2
JMP INSERTION




  C_RESULT:
  NUM_FORM_STACK
  MOV [SI] , DX
  ADD SI , 2
  MOV AX , 0
  MOV [SI] , AX
  CALCULATE CALC_ARRAY , FINAL_RESULT
  MOV AX , FINAL_RESULT
  MOV CL , 0

  STACKING:
  MOV BX , 10
  MOV DX , 0
  DIV BX
  PUSH DX
  INC CL
  CMP AX , 0
  JE PRINT
  JMP STACKING


  PRINT:
  MOV DH , 0
  POP DX
  MOV AH , 02H
  ADD DL , 30H
  INT 21H
  DEC CL
  CMP CL , 0
  JA PRINT

.EXIT
END
