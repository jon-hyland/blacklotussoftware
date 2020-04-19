program RandWindow;

uses
 Crt;

var
 x1, y1,
 x2, y2 : integer;
 Color  : integer;
 Kind   : integer;

{Clear v1.0
(c) 1995 Black Lotus Software
Procedure clears screen and draws an invisable black box at bottom/left
screen corner. To be used with Cursor procedure. }
procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  textcolor(white);
  gotoxy(1,1);
 end;

{Cursor v1.0
(c) 1996 Black Lotus Software
Procedure makes cursor "invisable" by moving it to bottom/left corner.
 + Screen must have been cleared with Clear. }
procedure Cursor;
 begin
  gotoxy(1,25);
 end;

{DrawWindow 1.0
(c) 1996 Black Lotus Software
Procedure draws text window and centers the title on top line.
 + x1, y1, x2, y2 are the four corners for text window.
 + BackColor indicates background box color.
 + Name is the string centered on top of text window. }
procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 const
  DelayTime = 20;
 procedure Box(x1, y1, x2, y2 : integer);
  var
   x : integer;
   y : integer;
  begin
   for y := y1 to y2 do
    begin
     gotoxy(x1, y);
     for x := x1 to x2 do
      write(#219);
    end;
   Cursor;
  end;
 var
  j, k   : integer;
  ya, yb : integer;
  xa, xb : real;
  Times  : integer;
  XInc   : real;
 begin
  textcolor(BackColor);
  Times := (y2-y1+1) - trunc((y2-y1+1)/2);
  XInc := ((x2-x1+1)/2) / Times;
  ya := trunc((y2-y1+1)/2+y1);
  yb := ya;
  xa := trunc((x2-x1+1)/2+x1-XInc);
  xb := trunc((x2-x1+1)/2+x1+XInc);
  for j := 1 to Times - 1 do
   begin
    Box(trunc(xa), ya, trunc(xb), yb);
    delay(DelayTime);
    xa := xa - XInc;
    xb := xb + XInc;
    ya := ya - 1;
    yb := yb + 1;
   end;
  textcolor(white);
  textbackground(BackColor);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(darkgray);
  textbackground(black);
  for k := y1+1 to y2 do
   begin
    gotoxy(x2+1,k);
    write(#176, #176);
   end;
  for j := x1+2 to x2+2 do
   begin
    gotoxy(j, y2+1);
    write(#176);
   end;
  textcolor(white);
  textbackground(BackColor);
  gotoxy(x1,y1);
  write(#218);
  gotoxy(x1,y2);
  write(#192);
  for j := x1+1 to x2-1 do
   begin
    gotoxy(j, y1);
    write(#196);
    gotoxy(j,y2);
    write(#196);
   end;
  gotoxy(trunc(x1+((x2-x1+1)-length(Name))/2)-2, y1);
  write(#180, ' ', Name, ' ', #195);
  gotoxy(x2,y1);
  write(#191);
  gotoxy(x2,y2);
  write(#217);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1, k);
    write(#179);
    gotoxy(x2, k);
    write(#179);
   end;
  Cursor;
 end;

{FadeOut v2.4
(c) 1996 Black Lotus Software
Procedure clears screen from edges to center.
Usually used at program termination. }
procedure FadeOut;
 const
  XInc = (80 / 24);
 var
  i, j, k : integer;
  xa, xb  : real;
  ya, yb  : integer;
 begin
  ya := 1;
  yb := 24;
  xa := 1;
  xb := 80;
  textcolor(black);
  gotoxy(2,25);
  for j := 1 to 78 do
   write(#219);
  for i := 1 to 12 do
   begin
    for j := 1 to 80 do
     begin
      gotoxy(j,ya);
      write(#219);
      Cursor;
      gotoxy(j,yb);
      write(#219);
      Cursor;
     end;
    ya := ya + 1;
    yb := yb - 1;
    for k := ya to yb do
     begin
      for j := trunc(xa) to trunc(xa + XInc) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
      for j := trunc(xb - XInc) to trunc(xb) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
     end;
    xa := xa + XInc;
    xb := xb - XInc;
    delay(15);
   end;
  textcolor(white);
  textbackground(black);
  clrscr;
 end;

procedure FillArea;
 var
  j, k   : integer;
  Cha    : array[1..80, 1..25] of char;
  Colors : array[1..80, 1..25] of integer;
 begin
  for k := y1+1 to y2-1 do
   for j := x1+1 to x2-1 do
    begin
     Cha[j,k] := chr(random(3)+176);
     Colors[j,k] := random(16);
    end;
  Kind := random(5);
  for k := y1+1 to y2-1 do
   for j := x1+1 to x2-1 do
    begin
     gotoxy(j,k);
     if Kind = 0 then
      textcolor(Colors[j,k])
     else
      textcolor(Color+8);
     write(Cha[j,k]);
    end;
  Cursor;
 end;

begin
 Clear;
  repeat
    repeat
     x1 := random(79)+1;
     x2 := random(80)+1;
    until x2 > (x1+3);
    repeat
     y1 := random(21)+1;
     y2 := random(22)+1;
    until y2 > (y1+3);
   Color := random(8);
   DrawWindow(x1, y1, x2, y2, Color, '');
   FillArea;
  until KeyPressed;
 FadeOut;
end.
