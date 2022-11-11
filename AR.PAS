unit ar;
interface
uses dos,crt,printer,esit;
procedure vlisays;
procedure vpoisto;
procedure tilanne;
implementation
procedure kokovarasto;
begin
window(5,5,75,24);
textbackground(0);
textcolor(15);
clrscr;
b := 1;
c := 25;
writeln('     KOKO     PESŽT     KANNET     VENTTIILIT');
repeat
gotoxy(6,b+2);
writeln(c);
gotoxy(15,b+2);
writeln(pesat^[c]);
gotoxy(25,b+2);
writeln(kannet^[c]);
gotoxy(36,b+2);
writeln(venttiilit^[c]);
inc(b);
if b = 2 then inc(c,7);
if b = 3 then inc(c,8);
if b = 4 then inc(c,10);
if b = 5 then inc(c,15);
if b = 6 then inc(c,15);
if b = 7 then inc(c,20);
if b = 8 then inc(c,25);
if b = 9 then inc(c,25);
if b = 10 then inc(c,50);
if b = 11 then inc(c,50);
if b = 12 then inc(c,50);
until b > 12;
writeln;writeln;
writeln('   Tulostetaanko kirjoittimelle  (K/E) ?');
nappain  := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
b := 1;
c := 25;
writeln(lst,'    KOKO     PESŽT     KANNET     VENTTIILIT');
repeat
writeln(lst,'    ',c,'       ',pesat^[c],'        ', kannet^[c],'         ',venttiilit^[c]);
inc(b);
if b = 2 then inc(c,7);
if b = 3 then inc(c,8);
if b = 4 then inc(c,10);
if b = 5 then inc(c,15);
if b = 6 then inc(c,15);
if b = 7 then inc(c,20);
if b = 8 then inc(c,25);
if b = 9 then inc(c,25);
if b = 10 then inc(c,50);
if b = 11 then inc(c,50);
if b = 12 then inc(c,50);
until b > 12;
end;
end;
procedure yksikoko;
begin;
window(27,12,43,19);
textbackground(11);
textcolor(0);
repeat
totuus := false;
clrscr;
writeln(' Venttiilit');
writeln(' Kannet');
writeln(' Pes„t');
writeln(' kAikki');
writeln;
writeln(' Anna ');
writeln(' toimintokirjain');
nappain := readkey;
totuus := true;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
halt(1);
end;
if (nappain <> 'v') and (nappain <> 'V') then begin
if (nappain <> 'K') and (nappain <> 'k') then begin
if (nappain <> 'P') and (nappain <> 'p') then begin
if (nappain <> 'a') and (nappain <> 'A') then totuus := false;
end;
end;
end;
if not totuus then writeln(' V„„r„');writeln(' n„pp„in');
until totuus;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
if (nappain = 'k') or (nappain = 'K') then begin
clrscr;
writeln('KOON ',koko,'  KANSIA VARASTOSSA ON ', kannet^[koko]);
totuus := true;
writeln('TULOSTANKO KIRJOITTIMELLE  (K/E) ?');
nappain1 := readkey;
if (nappain1 = 'k') or (nappain1 = 'K') then begin
writeln(lst,'KOON ',koko,' KANSIA VARASTOSSA ON ',kannet^[koko]);
end;
end;
if (nappain = 'p') or (nappain = 'P') then begin
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
totuus := true;
writeln('KOON ',koko,'  PESIŽ VARASTOSSA ON ', pesat^[koko]);
writeln('TULOSTANKO KIRJOITTIMELLE  (K/E) ?');
nappain1 := readkey;
if (nappain1 = 'k') or (nappain1 = 'K') then begin
writeln(lst,'KOON ',koko,' PESIŽ VARASTOSSA ON ',pesat^[koko]);
end;
end;
if (nappain = 'v') or (nappain = 'V') then begin
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
totuus := true;
writeln('KOON ',koko,'  VENTTIILEITŽ VARASTOSSA ON ', venttiilit^[koko]);
writeln('TULOSTANKO KIRJOITTIMELLE  (K/E) ?');
nappain1 := readkey;
if (nappain1 = 'k') or (nappain1 = 'K') then begin
writeln(lst,'KOON ',koko,' VENTTIILEITŽ VARASTOSSA ON ',venttiilit^[koko]);
end;
end;
if (nappain = 'a') or (nappain = 'A') then begin
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
totuus := true;
writeln('KOOSTA ',koko,' ON VARASTOSSA:');
writeln('VENTTIILEITŽ ',venttiilit^[koko]);
writeln('KANSIA ',kannet^[koko]);
writeln('POHJIA ',pesat^[koko]);
writeln;
writeln(' TULOSTANKO KIRJOITTIMELLE (K/E) ?');
nappain1 := readkey;
if (nappain1 = 'k') or (nappain1 = 'K') then begin
writeln(lst,'KOOSTA ',koko,' ON VARASTOSSA:');
writeln(lst,'VENTTIILEITŽ ',venttiilit^[koko]);
writeln(lst,'KANSIA ',kannet^[koko]);
writeln(lst,'POHJIA ',pesat^[koko]);
end;
end;
nappain := 'z';
end;
procedure tilanne;
begin
chdir('\');
chdir('firma');
assign(luku,'varasto.dat');
reset(luku);
readln(luku,kannet^[25]);
readln(luku,pesat^[25]);
readln(luku,venttiilit^[25]);
readln(luku,kannet^[32]);
readln(luku,pesat^[32]);
readln(luku,venttiilit^[32]);
readln(luku,kannet^[40]);
readln(luku,pesat^[40]);
readln(luku,venttiilit^[40]);
readln(luku,kannet^[50]);
readln(luku,pesat^[50]);
readln(luku,venttiilit^[50]);
readln(luku,kannet^[65]);
readln(luku,pesat^[65]);
readln(luku,venttiilit^[65]);
readln(luku,kannet^[80]);
readln(luku,pesat^[80]);
readln(luku,venttiilit^[80]);
readln(luku,kannet^[100]);
readln(luku,pesat^[100]);
readln(luku,venttiilit^[100]);
readln(luku,kannet^[125]);
readln(luku,pesat^[125]);
readln(luku,venttiilit^[125]);
readln(luku,kannet^[150]);
readln(luku,pesat^[150]);
readln(luku,venttiilit^[150]);
readln(luku,kannet^[200]);
readln(luku,pesat^[200]);
readln(luku,venttiilit^[200]);
readln(luku,kannet^[250]);
readln(luku,pesat^[250]);
readln(luku,venttiilit^[250]);
readln(luku,kannet^[300]);
readln(luku,pesat^[300]);
readln(luku,venttiilit^[300]);
close (luku);
repeat;
window(20,9,33,15);
textbackground(10);
textcolor(0);
clrscr;
writeln(' Koko varasto');
writeln(' Yksi koko');
writeln;writeln;
writeln(' Anna');
writeln(' kirjain');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
halt(1);
end;
if (nappain = 'y') or (nappain = 'Y') then begin
totuus := true;
yksikoko;
end;
if (nappain = 'k') or (nappain = 'K') then begin
totuus := true;
kokovarasto;
end;
if not totuus then writeln(' V„„r„ n„pp„in !!!');
until totuus ;
end;
procedure vlisays;
begin
chdir('\');
chdir('firma');
assign(luku,'varasto.dat');
reset(luku);
readln(luku,kannet^[25]);
readln(luku,pesat^[25]);
readln(luku,venttiilit^[25]);
readln(luku,kannet^[32]);
readln(luku,pesat^[32]);
readln(luku,venttiilit^[32]);
readln(luku,kannet^[40]);
readln(luku,pesat^[40]);
readln(luku,venttiilit^[40]);
readln(luku,kannet^[50]);
readln(luku,pesat^[50]);
readln(luku,venttiilit^[50]);
readln(luku,kannet^[65]);
readln(luku,pesat^[65]);
readln(luku,venttiilit^[65]);
readln(luku,kannet^[80]);
readln(luku,pesat^[80]);
readln(luku,venttiilit^[80]);
readln(luku,kannet^[100]);
readln(luku,pesat^[100]);
readln(luku,venttiilit^[100]);
readln(luku,kannet^[125]);
readln(luku,pesat^[125]);
readln(luku,venttiilit^[125]);
readln(luku,kannet^[150]);
readln(luku,pesat^[150]);
readln(luku,venttiilit^[150]);
readln(luku,kannet^[200]);
readln(luku,pesat^[200]);
readln(luku,venttiilit^[200]);
readln(luku,kannet^[250]);
readln(luku,pesat^[250]);
readln(luku,venttiilit^[250]);
readln(luku,kannet^[300]);
readln(luku,pesat^[300]);
readln(luku,venttiilit^[300]);
close (luku);
repeat;
window(20,9,32,17);
textbackground(10);
textcolor(0);
clrscr;
writeln(' Kansia');
writeln(' Pesi„');
writeln(' Venttiieit„');
writeln;writeln(' Anna kirjain');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
halt(1);
end;
if (nappain = 'p') or (nappain = 'P') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat;
writeln;writeln(' Anna m„„r„ ');
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' pesi„ lis„t„„n varastoon ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
inc(pesat^[koko],maara);
end;
if (nappain = 'k') or (nappain = 'K') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat;
writeln;writeln(' Anna m„„r„ ');
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' kansia lis„t„„n varastoon ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
inc(kannet^[koko],maara);
end;
if (nappain = 'v') or (nappain = 'V') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat;
writeln;writeln(' Anna m„„r„ ');
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' venttiileit„ lis„t„„n varastoon ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
inc(venttiilit^[koko],maara);
end;
assign(luku,'varasto.dat');
rewrite(luku);
writeln(luku,kannet^[25]);
writeln(luku,pesat^[25]);
writeln(luku,venttiilit^[25]);
writeln(luku,kannet^[32]);
writeln(luku,pesat^[32]);
writeln(luku,venttiilit^[32]);
writeln(luku,kannet^[40]);
writeln(luku,pesat^[40]);
writeln(luku,venttiilit^[40]);
writeln(luku,kannet^[50]);
writeln(luku,pesat^[50]);
writeln(luku,venttiilit^[50]);
writeln(luku,kannet^[65]);
writeln(luku,pesat^[65]);
writeln(luku,venttiilit^[65]);
writeln(luku,kannet^[80]);
writeln(luku,pesat^[80]);
writeln(luku,venttiilit^[80]);
writeln(luku,kannet^[100]);
writeln(luku,pesat^[100]);
writeln(luku,venttiilit^[100]);
writeln(luku,kannet^[125]);
writeln(luku,pesat^[125]);
writeln(luku,venttiilit^[125]);
writeln(luku,kannet^[150]);
writeln(luku,pesat^[150]);
writeln(luku,venttiilit^[150]);
writeln(luku,kannet^[200]);
writeln(luku,pesat^[200]);
writeln(luku,venttiilit^[200]);
writeln(luku,kannet^[250]);
writeln(luku,pesat^[250]);
writeln(luku,venttiilit^[250]);
writeln(luku,kannet^[300]);
writeln(luku,pesat^[300]);
writeln(luku,venttiilit^[300]);
close (luku);
until totuus;
nappain := 'z';
nappain1 := 'z';
totuus := false;

end;
procedure vpoisto;
begin
chdir('\');
chdir('firma');
assign(luku,'varasto.dat');
reset(luku);
readln(luku,kannet^[25]);
readln(luku,pesat^[25]);
readln(luku,venttiilit^[25]);
readln(luku,kannet^[32]);
readln(luku,pesat^[32]);
readln(luku,venttiilit^[32]);
readln(luku,kannet^[40]);
readln(luku,pesat^[40]);
readln(luku,venttiilit^[40]);
readln(luku,kannet^[50]);
readln(luku,pesat^[50]);
readln(luku,venttiilit^[50]);
readln(luku,kannet^[65]);
readln(luku,pesat^[65]);
readln(luku,venttiilit^[65]);
readln(luku,kannet^[80]);
readln(luku,pesat^[80]);
readln(luku,venttiilit^[80]);
readln(luku,kannet^[100]);
readln(luku,pesat^[100]);
readln(luku,venttiilit^[100]);
readln(luku,kannet^[125]);
readln(luku,pesat^[125]);
readln(luku,venttiilit^[125]);
readln(luku,kannet^[150]);
readln(luku,pesat^[150]);
readln(luku,venttiilit^[150]);
readln(luku,kannet^[200]);
readln(luku,pesat^[200]);
readln(luku,venttiilit^[200]);
readln(luku,kannet^[250]);
readln(luku,pesat^[250]);
readln(luku,venttiilit^[250]);
readln(luku,kannet^[300]);
readln(luku,pesat^[300]);
readln(luku,venttiilit^[300]);
close (luku);
repeat;
window(20,9,32,17);
textbackground(10);
textcolor(0);
clrscr;
writeln(' Kansia');
writeln(' Pesi„');
writeln(' Venttiieit„');
writeln;writeln(' Anna kirjain');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
halt(1);
end;
if (nappain = 'p') or (nappain = 'P') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat
repeat
writeln;writeln(' Anna m„„r„ ');
totuus := true;
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' pesist„ v„hennet„„n varastosta ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
dec(pesat^[koko],maara);
if pesat^[koko] < 0 then begin
totuus := false;
inc(pesat^[koko],maara);
writeln(' Varastossa ei ole tarpeeksi tavaraa');
end;
until totuus;
end;
if (nappain = 'k') or (nappain = 'K') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat
repeat
writeln;writeln(' Anna m„„r„ ');
totuus := true;
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' kansista v„hennet„„n varastosta ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
dec(kannet^[koko],maara);
if kannet^[koko] < 0 then begin
totuus := false;
inc(kannet^[koko],maara);
writeln(' Varastossa ei ole tarpeeksi tavaraa');
end;
until totuus;
end;
if (nappain = 'v') or (nappain = 'V') then begin
totuus := true;
window(5,5,75,24);
textcolor(0);
textbackground(15);
clrscr;
repeat
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko !');
readln(koko1);
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then totuus := true;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
until totuus;
val(koko1,koko,a);
repeat
repeat
writeln;writeln(' Anna m„„r„ ');
totuus := true;
readln(maara);
if (maara < 1) or (maara >50) then begin
totuus := false;
writeln(' Mahdoton m„„r„');
end;
until totuus;
writeln(' Koon ',koko,' venttiileist„ v„hennet„„n varastosta ',maara);
writeln('  Oliko oikein (K/E)');
nappain1 := readkey;
if (nappain1 =  'e') or (nappain1 = 'E') then exit;
dec(venttiilit^[koko],maara);
if venttiilit^[koko] < 0 then begin
totuus := false;
inc(venttiilit^[koko],maara);
writeln(' Varastossa ei ole tarpeeksi tavaraa');
end;
until totuus;
end;
chdir('c:\');
chdir('firma');
assign(luku,'varasto.dat');
rewrite(luku);
writeln(luku,kannet^[25]);
writeln(luku,pesat^[25]);
writeln(luku,venttiilit^[25]);
writeln(luku,kannet^[32]);
writeln(luku,pesat^[32]);
writeln(luku,venttiilit^[32]);
writeln(luku,kannet^[40]);
writeln(luku,pesat^[40]);
writeln(luku,venttiilit^[40]);
writeln(luku,kannet^[50]);
writeln(luku,pesat^[50]);
writeln(luku,venttiilit^[50]);
writeln(luku,kannet^[65]);
writeln(luku,pesat^[65]);
writeln(luku,venttiilit^[65]);
writeln(luku,kannet^[80]);
writeln(luku,pesat^[80]);
writeln(luku,venttiilit^[80]);
writeln(luku,kannet^[100]);
writeln(luku,pesat^[100]);
writeln(luku,venttiilit^[100]);
writeln(luku,kannet^[125]);
writeln(luku,pesat^[125]);
writeln(luku,venttiilit^[125]);
writeln(luku,kannet^[150]);
writeln(luku,pesat^[150]);
writeln(luku,venttiilit^[150]);
writeln(luku,kannet^[200]);
writeln(luku,pesat^[200]);
writeln(luku,venttiilit^[200]);
writeln(luku,kannet^[250]);
writeln(luku,pesat^[250]);
writeln(luku,venttiilit^[250]);
writeln(luku,kannet^[300]);
writeln(luku,pesat^[300]);
writeln(luku,venttiilit^[300]);
close (luku);
until totuus;
nappain := 'z';
nappain1 := 'z';
totuus := false;
end;
begin
new(pesat);
new(kannet);
new(venttiilit);
end.
