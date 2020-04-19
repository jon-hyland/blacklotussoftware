program Run;

type
 Screen_Type = array[1..80, 1..24] of boolean;

var
 Rock : ScreeType;
 X, Y : integer;
 BadX, BadY : integer;
 Dead : boolean;

procedure Init;
 var
  RockCount : integer;
  Rand1, Rand2 : integer;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  Dead := false;
  for RockCount := 1 to 500 do
   begin
    Rand1 := random(80)+1;
    Rand2 := random(24)+1;
    Rock[Rand1, Rand2)] := true;
    gotoxy(Rand1, Rand2);
    write('O');
   end;
   repeat
    Rand1 := random(80)+1;
    Rand2 := random(24)+1;
   until not Rock[Rand1, Rand2];
  X := Rand1;
  Y := Rand2;
   repeat
    Rand1 := random(80)+1;
    Rand2 := random(24)+1;
   until not Rock[Rand1, Rand2];
  BadX := Rand1;
  BadY := Rand2;
  gotoxy(X,Y);
  write('i');
  gotoxy(BadX, BadY);
  write('X');
 end;

procedure YouMove;
 var
  Key : char;
  oX, oY : integer;
 begin
  oX := X;
  oY := Y;
  Key := readkey;
   case Key of
    'u', 'U' : Y := Y - 1;
    'j', 'J' : Y := Y + 1;
    'h', 'H' : X := X - 1;
    'k', 'K' : X := X + 1;
   end; {case}
  if X > 80 then X := 1;
  if X < 1 then X := 80;
  if Y > 24 then Y := 1;
  if Y < 1 then Y := 24;
  if Rock[X,Y] then
   begin
    sound(200);
    delay(100);
    nosound;
    X := oX;
    Y := oY;
   end;
  gotoxy(oX, oY);
  write(' ');
  gotoxy(X, Y);
  write('i');
 end;

procedure BadMove;
 var
  oX, oY : integer;
  TotMoves : integer;
  Move : integer;
 begin
  TotMoves := random(5)+1;
  for Move := 1 to TotMoves do
   begin






begin
 repeat
  YouMove;
  BadMove;
 until Dead;
end.
