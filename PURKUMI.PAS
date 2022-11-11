program asetus;
uses crt,dos;

































    procedure muokkaaauto(hakemisto : string);
      var mjono : string;
      rivinro : integer;
      function etsirivi(nimi : string) : integer;
        var muut : text;
            a,b : integer;
            alkurivi : string;
            rivi : array [1..100] of string;
        begin
          a := 0;
          chdir('c:\');
          assign(muut,'autoexec.bat');
          reset(muut);
          while not eof(muut) do begin
          inc(a);
          readln(muut,rivi[a]);
        end;
        close(muut);
        etsirivi := 0;
        for b := 1 to a do begin
          alkurivi := copy(rivi[b],0,length(nimi));
          if alkurivi = nimi then etsirivi := b;
        end;
      end;
      procedure muuta (b : integer;nimi,hakem : string);
        var a : integer;
            muut : text;
            rivi : array [1..100] of string;
        begin
          a := 0;
          chdir('c:\');
          assign(muut,'autoexec.bat');
          reset(muut);
          while not eof(muut) do begin
            inc(a);
            readln(muut,rivi[a]);
          end;
          close(muut);
          if b = 0 then begin
            inc(a);
            insert(' ',hakem,1);
            insert(hakem,nimi,length(nimi)+1);
            rivi[a] := nimi;
          end else begin
            insert(';',hakem,1);
            insert(hakem,rivi[b],length(rivi[b])+1);
          end;
          assign(muut,'autoexec.bat');
          rewrite(muut);
          for b := 1 to a do begin
            writeln(muut,rivi[b]);
          end;
          close(muut);
      end;
    begin
    muuta(etsirivi('path'),'path',hakemisto);
    muuta(etsirivi('append'),'append',hakemisto);
    end;
  begin
    muokkaaauto;
  end.