program CheapBlaster;

uses
 Crt;

type
 LocationArray = array[1..25] of integer;

var
 Enemy : integer;
 EnemyX : LocationArray;
 EnemyY : LocationArray;
 TotEnemy : integer;
 Ship : integer;
 Lives : integer;
 Level : integer;
 Dead, Quit : boolean;
 RandMove : integer;
 x, y, ox, oy : integer;
 DelayCount : integer;

procedure Init;
 var
  j : integer;
 begin
  for j := 1 to 25 do
   begin
    EnemyX[j] := 0;
    EnemyY[j] := 0;
   end;
  randomize;
  Level := 1;
  TotEnemy := 3;
  Lives := 3;
  Dead := false;
  Quit := false;
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

function ShipExist(x, y : integer) : boolean;
 var
  j : integer;
  s : boolean;
 begin
  s := false;
  for j := 1 to 25 do
   if ((EnemyX[j] = x) and (EnemyY[j] = y)) then
    s := true;
  ShipExist := s;
 end;

procedure LevelInit;
 var
  j, k : integer;
  rx, ry : integer;
 begin
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,24);
  for j := 1 to 80 do
   write('-');
  Cursor;
  TotEnemy := Level * 3;
  for j := 1 to TotEnemy do
   begin
     repeat
      rx := random(80)+1;
      ry := random(5)+1;
     until not ShipExist(rx,ry);
    EnemyX[j] := rx;
    EnemyY[j] := ry;
    gotoxy(rx, ry);
    write('X');
    Cursor;
   end;
  Ship := random(80)+1;
  gotoxy(Ship, 23);
  write('O');
  gotoxy(2,25);
  write('Level : ', Level);
  gotoxy(14,25);
  write('Lives : ', Lives);
  Cursor;
 end;


begin
 Init;
  repeat
   LevelInit;
    repeat
     Enemy := random(TotEnemy)+1;
     RandMove := random(6)+1;
     if EnemyX[Enemy] = Ship then
      if random(2) = 0 then
       RandMove := 5;     {Enemy fire}
     if random(50) = 0 then
      RandMove := 5;
     if RandMove in [1..4] then
      begin
       x := EnemyX[Enemy];
       y := EnemyY[Enemy];
       ox := x;
       oy := y;
        case RandMove of
         1 : x := x + 1;
         2 : x := x - 1;
         3 : y := y + 1;
         4 : y := y - 1;
        end; {case}
       if x > 80 then x := 80;
       if x < 1 then x := 1;
       if y > 5 then y := 5;
       if y < 1 then y := 1;
       if ShipExist(x,y) then
        begin
         x := ox;
         y := oy;
        end;
       EnemyX[Enemy] := x;
       EnemyY[Enemy] := y;
       gotoxy(ox,oy);
       write(' ');
       gotoxy(x,y);
       write('X');
       Cursor;
       DelayCount := 0;
        repeat
         delay(1);
         DelayCount := DelayCount + 1;
        until (DelayCount > 10) or KeyPressed;
      end;
     if RandMove = 5 then
      begin
       for y := EnemyY[Enemy] + 1 to 23 do
        begin
         gotoxy(EnemyX[Enemy], y);
         write('|');


      end;
    until KeyPressed or Dead or Quit;


   readkey;
  until Dead or Quit;
 clrscr;
end.









