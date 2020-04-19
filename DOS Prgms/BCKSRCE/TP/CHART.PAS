program ASCIIChart;

uses
 Crt;

var
 j, k, n : integer;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 gotoxy(33,1);
 for j := 1 to 10 do
  for k := 1 to 25 do
   begin
    n := (k + ((j-1)*25)) + 10;
    gotoxy((j-1)*8+1, k);
    if n <= 254 then
     write(n:3, ': ', chr(n));
   end;
 readkey;
end.