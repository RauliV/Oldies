
Program Sieve(input, output);

const
   Psize = 7400;

var
   I, J   : integer;
   Reps   : integer;
   Pcount : integer;
   Prime  : integer;
   Hour, Min, Sec, Hund : integer;
   TStart, TEnd : real;
   Flags  : array[1..Psize] of boolean;

begin
   Writeln( '5 passes' );
   GetTime( Hour, Min, Sec, Hund );
   TStart := (Min * 60) + Sec + (Hund / 100);

   For Reps := 1 to 5 do
   begin;
(*      Write( '.' ); *)
      Pcount := 0;
      For I := 1 to Psize do 
	Flags[I] := true; 		{Fill array with true.}
      For I := 1 to Psize do
      begin;
         If Flags[I] then
         begin;
            Pcount := Pcount + 1;
            Prime := I + I + 3;
            J := Prime + I;
            While J <= Psize do
               begin;
                  Flags[J] := false;
                  J := J + Prime;
               End {killing all multiples};
            End {found a prime};
         End {scan the array};
      End {each pass};

   GetTime( Hour, Min, Sec, Hund );
   TEnd := (Min * 60) + Sec + (Hund / 100);
   Writeln( (TEnd - TStart):4:2, ' seconds.' );
   Writeln( Pcount, ' primes found.' );
   End.
