program ReadHS;

uses
 Crt;

type
 HighScoreRecord = record
  Name : string[20];
  Points : integer;
 end;
 HighScoreFile = file of HighScoreRecord;

var
 HSFile : HighScoreFile;
 HSRec : HighScoreRecord;
 j : integer;

begin
 clrscr;
 assign(HSFile, 'HSFILE.DAT');
 reset(HSFile);
 for j := 1 to 10 do
  begin
   writeln('Entry # ', j);
   read(HSFile, HSRec);
   writeln(' Name   : ', HSRec.Name);
   writeln(' Points : ', HSRec.Points);
   readkey;
   writeln('--------------------------');
  end;
 close(HSFile);
end.

