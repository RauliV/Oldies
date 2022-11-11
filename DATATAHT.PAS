 program DATATAHTI;
   uses CRT,GRAPH;
   var
       TAPPI : array [1..50] of integer;
       LASK,LASK2,LASK3,LASK4,LASK5,ALKUREUNA,TAPPIOL,TOISTOTOL,KIMOIKOL,
       AUKKO,GRAAF,KIMVASOL,B,C,X,Y,H : integer;
       OIK : real;
       A : char;
       VAST : string;
        TOTUUS : boolean;
   procedure ARVONTA;
     begin
       for LASK := 1 to TAPPIOL do begin
         TAPPI[LASK] := 0;
       end;
       KIMVASOL := 100- KIMOIKOL;
       for LASK := 1 to TAPPIOL do begin
         B := random(99);
         inc(B);
         if B <= KIMOIKOL then TAPPI[LASK] := 1
       end;
     end;
   begin
     randomize;
     repeat
       H := ioresult;
       clrscr;
       window(2,2,78,23);
       textbackground(3);
       textcolor(0);
       clrscr;
       h := ioresult;
       writeln;writeln;
       writeln('                    ***       ASETUSTEN MŽŽRITYS    ***');
       writeln;writeln;writeln;
       writeln('                        Poistu');
       writeln;
       writeln('                        Tappirivej„: ');
       writeln;
       writeln('                        Kimmoisuus   oikea:');
       writeln('                                     vasen: ');
       writeln;
       writeln('                        Toistojen lukum„„ra:');
       writeln;
       writeln('                        Tulostus: ');
       writeln;
       writeln('                        Valmis');
       TOTUUS := false;
       X := 20 ;
       Y := 7;
       TAPPIOL := 10;
       TOISTOTOL := 1;
       GRAAF := 1;
       KIMOIKOL := 50;
       KIMVASOL := 50;
       gotoxy(X,Y);
       write('*');
       gotoxy(38,9);
       write(TAPPIOL);
       gotoxy(49,11);
       write(KIMOIKOL);
       gotoxy(51,12);
       write(KIMVASOL);
       gotoxy(47,14);
       write(TOISTOTOL);
       gotoxy(35,16);
       writeln('Graafinen (hitaampi)');
       repeat
         repeat
           A := readkey;
         until (A = #50) or (A= #52) or (A=#54) or (A =#56);
         if (A = #50) or (A = #56) then begin
           gotoxy(X,Y);
           write(' ');
           if (A= #50) and (Y = 18) then begin
             dec(Y,13);
           end;
           if (A= #56) and (Y = 7) then begin
             inc(Y,13);
           end;
           if (A = #50) and (Y = 11) then begin
             inc(Y,1);
           end;
           if (A = #56) and (Y = 14) then begin
             dec(Y,1);
           end;
           if  A = #56 then begin
             dec(Y,2);
             gotoxy(X,Y);
             write('*');
           end else begin
             inc(Y,2);
             gotoxy(X,Y);
             write('*');
           end;
         end;
         if (A = #54) or (A = #52) then begin
           if Y = 7 then begin
             gotoxy(10,20);
             write(' Poistutaanko ohjelmasta (K/E)');
             readln(VAST);
              if (VAST = 'k') or (VAST = 'K') then halt(1);
            end;
            if Y = 16 then begin
              if GRAAF = 1 then begin
                GRAAF := 0;
                gotoxy(35,16);
                write('                            ');
                gotoxy(35,16);
                write('Numeerinen (nopeampi)');
              end else begin
                GRAAF := 1;
                gotoxy(35,16);
                write('                           ');
                gotoxy(35,16);
                write('Graafinen (hitaampi)');
              end;
            end;
            if Y = 18 then begin
              gotoxy(10,20);
              write(' Hyv„ksyt„„nk” asetukset (K/E)');
              readln(VAST);
              if (VAST = 'k') or (VAST = 'K') then TOTUUS := true;
              gotoxy(10,20);
              write('                                   ');
              gotoxy(X,Y);
            end;
            if Y = 9 then begin
              if (A= #54) and (TAPPIOL = 20 ) then TAPPIOL := 0;
              if (A = #52) and (TAPPIOL = 1 ) then TAPPIOL := 21;
              if A = #54 then inc(TAPPIOL);
              if A = #52 then dec(TAPPIOL);
              gotoxy(38,9);
              write('  ');
              gotoxy(38,9);
              write(TAPPIOL);
            end;
            if Y = 14 then begin
              if (A= #54) and (TOISTOTOL = 20 ) then TOISTOTOL := 0;
              if (A = #52) and (TOISTOTOL = 1 ) then TOISTOTOL := 21;
              if A = #54 then inc(TOISTOTOL);
              if A = #52 then dec(TOISTOTOL);
              gotoxy(47,14);
              write('  ');
              gotoxy(47,14);
              write(TOISTOTOL);
            end;
            if Y = 11 then begin
              if (A = #54) and (KIMOIKOL =100) then KIMOIKOL := 0;
              if (A = #52) and (KIMOIKOL = 0 ) then KIMOIKOL := 100;
              if A = #54 then inc(KIMOIKOL,2);
              if A = #52 then dec(KIMOIKOL,2);
              gotoxy(49,11);
              write('    ');
              gotoxy(49,11);
              write(KIMOIKOL);
              gotoxy(51,12);
              write('   ');
              gotoxy(51,12);
              write(100-KIMOIKOL);
            end;
          end;
        until TOTUUS;
        if GRAAF = 0 then begin
          clrscr;
          writeln('                    *****  NUMEERINEN TULOSTUS  *****');
          writeln;
          writeln('     Pallonumero:                 Ulostuloaukko:');
          for LASK3 := 1 to TOISTOTOL do begin
            ARVONTA;
            AUKKO := 1;
            for LASK := 1 to TAPPIOL do begin
              if TAPPI[lask] = 1 then inc(AUKKO);
            end;
            writeln('       ',LASK3,'                    ',aukko);
          end;
          readln;
        end else begin
          for  LASK5 := 1 to TOISTOTOL do begin;
            H := ioresult;
            ARVONTA;
            H := ioresult;
            B := detect;
            initgraph(B,C,'');
            line(330,50,330+TAPPIOL*14,50+20*TAPPIOL);
            line(290,50,290-TAPPIOL*14,50+20*TAPPIOL);
            for B := 0 to TAPPIOL-1 do begin
              ALKUREUNA := 310 - B*26 div 2;
              dec(ALKUREUNA,B);
              for C := 0 to B do begin
                circle(ALKUREUNA+C*28,60+B*20,4);
              end;
            end;
            for LASK := 0 to C do begin
              line(ALKUREUNA+LASK*28,70+B*20,ALKUREUNA+LASK*28,80+B*20);
            end;
            B := 310;
            C := 40;
            for LASK := 1 to 4 do begin
              circle(B,C,LASK);
            end;
            for LASK2 := 1 to 10 do begin
	      for LASK3 := 1 to 4 do begin
                circle(B,C,LASK3);
              end;
              setcolor(0);
              for LASK3 := 1 to 4 do begin
                circle(B,C,LASK3);
              end;
              setcolor(15);
              inc(C);
            end;
            for LASK := 1 to TAPPIOL do begin
              if TAPPI[LASK] = 0 then begin
                for LASK2 := 1 to 2 do begin
                  for LASK4 := 1 to 7 do begin
                    dec(B,1);
                    for LASK3 := 1 to 4 do begin
                      circle(B,C,LASK3);
                    end;
                    setcolor(0);
                    for LASK3 := 1 to 4 do begin
                      circle(B,C,LASK3);
                    end;
                    setcolor(15);
                  end;
                  dec(C,1);
                end;
                for LASK2 := 1 to 22 do begin
                  inc(C,1);
                  for LASK3 := 1 to 4 do begin
                    circle(B,C,LASK3);
                  end;
                  setcolor(0);
                  for LASK3 := 1 to 4 do begin
                    circle(B,C,LASK3);
                  end;
                  setcolor(15);
                end;
              end else begin
                for LASK2 := 1 to 2 do begin
                  for LASK4 := 1 to 7 do begin
                    inc(B,1);
                    for LASK3 := 1 to 4 do begin
                      circle(B,C,LASK3);
                    end;
                    setcolor(0);
                    for LASK3 := 1 to 4 do begin
                      circle(B,C,LASK3);
                    end;
                    setcolor(15);
                  end;
                  dec(C,1);
                end;
                for LASK2 := 1 to 22 do begin
                  inc(C,1);
                  for LASK3 := 1 to 4 do begin
                    circle(B,C,LASK3);
                  end;
                  setcolor(0);
                  for LASK3 := 1 to 4 do begin
                    circle(B,C,LASK3);
                  end;
                  setcolor(15);
                end;
              end;
            end;
            clearviewport;
          end;
        end;
        closegraph;
        B := ioresult;
      until not TOTUUS;

end.
