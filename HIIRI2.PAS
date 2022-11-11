program hiiri_esim2;

uses crt,kirjasto,mouse;

var val : char;
    ok  : boolean;
    koodi,a,b,c,d,hx,hy : integer;

procedure VALIKKO ( var valittu : char );
{*******************************************************************
 * Aliohjelma tulostaa ohjelman pvalikon ja palauttaa paramet-   *
 * rinsa VALITTU arvona valitun toiminnon koodin                   *
 ******************************************************************* }

const  { valikon tiedot }
       valx   = 10;         { valikon x-koordinaatti }
       valy   =  4;         { valikon y-koordinaatti }
       valpit = 54;         { valikon pituus }
       valkork= 15;         { valikon korkeus }
       x      = 12;         { kaikkien kenttien x-koordinaatti }
       ekay   = 9;          { kenttien y-koordinaatit }
       tokay  = 10;
       kolmasy= 11;
       neljasy= 12;
       vikay  = 14;

       { valikkotekstit }
       teksti1 = '1. HENKILN LISYS';
       teksti2 = '2. HENKILN POISTO';
       teksti3 = '3. TIETOJEN MUUTOS';
       teksti4 = '4. TIETOJEN KATSELU';
       teksti6 = '*  LOPETUS';

       { toimintonppinten antamat koodit }
       enter    = #13;
       ylanuoli = #72;
       alanuoli = #80;

var    mrk    : char;        { luettu merkki }
       y      : integer;     { kohdistimen pystysuunt. sijainti nyt”ll }
       vanhay : integer;     { aikaisempi y:n arvo }


{ -------------------------------------------------------------- }
procedure TULOSTATEKSTI( edusta,tausta : byte ; sij : byte);
{*****************************************************************
 * Aliohjelma tulostaa valikkotekstin annetulla vrill,         *
 * annetunvriseen kenttn, parametrin sij kertomaan paikkaan   *
 ***************************************************************** }

begin
  textcolor(edusta);
  textbackground(tausta);
  case sij of
    ekay    :begin
              gotoxy(x,ekay);
              write(teksti1);
             end;
    tokay   :begin
              gotoxy(x,tokay);
              write(teksti2);
             end;
    kolmasy :begin
              gotoxy(x,kolmasy);
              write(teksti3);
             end;
    neljasy :begin
              gotoxy(x,sij);
              write(teksti4);
             end;
    vikay   :begin
              gotoxy(x,sij);
              write(teksti6);
             end;
  end;

  {siirretn kohdistin takaisin rivin alkuun}
  gotoxy(x,sij);

end;

{ ----------------------------------------------------- }

begin

     PUTSAA_NAYTTO;
     AVAA_IKKUNA(valx+2,valy+1,valx+valpit+2
                 ,valy+valkork+1,black,white);
     AVAA_IKKUNA(valx,valy,valx+valpit,valy+valkork,blue,white);

     writeln('ษออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     writeln('บ                                                    บ');
     writeln('บ        H E N K I L  R E K I S T E R I             บ');
     writeln('บ                                                    บ');
     writeln('บ              P   V A L I K K O                   บ');
     writeln('บ                                                    บ');
     writeln('ฬออออออออออออออออออออออออออออออออออออออออออออออออออออน');
     writeln('บ                                                    บ');
     writeln('บ          1. HENKILN LISYS                        บ');
     writeln('บ          2. HENKILN POISTO                        บ');
     writeln('บ          3. TIETOJEN MUUTOS                        บ');
     writeln('บ          4. TIETOJEN KATSELU                       บ');
     writeln('บ                                                    บ');
     writeln('บ          *  LOPETUS                                บ');
     writeln('บ                                      (C) Kuka Lie  บ');
     write  ('ศออออออออออออออออออออออออออออออออออออออออออออออออออออผ');

     y := ekay;
     d := 0;

     repeat

       { jos siirrytn niin palautetaan vanha kentt taas
         sinivalkoiseksi }
       TULOSTATEKSTI(white,blue,vanhay);

       { otetaan y talteen seuraavaa siirtymist varten }
       vanhay := y;
       TULOSTATEKSTI(black,cyan,y);

       NAYTA_HIIRI;

       { luetaan seuraava merkki }
       koodi:=0;
       c:=0;
       d:=0;
       repeat
         paikka_ja_nappulat(a,b,c,d);
         if (keypressed) then koodi:=1;
         if (c=1) then koodi := 2;
         if (d=1) then koodi := 3;
       until(koodi<>0);
       if (koodi=1) then
       begin
         mrk := readkey;
         if (mrk = #0) then    { jos toimintonppin }
         begin
           mrk := readkey;
           case mrk of
             ylanuoli : begin
                          case wherey of
                            ekay :  y := vikay;
                            vikay:  y := neljasy;
                            else y := wherey - 1;
                          end;
                        end;
             alanuoli : begin
                          case wherey of
                            vikay  :  y := ekay;
                            neljasy:  y := vikay;
                            else y := wherey + 1;
                          end;
                        end;
           end;
         end
         else  { jos valinta tehty suoraan tunnuksella }
         begin
           { katsotaan, mihin pit menn }
           case mrk of
             '1' : y := ekay;
             '2' : y := tokay;
             '3' : y := kolmasy;
             '4' : y := neljasy;
             '*' : y := vikay;
           end;
         end
       end
       else
       begin
        if (koodi=2) then
        begin
         { jos painettu hiirt }
         hx := a div 8;
         hy := b div 8;
         if (hy=11) and (hx>=20) and (hx<=37) then y:=ekay;
         if (hy=12) and (hx>=20) and (hx<=37) then y:=tokay;
         if (hy=13) and (hx>=20) and (hx<=37) then y:=kolmasy;
         if (hy=14) and (hx>=20) and (hx<=38) then y:=neljasy;
         if (hy=16) and (hx>=20) and (hx<=29) then y:=vikay;
        end;
       end;
       HIIRI_PIILOON;
     until ( (mrk = enter) or (d = 1) );

     { mit tulikaan valittua }
     case y of
      ekay    : valittu := '1';
      tokay   : valittu := '2';
      kolmasy : valittu := '3';
      neljasy : valittu := '4';
      vikay   : valittu := '*';
     end;

end;
{ ---------------------------------------------------------------- }

begin
  ALUSTA_HIIRI(ok);
  if not(ok) then
  begin
    write('HIIRI EI OLE LYISSN .......');
    readln;
    halt(1);
  end
  else
  begin
    STEKSTIKURSORI;
    valikko(val);
    clrscr;
    write('Valittu oli ',val);
    readln;
  end;
end.