program hiiri_esim1;

uses mouse,crt;

var ok : boolean;
    a,b,c,d : integer;

begin
  textbackground(blue);
  textcolor(yellow);
  clrscr;
  alusta_hiiri(ok);
  if not(ok) then
  begin
    write('HIIRI EI OLE ŽLYISSŽŽN ......');
    readln;
  end
  else
  begin
    write('HIIRI OK .... Paina enter .....');
    readln;
    clrscr;
    write('Paina enter, niin jatketaan ......');
    nayta_hiiri;
    readln;
    hiiri_piiloon;
    clrscr;
    window(5,5,70,20);
    textbackground(cyan);
    textcolor(black);
    clrscr;
    nayta_hiiri;
    writeln('HEIPPA !!!  Paina hiiren n„pp„int„ ');
    write('niin p„„set ohjelmasta ulos ......');
    repeat
      paikka_ja_nappulat(a,b,c,d);
      gotoxy(30,16);
      write('HIIREN SIJAINTI : ','X= ',a/8:4:0,'   Y= ',b/8:4:0);
    until ((c=1) or (d=1));
    hiiri_piiloon;

  end;
end.