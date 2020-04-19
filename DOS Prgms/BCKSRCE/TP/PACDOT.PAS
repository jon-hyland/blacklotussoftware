program DotMan;

uses
 Crt, Std, Dos;

type
 AreaType = array[1..15,1..15] of boolean;

procedure DrawFood(x : integer; y : integer);
 begin
  x := (x * 2) + 24;
  y := y + 4;
  textcolor(lightgreen);
  textbackground(black);
  gotoxy(x, y);
  write('<>');
 end;

procedure DrawMaze;
 var
  j : integer;
 begin
  clrscr;
  textcolor(darkgray);
  for j := 24 to 57 do
   begin
    gotoxy(j, 4);
    write(chr(219));
    gotoxy(j, 20);
    write(chr(219));
   end;
  for j := 5 to 19 do
   begin
    gotoxy(24, j);
    write(chr(219), chr(219));
    gotoxy(56, j);
    write(chr(219), chr(219));
   end;
  for j := 28 to 37 do
   begin
    gotoxy(j, 6);
    write(chr(219));
    gotoxy(j+16, 6);
    write(chr(219));
    gotoxy(j, 18);
    write(chr(219));
    gotoxy(j+16, 18);
    write(chr(219));
   end;
  for j := 7 to 10 do
   begin
    gotoxy(28, j);
    write(chr(219), chr(219));
    gotoxy(52, j);
    write(chr(219), chr(219));
    gotoxy(28, j+7);
    write(chr(219), chr(219));
    gotoxy(52, j+7);
    write(chr(219), chr(219));
   end;
  for j := 26 to 55 do
   begin
    if ((j > 31) and (j < 50)) then
     begin
      gotoxy(j, 8);
      write(chr(219));
      gotoxy(j, 16);
      write(chr(219));
     end else
     begin
      gotoxy(j, 12);
      write(chr(219));
     end;
   end;
  for j := 5 to 7 do
   begin
    gotoxy(40, j);
    write(chr(219), chr(219));
    gotoxy(40, j+12);
    write(chr(219), chr(219));
   end;
  for j := 36 to 45 do
   begin
    gotoxy(j, 10);
    write(chr(219));
    gotoxy(j, 14);
    write(chr(219));
   end;
  for j := 11 to 13 do
   begin
    gotoxy(36, j);
    write(chr(219), chr(219), '      ', chr(219), chr(219));
   end;
  for j := 10 to 14 do
   begin
    gotoxy(32, j);
    write(chr(219), chr(219));
    gotoxy(48, j);
    write(chr(219), chr(219));
   end;
  for j := 2 to 7 do DrawFood(j, 1);
  for j := 9 to 14 do DrawFood(j, 1);
  for j := 3 to 7 do DrawFood(j, 3);
  for j := 9 to 13 do DrawFood(j, 3);
  for j := 3 to 13 do DrawFood(j, 5);
  for j := 1 to 3 do DrawFood(j, 7);
  for j := 13 to 15 do DrawFood(j, 7);
  for j := 1 to 3 do DrawFood(j, 9);
  for j := 13 to 15 do DrawFood(j, 9);
  for j := 3 to 13 do DrawFood(j, 11);
  for j := 3 to 7 do DrawFood(j, 13);
  for j := 9 to 13 do DrawFood(j, 13);
  for j := 2 to 7 do DrawFood(j, 15);
  for j := 9 to 14 do DrawFood(j, 15);
  for j := 2 to 6 do
   begin
    DrawFood(1, j);
    DrawFood(15, j);
   end;
  for j := 6 to 10 do
   begin
    DrawFood(5, j);
    DrawFood(11, j);
   end;
  for j := 10 to 14 do
   begin
    DrawFood(1, j);
    DrawFood(15, j);
   end;
  DrawFood(7, 2);
  DrawFood(9, 2);
  DrawFood(3, 4);
  DrawFood(13, 4);
  DrawFood(3, 6);
  DrawFood(13, 6);
  DrawFood(3, 10);
  DrawFood(13, 10);
  DrawFood(3, 12);
  DrawFood(13, 12);
  DrawFood(7, 14);
  DrawFood(9, 14);
  textcolor(white);
  gotoxy(26, 5);
  write(chr(222), chr(221));
  gotoxy(54, 5);
  write(chr(222), chr(221));
  gotoxy(26, 19);
  write(chr(222), chr(221));
  gotoxy(54, 19);
  write(chr(222), chr(221));
 end;

begin
 DrawMaze;

 readkey; {}
end.
