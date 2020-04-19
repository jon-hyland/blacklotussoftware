program Static;

uses
 Crt;

var
 x, y : integer;

begin
 randomize;
 textcolor(white);
 textbackground(black);
 clrscr;
  repeat
   x := random(80)+1;
   y := random(24)+1;
   gotoxy(x,y);
   write(chr(random(3)+176));
  until KeyPressed;
 clrscr;
end.