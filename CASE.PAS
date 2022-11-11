program cases(input, output);
var
   i : integer;

begin
   repeat
      write( 'Enter an integer, 0 to end : ' );
      readln(i);
      case i of
        0:;
        1:i:=i*2;
	2:i:=i*3;
	3:i:=i*4;
      end;
      writeln(i);
   until i = 0;
end.
