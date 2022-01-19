	CODE SEGMENT
	ASSUME CS:CODE

	PA	EQU	0FF28H          ; PA Data port
	PCTL	EQU	0FF2BH          ; 8255 Command port
	RSN	EQU	00H	; PC0   bit set/reset mode of 8255 (PC)
	RS 	EQU	01H
	RWN	EQU	02H	; PC1
	RW	EQU	03H
	EN	EQU	04H	; PC2   Enable = 0
	E	EQU	05H     ;       Enable = 1
	CS1N	EQU	08H	; PC4
	CS1	EQU	09H
	CS2N	EQU	0Ch	;  PC6
	CS2	EQU	0Dh
	ORG 	22E0h           ;2FE0H
        JMP START

        YR  db   ?              ; column address
        pag db   ?              ; page address
        ZR  db   0c0H           ; always first row of page (don't change)
        val db   ?              ; value of command or data

START:
      ; configure 8255
      MOV DX , PCTL
      MOV AL , 80H
      OUT DX , AL


      ; initialize LCD (Display ON command) for both halves (call sendComm procedure)
      ; left half
      CALL SELECTLEFT
      MOV AL , 3FH
      MOV VAL , AL
      CALL SendComm

      ; delay
      CALL DELAY2MS
      ; right half
      CALL SELECTRIGHT
      MOV AL , 3FH
      MOV VAL , AL
      CALL SendComm

      ; delay
      CALL DELAY2MS
MAIN:
      ; select first column and first page

      MOV AL , 0
      MOV PAG , 0B8H
      MOV YR , 40H

      ; select left half of LCD and set cursor

      CALL SELECTLEFT


      ; get offset of character to be displayed and call sendData procedure
      ; this can be repeated to print an many characters as required

      CALL setCursor

      MOV SI , OFFSET CHARA
      CALL dispComm

      jmp $                   ; stay at current location


      ; procecure to display a single character (8 columns)
      ; loop through the columns of the character and call sendData
dispComm:

PUSH CX
MOV CX , 8
MOV SI , OFFSET CHARH
LPH:
MOV AL , [SI]
MOV val , AL
CALL SendData
INC SI
LOOP LPH


MOV CX , 8
MOV SI , OFFSET CHARE
LPE:
MOV AL , [SI]
MOV val , AL
CALL SendData
INC SI
LOOP LPE

MOV CX , 8
MOV SI , OFFSET CHARL
LPL:
MOV AL , [SI]
MOV val , AL
CALL SendData
INC SI
LOOP LPL

MOV CX , 8
MOV SI , OFFSET CHARL
LPL2:
MOV AL , [SI]
MOV val , AL
CALL SendData
INC SI
LOOP LPL2

MOV CX , 8
MOV SI , OFFSET CHARO
LPO:
MOV AL , [SI]
MOV val , AL
CALL SendData
INC SI
LOOP LPO

POP CX

RET

; Procedure to send a command to LCD (command value is in variable called val)
SendComm:

MOV DX , PA
MOV AL , VAL
OUT DX , AL
MOV DX , PCTL
MOV  AL , RSN
OUT DX , AL
MOV  AL , RWN
OUT DX , AL
MOV  AL , EN
OUT DX , AL
CALL DELAY2MS
MOV  AL , E
OUT DX , AL
CALL DELAY2MS
MOV  AL , EN
OUT DX , AL

RET



; Procedure to send a Data (single column) to LCD (data value is in variable called val)
SendData:
MOV DX , PA
MOV AL , VAL
OUT DX , AL

MOV DX , PCTL
MOV  AL , RS
OUT DX , AL
MOV  AL , RWN
OUT DX , AL
MOV  AL , EN
OUT DX , AL
CALL DELAY2MS
MOV  AL , E
OUT DX , AL
CALL DELAY2MS
MOV  AL , EN
OUT DX , AL

RET



   ; set cursor of LCD to a certain page line and a certain column.
   ; LCD half should be already selected
setCursor:

          ; set column (send YR value as command)
          MOV AL , YR
          MOV VAL , AL
          CALL SendComm


          ; set page (send PAG (x address) value as command)
          MOV AL , PAG
          MOV VAL , AL
          CALL SendComm


          ; set row (send ZR value as command)
          MOV AL , ZR
          MOV VAL , AL
          CALL SendComm


          RET

          ; enable left half of the LCD (CS1 = 1, CS2 = 0)
SELECTLEFT:
MOV DX , PCTL
MOV AL , CS1
OUT DX , AL

MOV AL , CS2N
OUT DX , AL


RET



           ; enable right half of the LCD (CS1 = 0, CS2 = 1)
SELECTRIGHT:
MOV DX , PCTL
MOV AL , CS2
OUT DX , AL

MOV AL , CS1N
OUT DX , AL

 RET



DELAY2MS:
        push cx
        MOV CX,78H
	LOOP $            ; current position
        pop cx

RET

; characters can be declared here
CharEmpty: DB  00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h         ; empty block of 8x8 pixels
CHARA:     DB  00h, 7eh, 11h, 11h, 11h, 7eh, 00h, 00h        ; character A on a block of 8x8 pixels
CHARH: DB 7fH ,08H ,08H ,08H ,7fH ,00H ,00H
CHARE: DB 7fH ,49H ,49H ,49H ,41H ,00H ,00H
CHARL: DB 7fH ,40H ,40H ,40H ,40H ,00H ,00H
CHARO: DB 3eH ,41H ,41H ,41H ,3eH ,00H ,00H
CHARFULL:  DB  0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh  ; all black

CODE ENDS
END START
