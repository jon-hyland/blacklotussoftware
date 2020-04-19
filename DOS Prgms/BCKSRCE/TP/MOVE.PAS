program MoveChar;

uses
 Crt;

var
 x, y : integer;
 ox, oy : integer;
 Key : char;
 Wrap : boolean;

begin
 randomize;
 textcolor(white);
 writeln;
 write('Wrap around screen (Y/N): ');
 readln(Key);
 if (Key = 'y') or (Key = 'Y') then Wrap := true else Wrap := false;
 clrscr;
 x := random(80)+1;
 y := random(24)+1;
 textcolor(black);
 gotoxy(1,1);
 write(chr(219));
 textcolor(white);
 gotoxy(x, y);
 write('X');
 gotoxy(1,1);
  repeat
   Key := readkey;
    case Key of
     #0 :
      begin
       ox := x;
       oy := y;
       Key := readkey;
        case Key of
         #72 : y := y - 1;
         #77 : x := x + 1;
         #80 : y := y + 1;
         #75 : x := x - 1;
         #71 : x := 1;
         #79 : x := 80;
        end; {case}
      end;
    end; {case}
   if Wrap then
    begin
     if x > 80 then x := 1;
     if x < 1 then x := 80;
     if y > 24 then y := 1;
     if y < 1 then y := 24;
    end
   else
    begin
     if x > 80 then x := 80;
     if x < 1 then x := 1;
     if y > 24 then y := 24;
     if y < 1 then y := 1;
    end;
   gotoxy(ox, oy);
   write(' ');
   gotoxy(x, y);
   write('X');
   gotoxy(1,1);
  until ord(Key) = 27;
end.