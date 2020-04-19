program BugZapper;

uses
 Crt;

type
 array1 = array[1..16] of integer;

var
 Xpos : array1;
 Ypos : array1;
 b, j, k : integer;
 ox, oy : integer;
 BugsDead : integer;

begin
 randomize;
 BugsDead := 0;
 for j := 1 to 16 do
  begin
   Xpos[j] := 0;
   Ypos[j] := 0;
  end;
 textbackground(black);
 textcolor(white);
 clrscr;
 textcolor(black);
 gotoxy(1,25);
 write(chr(219));
 textcolor(lightblue);
 gotoxy(1, 12);
 for j := 1 to 80 do write('-');
 textcolor(white);
 gotoxy(1,25);
 for j := 1 to 16 do
  begin
   Xpos[j] := random(80)+1;
   Ypos[j] := random(24)+1;
   gotoxy(Xpos[j], Ypos[j]);
   textcolor(j);
   write('X');
  end;
  repeat
   for j := 1 to 16 do
    begin
     if Ypos[j] = 12 then
      begin
       for k := 1 to 5 do
        begin
         sound(100);
         gotoxy(Xpos[j], 12);
         textcolor(yellow);
         write('X');
         delay(10);
         sound(200);
         gotoxy(Xpos[j], 12);
         textcolor(darkgray);
         write('X');
         delay(10);
        end;
       nosound;
       gotoxy(Xpos[j], 12);
       textcolor(lightblue);
       write('-');
       gotoxy(1,25);
       Xpos[j] := 0;
       Ypos[j] := 0;
       textcolor(white);
       BugsDead := BugsDead + 1;
      end;
    end;
    repeat
     b := random(16)+1;
    until (Xpos[b] <> 0) or (BugsDead >= 16);
   if BugsDead >= 16 then
    begin
     delay(250);
     for j := 1 to 16 do
      begin
       k := 12;
       while k = 12 do k := random(24)+1;
       Ypos[j] := k;
       Xpos[j] := random(80)+1;
       gotoxy(Xpos[j], Ypos[j]);
       textcolor(j);
       write('X');
       BugsDead := 0;
      end;
     gotoxy(1,25);
    end;
   j := random(4)+1;
   ox := Xpos[b];
   oy := Ypos[b];
    case j of
     1 : Xpos[b] := Xpos[b] + 1;
     2 : Xpos[b] := Xpos[b] - 1;
     3 : Ypos[b] := Ypos[b] + 1;
     4 : Ypos[b] := Ypos[b] - 1;
    end;
   if Xpos[b] > 80 then Xpos[b] := 60;
   if Xpos[b] < 1 then Xpos[b] := 1;
   if Ypos[b] > 24 then Ypos[b] := 24;
   if Ypos[b] < 1 then Ypos[b] := 1;
   gotoxy(ox,oy);
   write(' ');
   gotoxy(Xpos[b], Ypos[b]);
   textcolor(b);
   write('X');
   gotoxy(1,25);
   delay(10);
  until KeyPressed;
 clrscr;
end.


