;***************************************************************************
;       VERY FAST SQRT PROCEDURE PROGRAMMED BY MIKA TUOMI  4.11.1991
;
;   ALGORITHM IS SIMPLY
;   GUESS = ((NUMBER/GUESS)+GUESS)/2
;
;   FIRST TIME GUESS CAN BE ANY NUMBER (0FFh IN EXAMPLE) BUT NEXT TIME GUESS
;   SHOULD BE THE VALUE FROM LAST ALGORITHM ROUND.
;   7 ROUNDS IS GOOD ENOUGH WHEN CALCULATING 16bit NUMBERS.
;   YOU CAN EASILY TEST ALGORITHM WITH YOUR CALCULATOR.
;
;   SQRT PROCEDURE IS EXAMPLE NEEDED WHEN FINDING
;   DISTANCE BETWEEN 2 OBJECTS IN 3D-SPACE.
;
;***************************************************************************
.MODEL SMALL
.STACK
.CODE
;***************************************************************************

SQRT     PROC    NEAR       ; INPUT: AX = NUMBER TO CALC SQRT
         MOV     BP,AX      ; STORE ORIGINAL NUMBER TO BP
         MOV     CX,7       ; NUMBER OF ROUNDS TO CALC SQRT
         MOV     BX,00FFH   ; BL = GUESS (ALGORITHM NEEDS IN FIRST ROUND)
SQRTL:   MOV     AX,BP      ; GET ORIGINAL NUMBER FROM BP
         XOR     DX,DX      ; ZERO DX REGISTER FOR DIVIDING
         DIV     BX         ; AX = AX / BX
         ADD     AX,BX      ; AX = AX + BX
         SHR     AX,1       ; AX = AX / 2
         MOV     BX,AX      ; PUT NEW GUESS VALUE TO BX
         LOOP    SQRTL      ; LOOP WHICH USES NEW GUESS VALUE
         RET                ; OUTPUT: AX = SQRT VALUE OF NUMBER IN INPUT
SQRT     ENDP

;**************************************************************************
;******* MAIN PROGRAM TO TEST SQRT PROCEDURE ******************************
;**************************************************************************

START:
         MOV     AX,64      ; TEST VALUE (64) FOR SQRT ROUTINE
         CALL    SQRT       ; CALL SQRT ROUTINE
                            ; AFTER CALLING AX AND BX HAVE VALUE 8

         MOV     AH,4CH     ; END PROCESS
         INT     21H        ; DO IT!!
         ENDS
         END     START

;**************************************************************************