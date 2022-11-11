unit ty;
interface
uses crt,dos,graph,paa;
procedure venttiilit;
implementation
procedure uusipaivav;
const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
var
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,kansia,pohjia,venttiileita : integer;
 totuus : boolean;
 vast : char;
 tiedosto,nimi : text;
 a,b,c,ko : string;
 yt : string;

 begin
   repeat
   writeln('Anna p„iv„ ?');
   readln(pp);
   writeln('Anna kuukausi ?');
   readln(kk);
   writeln('Anna vuosi ?');
   readln(vv);
   totuus := false;
   if pp < 32 then begin
     if pp > -1 then begin
     if kk < 12 then begin
       if kk > -1 then begin
       if vv < 2000 then begin
        if vv > 1985 then begin

          if kk = 2 then begin
            if pp < 28 then begin
              totuus := true;
            end;
          end
           else totuus := true
      end;
     end;
   end;
   end;
   end;
   end;
   if totuus = false then begin
   writeln('V„„r„ p„iv„ys');
   end;
   until totuus = true;
   str(pp,a);
   str(kk,b);
   str(vv,c);
   yt := concat(a,b,c);
  assign(tiedosto,yt);
  {$I-}
  chdir('c:\tp\tied');
  reset(tiedosto);
  if ioresult = 0 then begin
    writeln('P„iv„ on jo talletettu korvataanko (k/e)');
    readln(vast);
    if vast = #107 then erase (tiedosto);
    if vast = #101 then alku ;
  {$I+}
  end;
  rewrite(tiedosto);
  writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  totuus := true;
  repeat
    writeln('Kuinka monta kantta on kokoa ',ko);
    readln(kansia);
    if kansia > 100 then totuus := false;
    writeln('Kuinka monta pohjaa on kokoa ',ko);
    readln(pohjia);
    if pohjia > 100 then totuus := false;
    writeln('Kuinka monta koko venttiiili„ on kokoa ',ko);
    readln(venttiileita);
    if venttiileita > 100 then totuus := false;
    if totuus = false then begin
      writeln('Mahdottomat m„„r„t');
    end;
  until totuus = true;
  clrscr;
  writeln('   P„iv„m„„r„ on :',a,'.',b,'.',c);
  writeln('   Venttiilin koko on ',ko);
  writeln('   Koon ',ko,' venttiileit„ on :');
  writeln('   KANSIA ',KANSIA);
  WRITELN('   POHJIA ',POHJIA);
  WRITELN('   VENTTIILEITŽ ',VENTTIILEITA);
  repeat
  totuus := true;
  gotoxy(200,200);
  write('    Talletetaanko (k/e) ? ');
  read(vast);
  if vast = #101 then begin
    write('Ei');
  alku;
  end;
  if vast = #107 then begin
  writeln(tiedosto,ko);
  writeln(tiedosto,kansia);
  writeln(tiedosto,pohjia);
  writeln(tiedosto,venttiileita);
  close(tiedosto);
  chdir('c:\tp');
  alku;
  end
  else begin
  writeln('V„„r„ n„pp„in');
  totuus := false;
  end;
  until totuus = true;
  alku;
  end;
  procedure  lisaysvanhaanv;
  const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 pohjia : ^pohji;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask,lask1,kan,poh,ven : integer;
 totuus,arvo : boolean;
 vast : char;
 tiedosto,tied2,nimi : text;
 a,b,c,d,e,f,g,ko : string;
 yt,yt2 : string;
 haktied : searchrec;
 begin
  new(koko);
  new(kansia);
  new(pohjia);
  new(venttiileita);
   repeat
   repeat
   gotoxy(200,200);
   writeln('PŽIVŽMŽŽRIŽ');
 repeat
   findfirst('c:\tp\tied\*.*',archive,haktied);
   while doserror = 0 do
   begin
   writeln(haktied.name);
   findnext(haktied);
   end;
   writeln('Anna p„iv„ ?');
   readln(pp);
 writeln('Anna kuukausi ?');
   readln(kk);
   writeln('Anna vuosi ?');
   readln(vv);
   totuus := false;
   if pp < 32 then begin
     if pp > -1 then begin
     if kk < 13 then begin
       if kk > -1 then begin
       if vv < 2000 then begin
        if vv > 1985 then begin

          if kk = 2 then begin
            if pp < 28 then begin
              totuus := true;
            end;
          end
           else totuus := true
        end;
       end;
      end;
     end;
    end;
   end;
   if totuus = false then begin
   writeln('V„„r„ p„iv„ys');
   end;
   until totuus = true;
  str(pp,a);
   str(kk,b);
   str(vv,c);
   yt := concat(a,b,c);
   yt2 := yt;
   {$I-}
   chdir('c:\tp\tied');
   assign(tiedosto,yt);
   reset(tiedosto);
   if ioresult <> 0 then begin
     writeln('Ei l”ydy p„iv„„');
     totuus := false;
     end;
   {$I+}
  until totuus = true;
   lask := 0;
   while not eof (tiedosto) do
   begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
   close (tiedosto);
   clrscr;
   writeln('    P„iv„m„„r„ : ',a,'.',b,'.',c);
   for lask1 := 1 to lask do
     begin
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
      readln;
     end;
     writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  totuus := true;
  repeat
    writeln('Kuinka monta kantta on kokoa ',ko);
    readln(kan);
    if kan    > 100 then totuus := false;
    writeln('Kuinka monta pohjaa on kokoa ',ko);
    readln(poh);
    if poh    > 100 then totuus := false;
    writeln('Kuinka monta koko venttiiili„ on kokoa ',ko);
    readln(ven);
    if ven          > 100 then totuus := false;
    if totuus = false then begin
      writeln('Mahdottomat m„„r„t');
    end;
  until totuus = true;
   str(kan,d);
   str(poh,e);
   str(ven,f);
   inc(lask,1);
   koko^[lask] := ko;
   kansia^[lask] := d;
   pohjia^[lask] := e;
   venttiileita^[lask] := f;
   clrscr;

   for lask1 := 1 to lask do
     begin
       writeln('  P„iv„maara : ',a,'.',b,'.',c);
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
       readln;
       end;
    repeat
    totuus := true;
     gotoxy(200,200);
  writeln('    Talletetaanko (k/e) ? ');
  vast := readkey;
  if vast =  #101 then begin
    write('Ei');
  alku;
  end;
  if vast = #107 then begin
  writeln('Kyll„');
  assign(tiedosto,yt2);
  append(tiedosto);
  writeln(tiedosto,ko);
  writeln(tiedosto,d);
  writeln(tiedosto,e);
  writeln(tiedosto,f);
  close (tiedosto);
  end
  else begin
  writeln('V„„r„ n„pp„in');
  totuus := false;
  end;
  until totuus = true;
  arvo := false;
  repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  until totuus = false;
  chdir('c:\tp');
  alku;
  end;
  procedure poistov;
const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
k = array[0..30] of integer;
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kok2 = array[1..30] of string;
var
 KOKO : ^kok;
 koko2 : ^kok2;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 venttiileita : ^venttiileit;
 ki :^k;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask,lask1,lask2,lask3,kan,poh,ven : integer;
 totuus,arvo : boolean;
 vast : char;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko,vas : string;
 yt: string;
 yt1 : string;
 begin
  new(koko);
  new(koko2);
  new(ki);
  new(kansia);
  new(pohjia);
  new(venttiileita);
   lask := 0;
   lask3 := 0;
   repeat
   repeat
   writeln('PŽIVŽMŽŽRIŽ');
 repeat
   findfirst('c:\tp\tied\*.*',archive,haktied);
   while doserror = 0 do
   begin
   writeln(haktied.name);
   findnext(haktied);
   end;
   writeln('Anna p„iv„ ?');
   readln(pp);
   writeln('Anna kuukausi ?');
   readln(kk);
   writeln('Anna vuosi ?');
   readln(vv);
   totuus := false;
   if pp < 32 then begin
     if pp > -1 then begin
     if kk < 13 then begin
       if kk > -1 then begin
       if vv < 2000 then begin
        if vv > 1985 then begin

          if kk = 2 then begin
            if pp < 28 then begin
              totuus := true;
            end;
          end
           else totuus := true
        end;

       end;
      end;
     end;
    end;
   end;
   if totuus = false then begin
   writeln('V„„r„ p„iv„ys');
   end;
   until totuus = true;
  str(pp,a);
   str(kk,b);
   str(vv,c);

   yt := concat(a,b,c);
   yt1 := yt;
   {$I-}
   chdir('c:\tp\tied');
   assign(tiedosto,yt);
   reset(tiedosto);
   if ioresult <> 0 then begin
     writeln('Ei l”ydy p„iv„„');
     totuus := false;
     end;
   {$I+}
  until totuus = true;
   lask := 0;
   while not eof (tiedosto) do
   begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
    close (tiedosto);
   clrscr;
   writeln('    P„iv„m„„r„ : ',a,'.',b,'.',c);
   for lask1 := 1 to lask do
     begin
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
      readln;
     end;
   clrscr;
   writeln('KOKOJA:');
   for lask1 := 1 to lask do
   begin
   writeln(koko^[lask1]);
   end;
   totuus := false;
   lask1 := 0;
   repeat
   writeln('Anna koko ? (Pelkk„ "ENTER" lopetus)');
   inc(lask1,1);
   repeat
   readln (koko2^[lask1]);
   if length(koko2^[lask1]) = 0 then totuus := true
   else begin
   for lask2 := 1 to lask do
   begin
   if koko2^[lask1]  = koko^[lask2] then begin
   totuus := true;
   inc (lask3,1);
   ki^[lask3] := lask2;
   end;
   end;
   end;
   if totuus = false then begin
   writeln('V„„r„ koko');
   end;
   until totuus = true;
   until length(koko2^[lask1]) = 0;
   for lask2 := 1 to lask3 do
   begin
     koko^[ki^[lask2]] := '';
     kansia^[ki^[lask2]] := '';
     pohjia^[ki^[lask2]] := '';
     venttiileita^[ki^[lask2]] := '';
     end;
   if lask <> 0 then  begin
    repeat
   for lask2 := 1 to lask do
     begin
       totuus := true;
       if koko^[lask2] = '' then begin
         kansia^[lask2] := kansia^[lask2+1];
         pohjia^[lask2] := pohjia^[lask2+1];
         venttiileita^[lask2] := venttiileita^[lask2+1];
         koko^[lask2] := koko^[lask2+1];
         kansia^[lask2+1] := '';
         pohjia^[lask2+1] := '';
         venttiileita^[lask2+1] := '';
         koko^[lask2+1] := '';
       if koko^[lask] = '' then dec(lask,1);
       totuus := false;
       end;
       end;
  until totuus = true;
      end;
   clrscr;
   writeln('    P„iv„m„„r„ : ',a,'.',b,'.',c);
   for lask1 := 1 to lask do
     begin
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
      readln;
     end;
    repeat
  totuus := true;
  gotoxy(200,200);
  write('    Talletetaanko (k/e) ? ');
  read(vast);
  if vast = #101 then begin
    write('Ei');
  alku
  end;
  if vast = #107 then begin
  chdir('c:\tp\tied');
  assign(tiedosto,yt1);
  rewrite(tiedosto);
  for lask2 := 1 to lask do begin
  writeln(tiedosto,koko^[lask2]);
  writeln(tiedosto,kansia^[lask2]);
  writeln(tiedosto,pohjia^[lask2]);
  writeln(tiedosto,venttiileita^[lask2]);
  close(tiedosto);
  chdir('c:\tp');
  end;
  end
  else begin
  writeln('V„„r„ n„pp„in');
  totuus := false;
  end;
  until totuus = true;
  repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
 until totuus = true;
 until totuus = true;
 alku;
 end;

  procedure talletusv;
  var
   h,grtila : integer;
   arvo : boolean;
   vast : char;
   begin
repeat
  grtila := detect;
initgraph(grtila,h, 'c:\tp');
 settextstyle(triplexfont,horizdir,6);
 outtext('     Talletus');
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 settextstyle(triplexfont,horizdir,4);
 outtextxy(140,120, ' A. Uusip„iv„');
 outtextxy(140,160, ' B. Lis„ys vanhaan p„iv„„n');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #100 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then uusipaivav;arvo := false;
  if vast = #98 then lisaysvanhaanv;arvo := false;
  until arvo = false;
end;
procedure paiva_venttiili;
  const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask,lask1,kan,poh,ven : integer;
 totuus,arvo : boolean;
 vast : char;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko : string;
 yt : string;

 begin
  new(koko);
  new(kansia);
  new(pohjia);
  new(venttiileita);
   repeat
   repeat
   gotoxy(200,200);
   writeln('PŽIVŽMŽŽRIŽ');
 repeat
   findfirst('c:\tp\tied\*.*',archive,haktied);
   while doserror = 0 do
   begin
   writeln(haktied.name);
   findnext(haktied);
   end;
   writeln('Anna p„iv„ ?');
   readln(pp);
   writeln('Anna kuukausi ?');
   readln(kk);
   writeln('Anna vuosi ?');
   readln(vv);
   totuus := false;
   if pp < 32 then begin
     if pp > -1 then begin
     if kk < 13 then begin
       if kk > -1 then begin
       if vv < 2000 then begin
        if vv > 1985 then begin

          if kk = 2 then begin
            if pp < 28 then begin
              totuus := true;
            end;
          end
           else totuus := true
        end;
       end;
      end;
     end;
    end;
   end;
   if totuus = false then begin
   writeln('V„„r„ p„iv„ys');
   end;
   until totuus = true;
  str(pp,a);
   str(kk,b);
   str(vv,c);
   yt := concat(a,b,c);
   {$I-}
   chdir('c:\tp\tied');
   assign(tiedosto,yt);
   reset(tiedosto);
   if ioresult <> 0 then begin
     writeln('Ei l”ydy p„iv„„');
     totuus := false;
     end;
   {$I+}
  until totuus = true;
   lask := 0;
   while not eof (tiedosto) do
   begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
    close (tiedosto);
   clrscr;
   writeln('    P„iv„m„„r„ : ',a,'.',b,'.',c);
   for lask1 := 1 to lask do
     begin
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
      readln;
     end;
   arvo := false;
  repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  alku;
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  until totuus = false;
  alku;
  end;

    procedure venttiili_paiva;
     const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus,arvo : boolean;
 vast : char;
 kokoja : ^kokoj;

 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko,haktied2 : string;
 yt : string;

 begin
   new(koko);
   new(kansia);
   new(kokoja);
   new(venttiileita);
   new(kokoja);
   repeat

   writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  chdir('c:\tp\tied');
  findfirst('c:\tp\tied\*.*',archive,haktied);
  lask2 := 0;
  while doserror = 0 do
   begin
    lask := 0;
    haktied2 := haktied.name;
    assign(tiedosto,haktied.name);
    reset(tiedosto);
      while not eof (tiedosto) do
   begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
  close(tiedosto);
   for lask1 := 1 to lask do
     begin
        if koko^[lask1]  = ko then begin
         inc(lask2,1);
          kokoja^[lask2] := haktied2;
         end;
     end;
  findnext(haktied);
  end;
  clrscr;
  repeat
  repeat
  writeln('P„iv„t jona kokoa ',ko,' on viety:');
  for lask3 := 1 to lask2 do
    begin
    writeln(kokoja^[lask3]);
    end;
  writeln('Anna p„iv„ ?');
   readln(pp);
   writeln('Anna kuukausi ?');
   readln(kk);
   writeln('Anna vuosi ?');
   readln(vv);
   totuus := false;
   if pp < 32 then begin
     if pp > -1 then begin
     if kk < 13 then begin
       if kk > -1 then begin
       if vv < 2000 then begin
        if vv > 1985 then begin

          if kk = 2 then begin
            if pp < 28 then begin
              totuus := true;
            end;
          end
           else totuus := true
        end;
       end;
      end;
     end;
    end;
   end;
   if totuus = false then begin
   writeln('V„„r„ p„iv„ys');
   end;
   until totuus = true;
  str(pp,a);
   str(kk,b);
   str(vv,c);
   yt := concat(a,b,c);
   {$I-}
   chdir('c:\tp\tied');
   assign(tiedosto,yt);
   reset(tiedosto);
   if ioresult <> 0 then begin
     writeln('Ei l”ydy p„iv„„');
     totuus := false;
     end;
   {$I+}
  until totuus = true;
   lask := 0;
   while not eof (tiedosto) do
   begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
   close (tiedosto);
   clrscr;
   writeln('    P„iv„m„„r„ : ',a,'.',b,'.',c);
   for lask1 := 1 to lask do
     begin
       writeln(' KOKO ',koko^[lask1],' KPL.');
       writeln('---------------');
       writeln(' PESIA ',pohjia^[lask1],' KPL.');
       writeln(' KANSIA ',kansia^[lask1],' KPL.');
       writeln(' VENTTIILEITŽ ',venttiileita^[lask1],' KPL.');
       writeln;writeln;
      readln;
     end;
    arvo := false;
  repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  until totuus = false;

    alku;
   end;
   procedure pohjaty;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
paivia = array[1..30] of string;
paivi2 = array[1..30] of string;
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 paivia1 : ^paivia;
 paivia2 : ^paivi2;
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,laskuri,l,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 pituus2 : integer;
 kokoja : ^kokoj;
 tiedosto2,vuosi,valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko,yt : string;
 begin
   new(paivia1);
   new(paivia2);
   new(koko);
   new(kansia);
   new(kokoja);
   new(venttiileita);
   new(kokoja);
   repeat

   writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  writeln('Anna vuosi');
  readln(vuosi);
  laskuri := 0;
  chdir('c:\tp\tied');
  findfirst('*.*',archive,haktied);
  while doserror = 0 do begin
  pituus2 := length(haktied.name);
  pituus2 := (pituus2 - 4);
  tiedosto2 := copy(haktied.name,pituus2,4);
  if vuosi = tiedosto2 then begin
  inc(laskuri,1);
  paivia1^[laskuri] := haktied.name;
  end;
  findnext(haktied);
  end;
  for l := 1 to laskuri do begin
  assign(tiedosto,paivia1^[l]);
  reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
  close(tiedosto);
   for lask2 := 1 to lask do begin
   if koko^[lask2] = ko then begin
   inc(lask3,1);
   paivia2^[lask3] := paivia1^[l];
   end;
   end;
   for lask2 := 1 to lask3 do begin
   assign(tiedosto,paivia2^[lask2]);
   reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
   close(tiedosto);
   clrscr;
   writeln('    PŽIVŽ ,paivia2[lask2]');
   for lask3 := 1 to lask do begin
   writeln('   ',pohjia^[lask3]);
   end;
   end;
    repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  end;
  until totuus = false;

    alku;
   end;

   procedure kannety;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
paivia = array[1..30] of string;
paivi2 = array[1..30] of string;
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 paivia1 : ^paivia;
 paivia2 : ^paivi2;
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,laskuri,l,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 pituus2 : integer;
 kokoja : ^kokoj;
 tiedosto2,vuosi,valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko,yt : string;
 begin
   new(paivia1);
   new(paivia2);
   new(koko);
   new(kansia);
   new(kokoja);
   new(venttiileita);
   new(kokoja);
   repeat

   writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  writeln('Anna vuosi');
  readln(vuosi);
  laskuri := 0;
  chdir('c:\tp\tied');
  findfirst('*.*',archive,haktied);
  while doserror = 0 do begin
  pituus2 := length(haktied.name);
  pituus2 := (pituus2 - 4);
  tiedosto2 := copy(haktied.name,pituus2,4);
  if vuosi = tiedosto2 then begin
  inc(laskuri,1);
  paivia1^[laskuri] := haktied.name;
  end;
  findnext(haktied);
  end;
  for l := 1 to laskuri do begin
  assign(tiedosto,paivia1^[l]);
  reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
  close(tiedosto);
   for lask2 := 1 to lask do begin
   if koko^[lask2] = ko then begin
   inc(lask3,1);
   paivia2^[lask3] := paivia1^[l];
   end;
   end;
   for lask2 := 1 to lask3 do begin
   assign(tiedosto,paivia2^[lask2]);
   reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
   close(tiedosto);
   clrscr;
   writeln('    PŽIVŽ ,paivia2[lask2]');
   for lask3 := 1 to lask do begin
   writeln('   ',kansia^[lask3]);
   end;
   end;
    repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  end;
  until totuus = false;

    alku;
   end;

   procedure venttiility;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
paivia = array[1..30] of string;
paivi2 = array[1..30] of string;
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 paivia1 : ^paivia;
 paivia2 : ^paivi2;
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,laskuri,l,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 pituus2 : integer;
 kokoja : ^kokoj;
 tiedosto2,vuosi,valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko,yt : string;
 begin
   new(paivia1);
   new(paivia2);
   new(koko);
   new(kansia);
   new(kokoja);
   new(venttiileita);
   new(kokoja);
   repeat

   writeln(' V E N T T I I L I N   K O K O J A');
  for i := 1 to 12 do begin
    writeln(ventko[i]);
  end;
  repeat
  writeln('Anna koko');
readln(ko);
  totuus := false;
  for i := 1 to 12 do begin
  if ko  = (ventko[i]) then totuus := true;kl := i;
  end;
  if totuus = false then begin
    writeln('V„„r„ koko');
  end;
  until totuus = true;
  writeln('Anna vuosi');
  readln(vuosi);
  laskuri := 0;
  chdir('c:\tp\tied');
  findfirst('*.*',archive,haktied);
  while doserror = 0 do begin
  pituus2 := length(haktied.name);
  pituus2 := (pituus2 - 4);
  tiedosto2 := copy(haktied.name,pituus2,4);
  if vuosi = tiedosto2 then begin
  inc(laskuri,1);
  paivia1^[laskuri] := haktied.name;
  end;
  findnext(haktied);
  end;
  for l := 1 to laskuri do begin
  assign(tiedosto,paivia1^[l]);
  reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
  close(tiedosto);
   for lask2 := 1 to lask do begin
   if koko^[lask2] = ko then begin
   inc(lask3,1);
   paivia2^[lask3] := paivia1^[l];
   end;
   end;
   for lask2 := 1 to lask3 do begin
   assign(tiedosto,paivia2^[lask2]);
   reset(tiedosto);
        while not eof (tiedosto) do begin
   inc(lask,1);
   readln(tiedosto,yt);
   koko^[lask] := yt;
   readln(tiedosto,yt);
   kansia^[lask] := yt;
   readln(tiedosto,yt);
   pohjia^[lask] := yt;
   readln(tiedosto,yt);
   venttiileita^[lask] := yt;
   end;
   close(tiedosto);
   clrscr;
   writeln('    PŽIVŽ ,paivia2[lask2]');
   for lask3 := 1 to lask do begin
   writeln('   ',venttiileita^[lask3]);
   end;
   end;
    repeat
  writeln('Uudelleen (k/e) ? ');
  vast := readkey;
  if vast = #101 then begin
  totuus := false;
  arvo := true;
  end;
  if totuus = true then begin
  if vast = #107 then arvo := true
  else begin
  writeln('V„„r„ n„pp„in');
  arvo := false;
  end;
  end;
  until arvo = true;
  end;
  until totuus = false;
  alku;
  end;
  procedure yksikokov;
  var
   h,grtila : integer;
   arvo : boolean;
   vast : char;
   begin
repeat
  grtila := detect;
initgraph(grtila,h, 'c:\tp');
 settextstyle(triplexfont,horizdir,6);
 outtext('     Talletus');
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 settextstyle(triplexfont,horizdir,4);
 outtextxy(140,120, ' A. Pohjat');
 outtextxy(140,160, ' B. Kannet');
 outtextxy(140,200, ' C. Venttiilit');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #100 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then pohjaty;arvo := false;
  if vast = #98 then kannety;arvo := false;
  if vast = #99 then venttiility;arvo := false;
  until arvo = false;
end;

  procedure kaikkikootv;
const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 kokoja : ^kokoj;
 valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko : string;
   begin
   repeat

   gtila := detect;
   initgraph(gtila,h,'c:\tp');
   settextstyle(triplexfont,horizdir,6);
   outtext('    KAIKKI KOOT');
   settextstyle(triplexfont,horizdir,4);
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 outtextxy(170,120, ' A. Pohjat');
 outtextxy(170,160, ' B. Kannet');
 outtextxy(170,200, ' C. Venttiilit');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #100 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then pohjatk;
  if vast = #98 then kannetk;
  if vast = #99 then venttiilitk;
  end;
   procedure vuosiv;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 kokoja : ^kokoj;
 valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko : string;
   begin
   repeat

   gtila := detect;
   initgraph(gtila,h,'c:\tp');
   settextstyle(triplexfont,horizdir,6);
   outtext('  VUOSI TAPAHTUMAT ');
   settextstyle(triplexfont,horizdir,4);
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 outtextxy(170,120, ' A. Yksi koko ');
 outtextxy(170,160, ' B. Kaikki koot');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #99 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then yksikokov;
  if vast = #98 then kaikkikootv;
  until arvo = true;

  end;
  procedure tarkistusv;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 kokoja : ^kokoj;
 valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko : string;
   begin
   repeat

   gtila := detect;
   initgraph(gtila,h,'c:\tp');
   settextstyle(triplexfont,horizdir,6);
   outtext('    TARKISTUS');
   settextstyle(triplexfont,horizdir,4);
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 outtextxy(170,120, ' A. Paiv„-ventiili');
 outtextxy(170,160, ' B. Venttiili-p„iv„');
 outtextxy(170,200, ' C. Vuosi tapahtumat');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #100 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then paiva_venttiili;
  if vast = #98 then venttiili_paiva;
  if vast = #99 then vuosiv;
  until arvo = true;
  end;
 procedure venttiilit;
   const
ventko  : array [1..12] of string =
('25','32','40','50','65','80','100','125','150','200','250','300');
type
kok  = array[1..30] of string;
kansi = array[1..30] of string;
pohji = array[1..30] of string;
venttiileit = array[1..30] of string;
kokoj = array[1..100] of string;
var
 KOKO : ^kok;
 kansia : ^kansi;
 haktied : searchrec;
 pohjia : ^pohji;
 arvo : boolean;
 hak : string;
 venttiileita : ^venttiileit;
 gtila : integer;
 h : integer;
 pp,kk,vv,vt,i,kl,lask3,lask2,lask,lask1,kan,poh,ven : integer;
 totuus : boolean;
 vast : char;
 kokoja : ^kokoj;
 valinta : string;
 tiedosto,nimi : text;
 a,b,c,d,e,f,g,ko : string;
   begin
   repeat
   gtila := detect;
   initgraph(gtila,h,'c:\tp');
   settextstyle(triplexfont,horizdir,6);
   outtext('  VENTTIILIT');
   settextstyle(triplexfont,horizdir,4);
 rectangle(1,1,600,400);
 rectangle(5,5,595,395);
 outtextxy(170,120, ' A. Tallennus');
 outtextxy(170,160, ' B. Tarkistus');
 outtextxy(170,200, ' C. Poisto');
 settextstyle(sansseriffont,horizdir,3);
 arvo := false;
 repeat
 outtextxy(40,425, ' Valitse toiminto');
 vast := readkey;
  IF  vast > #96  then
  begin
  if vast < #100 then arvo := true
  else arvo := false;
  end;
  if arvo = false then
  begin
  outtextxy(40,455, ' V„„r„ n„pp„in');
  end;
  until arvo  = true;
  closegraph;
  if vast = #97 then talletusv;
  if vast = #98 then tarkistusv;
  if vast = #99 then poistov;
  until arvo = true;
  end;
  end.
