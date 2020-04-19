program Random;

uses
 Crt;

type
 array1 = array[1..80,1..50] of integer;

var
 Screen : array1;
 x, y, j, k : integer;
 CT, CB : integer;

procedure Init;
 begin
  randomize;
  textcolor(white);
  textbackground(black);
  clrscr;
  for j := 1 to 50 do
   begin
    for k := 1 to 80 do
     begin
      Screen[j, k] := 0;
     end;
   end;
 end;

begin
 Init;
  repeat
   y := random[50]+1;
   x := random[80]+1;
   if Screen[x, y] = 0 then Screen[x, y] := 1 else Screen[x, y] := 0;
   if (y/2) <> int(y/2) then
    begin
     CT := Screen[x, y];
     CB := Screen[x, y+1];
    end else
    begin
     CT := Screen[x, y-1];
     CB := Screen[x, y];
    end;
   gotoxy(x, y);
   if ((CT = 0) and (CB = 0)) then write(' ');
   if ((CT = 1) and (CB = 1)) then write(chr(219));
   if ((CT = 1) and (CB = 0)) then write(chr());
   if ((CT = 0) and (CB = 1)) then write(chr());
