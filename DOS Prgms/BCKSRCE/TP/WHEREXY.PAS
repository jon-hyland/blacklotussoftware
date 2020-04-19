program WhereXY;

uses
 Crt;

var
 x, y : integer;
 Key  : char;

begin
 x := 1;
 y := 1;
 textcolor(white);
 textbackground(black);
  repeat
   gotoxy(1,25);
   write('(', x, ',', y, ')  ');
   gotoxy(x,y);
   Key := readkey;
    case Key of
     'H' : y := y - 1;
     'K' : x := x - 1;
     'P' : y := y + 1;
     'M' : x := x + 1;
    end; {case}
   if x < 1 then x := 80;
   if x > 80 then x := 1;
   if y < 1 then y := 25;
   if y > 25 then y := 1;
  until Key = #27;
end.


