program ClearHighScore;

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
 write('Resetting WormBomb high score file...');
 assign(HSFile, 'HSFILE.DAT');
 rewrite(HSFile);
 HSRec.Name := '< Empty >';
 HSRec.Points := 0;
 for j := 1 to 10 do
  write(HSFile, HSRec);
 close(HSFile);
 writeln('Done');
end.


