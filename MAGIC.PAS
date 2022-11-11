PROGRAM Magic(Input, Output);

const
   maxsize = 11;	{Maximum size of square}
type
   sqrtype = ARRAY[1..maxsize, 1..maxsize] OF Integer;
var
   square : sqrtype;
   size, row, sum : Integer;

  Procedure MakeSquare( VAR sq : sqrtype; Limit : Integer );
  var
     num, r, c  : Integer;

  begin
    FOR r := 1 TO Limit DO
      FOR c := 1 TO Limit DO sq[r, c] := 0;

    IF Odd(Limit) THEN
      BEGIN (* start in middle row of last column *)
        r := (Limit+1) DIV 2;
        c := Limit;
        FOR num := 1 TO Sqr(Limit) DO
          BEGIN
            IF sq[r, c] <> 0 THEN
              BEGIN (* select a different diagonal *)
                r := r-1; IF r < 1 THEN r := r+Limit;
                c := c-2; IF c < 1 THEN c := c+Limit;
              END;
            sq[r, c] := num; (* move down diagonally to right *)
            r := r+1; IF r > Limit THEN r := r-Limit;
            c := c+1; IF c > Limit THEN c := c-Limit;
          END; (* FOR *)
      END; (* IF *)
  END; (* MakeSquare *)

  Procedure WriteSquare( VAR sq: sqrtype; Limit: Integer );
  var 
     row, col : Integer;

  Begin
     FOR row := 1 TO Limit DO
        begin
	for col := 1 to (Limit div 2) do
	   Write( sq[row, 2*col -1]:4, sq[row, 2*col]:4 );
        Writeln( sq[row, Limit]:4 );
        end;
  End; (* PrintSquare *)

begin
  size := 3;
  while ( size <= maxsize ) do
     begin
     WriteLn( 'Magic Square of size = ', size:3 );
     WriteLn;
     MakeSquare( square, size );
     WriteSquare( square, size );
     WriteLn;
     sum := 0;
     FOR row := 1 TO size DO 
        sum := sum + square[row, 1];
     WriteLn('Sum of row, column or diagonal = ', sum:5);
     WriteLn;
     WriteLn;
     size := size+2;
     end;
end.
