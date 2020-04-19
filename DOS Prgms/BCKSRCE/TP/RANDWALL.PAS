program RandomWallpaper;

uses
 Crt, Std, Dos;

const
 VerNum  = '1.0';

var
 TFile : text;
 Tot   : integer;
 Num   : integer;

procedure MakeFileList;
 var
  FileInfo : SearchRec;
 begin
  assign(TFile, 'RANDWALL.DAT');
  rewrite(TFile);
  Tot := 0;
  findfirst('C:\WINDOWS\WALLPAPR\*.BMP', Archive, FileInfo);
  while DosError = 0 do
   begin
    writeln(TFile, FileInfo.Name);
    Tot := Tot + 1;
    findnext(FileInfo);
   end;
  close(TFile);
 end;

procedure CopyWallpaper;




begin
 MakeFileList;
 CopyWallpaper;

end.