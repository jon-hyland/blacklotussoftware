program MoveObj;

uses
 Crt, Std;

const
 TotRocks = 100;

type
 ObjType = array[1..80, 1..24] of boolean;

var
 x, y   : integer;
 ox, oy : integer;
 i, j, k : integer;
 key    : char;
 Obj    : ObjType;

begin
 randomize;
 Clear;
 for k := 1 to 24 do
  for j := 1 to 80 do
   Obj[j,k] := false;
 for i := 1 to TotRocks do
  begin
    repeat
     j := random(80)+1;
     k := random(24)+1;
    until not Obj[j,k];
   Obj[j,k] := true;
   gotoxy(j,k);
   write(#250);
   Cursor;
  end;
  repeat
   x := random(80)+1;
   y := random(24)+1;
  until not Obj[x,y];
 gotoxy(x,y);
 write('X');
 Cursor;
  repeat
   key := readkey;
   ox := x;
   oy := y;
    case key of
     #0 :
      begin
       key := readkey;
        case key of
         'H' : y := y - 1;
         'K' : x := x - 1;
         'P' : y := y + 1;
         'M' : x := x + 1;
        end; {case}
      end;
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
   gotoxy(ox,oy);
   write(' ');
   gotoxy(x,y);
   write('X');
   Cursor;
  until key = #27;
end.







