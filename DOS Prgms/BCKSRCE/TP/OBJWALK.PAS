program Move;

uses
 Crt;

type
 ScreenType = array[1..80, 1..24] of boolean;

var
 Obj : ScreenType;
 x, y : integer;
 ox, oy : integer;
 rx, ry : integer;
 j, k : integer;
 Key : char;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

begin
 randomize;
 textcolor(white);
 clrscr;
 textcolor(black);
 gotoxy(1,25);
 write(chr(219));
 textcolor(white);
 x := random(80)+1;
 y := 24;
 gotoxy(x,y);
 write('X');
 for k := 1 to 24 do
  for j := 1 to 80 do
   Obj[j,k] := false;
 Obj[x,y] := true;
 for j := 1 to 100 do
  begin
    repeat
     rx := random(80)+1;
     ry := random(24)+1;
    until not Obj[rx,ry];
   gotoxy(rx,ry);
   write(chr(219));
   Obj[rx,ry] := true;
  end;
 Cursor;
 Obj[x,y] := false;
  repeat
   ox := x;
   oy := y;
   if KeyPressed then Key := readkey;
   if Key = #0 then
    Key := readkey;
    case Key of
     'H' : y := y - 1;
     'K' : x := x - 1;
     'P' : y := y + 1;
     'M' : x := x + 1;
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
   gotoxy(ox, oy);
   write(' ');
   gotoxy(x, y);
   write('X');
   Cursor;
   if (Key = 'H') or (Key = 'P') then
    delay(25);
   delay(25);
  until (y <= 1) or (ord(Key) = 27);
end.

