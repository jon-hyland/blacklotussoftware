program Typing;

uses
 Crt;

type
 array1 = array[1..80] of char;

var
 Text : array1;
 x, xx : integer;
 Key : char;

procedure Input;
 begin
  x := 1;
   repeat
    Key := readkey;
    Text[x] := Key;
    write(Key);
    x := x + 1;
   until ((x > 80) or (ord(Key) = 13));
  writeln;
 end;

procedure TypeIt;
 begin
  xx := 1;
  delay(random(300)+500);
   repeat
    if random(8)+1 = 1 then
     begin
      write(chr(random(26)+98));
      delay(random(200)+251);
      gotoxy(xx, WhereY);
     end;
    write(Text[xx]);
    delay(random(200)+101);
    xx := xx + 1;
   until xx >= x;
  writeln;
 end;


begin
 textcolor(white);
 textbackground(black);
 clrscr;
 randomize;
  repeat
   Input;
   TypeIt;
  until 1 = 2;
end.


