program FillDisk;

uses
 Dos;

type
 Junk = array[1..80] of char;
 JunkFile = file of Junk;

var
 x : Junk;
 JFile : JunkFile;
 j, k : integer;
 Left : longint;

begin
 randomize;
 assign(JFile, 'B:\JUNK.TXT');
 rewrite(JFile);
 Left := 0;
  repeat
   write(Left:15, '    ');
   for j := 1 to 60 do
    begin
     x[j] := chr(random(26)+65);
     write(x[j]);
    end;
   writeln;
   write(JFile,x);
   Left := DiskFree(2);
  until Left < 100;
 close(JFile);
end.


