program Test;

type
 HighScore = record
   Name : string[20];
   Score : integer;
  end;
 HighScoreFile = file of HighScore;

var
 Score : HighScore;
 TestFile : HighScoreFile;
 x : integer;

begin
 assign(TestFile, 'TEST.FIL');
 rewrite(TestFile);
 Score.Name := 'Bob Suck';
 Score.Score := 12;
 write(TestFile, Score);
 close(TestFile);
end.

