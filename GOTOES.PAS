program Gotoes( input, output );

procedure test;

procedure Gotoes2; forward;

procedure Gotoes1;
label
   0, 1, 2, 3, 4, 5, 6;
var
   ch : char;
begin
   0:
   if keypressed then
      begin
      ch := readkey;
      Gotoes2;
      goto 6;
      end
   else
      goto 5;

   1: writeln( 'line 1' );
   writeln;
   goto 0;
   2: writeln( 'line 2' );
   goto 1;
   3: writeln( 'line 3' );
   goto 2;
   4: writeln( 'line 4' );
   goto 3;
   5: writeln( 'line 5' );
   goto 4;

   6: writeln;
end;

procedure Gotoes2;
var
   i : integer;
label
   11, 12, 13, 14, 15, 16;
begin
   11: writeln( 'line 1-2' );
   12: writeln( 'line 2-2' );
   13: writeln( 'line 3-2' );
   14: writeln( 'line 4-2' );
   15: writeln( 'line 5-2' );
   writeln;

   if keypressed then 
      goto 16
   else
      goto 11;

   16: writeln;
end;

begin
   gotoes1;
end;

begin
   test;
end.
