program RunGame;

uses
 Crt;

type
 ObjType = array[1..80, 1..24] of boolean;
 CoorType = array[1..12] of integer;

var
 Obj : ObjType;
 Level : integer;
 EnemyX, EnemyY : CoorType;
 TotEnemy : integer;
 Enemy : integer;
 Coin : ObjType;
 TotCoin : integer;
 x, y : integer;
 ox, oy : integer;
 tx, ty : integer;
 Move : integer;
 Quit : boolean;
 Dead : boolean;
 Key : char;


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

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(29, 10);
  write('- Run Game 2000  v1.0 -');
  gotoxy(25,12);
  write('(c) 1996  BlackWolf Productions');
  Cursor;
  readkey;
 end;

procedure UpDate;
 begin
  gotoxy(10,25);
  write(Level);
  gotoxy(36,25);
  write(TotCoin);
  Cursor;
 end;

procedure GameInit;
 begin
  randomize;
  Level := 1;
  Quit := false;
 end;

procedure LevelInit;
 var
  i, j, k : integer;
 begin
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  Clear;
  for i := 1 to (25 + ((Level-1) * 10)) do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    gotoxy(j,k);
    write(chr(249));
    Cursor;
   end;
  TotEnemy := 2 + Level;
  for i := 1 to TotEnemy do
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
  TotCoin := 3 + (Level * 2);
  for i := 1 to TotCoin do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Coin[j,k] := true;
    gotoxy(j,k);
    write('o');
    Cursor;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until (not Obj[x,y]) and (not Coin[x,y]);
  gotoxy(x,y);
  write('O');
  Cursor;
  for j := 1 to TotEnemy do
   Obj[EnemyX[j], EnemyY[j]] := false;
  gotoxy(2,25);
  write('Level :              Coins Left :');
  UpDate;
 end;

function GoodMove(En : integer) : integer;
 var
  XDif, YDif : integer;
 begin
  XDif := x - EnemyX[En];
  YDif := y - EnemyY[En];
  if Abs(XDif) > Abs(YDif) then
   if XDif > 0 then GoodMove := 1 else GoodMove := 2
  else
   if YDif > 0 then GoodMove := 3 else GoodMove := 4;
 end;

procedure EndDelay(Time : integer);
 var
  x : integer;
 begin
  x := 0;
   repeat
    delay(2);
    x := x + 1;
   until (x > Time) or KeyPressed;
 end;

begin
 Title;
 GameInit;
  repeat
   LevelInit;
    repeat
     Enemy := random(TotEnemy)+1;
     tx := EnemyX[Enemy];
     ty := EnemyY[Enemy];
     ox := tx;
     oy := ty;
     Move := random(4+2)+1;
     if Move > 4 then
      Move := GoodMove(Enemy);
      case Move of
       1 : tx := tx + 1;
       2 : tx := tx - 1;
       3 : ty := ty + 1;
       4 : ty := ty - 1;
      end; {case}
     if tx > 80 then tx := 80;
     if tx < 1 then tx := 1;
     if ty > 24 then ty := 24;
     if ty < 1 then ty := 1;
     if (Obj[tx,ty] or Coin[tx,ty]) then
      begin
       tx := ox;
       ty := oy;
      end;
     gotoxy(ox,oy);
     write(' ');
     gotoxy(tx,ty);
     write('X');
     Cursor;
     if (tx = x) and (ty = y) then Dead := true;
     EnemyX[Enemy] := tx;
     EnemyY[Enemy] := ty;
     EndDelay(25);
     if KeyPressed and not Dead then
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
        end; {case}
       if x > 80 then x := 80;
       if x < 1 then x := 1;
       if y > 24 then y := 24;
       if y < 1 then y := 1;
       if Obj[x,y] then
        begin
         x := ox;
         y := oy;
        end;
       if Coin[x,y] then
        begin
         Coin[x,y] := false;
         TotCoin := TotCoin - 1;
         UpDate;
        end;
       gotoxy(ox,oy);
       write(' ');
       gotoxy(x,y);
       write('O');
       Cursor;
      end;






    until Dead or Quit or (TotCoin <= 0);
   Level := Level + 1;
  until Dead or Quit or (Level > 10);
 clrscr;
end.


