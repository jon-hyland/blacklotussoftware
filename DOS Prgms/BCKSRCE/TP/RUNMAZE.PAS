program RunMaze;

uses
 Crt;

type
 ScreenType = array[1..80, 1..24] of boolean;
 EnemyPos = array[1..3] of integer;

var
 x, y : integer;
 Coin : ScreenType;
 Coins : integer;
 Enemy : integer;
 EnemyX : EnemyPos;
 EnemyY : EnemyPos;
 Move : integer;
 Obj : ScreenType;
 Done : boolean;
 Dead : boolean;
 Quit : boolean;
 Key : char;
 OldX, OldY : integer;
 j : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

function Something(x, y : integer) : boolean;
 begin
  Something := Obj[x,y] or Coin[x,y];
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  Cursor;
  write(chr(219));
  textcolor(white);
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     Obj[j,k] := false;
     Coin[j,k] := false;
    end;
  Coins := 10;
  for i := 1 to Coins do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Coin[j,k];
    gotoxy(j,k);
    write('*');
    Cursor;
    Coin[j,k] := true;
   end;
  for i := 1 to 200 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Something(j,k);
    gotoxy(j,k);
    write('.');
    Cursor;
    Obj[j,k] := true;
   end;
  for i := 1 to 3 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Something(j,k);
    gotoxy(j,k);
    write('X');
    Cursor;
    EnemyX[i] := j;
    EnemyY[i] := k;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until not Something(x,y);
  gotoxy(x,y);
  write('O');
  Cursor;
 end;

function Touch(x,y : integer) : boolean;
 var
  t : boolean;
  j : integer;
 begin
  t := false;
  for j := 1 to 3 do
   if ((EnemyX[j] = x) and (EnemyY[j] = y)) then
    t := true;
  Touch := t;
 end;

function GoodMove(e : integer) : integer;
 var
  XDif, YDif : integer;
 begin
  XDif := x - EnemyX[e];
  YDif := y - EnemyY[e];
  if abs(XDif) > abs(YDif) then
   if XDif > 0 then GoodMove := 1 else GoodMove := 2
  else
   if YDif > 0 then GoodMove := 3 else GoodMove := 4;
 end;

begin
 Init;
  repeat
   OldX := x;
   OldY := y;
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in ['H', 'K', 'P', 'M', #27];
    case Key of
     #27 : Quit := true;
     'H' : y := y - 1;
     'K' : x := x - 1;
     'P' : y := y + 1;
     'M' : x := x + 1;
    end; {case}
   if x > 80 then x := 1;
   if x < 1 then x := 80;
   if y > 24 then y := 1;
   if y < 1 then y := 24;
   if Obj[x,y] then
    begin
     x := OldX;
     y := OldY;
    end;
   gotoxy(OldX, OldY);
   write(' ');
   gotoxy(x,y);
   write('O');
   Cursor;
   if Coin[x,y] then
    begin
     Coin[x,y] := false;
     Coins := Coins - 1;
     sound(300);
     delay(25);
     sound(400);
     delay(25);
     nosound;
     if Coins <= 0 then  Done := true;
    end;
   if Touch(x,y) then Dead := true;

   if not Dead then
    begin
     Enemy := random(3)+1;
     OldX := EnemyX[Enemy];
     OldY := EnemyY[Enemy];
     if random(2) <> 0 then
       Move := random(4)+1
     else
      Move := GoodMove(Enemy);
      case Move of
       1 : EnemyX[Enemy] := EnemyX[Enemy] + 1;
       2 : EnemyX[Enemy] := EnemyX[Enemy] - 1;
       3 : EnemyY[Enemy] := EnemyY[Enemy] + 1;
       4 : EnemyY[Enemy] := EnemyY[Enemy] - 1;
      end; {case}
     if EnemyX[Enemy] > 80 then EnemyX[Enemy] := 1;
     if EnemyX[Enemy] < 1 then EnemyX[Enemy] := 80;
     if EnemyY[Enemy] > 24 then EnemyY[Enemy] := 1;
     if EnemyY[Enemy] < 1 then EnemyY[Enemy] := 24;
     if Something(EnemyX[Enemy], EnemyY[Enemy]) then
      begin
       EnemyX[Enemy] := OldX;
       EnemyY[Enemy] := OldY;
      end;
     gotoxy(OldX, OldY);
     write(' ');
     gotoxy(EnemyX[Enemy], EnemyY[Enemy]);
     write('X');
     Cursor;
    end;
  until Dead or Quit or Done;
 if Dead then
  begin
   for j := 500 downto 1 do
    begin
     sound(j);
     delay(1);
    end;
   nosound;
  end;
 if Done then
  begin
   for j := 100 to 200 do
    begin
     sound(j);
     delay(1);
    end;
   for j := 200 downto 100 do
    begin
     sound(j);
     delay(1);
    end;
   for j := 100 to 200 do
    begin
     sound(j);
     delay(1);
    end;
   nosound;
  end;
end.