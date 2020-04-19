program ShowReadKey;

uses
 Crt;

var
 Key : char;

begin
 clrscr;
 while ord(key) <> 27 do
  begin
   key := ReadKey;
   gotoxy(36,10);
   write('                 ');
   gotoxy(36,10);
   write('ord(', key, ') = ', ord(key));
  end;
end.

