program Quiz;

uses
 Crt;

var
 Question : string;
 QNum     : integer;
 Points   : integer;
 QFile    : text;
 Key      : char;
 Asked    : array[1..100] of boolean;
 Num      : integer;

procedure Init;
 var
  j : integer;
 begin
  assign(QFile, 'QFILE.DAT');
  Points := 0;
  QNum := 1;
  for j := 1 to 100 do
   Asked[j] := false;
 end;

procedure LoadQuestion(Num : integer);
 var
  j : integer;
 begin
  randomize;
  reset(QFile);
  for j := 1 to Num do
   readln(QFile, Question);
  close(QFile);
 end;

begin
 clrscr;
 Init;
  repeat
    repeat
     Num := random(100)+1;
    until not Asked[Num];
   Asked[Num] := true;
   LoadQuestion(Num);
   write(Question);
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in ['Y','N',#27];
   if Key <> #27 then write('  ', Key);
   writeln;
   if Key = 'Y' then Points := Points + 1;
   QNum := QNum + 1;
  until (QNum > 100) or (Key = #27);
 if Key <> #27 then
  write('You have ', Points, ' points!');
 readkey;
end.
