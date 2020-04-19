program PictureListReset;

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
 NFile : file of integer;
 Pic   : PicRec;
 Num   : integer;
 Tot   : integer;

procedure CreateList;
 var
  DirDat : SearchRec;
  Jnk    : PicRec;
  j      : integer;
 begin
  assign(PFile, 'PICLST.DAT');
  assign(NFile, 'PICNUM.DAT');
  rewrite(PFile);
  Tot := 0;
  findfirst('C:\PIC\*.JPG', Archive, DirDat);
  while DosError = 0 do
   begin
    Jnk.FileName := '';
    for j := 1 to 12 do
     if DirDat.Name[j] <> ' ' then
      Jnk.FileName := Jnk.FileName + DirDat.Name[j];
    Jnk.Size := DirDat.Size;
    write(PFile, Jnk);
    Tot := Tot + 1;
    findnext(DirDat);
   end;
  close(PFile);
 end;

procedure ResetCycle;
 begin
  Num := 1;
  rewrite(NFile);
  write(NFile, Num);
  write(NFile, Tot);
  close(NFile);
 end;

begin
 CreateList;
 ResetCycle;
end.