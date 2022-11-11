Program ListIt( input, output );
type
   string = array[0..128] of char;
var
   Fname : string;
   F : text;
   buf : string;
   I : integer;

Begin
   Write( 'Enter the file name to read: ' );
   Readln( Fname );

   Assign( F, Fname );
   Reset( F );

   While ( NOT EOF(F) ) do
      Begin
      I := 0;
      While ( NOT EOLN(F) AND NOT EOF(F) ) do
         Begin
         I := I + 1;
         Read( F, buf[I] );
         End;
      buf[0] := CHR( I );
      Readln( F );

      Writeln( buf );
      End;
   Close( F );
End.
