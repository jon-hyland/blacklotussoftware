program ConvertPicture;

uses
 Crt;

type
 PicType1 = array[1..2000] of char;
 PicType2 = record
   Char  : array[1..80, 1..24] of char;
   Color : array[1..80, 1..24] of integer;
  end;

var
 Pic     : PicType2;
 TD      : PicType1;
 PicFile : file of PicType2;
 TDFile  : file of PicType1;
 x, j, k : integer;
 Key     : char;


{$I c:\cd.pas}
begin
 assign(PicFile, 'c:\td1.pic');
 rewrite(Picfile);
 for k := 1 to 24 do
  for j := 1 to 80 do
   begin
    Pic.Color[j,k] := 116;
    Pic.Char[j,k] := CD[(k)*80 + j] ;
   end;
 clrscr;
 for k := 1 to 24 do
  for j := 1 to 80 do
   begin
    gotoxy(j,k);
    write(Pic.Char[j,k]);
   end;
 readkey;
 write(PicFile, Pic);
 close(PicFile);
end.
