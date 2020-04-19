program TestClock;

uses
 Crt, Dos;

var
 Count : longint;
 j, k : integer;

function TimeInt : longint;
 var
  Hour, Min, Sec, Hund : word;
 begin
  GetTime(Hour, Min, Sec, Hund);
  TimeInt := trunc(Hund + (Sec * 100) + (Min * 6000) + (Hour * 360000));
 end;

procedure ResetCount;
 begin
  Count := TimeInt;
 end;

procedure WaitCount(DelayTime : longint);
 var
  Time : longint;
 begin
   repeat
    Time := TimeInt;
   until Time >= (Count + DelayTime);
 end;

begin
 clrscr;
 for j := 1 to 10 do
  begin
   ResetCount;
   delay(random(500));
   {WaitCount(100);}
   write(j);
  end;
 readkey;
end.
