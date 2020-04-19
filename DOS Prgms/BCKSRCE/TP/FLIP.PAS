program Test;

uses
 Crt;

type
 FlipType = array[1..2, 1..23] of char;

var
 Flip : FlipType;
 VertFile : text;
 FlipFile : file of FlipType;
 j, k : integer;

begin
 assign(VertFile, 'VERT.DAT');
 assign(FlipFile, 'FLIP.DAT');
 reset(VertFile);
 for k := 1 to 23 do
  begin
   for j := 1 to 2 do
    read(VertFile, Flip[j,k]);
   readln(VertFile);
  end;
 rewrite(FlipFile);
 write(FlipFile, Flip);
 close(FlipFile);
 reset(FlipFile);
 read(FlipFile, Flip);
 clrscr;
 for k := 1 to 23 do
  for j := 1 to 2 do
   begin
    gotoxy(j,k);
    write(Flip[j,k]);
   end;
 readkey;
end.