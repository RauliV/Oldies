CODE            SEGMENT BYTE PUBLOC
                ASSUME  CS:CODE
                EXTRN   TULOSTA:NEAR
                PUBLIC  Laskuri(x : integer) : integer;
; function Laskuri(x:integer) : integer;
  vanha    equ                dword ptr [bp+6]

  laskuri              PROC FAR

                 push  bp
                 mov   bp,sp
                 lds   a,vanha
                 mvi   d,FFH
      UUSI:      inr   a
                 call tulosta
                 dcr   d
                 jnz   uusi
                 mov   sp,bp
                 pop   bp
                 ret   4


