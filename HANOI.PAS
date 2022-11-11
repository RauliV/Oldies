Program Hanoi( input, output );

var
   ndiscs : integer;
   pegs : array[1..3] of integer;

Procedure move( source, destn, spare : integer; n: integer );
begin
   if n > 1 then 
      move( source, spare, destn, n-1 );

   pegs[source] := pegs[source] - 1;
   pegs[destn] := pegs[destn] + 1;
   writeln( pegs[1]:3, pegs[2]:3, pegs[3]:3 );
{   writeln( 'Moving from', source:2, ' to', destn:2 ); }

   if n > 1 then 
      move( spare, destn, source, n-1 );
end;

Begin
   write( 'How many discs? ' );
   readln( ndiscs );
   writeln;

   pegs[1] := ndiscs;
   pegs[2] := 0;
   pegs[3] := 0;

   writeln( pegs[1]:3, pegs[2]:3, pegs[3]:3 );
   move( 1, 3, 2, ndiscs );
   writeln( 'Done.' );
End.

