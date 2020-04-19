program Run;

uses
 Crt;

type
 ScreenType = array[1..80, 1..24] of boolean;
 EnemyType = array[1..5] of integer;
 CoinType = array[1..10] of integer;

var
 Obj : ScreenType;
 EnemyX : EnemyType;
 EnemyY : EnemyType;
 CoinX : CoinType;
 CoinY : CoinType;
 Coins : integer;
 x, y : integer;
 tx, ty : integer;
 ox, oy : integer;
 Key : char;
 Dead : boolean;
 Quit : boolean;
 Rand, Enemy, Move : integer;
 Count : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(30,10);
  write('- Run Game  v1.0 -');
  gotoxy(25,12);
  write('(c)1996 BlackWolf Productions');
  Cursor;
  readkey;
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  Clear;
  randomize;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  for i := 1 to 100 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    gotoxy(j,k);
    write('.');
    Cursor;
   end;
  Coins := 10;
  for i := 1 to Coins do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    CoinX[i] := j;
    CoinY[i] := k;
    gotoxy(j,k);
    write('o');
    Cursor;
   end;
  for i := 1 to 5 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    EnemyX[i] := j;
    EnemyY[i] := k;
    gotoxy(j,k);
    write('X');
    Cursor;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until not Obj[x,y];
  gotoxy(x,y);
  write('O');
  Cursor;
  for i := 1 to 5 do
   Obj[EnemyX[i], EnemyY[i]] := false;
  for i := 1 to 10 do
   Obj[CoinX[i], CoinY[i]] := false;
  Dead := false;
  Quit := false;
 end;

function GoodMove(Enemy : integer) : integer;
 var
  XDif, YDif : integer;
 begin
  XDif := x - EnemyX[Enemy];
  YDif := y - EnemyY[Enemy];
  if abs(XDif) > abs(YDif) then
   if XDif > 0 then GoodMove := 1 else GoodMove := 2
  else
   if YDif > 0 then GoodMove := 3 else GoodMove := 4;
 end;

function EnemyAt(x, y : integer) : boolean;
 var
  j : integer;
 begin
  EnemyAt := false;
  for j := 1 to 5 do
   if (EnemyX[j] = x) and (EnemyY[j] = y) then
    EnemyAt := true;
 end;

function CoinAt(x, y : integer) : boolean;
 var
  j : integer;
 begin
  CoinAt := false;
  for j := 1 to 10 do
   if (CoinX[j] = x) and (CoinY[j] = y) then
    CoinAt := true;
 end;


begin
 Title;
 Init;
  repeat
    repeat
     Count := 0;
      repeat
       delay(5);
       Count := Count + 1;
      until KeyPressed or (Count > 10);
     Enemy := random(5)+1;
     Move := random(4+2)+1;
     if Move > 4 then
      Move := GoodMove(Enemy);
     tx := EnemyX[Enemy];
     ty := EnemyY[Enemy];
     ox := tx;
     oy := ty;
      case Move of
       1 : tx := tx + 1;
       2 : tx := tx - 1;
       3 : ty := ty + 1;
       4 : ty := ty - 1;
      end; {case}
     if tx > 80 then tx := 1;
     if tx < 1 then tx := 80;
     if ty > 24 then ty := 1;
     if ty < 1 then ty := 24;
     if (Obj[tx,ty]) or (EnemyAt(tx, ty)) or (CoinAt(tx, ty)) then
      begin
       tx := ox;
       ty := oy;
      end;
     gotoxy(ox,oy);
     write(' ');
     gotoxy(tx,ty);
     write('X');
     Cursor;
     EnemyX[Enemy] := tx;
     EnemyY[Enemy] := ty;
     if (tx = x) and (ty = y) then
      Dead := true;
    until KeyPressed or Dead;
   if not Dead then
    begin
     Key := readkey;
     ox := x;
     oy := y;
      case Key of
       'H' : y := y - 1;
       'K' : x := x - 1;
       'P' : y := y + 1;
       'M' : x := x + 1;
       #27 : Quit := true;
      end;
     if x > 80 then x := 1;
     if x < 1 then x := 80;
     if y > 24 then y := 1;
     if y < 1 then y := 24;
     if Obj[x,y] then
      begin
       x := ox;
       y := oy;
      end;
     gotoxy(ox,oy);
     write(' ');
     gotoxy(x,y);
     write('O');
     Cursor;
     if EnemyAt(x,y) then Dead := true;
     if CoinAt(x,y) then
      begin
       Coins := Coins - 1;
       for Count := 1 to 10 do
        begin
         if (x = CoinX[Count]) and (y = CoinY[Count]) then
          begin
           CoinX[Count] := 0;
           CoinY[Count] := 0;
          end;
         sound((11-Count)*25);
         delay(5);
        end;
       nosound;
      end;
    end;
  until Dead or Quit or (Coins <= 0);
end.