 program MakeHSFile;

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
   write(' Name   : ');
   readln(HSRec.Name);
   write(' Points : ');
   readln(HSRec.Points);
   write(HSFile, HSRec);
  end;
 close(HSFile);
end.
