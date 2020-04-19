program Keys;

uses
 Crt;

var
 key : char;

begin
 textbackground(black);
 textcolor(white);
 clrscr;
 gotoxy(34, 10);
 write('Key:');
 gotoxy(34,12);
 write('ord(Key):');
 while ord(key) <> 27 do
  begin
   key := readkey;
   gotoxy(39,10);
   write('     ');
   gotoxy(44,12);
   write('     ');
   gotoxy(39,10);
   write(key);
   gotoxy(44,12);
   write(ord(key));
   if Key = #0 then
    begin
     gotoxy(39,8);
     write('Extended char');
     Key := readkey;
     gotoxy(39,10);
     write('     ');
     gotoxy(44,12);
     write('     ');
     gotoxy(39,10);
     write(key);
     gotoxy(44,12);
     write(ord(key));
    end
   else
    begin
     gotoxy(39,8);
     write('             ');
    end;
  end;
end.
