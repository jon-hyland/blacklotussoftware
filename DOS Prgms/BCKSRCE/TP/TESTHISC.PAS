program TestHighScore;

uses
 Crt;

type
 HighScoreRecord = record
  Name : string[20];
  Points : integer;
 end;
 HighScoreArray = array[1..10] of HighScoreRecord;
 HighScoreFile = file of HighScoreRecord;

var
 HSRec : HighScoreRecord;
 HSArr : HighScoreArray;
 HSFile : HighScoreFile;
 Points : integer;
 Name : string[20];
 Place : integer;
 j : integer;

begin
 clrscr;
 assign(HSFile, 'HSFILE.DAT');
 write('Points : ');
 readln(Points);
 reset(HSFile);
 for j := 1 to 10 do
  read(HSFile, HSArr[j]);
 close(HSFile);
 Place := 0;
 for j := 1 to 10 do
  if Place = 0 then
   if Points > HSArr[j].Points then
    Place := j;
 if Place <> 0 then
  begin
   write('Your name : ');
   readln(Name);
   for j := 10 downto Place + 1 do
    HSArr[j] := HSArr[j-1];
   HSArr[Place].Name := Name;
   HSArr[Place].Points := Points;
   reset(HSFile);
   for j := 1 to 10 do
    write(HSFile, HSArr[j]);
   close(HSFile);
  end;
end.
