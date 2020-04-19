program Make_ASCII_Set;

uses
 Crt;

type
 Set_Type = array[1..10] of char;
 Char_Type = array[1..10, 1..15] of char;

var
 CSet : Set_Type;
 s : string[10];
 SetFile : file of Set_Type;
 Char : Char_Type;
 CharFile : text;
 x, y : integer;

begin
 clrscr;
 assign(CharFile, 'C:\ASCII.TXT');
 assign(SetFile, 'MAKEOBJ.DAT');
 reset(CharFile);
 rewrite(SetFile);
 for y := 1 to 15 do
  begin
   for x := 1 to 10 do
    read(CharFile, Char[x,y]);
   readln(CharFile);
  end;
 close(CharFile);
 for y := 1 to 15 do
  begin
   for x := 1 to 10 do
    CSet[x] := Char[x,y];
   write(SetFile, CSet);
   writeln(CSet);
  end;
  repeat
   readln(s);
   for x := 1 to 10 do
    CSet[x] := s[x];
   write(SetFile, CSet);
  until s = '';
 close(SetFile);
end.