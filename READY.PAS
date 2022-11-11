program Ready(input, output);

const
	pi = 3.14159;

type
	string = array[0..48] of char; (* holds textual strings *)

var 	i, j :integer;
	ch : char;
	r : real;
	Rsp : string;
	F : text;

begin
	assign( F, 'zip.pas' );
	rewrite( F );
	writeln( F, 'program Zip( input, output );' );
	writeln( F, 'const' );
	writeln( F, '  pi = 3.14159;' );
	writeln( F, 'var' );
	writeln( F, '  i : integer;' );
	writeln( F, 'begin' );
	writeln( F, ' for i := ', 1:1, ' to ', 10:1 );
	writeln( F, ' do writeln( i );' );
	writeln( F, ' writeln( ', pi:7:4, ' );' );
	writeln( F, 'end.' );
	close( F );

	repeat
		i := 0;
		j := 0;
		r := 0;

		write( 'enter an int, real, int, string: ' );
		readln( i, r, j, Rsp );
		writeln( i, ' ', r, ' ', j, '-', Rsp );
                write( 'continue (y/n)? ' );
		readln( ch );
	until	ch = 'n';
end.
