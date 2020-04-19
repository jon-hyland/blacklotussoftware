program MakeTetrisDat;

uses
 Crt;

type
 BlockType = record
   Solid : array[1..4, 1..2] of boolean;
   Color : integer;
   StartX : integer;
  end;

var
 Block : BlockType;
 DatFile : file of BlockType;
 Color : integer;
 X : integer;
 i, j, k : integer;
 y : integer;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 assign(DatFile, 'TETRIS.DAT');
 rewrite(DatFile);
 for i := 1 to 7 do
  begin
   writeln('Block #', i, ':');
   write('Color : ');
   read(Color);
   write('StartX : ');
   read(X);
   for k := 1 to 2 do
    for j := 1 to 4 do
     begin
      write(j, 'x', k, ' : ');
      read(y);
      Block.Solid[j,k] := y = 1;
     end;
   Block.Color := Color;
   Block.StartX := X;
   write(DatFile, Block);
  end;
 close(DatFile);
end.
