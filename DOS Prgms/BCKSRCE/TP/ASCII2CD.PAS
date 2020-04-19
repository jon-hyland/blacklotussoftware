program ASCII2CoolDraw1_0;

uses
 Crt;

type
 PicType = record
   Char  : array[1..80, 1..24] of char;
   Color : array[1..80, 1..24] of integer;
  end;

var
 Pic       : PicType;
 PicFile   : file of PicType;
 ASCIIFile : text;
 j, k      : integer;
 File1,
 File2     : string[12];
 Cha       : char;

begin
 textcolor(white);
 textbackground(black);
 writeln('ASCII 2 Cooldraw  v1.0 (c) 1996 by Jon Hyland');
 if (paramstr(1) = '') or (paramstr(2) = '') then
  begin
   writeln(' usage : ASCII2CD <ASCII.ASC> <COOLDRAW.PIC>');
   write('ASCII filename : ');
   readln(File1);
   write('Cooldraw filename : ');
   readln(File2);
  end
 else
  begin
   File1 := paramstr(1);
   File2 := paramstr(2);
  end;
 assign(ASCIIFile, File1);
 assign(PicFile, File2);
 reset(ASCIIFile);
 for k := 1 to 24 do
  for j := 1 to 80 do
   begin
    Pic.Color[j,k] := 116;
    Pic.Char[j,k] := ' ';
   end;
 for k := 1 to 24 do
  begin
   for j := 1 to 80 do
    begin
     read(ASCIIFile, Cha);
     if (Cha <> #13) and (Cha <> #10) then
      Pic.Char[j,k] := Cha
     else
      j := 80;
    end;
   readln(ASCIIFile);
  end;
 close(ASCIIFile);
 clrscr;
 for k := 1 to 24 do
  for j := 1 to 80 do
   begin
    gotoxy(j,k);
    write(Pic.Char[j,k]);
   end;
 readkey;
 rewrite(PicFile);
 write(PicFile, Pic);
 close(PicFile);
end.