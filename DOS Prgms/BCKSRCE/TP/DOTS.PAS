program Dots;

uses
 Crt;

type
 array1 = array[1..78, 1..23] of integer;

var
 Screen : array1;
 x, y, rx, ry, j, k : integer;

procedure Init;
 begin
  randomize;
  textcolor(white);
  textbackground(black);
  clrscr;
  for j := 1 to 78 do
   begin
    for k := 1 to 23 do
     begin
      Screen[j, k] := 0;
     end;
   end;
 end;

begin
 Init;
  repeat
   rx := random(78)+1;
   ry := random(23)+1;
   textcolor(random(15)+1);
   if Screen[rx, ry] = 0 then
    begin
     gotoxy(rx+1, ry+1);
     write(chr(219));
    end else
    begin
     gotoxy(rx+1, ry+1);
     write(' ');
    end;
   if Screen[rx, ry] = 0 then Screen[rx, ry] := 1 else Screen[rx, ry] := 0;
  until KeyPressed;
end.

