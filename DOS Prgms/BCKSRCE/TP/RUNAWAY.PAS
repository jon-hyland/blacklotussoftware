program RunAway;

uses
 Crt;

type
 ScreenObject = array[1..80, 1..24] of boolean;

var
 Level : integer;
 Rock : ScreenObject;
 Coin : ScreenObject;
 Coins : integer;
 j, k : integer;
 Key : char;
 x, y : integer;
 bx, by : integer;
 ox, oy : integer;
 Dead : boolean;
 Moves : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure GameInit;
 begin
  randomize;
  Level := 1;
  Dead := false;
 end;

procedure LevelInit;
 var
  i, j, k : integer;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  gotoxy(2,25);
  write('Level : ', Level);
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     Rock[j,k] := false;
     Coin[j,k] := false;
    end;
  for i := 1 to 100 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Rock[j,k];
    Rock[j,k] := true;
    gotoxy(j,k);
    write('.');
    Cursor;
   end;
  Coins := 0;
  for i := 1 to (Level * 10) do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until ((not Rock[j,k]) and (not Coin[j,k]));
    Coin[j,k] := true;
    gotoxy(j,k);
    write('o');
    Cursor;
    Coins := Coins + 1;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until ((not Rock[x,y]) and (not Coin[x,y]));
   repeat
    bx := random(80)+1;
    by := random(24)+1;
   until ((not Rock[bx,by]) and (not Coin[bx,by]) and ((bx <> x) or (by <> y)));
  gotoxy(x,y);
  write('X');
  gotoxy(bx, by);
  write('%');
  Cursor;
 end;

procedure MoveRand;
 var
  Dir : integer;
 begin
  Dir := random(4)+1;
  ox := bx;
  oy := by;
   case Dir of
    1 : bx := bx + 1;
    2 : bx := bx - 1;
    3 : by := by + 1;
    4 : by := by - 1;
   end; {case}
  if Rock[bx,by] or Coin[bx,by] then
   begin
    bx := ox;
    by := oy;
   end;
  if bx > 80 then by := 80;
  if bx < 1 then bx := 1;
  if by > 24 then by := 24;
  if by < 1 then by := 1;
  gotoxy(ox,oy);
  write(' ');
  gotoxy(bx,by);
  write('%');
  Cursor;
 end;

procedure MoveRight;
 var
  XDif, YDif : integer;
 begin
  ox := bx;
  oy := by;
  XDif := x - bx;
  YDif := y - by;
  if abs(XDif) > abs(YDif) then
   if XDif > 0 then
    bx := bx + 1
   else
    bx := bx - 1
  else
   if YDif > 0 then
    by := by + 1
   else
    by := by - 1;
  if Rock[bx,by] or Coin[bx,by] then
   begin
    bx := ox;
    by := oy;
   end;
  if bx > 80 then by := 80;
  if bx < 1 then bx := 1;
  if by > 24 then by := 24;
  if by < 1 then by := 1;
  gotoxy(ox,oy);
  write(' ');
  gotoxy(bx,by);
  write('%');
  Cursor;
 end;

procedure YouDie;
 begin
  gotoxy(30,10);
  write(' Your dead. ');
  Dead := true;
  readkey;
 end;

begin
 GameInit;
  repeat
   LevelInit;
    repeat
     ox := x;
     oy := y;
     Key := readkey;
      case Key of
       #0 :
        begin
         Key := readkey;
          case Key of
           'H' : y := y - 1;
           'K' : x := x - 1;
           'P' : y := y + 1;
           'M' : x := x + 1;
          end; {case}
         if x < 80 then x := 80;
         if x < 1 then x := 1;
         if y > 24 then y := 24;
         if y < 1 then y := 1;
         if Rock[x,y] then
          begin
           x := ox;
           y := oy;
          end;
         if Coin[x,y] then
          begin
           Coin[x,y] := false;
           Coins := Coins - 1;
          end;
         if ((x = bx) and (y = by)) then
          YouDie;
        end;
       #27 : Dead := true;
      end; {case}




     Moves := random(5)+1;
      case Moves of
       1,2 : MoveRight;
         3 : MoveRand;
         4 : begin
              MoveRight;
              MoveRight;
             end;
      end; {case}
     if ((x = bx) and (y = oy)) then
      YouDie;
    until Dead;
  until Dead;
 clrscr;
end.





