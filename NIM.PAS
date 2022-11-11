Program Nim( input, output );

const
   NROWS = 18;

var
   i : integer;
   key : char;
   pile : array[1..3] of integer;
   move : record
      ntaken, pileno : integer;
   end;

function GameOver : boolean;
begin
   gameover := ( pile[1] + pile[2] + pile[3] = 0 );
end;

procedure display;
var
   start, row, col : integer;
begin
   ClrScr;
   start := 0;
   for col := 1 to 3 do
      if pile[col] > start then
         start := pile[col];

   for row := start downto 1 do
      begin
      for col := 1 to 3 do
         if pile[col] >= row then
            write( '  __  ' )
         else
            write( '      ' );         
      writeln;
      end;

   if start > 0 then
      writeln( pile[1]:4, pile[2]:6, pile[3]:6 );

   writeln;
end;

procedure signon;
begin
   writeln;
   writeln( '   *** NIM ***   ' );
   writeln;
   writeln( 'I will set up three piles of coins.' );
   writeln( 'To move, take any number of coins away from any pile.' );
   writeln( 'The player who clears the screen wins.' );
   writeln;
   write( 'Now hit any key to start:' );

   while NOT keypressed do
      ;
   key := readkey;
   writeln;
end;

Procedure hismove;
var
   ok : boolean;
begin
   repeat
      write( 'Pile (1,2 or 3)? ' );
      readln( move.pileno );
      ok := (move.pileno >= 1) AND (move.pileno <= 3);
      if ok then
         begin
         write( 'Number to take away? ' );
         readln( move.ntaken );
         ok := (move.ntaken >= 1) AND (move.ntaken <= pile[move.pileno]);
         end;
      if not ok then writeln( 'What??' );
   until ok;
   pile[ move.pileno ] := pile[ move.pileno ] - move.ntaken;
end;

Procedure mymove;
var
   firstbit, x, i, j : integer;
   bit : array[1..3,1..4] of boolean;
   parity : array[1..4] of boolean;
begin
   for i := 1 to 3 do
      begin
      x := pile[i];
      for j := 4 downto 1 do
         begin
         bit[i, j] := odd(x);
         x := x div 2;
         end;
      end;

   for i := 1 to 4 do
      parity[i] := bit[1,i] <> (bit[2,i] <> bit[3,i]);

   move.pileno := 1;
   move.ntaken := 0;
   if not ( parity[1] OR parity[2] OR parity[3] OR parity[4] ) then
      begin
      while pile[move.pileno] = 0 do
         move.pileno := move.pileno + 1;
      if pile[move.pileno] = 1 then
         move.ntaken := 1
      else
         move.ntaken := random( pile[move.pileno]-1 ) + 1;
      end
   else
      begin
      firstbit := 1;
      while not parity[firstbit] do
         firstbit := firstbit + 1;
      while not bit[move.pileno, firstbit] do
         move.pileno := move.pileno + 1;
      for i := firstbit to 4 do
         begin
         x := 1;
         for j := 3 downto i do
            x := x * 2;
         if parity[i] then
            if bit[move.pileno, i] then
               move.ntaken := move.ntaken + x
            else
               move.ntaken := move.ntaken - x;
         end;
      end;
   pile[move.pileno] := pile[move.pileno] - move.ntaken;
end;

Begin
   Randomize;
   Signon;
   repeat
      for i := 1 to 3 do pile[i] := random(10) + 6;
      display;
      repeat
         hismove;
         if gameover then
            writeln( 'Congratulations ...  You win!' )
         else
            begin
            display;
            Writeln( 'My move is ...' );
            Delay( 1500 );
            mymove;
            display;
            writeln( move.ntaken:3, ' from pile', move.pileno:2 );
            if gameover then
               writeln( '*** I win! ***' );
            writeln;
            end;
      until gameover;
      write( 'Another game? (y/n) ' );
      repeat
         key := readkey;
      until (key = 'n') OR (key = 'y');
   until key = 'n';
End.

