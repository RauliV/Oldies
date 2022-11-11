code segment byte public

     assume cs:code

     public plot

plot proc near

     push bp
     mov bp,sp
     mov ax,ss:[bp]+6
     mov bx,320d
     mul bx
     mov bx,ss:[bp]+8
     add ax,bx
     push ax
     mov bx,0a000h
     push bx
     pop es
     mov ax,ss:[bp]+4
     pop bx
     mov es:[bx],al
     pop bp
     ret 8
plot endp

code ends

     end


