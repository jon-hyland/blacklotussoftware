{$M $4000,0,0 }   { 16K stack, no heap }

uses
 Crt, Std, Dos;

type
 PicRec = record
   FileName : string[12];
   Score    : integer;
   Size     : longint;
  end;

var
 PFile : file of PicRec;
 Pic   : PicRec;
 Num   : integer;
 Tot   : integer;

procedure Init;
 begin
  randomize;
  assign(PFile, 'PICLST.DAT');
 end;

procedure CreateList;
 var
  DirDat : SearchRec;
  Jnk    : PicRec;
  j      : integer;
 begin
  rewrite(PFile);
  Tot := 0;
  findfirst('C:\PIC\WIN\*.BMP', Archive, DirDat);
  while DosError = 0 do
   begin
    Jnk.FileName := '';
    {for j := 1 to 12 do
     if DirDat.Name[j] <> ' ' then
      Jnk.FileName := Jnk.FileName + DirDat.Name[j];}
    Jnk.FileName := DirDat.Name;
    Jnk.Size := DirDat.Size;
    write(PFile, Jnk);
    Tot := Tot + 1;
    findnext(DirDat);
   end;
  close(PFile);
 end;

procedure RandomPic;
 var
  x : integer;
 begin
  reset(PFile);
  Num := random(Tot)+1;
  for x := 1 to Num do
   if not Eof(PFile) then
    read(PFile, Pic);
  close(PFile);
 end;

procedure CopyPic;
 var
  Line : string;
 begin
  SwapVectors;
  Line := Pic.FileName + ' C:\WINDOWS\WallPapr.BMP';
  Exec('C:\WINDOWS\XCOPY.EXE', Line);
  SwapVectors;
 end;

begin
 Init;
 CreateList;
 RandomPic;
 CopyPic;
end.





