program Coder;

uses
 Crt;

var
 File1 : text;
 File2 : text;
 Key : char;
 j, k : integer;

begin
 assign(File1, paramstr(1));
 assign(File2, paramstr(2));
 reset(File1);
 rewrite(File2);
  repeat
    repeat
     read(File1, key);
     write(File2, chr(ord(Key) + 128));
    until Eoln(File1);
   readln(File1);
   writeln(File2);
  until Eof(File1);
 close(File1);
 close(File2);
end.
