program MoveGuy;

uses
 Crt;

var
 x, y : integer;
 j, k : integer;
 ox,oy : integer;
 m : integer;

begin
 clrscr;
 textcolor(black);
 gotoxy(1,25);
 write(chr(219));
 textcolor(white);
 randomize;
 x := random(80)+1;
 y := random(24)+1;
 gotoxy(x,y);
 write('A');
  repeat
   ox := x;
   oy := y;
   m := random(4)+1;
   if m = 1 then y := y-1;
   if m = 2 then y := y+1;
   if m = 3 then x := x-1;
   if m = 4 then x := x+1;
   if y > 24 then y := 1;
   if y < 1 then y := 24;
   if x > 80 then x := 1;
   if x < 1 then x := 80;
   gotoxy(ox,oy);
   write(' ');
   gotoxy(x,y);
   write('A');
   gotoxy(1,25);
   delay(100);
  until Keypressed;
end.