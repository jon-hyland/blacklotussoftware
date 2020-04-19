program Rocks;

uses
 Crt;

type
 ScreenType = array[1..80, 1..24] of boolean;

var
 Obj : ScreenType;
 x, y : integer;
 ox, oy : integer;
 j, k : integer;
 Move : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  clrscr;
  randomize;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);

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
    write(chr(219));
   end;

   repeat
    x := random(80)+1;
    y := random(24)+1;
   until not Obj[x,y];
  gotoxy(x,y);
  write('X');
  Cursor;
 end;

begin
 Init;
  repeat
   ox := x;
   oy := y;
   Move := random(4)+1;
    case Move of
     1 : x := x - 1;
     2 : x := x + 1;
     3 : y := y - 1;
     4 : y := y + 1;
    end; {case}
   if x > 80 then x := 1;
   if x < 1 then x := 80;
   if y > 24 then y := 1;
   if y < 1 then y := 24;
   if Obj[x,y] then
    begin
     x := ox;
     y := oy;
    end;
   gotoxy(ox, oy);
   write(' ');
   gotoxy(x,y);
   write('X');
   Cursor;
   delay(100);
  until KeyPressed;
 clrscr;
end.


