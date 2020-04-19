program CooldrawPic_2_SourceCode;

uses
 Crt;

type
 PicType = record
   Char : array[1..80, 1..24] of char;
   Color : array[1..80, 1..24] of integer;
  end;

var
 Pic : PicType;
 PicFile : file of PicType;
 SourceFile : text;
 j, k : integer;
 File1, File2 : string;
 FileLoc : integer;

begin
 writeln('- CoolDraw To SourceCode -  v1.0  (c) 1996 Jon Hyland');
 if (paramstr(1) = '/h') or (paramstr(2) = '/H') then
  begin
   writeln(' usage : CD2SC <FILENAME.PIC> <SOURCE.PAS>');
   halt;
  end;
 if (paramstr(1) = '') or (paramstr(2) = '') then
  begin
   write('Pic Filename : ');
   readln(File1);
   write('Source Filename : ');
   readln(File2);
  end
 else
  begin
   File1 := paramstr(1);
   File2 := paramstr(2);
  end;
 assign(PicFile, File1);
 assign(SourceFile, File2);
 reset(PicFile);
 read(PicFile, Pic);
 close(PicFile);
 rewrite(SourceFile);
 writeln(SourceFile, '{Source code conversion of ', File2, '.}');
 writeln(SourceFile, 'const');
 writeln(SourceFile, ' PicChar : array[1..80, 1..24] of char =');
 write  (SourceFile, ' (');
 for j := 1 to 80 do
  begin
   write(SourceFile, '(');
   FileLoc := 4;
   for k := 1 to 24 do
    begin
     if FileLoc > 67 then
      begin
       writeln(SourceFile);
       write(SourceFile, '   ');
       FileLoc := 3;
      end;
     write(SourceFile, '#', ord(Pic.Char[j,k]));
     if k <> 24 then
      write(SourceFile, ',');
     if ord(Pic.Char[j,k]) > 99 then
      FileLoc := FileLoc + 5
     else
      FileLoc := FileLoc + 4;
    end;
   if j <> 80 then
    begin
     write(SourceFile, '),');
     writeln(SourceFile);
     write(SourceFile, '  ');
    end;
  end;
 writeln(SourceFile, '));');
 writeln(SourceFile, ' PicColor : array[1..80, 1..24] of integer =');
 write  (SourceFile, ' (');
 for j := 1 to 80 do
  begin
   write(SourceFile, '(');
   FileLoc := 4;
   for k := 1 to 24 do
    begin
     if FileLoc > 67 then
      begin
       writeln(SourceFile);
       write(SourceFile, '   ');
       FileLoc := 3;
      end;
     write(SourceFile, Pic.Color[j,k]);
     if k <> 24 then
      write(SourceFile, ',');
     if Pic.Color[j,k] > 99 then
      FileLoc := FileLoc + 4
     else
      FileLoc := FileLoc + 3;
    end;
   if j <> 80 then
    begin
     write(SourceFile, '),');
     writeln(SourceFile);
     write(SourceFile, '  ');
    end;
  end;
 write(SourceFile, '));');
 close(SourceFile);
end.




