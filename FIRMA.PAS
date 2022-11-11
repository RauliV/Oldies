uses printer,dos,crt,esit,ar;

procedure varasto;
begin
  totuus := false;
  window(17,5,25,12);
  repeat
   textbackground(0);
   textcolor(15);
   clrscr;
   writeln(' Lis„ys');
   writeln(' Poisto');
   writeln(' Tilanne');
   writeln;
   writeln(' Anna');
   writeln(' kirjain ');
   nappain := readkey;
   if (nappain = 'u') or (nappain = 'U') then begin
     nappain := 'z';
     totuus := false;
     exit;
    end;
    if (nappain = 'l') or (nappain = 'L') then begin
      vlisays;
      totuus := true;
    end;
    if (nappain = 'p') or (nappain = 'P') then begin
      vpoisto;
      totuus := true;
    end; 
if (nappain = 't') or (nappain ='T') then begin
totuus := true;
tilanne;
end;
if not totuus then writeln(' V„„r„ n„pp„in !!!');
until totuus;
nappain := 'z';
totuus := false;
end;






procedure oletustenvaihto;
begin
window(5,5,75,24);
textcolor(0);
textbackground(15);
chdir('c:\');
chdir('firma');
clrscr;
writeln('          OLETUSTEN VAIHTO');
writeln;writeln;
totuus := true;
repeat
repeat
writeln('Anna uusi p„iv„ (kahdella numerolla)');
readln(paiva2);
totuus := true;
if paiva2 = 'u' then exit;
if length(paiva2) <> 2 then begin
writeln('Kaksi numeroa  !!');
totuus := false;
end;
until totuus;
val(paiva2,paiva3,a);
totuus := true;
if (paiva3 < 01) or (paiva3 > 31 ) then begin
writeln(' Mahdoton p„iv„ys !!');
totuus := false;
end;
until totuus;
repeat
repeat
writeln('Anna uusi kuukausi (kahdella numerolla)');
readln(kuu2);
val(kuu2,kuu3,a);
totuus := true;
if length(kuu2) <> 2 then begin
writeln('Kaksi numeroa  !!');
totuus := false;
end;
until totuus;
totuus := true;
if (kuu3 < 01) or (kuu3 > 12 ) then begin
writeln(' Mahdoton kuukausi !!');
totuus := false;
end;
until totuus;
{$i-}
a := ioresult;
writeln('Anna vuosi');
readln(vuosi2);
chdir(vuosi2);
if ioresult <> 0 then begin
totuus := true;
repeat
a := ioresult;
val(vuosi2,vuosi3,a);
totuus := true;
if (vuosi3 < 1980) or (vuosi3 > 2099) then begin
totuus := false;
writeln('Mahdoton vuosi');
end;
if totuus = false then begin
writeln('Anna vuosi');
readln(vuosi2);
end;
until totuus;
writeln(' Antamastasi vuodesta ei ole viel„ mit„„n tietoja');
writeln('   Alustetaanko vuosi  (K/E) ?');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'k') or (nappain = 'K') then begin
mkdir(vuosi2);
chdir(vuosi2);
end;
end
else val(vuosi2,vuosi3,a);
setdate(vuosi3,kuu3,paiva3);
getdate(vuosi4,kuu4,paiva4,vko4);
if vko4  = 0  then paiva1 := 'SUNNUNTAI';
if vko4 = 1 then paiva1 := 'MAANANTAI';
if vko4 = 2 then paiva1 := 'TIISTAI';
if vko4 = 3 then paiva1 := 'KESKIVIIKKO';
if vko4 = 4 then paiva1 := 'TORSTAI';
if vko4 = 5 then paiva1 := 'PERJANTAI';
if vko4 = 6 then paiva1 := 'LAUNANTAI';
window(1,1,80,25);
textbackground(0);
clrscr;
textcolor(15);
writeln(' Oletus on : ',paiva1,' ',paiva4,'.',kuu4,' ',vuosi4);
end;
procedure tpaiva;
begin
chdir('\');
chdir('firma');
window(12,5,37,24);
doserror := 0;
textcolor(0);
textbackground(11);
clrscr;
a := 0;
findfirst('*.',directory,hae);
while doserror = 0 do begin
inc(a);
if a > 2 then begin
writeln(a-2,'.) ',hae.name);
end;
findnext(hae);
end;
dec(a,2);
repeat
writeln;writeln(' Anna vuoden numero');
readln(vara);
if (vara > a) or (vara < 1) then begin
totuus := false;
writeln(' V„„r„ luku');
end
else totuus := true;
until totuus;
findfirst('*.',directory,hae);
findnext(hae);
findnext(hae);
if vara > 1 then begin
for a := 1 to vara+1 do begin
findnext(hae);
end;
end;
chdir(hae.name);
findfirst('*.day',archive,hae);
a:=1;
while doserror = 0 do begin;
osa := hae.name;
delete(osa,5,4);
osa1 := osa;
delete (osa,3,2);
delete (osa1,1,2);
insert('.',osa,3);
osa3 := copy(osa,1,1);
if osa3 = '0' then delete(osa,1,1);
osa3 := copy(osa1,1,1);
if osa3 = '0' then delete(osa1,1,1);
hae.name := concat(osa,osa1);
writeln(a,'.) ',hae.name);
inc(a);
findnext(hae);
end;
repeat
writeln('  Anna p„iv„n numero');
readln(vara);
if (vara < 1) or (vara > a ) then begin
writeln(' V„„r„ numero');
totuus := false;
end
else totuus := true;
until totuus;
findfirst('*.day',archive,hae);
if vara > 1 then begin
for a := 1 to vara-1 do begin
findnext(hae);
end;
end;
assign(luku,hae.name);
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
s := concat(osa1,osa);
window(10,5,50,22);
clrscr;
writeln('         ',s);
writeln;writeln;
writeln('    KOKO        LAATU        MŽŽRŽ');
writeln;writeln;
writeln('    25          KANNET      ',kannet^[25]);
writeln('                PESŽT       ',pesat^[25]);
writeln('                VENTTIILIT  ',venttiilit^[25]);
writeln;
writeln('    32          KANNET      ',kannet^[32]);
writeln('                PESŽT       ',pesat^[32]);
writeln('                VENTTIILIT  ',venttiilit^[32]);
writeln;
writeln('    40          KANNET      ',kannet^[40]);
writeln('                PESŽT       ',pesat^[40]);
writeln('                VENTTIILIT  ',venttiilit^[40]);
writeln;
writeln('    50          KANNET      ',kannet^[50]);
writeln('                PESŽT       ',pesat^[50]);
writeln('                VENTTIILIT  ',venttiilit^[50]);
readln;
clrscr;
writeln('    65          KANNET      ',kannet^[65]);
writeln('                PESŽT       ',pesat^[65]);
writeln('                VENTTIILIT  ',venttiilit^[65]);
writeln;
writeln('    80          KANNET      ',kannet^[80]);
writeln('                PESŽT       ',pesat^[80]);
writeln('                VENTTIILIT  ',venttiilit^[80]);
writeln;
writeln('    100         KANNET      ',kannet^[100]);
writeln('                PESŽT       ',pesat^[100]);
writeln('                VENTTIILIT  ',venttiilit^[100]);
writeln;
writeln('    125         KANNET      ',kannet^[125]);
writeln('                PESŽT       ',pesat^[125]);
writeln('                VENTTIILIT  ',venttiilit^[125]);
readln;
clrscr;
writeln('    150         KANNET      ',kannet^[150]);
writeln('                PESŽT       ',pesat^[150]);
writeln('                VENTTIILIT  ',venttiilit^[150]);
writeln;
writeln('    200         KANNET      ',kannet^[200]);
writeln('                PESŽT       ',pesat^[200]);
writeln('                VENTTIILIT  ',venttiilit^[200]);
writeln;
writeln('    250         KANNET      ',kannet^[250]);
writeln('                PESŽT       ',pesat^[250]);
writeln('                VENTTIILIT  ',venttiilit^[250]);
writeln;
writeln('    300         KANNET      ',kannet^[300]);
writeln('                PESŽT       ',pesat^[300]);
writeln('                VENTTIILIT  ',venttiilit^[300]);
writeln;
writeln(' Kirjoittimelle (K/E) ?');
nappain := readkey;
if (nappain = 'k') or (nappain ='K') then begin
writeln(lst,'         ',s);
writeln(lst);writeln(lst);
writeln(lst,'    KOKO        LAATU        MŽŽRŽ');
writeln(lst);writeln(lst);
writeln(lst,'    25          KANNET      ',kannet^[25]);
writeln(lst,'                PESŽT       ',pesat^[25]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[25]);
writeln(lst);
writeln(lst,'    32          KANNET      ',kannet^[32]);
writeln(lst,'                PESŽT       ',pesat^[32]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[32]);
writeln(lst);
writeln(lst,'    40          KANNET      ',kannet^[40]);
writeln(lst,'                PESŽT       ',pesat^[40]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[40]);
writeln(lst);
writeln(lst,'    50          KANNET      ',kannet^[50]);
writeln(lst,'                PESŽT       ',pesat^[50]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[50]);
writeln(lst);
writeln(lst,'    65          KANNET      ',kannet^[65]);
writeln(lst,'                PESŽT       ',pesat^[65]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[65]);
writeln(lst);
writeln(lst,'    80          KANNET      ',kannet^[80]);
writeln(lst,'                PESŽT       ',pesat^[80]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[80]);
writeln(lst);
writeln(lst,'    100         KANNET      ',kannet^[100]);
writeln(lst,'                PESŽT       ',pesat^[100]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[100]);
writeln(lst);
writeln(lst,'    125         KANNET      ',kannet^[125]);
writeln(lst,'                PESŽT       ',pesat^[125]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[125]);
writeln(lst);
writeln(lst,'    150         KANNET      ',kannet^[150]);
writeln(lst,'                PESŽT       ',pesat^[150]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[150]);
writeln(lst);
writeln(lst,'    200         KANNET      ',kannet^[200]);
writeln(lst,'                PESŽT       ',pesat^[200]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[200]);
writeln(lst);
writeln(lst,'    250         KANNET      ',kannet^[250]);
writeln(lst,'                PESŽT       ',pesat^[250]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[250]);
writeln(lst);
writeln(lst,'    300         KANNET      ',kannet^[300]);
writeln(lst,'                PESŽT       ',pesat^[300]);
writeln(lst,'                VENTTIILIT  ',venttiilit^[300]);
totuus := true;
nappain := 'z';
end;
end;
procedure tventtiili;
begin
begin
chdir('\');
chdir('firma');
window(12,5,37,24);
doserror := 0;
textcolor(0);
textbackground(11);
clrscr;
a := 0;
findfirst('*.',directory,hae);
while doserror = 0 do begin
inc(a);
if a > 2 then begin
writeln(a-2,'.) ',hae.name);
end;
findnext(hae);
end;
dec(a,2);
repeat
writeln;writeln(' Anna vuoden numero');
readln(vara);
if (vara > a) or (vara < 1) then begin
totuus := false;
writeln(' V„„r„ luku');
end
else totuus := true;
until totuus;
findfirst('*.',directory,hae);
findnext(hae);
findnext(hae);
if vara > 1 then begin
for a := 1 to vara+1 do begin
findnext(hae);
end;
end;
chdir(hae.name);
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
doserror := 0;
a := ioresult;
a:= 0;
window(10,5,50,22);
clrscr;
writeln('    Koosta : ',koko);
findfirst('*.day',archive,hae);
while doserror = 0 do begin
assign(luku,hae.name);
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
a := ioresult;
totuus := true;
if kannet^[koko] = 0 then begin
if pesat^[koko] = 0 then begin
if venttiilit^[koko] = 0 then totuus := false;
end;
end;
if totuus then begin
inc(a);
delete(hae.name,5,4);
writeln('  ',hae.name,'    VENTTIILEITŽ ',venttiilit^[koko]);
writeln('          PESIŽ ',pesat^[koko]);
writeln('          KANSIA ',kannet^[koko]);
writeln;
writeln;writeln;
end;
if (a = 3) or (a = 6) or (a = 9) or (a = 12) or (a = 15) or (a = 18) then readln;
findnext(hae);
end;
end;
writeln('  Kirjoittimelle   (K/E)');
nappain := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
writeln(lst,'    Koosta : ',koko);
findfirst('*.day',archive,hae);
while doserror = 0 do begin
assign(luku,hae.name);
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
a := ioresult;
totuus := true;
if kannet^[koko] = 0 then begin
if pesat^[koko] = 0 then begin
if venttiilit^[koko] = 0 then totuus := false;
end;
end;
if totuus then begin
inc(a);
delete(hae.name,5,4);
writeln(lst,'  ',hae.name,'    VENTTIILEITŽ ',venttiilit^[koko]);
writeln(lst,'          PESIŽ ',pesat^[koko]);
writeln(lst,'          KANSIA ',kannet^[koko]);
writeln(lst);
writeln(lst);
end;
findnext(hae);
end;
end;
totuus := true;
nappain := 'z';
end;
procedure ventarkistus;
begin
repeat
window(27,11,45,14);
textbackground(11);
textcolor(0);
clrscr;
writeln(' P„iv„-venttiili');
writeln(' Venttiili-p„iv„');
writeln;write(' Anna kirjain ');
totuus := false;
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'p') or (nappain = 'P') then tpaiva;
if (nappain = 'v') or (nappain ='V') then tventtiili;
until totuus;
totuus := false;
end;
procedure uusivienti;
begin
window(10,5,50,22);
textcolor(0);
textbackground(11);
clrscr;
writeln('   Onko oletus p„iv„ys oikein (K/E)');
nappain := readkey;
if (nappain = 'e') or (nappain ='E') then begin
totuus := true;
nappain := 'z';
writeln(' Vaihda se sitten oletuksenvaihdosta');
delay (2000);
exit;
end;
c := 0;
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(c);
lisa[c] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
for a := 1 to c do begin
val(lisa[a],lisaa[a],b)
end;
for a := 1 to 300 do begin
kannet^[a] := 0;
pesat^[a] := 0;
venttiilit^[a]:= 0;
end;

for a := 1 to c do begin
clrscr;
writeln('  Koosta ',lisa[a],' vied„„n:');
write('  Venttiileit„     ');
readln(venttiilit^[lisaa[a]]);
writeln;
write('  Kansia     ');
readln(kannet^[lisaa[a]]);
writeln;
write('  Pesi„     ');
readln(pesat^[lisaa[a]]);
end;
chdir('\');
chdir('firma');
getdate(vuosi,kuu,paiva,vko);
str(vuosi,vuosi2);
chdir(vuosi2);
a := ioresult;
str(kuu,kuu2);
if length(kuu2) < 2 then begin
insert('0',kuu2,0);
end;
str(paiva,paiva2);
if length(paiva2) < 2 then begin
insert('0',paiva2,0);
end;
paivays := concat(paiva2,kuu2);
insert('.day',paivays,length(paivays)+1);
assign(luku,paivays);
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
end;
procedure venpoisto;
begin
chdir('\');
chdir('firma');
window(12,5,37,24);
doserror := 0;
textcolor(0);
textbackground(11);
clrscr;
a := 0;
findfirst('*.',directory,hae);
while doserror = 0 do begin
inc(a);
if a > 2 then begin
writeln(a-2,'.) ',hae.name);
end;
findnext(hae);
end;
dec(a,2);
repeat
writeln;writeln(' Anna vuoden numero');
readln(vara);
if (vara > a) or (vara < 1) then begin
totuus := false;
writeln(' V„„r„ luku');
end
else totuus := true;
until totuus;
findfirst('*.',directory,hae);
if vara > 1 then begin
for a := 1 to vara+1 do begin
findnext(hae);
end;
end;
chdir(hae.name);
findfirst('*.day',archive,hae);
a:=1;
while doserror = 0 do begin;
osa := hae.name;
delete(osa,5,4);
osa1 := osa;
delete (osa,3,2);
delete (osa1,1,2);
insert('.',osa1,3);
osa3 := copy(osa,1,1);
if osa3 = '0' then delete(osa,1,1);
osa3 := copy(osa1,1,1);
if osa3 = '0' then delete(osa1,1,1);
hae.name := concat(osa1,osa);
writeln(a,'.) ',hae.name);
inc(a);
findnext(hae);
end;
if a > 1 then begin
repeat
writeln('  Anna p„iv„n numero');
readln(vara);
if (vara < 1) or (vara > a ) then begin
writeln(' V„„r„ numero');
totuus := false;
end
else totuus := true;
until totuus;
findfirst('*.day',archive,hae);
if vara > 1 then begin
for a := 1 to vara-1 do begin
findnext(hae);
end;
end;
writeln(' Oletko varma, ett„ ');
writeln(' p„iv„ys tuhotaan (K/E)');
nappain := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
assign(luku,hae.name);
erase(luku)
end;
end
else writeln('P„ivi„ ei ole en„„');
delay(2000);
end;
procedure roletustenvaihto;
begin
chdir('/');
chdir('firma');
assign(luku,'rkirj.dat');
reset(luku);
readln(luku,lvv);
readln(luku,pos1^[25]);
readln(luku,pos1^[32]);
readln(luku,pos1^[40]);
readln(luku,pos1^[50]);
readln(luku,pos1^[65]);
readln(luku,pos1^[80]);
readln(luku,pos1^[100]);
readln(luku,pos1^[125]);
readln(luku,pos1^[150]);
readln(luku,pos1^[200]);
readln(luku,pos1^[250]);
readln(luku,pos1^[300]);
readln(luku,pos2^[25]);
readln(luku,pos2^[32]);
readln(luku,pos2^[40]);
readln(luku,pos2^[50]);
readln(luku,pos2^[65]);
readln(luku,pos2^[80]);
readln(luku,pos2^[100]);
readln(luku,pos2^[125]);
readln(luku,pos2^[150]);
readln(luku,pos2^[200]);
readln(luku,pos2^[250]);
readln(luku,pos2^[300]);
readln(luku,pos3^[25]);
readln(luku,pos3^[32]);
readln(luku,pos3^[40]);
readln(luku,pos3^[50]);
readln(luku,pos3^[65]);
readln(luku,pos3^[80]);
readln(luku,pos3^[100]);
readln(luku,pos3^[125]);
readln(luku,pos3^[150]);
readln(luku,pos3^[200]);
readln(luku,pos3^[250]);
readln(luku,pos3^[300]);
readln(luku,pos4^[25]);
readln(luku,pos4^[32]);
readln(luku,pos4^[40]);
readln(luku,pos4^[50]);
readln(luku,pos4^[65]);
readln(luku,pos4^[80]);
readln(luku,pos4^[100]);
readln(luku,pos4^[125]);
readln(luku,pos4^[150]);
readln(luku,pos4^[200]);
readln(luku,pos4^[250]);
readln(luku,pos4^[300]);
readln(luku,pos5^[25]);
readln(luku,pos5^[32]);
readln(luku,pos5^[40]);
readln(luku,pos5^[50]);
readln(luku,pos5^[65]);
readln(luku,pos5^[80]);
readln(luku,pos5^[100]);
readln(luku,pos5^[125]);
readln(luku,pos5^[150]);
readln(luku,pos5^[200]);
readln(luku,pos5^[250]);
readln(luku,pos5^[300]);
close(luku);
a := ioresult;
window(39,12,59,21);
textcolor(15);
textbackground(0);
clrscr;

writeln(' Lvv');
writeln(' Kansien korjaus');
writeln(' kumin Poltto');
writeln(' kOkoonpano');
writeln(' Ruuvien kiinnitys');
writeln(' Siemennysyhteydet');
writeln;write('Anna valinta ');
nappain := readkey;
totuus := false;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'K') or (nappain = 'k') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
for b := 1 to 12 do begin
writeln(' ',b,'.)  ',koot[b]);
end;
write(' Anna numero  ');;
readln(a);
if (a < 1 ) or (a > 11) then begin
totuus := false;
writeln(' V„„r„ luku');
end;
until totuus;
val(koot[a],b,c);
repeat
totuus := true;
writeln(' Oletus on ',pos1^[b]);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
pos1^[b] := vast;
end;
writeln(' Oliko ',pos1^[b],' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
if (nappain = 'p') or (nappain = 'P') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
for b := 1 to 12 do begin
writeln(' ',b,'.)  ',koot[b]);
end;
write(' Anna numero  ');;
readln(a);
if (a < 1 ) or (a > 11) then begin
totuus := false;
writeln(' V„„r„ luku');
end;
until totuus;
val(koot[a],b,c);
repeat
totuus := true;
writeln(' Oletus on ',pos2^[b]);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
pos2^[b] := vast;
end;
writeln(' Oliko ',pos2^[b],' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
if (nappain = 'o') or (nappain = 'O') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
for b := 1 to 12 do begin
writeln(' ',b,'.)  ',koot[b]);
end;
write(' Anna numero  ');;
readln(a);
if (a < 1 ) or (a > 11) then begin
totuus := false;
writeln(' V„„r„ luku');
end;
until totuus;
val(koot[a],b,c);
repeat
totuus := true;
writeln(' Oletus on ',pos3^[b]);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
pos3^[b] := vast;
end;
writeln(' Oliko ',pos3^[b],' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
if (nappain = 'r') or (nappain = 'R') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
for b := 1 to 12 do begin
writeln(' ',b,'.)  ',koot[b]);
end;
write(' Anna numero  ');;
readln(a);
if (a < 1 ) or (a > 11) then begin
totuus := false;
writeln(' V„„r„ luku');
end;
until totuus;
val(koot[a],b,c);
repeat
totuus := true;
writeln(' Oletus on ',pos4^[b]);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
pos4^[b] := vast;
end;
writeln(' Oliko ',pos4^[b],' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
if (nappain = 's') or (nappain = 'S') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
for b := 1 to 12 do begin
writeln(' ',b,'.)  ',koot[b]);
end;
write(' Anna numero  ');;
readln(a);
if (a < 1 ) or (a > 11) then begin
totuus := false;
writeln(' V„„r„ luku');
end;
until totuus;
val(koot[a],b,c);
repeat
totuus := true;
writeln(' Oletus on ',pos5^[b]);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
pos5^[b] := vast;
end;
writeln(' Oliko ',pos5^[b],' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
if (nappain = 'l') or (nappain = 'L') then begin
window(12,5,37,24);
repeat
clrscr;
totuus := true;
writeln(' Oletus on ',lvv);
writeln(' Anna uusi luku ');
writeln(' (enter = oletus) ');
readln(vast);
if length(vast) > 0 then begin
lvv := vast;
end;
writeln(' Oliko ',lvv,' oikein');
nappain1 := readkey;
if (nappain1 = 'E') or (nappain1 = 'e') then begin
totuus := false
end;
until totuus;
end;
assign(luku,'rkirj.dat');
rewrite(luku);
writeln(luku,lvv);
writeln(luku,pos1^[25]);
writeln(luku,pos1^[32]);
writeln(luku,pos1^[40]);
writeln(luku,pos1^[50]);
writeln(luku,pos1^[65]);
writeln(luku,pos1^[80]);
writeln(luku,pos1^[100]);
writeln(luku,pos1^[125]);
writeln(luku,pos1^[150]);
writeln(luku,pos1^[200]);
writeln(luku,pos1^[250]);
writeln(luku,pos1^[300]);
writeln(luku,pos2^[25]);
writeln(luku,pos2^[32]);
writeln(luku,pos2^[40]);
writeln(luku,pos2^[50]);
writeln(luku,pos2^[65]);
writeln(luku,pos2^[80]);
writeln(luku,pos2^[100]);
writeln(luku,pos2^[125]);
writeln(luku,pos2^[150]);
writeln(luku,pos2^[200]);
writeln(luku,pos2^[250]);
writeln(luku,pos2^[300]);
writeln(luku,pos3^[25]);
writeln(luku,pos3^[32]);
writeln(luku,pos3^[40]);
writeln(luku,pos3^[50]);
writeln(luku,pos3^[65]);
writeln(luku,pos3^[80]);
writeln(luku,pos3^[100]);
writeln(luku,pos3^[125]);
writeln(luku,pos3^[150]);
writeln(luku,pos3^[200]);
writeln(luku,pos3^[250]);
writeln(luku,pos3^[300]);
writeln(luku,pos4^[25]);
writeln(luku,pos4^[32]);
writeln(luku,pos4^[40]);
writeln(luku,pos4^[50]);
writeln(luku,pos4^[65]);
writeln(luku,pos4^[80]);
writeln(luku,pos4^[100]);
writeln(luku,pos4^[125]);
writeln(luku,pos4^[150]);
writeln(luku,pos4^[200]);
writeln(luku,pos4^[250]);
writeln(luku,pos4^[300]);
writeln(luku,pos5^[25]);
writeln(luku,pos5^[32]);
writeln(luku,pos5^[40]);
writeln(luku,pos5^[50]);
writeln(luku,pos5^[65]);
writeln(luku,pos5^[80]);
writeln(luku,pos5^[100]);
writeln(luku,pos5^[125]);
writeln(luku,pos5^[150]);
writeln(luku,pos5^[200]);
writeln(luku,pos5^[250]);
writeln(luku,pos5^[300]);
close(luku);
end;
procedure uusikirja;
begin
chdir('/');
chdir('firma');
assign(luku,'rkirj.dat');
reset(luku);
readln(luku,lvv);
readln(luku,pos1^[25]);
readln(luku,pos1^[32]);
readln(luku,pos1^[40]);
readln(luku,pos1^[50]);
readln(luku,pos1^[65]);
readln(luku,pos1^[80]);
readln(luku,pos1^[100]);
readln(luku,pos1^[125]);
readln(luku,pos1^[150]);
readln(luku,pos1^[200]);
readln(luku,pos1^[250]);
readln(luku,pos1^[300]);
readln(luku,pos2^[25]);
readln(luku,pos2^[32]);
readln(luku,pos2^[40]);
readln(luku,pos2^[50]);
readln(luku,pos2^[65]);
readln(luku,pos2^[80]);
readln(luku,pos2^[100]);
readln(luku,pos2^[125]);
readln(luku,pos2^[150]);
readln(luku,pos2^[200]);
readln(luku,pos2^[250]);
readln(luku,pos2^[300]);
readln(luku,pos3^[25]);
readln(luku,pos3^[32]);
readln(luku,pos3^[40]);
readln(luku,pos3^[50]);
readln(luku,pos3^[65]);
readln(luku,pos3^[80]);
readln(luku,pos3^[100]);
readln(luku,pos3^[125]);
readln(luku,pos3^[150]);
readln(luku,pos3^[200]);
readln(luku,pos3^[250]);
readln(luku,pos3^[300]);
readln(luku,pos4^[25]);
readln(luku,pos4^[32]);
readln(luku,pos4^[40]);
readln(luku,pos4^[50]);
readln(luku,pos4^[65]);
readln(luku,pos4^[80]);
readln(luku,pos4^[100]);
readln(luku,pos4^[125]);
readln(luku,pos4^[150]);
readln(luku,pos4^[200]);
readln(luku,pos4^[250]);
readln(luku,pos4^[300]);
readln(luku,pos5^[25]);
readln(luku,pos5^[32]);
readln(luku,pos5^[40]);
readln(luku,pos5^[50]);
readln(luku,pos5^[65]);
readln(luku,pos5^[80]);
readln(luku,pos5^[100]);
readln(luku,pos5^[125]);
readln(luku,pos5^[150]);
readln(luku,pos5^[200]);
readln(luku,pos5^[250]);
readln(luku,pos5^[300]);
close(luku);
a := ioresult;
window(5,21,41,24);
clrscr;
writeln('   Onko oletus p„iv„ys oikein (K/E)');
nappain := readkey;
if (nappain = 'e') or (nappain ='E') then begin
totuus := true;
nappain := 'z';
writeln(' Vaihda se sitten oletuksenvaihdosta');
delay (2000);
exit;
end;
FOR a := 1 To 11 do begin
val(koot[a],b,c);
d := pos(',',pos1^[b]);
if d <> 0 then begin
delete(pos1^[b],d,1);
d := length(pos1^[b])-d;
val(pos1^[b],e,f);
if d = 1 then d := 100;
if d = 2 then d := 1000;
if d = 3 then d := 10000;
e := e / d;
s1^[b] := e;
end
else val(pos1^[b],s1^[b],d);
d := pos(',',pos2^[b]);
if d <> 0 then begin
delete(pos2^[b],d,1);
d := length(pos2^[b])-d;
val(pos2^[b],e,f);
if d = 1 then d := 100;
if d = 2 then d := 1000;
if d = 3 then d := 10000;
e := e/d;
s2^[b] := e;
end
else val(pos2^[b],s2^[b],d);
d := pos(',',pos3^[b]);
if d <> 0 then begin
delete(pos3^[b],d,1);
d := length(pos3^[b])-d;
val(pos3^[b],e,f);
if d = 1 then d := 100;
if d = 2 then d := 1000;
if d = 3 then d := 10000;
e := e/d;
s3^[b] := e;
end
else val(pos3^[b],s3^[b],d);
d := pos(',',pos4^[b]);
if d <> 0 then begin
delete(pos4^[b],d,1);
d := length(pos4^[b])-d;
val(pos4^[b],e,f);
if d = 1 then d := 100;
if d = 2 then d := 1000;
if d = 3 then d := 10000;
e := e/d;
s4^[b] := e;
end
else val(pos4^[b],s4^[b],d);
d := pos(',',pos5^[b]);
if d <> 0 then begin
delete(pos5^[b],d,1);
d := length(pos5^[b])-d;
val(pos5^[b],e,f);
if d = 1 then d := 100;
if d = 2 then d := 1000;
if d = 3 then d := 10000;
e := e/d;
s5^[b] := e;
end
else val(pos5^[b],s5^[b],d);
end;
x1 := 0;
x2 := 0;
x3 := 0;
x4 := 0;
x5 := 0;
p1 := false;
p2 := false;
p3 := false;
p4 := false;
p5 := false;
repeat
window(39,12,59,21);
textcolor(15);
textbackground(0);
clrscr;
writeln(' Loppu');
writeln(' Kansien korjaus');
writeln(' kumin Poltto');
writeln(' kOkoonpano');
writeln(' Ruuvien kiinnitys');
writeln(' Siemennysyhteydet');
writeln;write('Anna valinta ');
nappain := readkey;
totuus := false;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'k') or (nappain = 'K') then begin
window(3,5,50,24);
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(x1);
koot1^[x1] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
clrscr;
for x := 1 to x1 do begin
writeln(' Kuinka monta kokoa :',koot1^[x]);
readln(maara1^[x]);
val(koot1^[x],kot1^[x],a);
bpos1^[kot1^[x]] := s1^[kot1^[x]] * maara1^[x];
p1 := true;
end;
end;
if (nappain = 'p') or (nappain = 'P') then begin
window(3,5,50,24);
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(x2);
koot2^[x2] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
clrscr;
for x := 1 to x2 do begin
writeln(' Kuinka monta kokoa :',koot2^[x]);
readln(maara2^[x]);
val(koot2^[x],kot2^[x],a);
bpos2^[kot2^[x]] := s2^[kot2^[x]] * maara2^[x];
p2 := true;
end;
end;
if (nappain = 'o') or (nappain = 'O') then begin
window(3,5,50,24);
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(x3);
koot3^[x3] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
clrscr;
for x := 1 to x3 do begin
writeln(' Kuinka monta kokoa :',koot3^[x]);
readln(maara3^[x]);
val(koot3^[x],kot3^[x],a);
bpos3^[kot3^[x]] := s3^[kot3^[x]] * maara3^[x];
p3 := true;
end;
end;
if (nappain = 'r') or (nappain = 'R') then begin
window(3,5,50,24);
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(x4);
koot4^[x4] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
clrscr;
for x := 1 to x4 do begin
writeln(' Kuinka monta kokoa :',koot4^[x]);
readln(maara4^[x]);
val(koot4^[x],kot4^[x],a);
bpos4^[kot4^[x]] := s4^[kot4^[x]] * maara4^[x];
p4 := true;
end;
end;
if (nappain = 's') or (nappain = 'S') then begin
window(3,5,50,24);
repeat
repeat
clrscr;
writeln(' KŽYTETTŽVŽT KOOT :');
for  b:= 1 to 12 do begin
writeln(koot[b]);
end;
writeln(' Anna koko ! (pelkk„ enter lopetus)');
readln(koko1);
totuus := true;
if length(koko1) > 1 then begin
totuus := false;
for b := 1 to 12 do begin
if koot[b] = koko1 then begin
totuus := true;
inc(x5);
koot5^[x5] := koot[b];
end;
end;
if totuus = false then writeln(' V„„r„ koko !!!!');
end;
until totuus;
until length(koko1) <2 ;
clrscr;
for x := 1 to x5 do begin
writeln(' Kuinka monta kokoa :',koot5^[x]);
readln(maara5^[x]);
val(koot5^[x],kot5^[x],a);
bpos5^[kot5^[x]] := s5^[kot5^[x]] * maara5^[x];
p5 := true;
end;
end;
until nappain ='l';
summa := 0;
a := ioresult;
window(5,5,75,24);
textbackground(5);
clrscr;
writeln('                      LASKU            Nro: 2753');
writeln;
writeln('  Myyj„: Noormarkun Metalli      Maksaja: Kemira Oy');
writeln('           Teerikuja                      Vuorikemian tehtaat');
writeln('                                          Pori');
writeln;
writeln('  P„iv„ys: ',paiva,'.',kuu,'. ',vuosi,'    Maksuehdot: 30pv/netto  ');
writeln('  Pankki: OP N:kku 570404-11281');
writeln;writeln;
writeln('    Kpl         NS             a-hinta                  yht  ');
writeln;
if p1 then begin
writeln('       - Pos1   Kansien korjaus');
for x := 1 to x1 do begin
write('    ',maara1^[x],'           ',koot1^[x],'              ');
write(s1^[kot1^[x]]:1:2);
write('                 ');
writeln(bpos1^[kot1^[x]]:1:2);
summa := summa + bpos1^[kot1^[x]];
end;
end;
if p2 then begin
if p1 then readln;
writeln('       - Pos2   Kumin poltto');
for x := 1 to x2 do begin;
write('    ',maara2^[x],'           ',koot2^[x],'              ');
write(s2^[kot2^[x]]:1:2);
write('                 ');
writeln(bpos2^[kot2^[x]]:1:2);
summa := summa + bpos2^[kot2^[x]];
end;
end;
if p3 then begin
 if p1 or p2 then readln;
writeln('       - Pos3   Kokoonpano');
for x := 1 to x3 do begin;
write('    ',maara3^[x],'           ',koot3^[x],'              ');
write(s3^[kot3^[x]]:1:2);
write('                 ');
writeln(bpos3^[kot3^[x]]:1:2);
summa := summa + bpos3^[kot3^[x]];
end;
end;
if p4 then begin
if p1 or p2 or p3 then readln;
writeln('       - Pos4   Ruuvien kiinnitys');
for x := 1 to x4 do begin;
write('    ',maara4^[x],'           ',koot4^[x],'              ');
write(s4^[kot4^[x]]:1:2);
write('                 ');
writeln(bpos4^[kot4^[x]]:1:2);
summa := summa + bpos4^[kot4^[x]];
end;
end;
if p5 then begin
if p1 or p2 or p3 or p4 then readln;
writeln('       - Pos5   Siemennysyhteiden kunnostus');
for x := 1 to x1 do begin;
write('    ',maara5^[x],'           ',koot5^[x],'              ');
write(s5^[kot5^[x]]:1:2);
write('                 ');
writeln(bpos5^[kot5^[x]]:1:2);
summa := summa + bpos5^[kot5^[x]];
end;
end;
val(lvv,lvv1,a);
writeln;
write('                                         yhteens„ on: ');
writeln(summa:1:2);
writeln('                                           - Lvv(',lvv,'%) ');
writeln;writeln;
writeln(' Tulostanko printterille (K/E) ?');
nappain := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
writeln(lst,'                       LASKU            Nro: 2753');
writeln(lst);
writeln(lst,'  Myyj„: Noormarkun Metalli      Maksaja: Kemira Oy');
writeln(lst,'           Teerikuja                      Vuorikemian tehtaat');
writeln(lst,'                                          Pori');
writeln(lst);
writeln(lst,'  P„iv„ys: ',paiva,'.',kuu,'. ',vuosi,'    Maksuehdot: 30pv/netto  ');
writeln(lst,'  Pankki: OP N:kku 570404-11281');
writeln(lst);writeln(lst);
writeln(lst,'    Kpl         NS             a-hinta                  yht  ');
writeln(lst);
if p1 then begin
writeln(lst,'       - Pos1   Kansien korjaus');
for x := 1 to x1 do begin
write(lst,'    ',maara1^[x],'           ',koot1^[x],'              ');
write(lst,s1^[kot1^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos1^[kot1^[x]]:1:2);
end;
end;
if p2 then begin
writeln(lst,'       - Pos2   Kumin poltto');
for x := 1 to x2 do begin;
write(lst,'    ',maara2^[x],'           ',koot2^[x],'              ');
write(lst,s2^[kot2^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos2^[kot2^[x]]:1:2);
end;
end;
if p3 then begin
writeln(lst,'       - Pos3   Kokoonpano');
for x := 1 to x3 do begin;
write(lst,'    ',maara3^[x],'           ',koot3^[x],'              ');
write(lst,s3^[kot3^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos3^[kot3^[x]]:1:2);
end;
end;
if p4 then begin
writeln(lst,'       - Pos4   Ruuvien kiinnitys');
for x := 1 to x4 do begin;
write(lst,'    ',maara4^[x],'           ',koot4^[x],'              ');
write(lst,s4^[kot4^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos4^[kot4^[x]]:1:2);
end;
end;
if p5 then begin
writeln(lst,'       - Pos5   Siemennysyhteiden kunnostus');
for x := 1 to x5 do begin;
write(lst,'    ',maara5^[x],'           ',koot5^[x],'              ');
write(lst,s5^[kot5^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos5^[kot5^[x]]:1:2);
end;
end;
writeln(lst);
write(lst,'                                         yhteens„ on: ');
writeln(lst,summa:1:2);
writeln(lst,'                                           - Lvv(',lvv,'%) ');
end;
writeln('  Talletanko levylle (K/E) ?');
nappain1 := readkey;
if (nappain1 = 'k') or (nappain1 = 'K') then begin
chdir('\');
chdir('firma');
getdate(vuosi,kuu,paiva,vko);
str(vuosi,vuosi2);
chdir(vuosi2);
a := ioresult;
str(kuu,kuu2);
if length(kuu2) < 2 then begin
insert('0',kuu2,0);
end;
str(paiva,paiva2);
if length(paiva2) < 2 then begin
insert('0',paiva2,0);
end;
paivays := concat(paiva2,kuu2);
insert('.rah',paivays,length(paivays)+1);
assign(luku,paivays);
rewrite(luku);
writeln(luku,x1);
for x := 1 to x1 do begin
writeln(luku,koot1^[x]);
writeln(luku,maara1^[x]);
writeln(luku,s1^[kot1^[x]]);
end;
writeln(luku,x2);
for x := 1 to x2 do begin
writeln(luku,koot2^[x]);
writeln(luku,maara2^[x]);
writeln(luku,s2^[kot2^[x]]);
end;
writeln(luku,x3);
for x := 1 to x3 do begin
writeln(luku,koot3^[x]);
writeln(luku,maara3^[x]);
writeln(luku,s3^[kot3^[x]]);
end;
writeln(luku,x4);
for x := 1 to x4 do begin
writeln(luku,koot4^[x]);
writeln(luku,maara4^[x]);
writeln(luku,s4^[kot4^[x]]);
end;
writeln(luku,x5);
for x := 1 to x5 do begin
writeln(luku,koot5^[x]);
writeln(luku,maara5^[x]);
writeln(luku,s5^[kot5^[x]]);
end;
writeln(luku,lvv1);
close(luku);
end;
end;
procedure vanhakirja;
begin
chdir('\');
chdir('firma');
window(12,5,37,24);
doserror := 0;
textcolor(0);
textbackground(11);
clrscr;
a := 0;
findfirst('*.',directory,hae);
while doserror = 0 do begin
inc(a);
if a > 2 then begin
writeln(a-2,'.) ',hae.name);
end;
findnext(hae);
end;
dec(a,2);
repeat
writeln;writeln(' Anna vuoden numero');
readln(vara);
if (vara > a) or (vara < 1) then begin
totuus := false;
writeln(' V„„r„ luku');
end
else totuus := true;
until totuus;
findfirst('*.',directory,hae);
findnext(hae);
findnext(hae);
if vara > 1 then begin
for a := 1 to vara+1 do begin
findnext(hae);
end;
end;
writeln(hae.name);
chdir(hae.name);
findfirst('*.rah',archive,hae);
a:=1;
while doserror = 0 do begin;
osa := hae.name;
delete(osa,5,4);
osa1 := osa;
delete (osa,3,2);
delete (osa1,1,2);
insert('.',osa,3);
osa3 := copy(osa,1,1);
if osa3 = '0' then delete(osa,1,1);
osa3 := copy(osa1,1,1);
if osa3 = '0' then delete(osa1,1,1);
hae.name := concat(osa,osa1);
writeln(a,'.) ',hae.name);
inc(a);
findnext(hae);
end;
repeat
writeln('  Anna p„iv„n numero');
readln(vara);
if (vara < 1) or (vara > a ) then begin
writeln(' V„„r„ numero');
totuus := false;
end
else totuus := true;
until totuus;
findfirst('*.rah',archive,hae);
if vara > 1 then begin
for a := 1 to vara-1 do begin
findnext(hae);
end;
end;
assign(luku,hae.name);
reset(luku);
readln(luku,x1);
for x := 1 to x1 do begin
readln(luku,koot1^[x]);
readln(luku,maara1^[x]);
readln(luku,s1^[kot1^[x]]);
end;
readln(luku,x2);
for x := 1 to x2 do begin
readln(luku,koot2^[x]);
readln(luku,maara2^[x]);
readln(luku,s2^[kot2^[x]]);
end;
readln(luku,x3);
for x := 1 to x3 do begin
readln(luku,koot3^[x]);
readln(luku,maara3^[x]);
readln(luku,s3^[kot3^[x]]);
end;
readln(luku,x4);
for x := 1 to x4 do begin
readln(luku,koot4^[x]);
readln(luku,maara4^[x]);
readln(luku,s4^[kot4^[x]]);
end;
readln(luku,x5);
for x := 1 to x5 do begin
readln(luku,koot5^[x]);
readln(luku,maara5^[x]);
readln(luku,s5^[kot5^[x]]);
end;
readln(luku,lvv1);
close(luku);
if x1 <> 0 then p1 := true
else p1 := false;
if x2 <> 0 then p2 := true
else p2 := false;
if x3 <> 0 then p3 := true
else p3 := false;
if x4 <> 0 then p4 := true
else p4 := false;
if x5 <> 0 then p5 := true
else p5 := false;
summa := 0;
a := ioresult;
window(5,5,75,24);
textbackground(5);
clrscr;
writeln('                      LASKU            Nro: 2753');
writeln;
writeln('  Myyj„: Noormarkun Metalli      Maksaja: Kemira Oy');
writeln('           Teerikuja                      Vuorikemian tehtaat');
writeln('                                          Pori');
writeln;
getdir(0,a1);
b1 := copy(a1,length(a1)-3,4);
writeln('  P„iv„ys: ',osa,osa1,'.',b1,'    Maksuehdot: 30pv/netto  ');
writeln('  Pankki: OP N:kku 570404-11281');
writeln;writeln;
writeln('    Kpl         NS             a-hinta                  yht  ');
writeln;
if p1 then begin
writeln('       - Pos1   Kansien korjaus');
for x := 1 to x1 do begin
write('    ',maara1^[x],'           ',koot1^[x],'              ');
write(s1^[kot1^[x]]:1:2);
write('                 ');
writeln(bpos1^[kot1^[x]]:1:2);
summa := summa + bpos1^[kot1^[x]];
end;
end;
if p2 then begin
if p1 then readln;
writeln('       - Pos2   Kumin poltto');
for x := 1 to x2 do begin;
write('    ',maara2^[x],'           ',koot2^[x],'              ');
write(s2^[kot2^[x]]:1:2);
write('                 ');
writeln(bpos2^[kot2^[x]]:1:2);
summa := summa + bpos2^[kot2^[x]];
end;
end;
if p3 then begin
 if p1 or p2 then readln;
writeln('       - Pos3   Kokoonpano');
for x := 1 to x3 do begin;
write('    ',maara3^[x],'           ',koot3^[x],'              ');
write(s3^[kot3^[x]]:1:2);
write('                 ');
writeln(bpos3^[kot3^[x]]:1:2);
summa := summa + bpos3^[kot3^[x]];
end;
end;
if p4 then begin
if p1 or p2 or p3 then readln;
writeln('       - Pos4   Ruuvien kiinnitys');
for x := 1 to x4 do begin;
write('    ',maara4^[x],'           ',koot4^[x],'              ');
write(s4^[kot4^[x]]:1:2);
write('                 ');
writeln(bpos4^[kot4^[x]]:1:2);
summa := summa + bpos4^[kot4^[x]];
end;
end;
if p5 then begin
if p1 or p2 or p3 or p4 then readln;
writeln('       - Pos5   Siemennysyhteiden kunnostus');
for x := 1 to x1 do begin;
write('    ',maara5^[x],'           ',koot5^[x],'              ');
write(s5^[kot5^[x]]:1:2);
write('                 ');
writeln(bpos5^[kot5^[x]]:1:2);
summa := summa + bpos5^[kot5^[x]];
end;
end;
val(lvv,lvv1,a);
writeln;
write('                                         yhteens„ on: ');
writeln(summa:1:2);
writeln('                                           - Lvv(',lvv,'%) ');
writeln;writeln;
writeln(' Tulostanko printterille (K/E) ?');
nappain := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
getdir(0,a1);
b1 := copy(a1,length(a1)-3,4);
writeln(lst,'                       LASKU            Nro: 2753');
writeln(lst);
writeln(lst,'  Myyj„: Noormarkun Metalli      Maksaja: Kemira Oy');
writeln(lst,'           Teerikuja                      Vuorikemian tehtaat');
writeln(lst,'                                          Pori');
writeln(lst);
writeln(lst,'  P„iv„ys: ',osa,osa1,'.',b1,'    Maksuehdot: 30pv/netto  ');
writeln(lst,'  Pankki: OP N:kku 570404-11281');
writeln(lst);writeln(lst);
writeln(lst,'    Kpl         NS             a-hinta                  yht  ');
writeln(lst);
if p1 then begin
writeln(lst,'       - Pos1   Kansien korjaus');
for x := 1 to x1 do begin
write(lst,'    ',maara1^[x],'           ',koot1^[x],'              ');
write(lst,s1^[kot1^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos1^[kot1^[x]]:1:2);
end;
end;
if p2 then begin
writeln(lst,'       - Pos2   Kumin poltto');
for x := 1 to x2 do begin;
write(lst,'    ',maara2^[x],'           ',koot2^[x],'              ');
write(lst,s2^[kot2^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos2^[kot2^[x]]:1:2);
end;
end;
if p3 then begin
writeln(lst,'       - Pos3   Kokoonpano');
for x := 1 to x3 do begin;
write(lst,'    ',maara3^[x],'           ',koot3^[x],'              ');
write(lst,s3^[kot3^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos3^[kot3^[x]]:1:2);
end;
end;
if p4 then begin
writeln(lst,'       - Pos4   Ruuvien kiinnitys');
for x := 1 to x4 do begin;
write(lst,'    ',maara4^[x],'           ',koot4^[x],'              ');
write(lst,s4^[kot4^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos4^[kot4^[x]]:1:2);
end;
end;
if p5 then begin
writeln(lst,'       - Pos5   Siemennysyhteiden kunnostus');
for x := 1 to x5 do begin;
write(lst,'    ',maara5^[x],'           ',koot5^[x],'              ');
write(lst,s5^[kot5^[x]]:1:2);
write(lst,'                 ');
writeln(lst,bpos5^[kot5^[x]]:1:2);
end;
end;
writeln(lst);
write(lst,'                                         yhteens„ on: ');
writeln(lst,summa:1:2);
writeln(lst,'                                           - Lvv(',lvv,'%) ');
end;
end;



















procedure rkirja;
begin
window(29,9,48,15);
doserror := 0;
textcolor(0);
textbackground(11);
repeat
clrscr;
writeln(' Oletustenvaihto');
writeln(' uuSi kirja');
writeln(' Vanha kirja');
writeln;writeln(' Anna komento');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'o') or (nappain = 'O') then begin
roletustenvaihto;
totuus := true;
end;
if (nappain = 's') or (nappain = 'S') then begin
uusikirja;
totuus := true;
end;
if (nappain = 'v') or (nappain = 'V') then begin
vanhakirja;
totuus := true;
end;
until totuus;
nappain := 'z';
totuus := false;
end;
procedure mventtiilit;
begin
window(25,5,37,12);
textcolor(15);
textbackground(0);
totuus:= false;
repeat
clrscr;
writeln(' uuSi vienti');
writeln(' Tarkistus');
writeln(' Poisto');
writeln(' R-kirja');
writeln;writeln(' Anna kirjain');
nappain := readkey;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 's') or (nappain = 's') then begin
uusivienti;
totuus := true;
end;
if (nappain = 't') or (nappain = 'T') then begin
ventarkistus;
totuus := true;
end;
if (nappain = 'r') or (nappain = 'R') then begin
rkirja;
totuus := true;
end;
if (nappain = 'p') or (nappain = 'P') then begin
venpoisto;
totuus := true;
end;
until totuus;
nappain := 'z';
totuus := false;
end;
procedure apua;
begin
window(8,5,17,8);
textbackground(0);
textcolor(15);
repeat;
clrscr;
writeln;
writeln(' Ohjeet');
writeln(' Muuta');
nappain := readkey;
totuus := false;
if (nappain = 'u') or (nappain = 'U') then begin
nappain := 'z';
totuus := false;
exit;
end;
if (nappain = 'o') or (nappain = 'O') then begin
window(17,5,37,24);
textbackground(11);
textcolor(0);
clrscr;
writeln('    OHJEITA !!!');
writeln('   ---------');
writeln;
writeln(' P„„menu:');
writeln('   Valitset menun ');
writeln('painamalla menussa');
writeln('olevaa isoa kirjainta');
writeln;
writeln(' Muut menut toimivat');
writeln(' samalla tavalla');
writeln;
writeln(' Takaisin p„„menuun');
writeln(' p„„set painamalla');
writeln(' U-n„ppaint„');
writeln;
writeln(' Onnea matkaan');
totuus := true;
readln;
end;
if ( nappain = 'M') or (nappain = 'm') then begin
window(17,5,37,24);
textbackground(11);
textcolor(0);
clrscr;
writeln('   MUITA TIETOJA !!!');
writeln('  ---------------');
writeln;
writeln(' K„ytt”oikeus :');
writeln('Noormarkun Metalli Ky');
writeln;writeln;
writeln(' Ohjelma valmistui :');
writeln('   .   .1991');
writeln(' Suunnitellut ja');
writeln(' toteuttanut :');
writeln;
writeln(' RAULI VIRTANEN');
writeln;writeln;
writeln('Hyvi„ k„ytt”hetki„ !!');
totuus := true;
readln;
end;
until totuus;
totuus := false;
nappain := 'z';
end;
procedure paa;
begin
repeat
window(1,3,80,25);
textbackground(0);
clrscr;
gotoxy(1,1);
delline;
textcolor(15);
writeln('    Ulos  Apua  Varasto  veNttiilit  Oletuksen vaihto ');
window(5,5,75,24);
textcolor(0);
textbackground(15);
repeat
clrscr;
writeln('Anna komentokirjain');
nappain := readkey;
if (nappain = 'a') or (nappain = 'A') then begin
write('Apua');
apua;
totuus := true;
end;
if (nappain = 'v') or (nappain = 'V') then begin
write('  Varasto');
varasto;
totuus := true;
end;
if (nappain = 'n') or (nappain = 'N') then begin
write('Venttiilit');
mventtiilit;
totuus := true;
end;
if (nappain = 'o') or (nappain = 'O') then begin
write('Oletuksien vaihto');
totuus := true;
delay(1000);
oletustenvaihto;
end;
if (nappain ='u') or (nappain = 'U') then begin
writeln('    Oletko varma, ett„ haluat poistua ohjelmasta (K/E) ?');
nappain := readkey;
if (nappain = 'k') or (nappain = 'K') then begin
setdate(vuosi,kuu,paiva);
textbackground(0);
textcolor(15);
window(1,1,80,25);
clrscr;
writeln('Rauli kiitt„„ k„yt”st„');
halt(1);
end;
end;
if totuus = false then begin
writeln('V„„r„ n„pp„in');
end;
until totuus;
until false;
end;
begin
{$s-}
getdate(vuosi,kuu,paiva,vko);
chdir('c:\');
chdir('firma');
str(vuosi,vuosi2);
chdir(vuosi2);
if ioresult <> 0 then begin
mkdir(vuosi2);
end
else chdir('..');
a := ioresult;
if vko  = 0  then paiva1 := 'SUNNUNTAI';
if vko = 1 then paiva1 := 'MAANANTAI';
if vko = 2 then paiva1 := 'TIISTAI';
if vko = 3 then paiva1 := 'KESKIVIIKKO';
if vko = 4 then paiva1 := 'TORSTAI';
if vko = 5 then paiva1 := 'PERJANTAI';
if vko = 6 then paiva1 := 'LAUNANTAI';
window(1,1,80,25);
textbackground(0);
clrscr;
textcolor(15);
writeln(' Oletus on : ',paiva1,' ',paiva,'.',kuu,' ',vuosi);
repeat
paa;
until false;
end.
