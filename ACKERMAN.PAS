program Ackerman( Input, Output );

var
  I, J: integer;
  Hour, Minute, Second, Hund : integer;
  TStart, TEnd : real;

Function Ack( M, N: integer ) : integer;
Begin
  if M = 0 then
     Ack := N + 1
  else if N = 0 then
     Ack := Ack( M-1, 1 )
  else 
     Ack := Ack( M-1, Ack(M, N-1) );

End;

Begin
   write( 'Enter two integers: ' );
   readln( I, J );
   GetTime( Hour, Minute, Second, Hund );
   TStart := (Minute * 60) + Second + (Hund / 100);

   writeln( 'Ackerman(', I:1, ',', J:1, ') = ', Ack(I,J) );

   GetTime( Hour, Minute, Second, Hund );
   TEnd := (Minute * 60) + Second + (Hund / 100);
   writeln( (TEnd - TStart):4:2, ' seconds.' );
End.
