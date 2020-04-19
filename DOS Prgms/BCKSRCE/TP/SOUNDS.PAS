program StringSounds;

uses
 Crt, Dos;

var
 Key : Char;
 x : integer;
 DatFile : text;
 FileName : string;
 Speed : integer;

begin
 nosound;
 writeln;
 textcolor(white);
 textbackground(black);
 write('Filename: ');
 readln(FileName);
 write('Speed: ');
 readln(Speed);
 assign(DatFile, FileName);
 reset(DatFile);
 textcolor(yellow);
  repeat
    repeat
     read(DatFile, Key);
     x := ord(Key);
     sound(x*3);
     delay(Speed);
     nosound;
     write(Key);
    until Eoln(DatFile);
   readln(DatFile);
   writeln;
  until Eof(DatFile);
 textcolor(white);
 write('Press Key to End..');
 readkey;
end.