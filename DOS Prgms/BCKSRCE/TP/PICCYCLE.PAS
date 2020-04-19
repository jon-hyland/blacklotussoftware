program PictureListCycle;

type
 PicRec = record
   FileName : string[12];
   Score    : integer;
   Size     : longint;
  end;

var
 PFile : file of PicRec;
 Pic   : PicRec;
 NFile : file of integer;
 BFile : text;
 Num   : integer;
 Tot   : integer;

procedure Init;
 begin
  assign(PFile, 'PICLST.DAT');
  assign(NFile, 'PICNUM.DAT');
  assign(BFile, 'PICRUN.BAT');
 end;

procedure ReadNumFile;
 begin
  reset(NFile);
  read(NFile, Num);
  read(NFile, Tot);
  close(NFile);
 end;

procedure ReadListFile;
 var
  x : integer;
 begin
  reset(PFile);
  for x := 1 to Num do
   read(PFile, Pic);
  close(PFile);
 end;

procedure CreateTempBatch;
 begin
  rewrite(BFile);
  write(BFile, 'C:\WINDOWS\PBRUSH.EXE ', Pic.FileName);
  close(BFile);
 end;

begin
 Init;
 ReadNumFile;
 ReadListFile;
 CreateTempBatch;
end.
