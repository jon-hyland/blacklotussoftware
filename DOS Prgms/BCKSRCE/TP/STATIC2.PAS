program Count;

uses
 Crt, Std;

type
 ScreenType = array[1..80, 1..24] of integer;

var
 Num  : ScreenType;
 j, k : integer;

begin
 for k := 1 to 24 do
  for j := 1 to 80 do
   begin
    gotoxy(j,k);
    Num[j,k] := 1;
    write(chr(176+Num[j,k]));
   end;
  repeat
   j := random(80)+1;
   k := random(24)+1;
   Num[j,k] := Num[j,k] + 1;
   if Num[j,k] > 2 then Num[j,k] := 0;
   gotoxy(j,k);
   write(chr(176+Num[j,k]));
   Cursor;

  until KeyPressed;
 Clear;
end.