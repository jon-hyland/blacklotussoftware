program Grades;

uses
 Crt, Dos;

procedure Init;
 begin
  randomize;
  textbackground(black);
  textcolor(white);
 end;

procedure BeginProg;
 var
  x, y, j : integer;
 begin
  clrscr;
  x := 18;
  y := 4;
  for j := 1 to 4 do
   begin
    gotoxy(x,y);
    write(chr(214), chr(196), chr(196), chr(196), chr(196), chr(183), ' ');
    x := x + 7;
   end;
  x := x + 1;
  for j := 1 to 2 do
   begin
    gotoxy(x,y);
    write(chr(214), chr(196), chr(196), chr(196), chr(196), chr(196), ' ');
    x := x + 8;
   end;
  y := y + 1;
  x := 18;
  gotoxy(18,5);
  write(chr(186));
  gotoxy(25,5);
  write(chr(186));
  gotoxy(30,5);
  write(chr(186));
  gotoxy(32,5);
  write(chr(186));
  gotoxy(37,5);
  write(chr(186));
  gotoxy(39,5);
  write(chr(186));
  gotoxy(44,5);
  write(chr(211), chr(183));
  gotoxy(47,5);
  write(chr(186));
  gotoxy(55,5);
  write(chr(186));









 end;

begin
 Init;
 BeginProg;
 readkey;
end.