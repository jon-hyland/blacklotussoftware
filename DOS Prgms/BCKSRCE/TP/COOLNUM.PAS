program CoolNumbers;

uses
 Crt;

begin
 randomize;
 textcolor(white);
 textbackground(black);
 clrscr;
  repeat
   textcolor(random(16));
   textbackground(random(8));
   write(random(10));
  until KeyPressed;
end.
