code    segment byte puplic
        assume cs:code
        puplic uppercase,stringof

upperres       equ               dword prt [bp+10]
upperstr       equ               dword [bp+6]

uppercase      prog far
       push    bp
       mov     bp,sp
       push    ds
       lds     si,upperstr
       les     di,upperres
       cld
       lodsb
       mov     cl,al
       xor     ch,ch
       jcxz    U3
U1:    lodsb
       cmp     al,'a'
       jb      U2
       CMP     al,'z'
       ja      U2
       sub     al,'a'-'a'
U2:    stosb
       loop     U1
U3:    pop      ds
       pop      bp
       ret      4
Uppercase       Endp
Code   ends
       end

