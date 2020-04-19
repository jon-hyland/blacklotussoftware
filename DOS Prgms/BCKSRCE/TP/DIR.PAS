uses
 Crt, Dos;

var
 FileInfo : SearchRec;
 TotFile : integer;

begin
 clrscr;

 TotFile := 0;
 findfirst('*.PIC', AnyFile, FileInfo);
 if DosError = 0 then
  TotFile := TotFile + 1;
  repeat
   findnext(FileInfo);
   if DosError = 0 then
    TotFile := TotFile + 1;
  until DosError <> 0;

 write(TotFile);
 readkey;
end.

