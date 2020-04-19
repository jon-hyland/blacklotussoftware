program LastUsed;

uses
 Crt, Std, Dos;

type
 TimeRecord = record
   Month   : string;
   Day     : integer;
   DayWeek : string;
   Hour    : integer;
   Min     : integer;
   AM      : boolean;
  end;

var
 LUFile : file of TimeRecord;
 Time   : TimeRecord;
 YearW,
 MonthW,
 DayW,
 DayOfWeekW,
 HourW,
 MinW,
 SecW,
 Sec100W    : word;
 Month,
 Day,
 DayOfWeek,
 Hour,
 Min        : integer;

procedure Init;
 begin
  assign(LUFile, 'C:\DOS\LASTUSED.DAT');
 end;

procedure FindTime;
 begin
  reset(LUFile);
  read(LUFile, Time);
  close(LUFile);
 end;

function I2S(Num : integer) : string;
 var
  St : string;
 begin
  str(Num, St);
  I2S := St;
 end;

procedure ShowTime;
 var
  TimeStr : string;
 begin
  Clear;
  TimeStr := Time.DayWeek + ' the ' + I2S(Time.Day);
   case Time.Day of
    1, 21, 31     : TimeStr := TimeStr + 'st';
    2, 22         : TimeStr := TimeStr + 'nd';
    3, 23         : TimeStr := TimeStr + 'rd';
   else
    TimeStr := TimeStr + 'th';
   end; {case}
  TimeStr := TimeStr + ' of ' + Time.Month
  + ' at ' + I2S(Time.Hour) + ':';
  if Time.Min < 10 then
   TimeStr := TimeStr + '0' + I2S(Time.Min) + ' '
  else
   TimeStr := TimeStr + I2S(Time.Min) + ' ';
  if Time.AM then
   TimeStr := TimeStr + 'AM'
  else
   TimeStr := TimeStr + 'PM';
  DrawWindow(40-trunc(length(TimeStr)/2)-3,1,40+trunc(length(TimeStr)/2)+3,3,1,'Last Used');
  gotoxy(40-trunc(length(TimeStr)/2), 2);
  write(TimeStr);
  gotoxy(1,6);
 end;

procedure SetTime;
 begin
  GetDate(YearW,MonthW,DayW,DayOfWeekW);
  GetTime(HourW,MinW,SecW,Sec100W);
  Month := trunc(MonthW);
  Day := trunc(DayW);
  DayOfWeek := trunc(DayOfWeekW);
  Hour := trunc(HourW);
  Min := trunc(MinW);
   case Month of
    1 : Time.Month := 'January';
    2 : Time.Month := 'Febuary';
    3 : Time.Month := 'March';
    4 : Time.Month := 'April';
    5 : Time.Month := 'May';
    6 : Time.Month := 'June';
    7 : Time.Month := 'July';
    8 : Time.Month := 'August';
    9 : Time.Month := 'September';
    10 : Time.Month := 'October';
    11 : Time.Month := 'November';
    12 : Time.Month := 'December';
   end; {case}
  Time.Day := Day;
   case DayOfWeek of
    0 : Time.DayWeek := 'Sunday';
    1 : Time.DayWeek := 'Monday';
    2 : Time.DayWeek := 'Tuesday';
    3 : Time.DayWeek := 'Wednesday';
    4 : Time.DayWeek := 'Thursday';
    5 : Time.DayWeek := 'Friday';
    6 : Time.DayWeek := 'Saturday';
   end; {case}
   case Hour of
    0 :
     begin
      Time.Hour := 12;
      Time.AM := true;
     end;
    1..11 :
     begin
      Time.Hour := Hour;
      Time.AM := true;
     end;
    12 :
     begin
      Time.Hour := Hour;
      Time.AM := false;
     end;
    13..23 :
     begin
      Time.Hour := Hour - 12;
      Time.AM := false;
     end;
   end; {case}
  Time.Min := Min;
  rewrite(LUFile);
  write(LUFile, Time);
  close(LUFile);
 end;


begin
 Init;
 FindTime;
 ShowTime;
 SetTime;
end.

