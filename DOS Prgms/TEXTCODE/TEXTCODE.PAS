program Coder;

uses
 Crt;

var
 File1 : text;
 File2 : text;
 Key : char;
 j, x, y : integer;

procedure Help;
 begin
  writeln('TextCoder v1.0 - Jon Hyland 7/17/95');
  writeln(' usage: textcode input.ext output.ext /h');
  writeln(' switches: /h = help');
  writeln;
  halt(3);
 end;

begin
 if ((paramstr(1) = '/h') or (paramstr(1) = '/H') or (paramstr(2) = 'h') or
  (paramstr(2) = '/H') or (paramstr(3) = '/h') or (paramstr(3) = '/H') or
  (paramstr(1) = '')) then Help;
 j := 1;
 assign(File1, paramstr(1));
 assign(File2, paramstr(2));
 reset(File1);
 rewrite(File2);
 write('Working: ');
 x := WhereX;
 y := WhereY;
  repeat
    repeat
     read(File1, Key);
     if ord(Key) <= 128 then write(File2, chr(ord(Key) + 128));
     if ord(Key) >  128 then write(File2, chr(ord(Key) - 128));
    until Eoln(File1);
   readln(File1);
   writeln(File2);
   if j = 1 then write('|');
   if j = 2 then write('/');
   if j = 3 then write('-');
   if j = 4 then write('\');
   if j = 5 then write('|');
   if j = 6 then write('/');
   if j = 7 then write('-');
   if j = 8 then write('\');
   gotoxy(x,y);
   j := j + 1;
   if j > 8 then j := 1;
  until Eof(File1);
 writeln;
 close(File1);
 close(File2);
end.