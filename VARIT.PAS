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
        var a : int