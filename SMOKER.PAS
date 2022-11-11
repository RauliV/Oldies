PROGRAM CigSmok(Input, Output);

   CONST
      NumCig         = 15; {  # of cigarettes for each smoker }
      paper          = 1;  {      .                           }
      match          = 3;  {      .   Resources               }
      tobacco        = 5;  {      .                           }

   TYPE
      semaphore = Integer;
      resource  = Integer;

   VAR
      S              : ARRAY[1..8] OF semaphore;
      alive          : ARRAY[1..8] OF Boolean;
      NumLeft        : ARRAY[1..3] of integer;
      a              : semaphore;
      k, m           : Integer;

   FUNCTION VALID(a, b : resource) : Boolean;
   BEGIN
      VALID := False;
      IF a<>b then
         IF alive[a+b] THEN
            VALID := True;
      END;

   PROCEDURE agent;
      VAR
         r1, r2      : resource;
         j           : Integer;
   BEGIN
      FOR j := 1 TO 3*NumCig DO BEGIN
         WAIT(a);
         REPEAT
            r1 := 2*random(3) + 1;
            r2 := 2*random(3) + 1;
         UNTIL VALID(r1, r2);
         SIGNAL(S[r1+r2]);
         END;
     END;

   procedure display;
   var
      loop         : Integer;
   begin
      Disable;
{      write( chr(27),'[2J' ); }
      ClrScr;

      for loop := 1 to 3 do
         if ( NumLeft[loop] > 0 ) then
            writeln( '=':NumLeft[loop] )
         else
            writeln( 'OX' );
      Enable;
   end;

   procedure beep;
   begin
      Disable;
      Sound( 100 );
      Delay( 250 );
      NoSound;
      Enable;
   end;

   procedure smoker(r3 : resource);
   var
      i          : resource;
      j, y       : Integer;
   begin
      i := (paper+match+tobacco)-r3;
      j := NumCig;
      y := (r3+1) div 2;

      repeat
         wait( s[i] );

         j := j - 1;
         NumLeft[y] := j;

         display;
{         write( chr(27), '[', r3:1, ';', j:1, 'H', ' '); }
         if j = 0 then 
            alive[i] := False;
         signal(a)
      until j = 0;
      beep;
      end;

BEGIN
{   writeln( chr(27),'[2J' ); }
   ClrScr;

   a := 1;
   FOR k := 1 TO 8 DO S[k] := 0; { Zero Semaphore array }
   FOR k := 1 TO 8 DO alive[k] := True;
   FOR k := 1 TO 3 DO NumLeft[k] := NumCig;

   for m:=0 to 2 do 
      begin
      writeln( '=':NumCig );
      end;

   cobegin
   agent;
   smoker(paper); smoker(match); smoker(tobacco)
   coend;
   END.
