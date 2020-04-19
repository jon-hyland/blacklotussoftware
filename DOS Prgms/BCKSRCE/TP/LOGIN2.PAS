{This program is intended to be executed at startup for users
 to log onto system.  Uses database created by Master v2+.  User's
 ID Num is returned as ERRORLEVEL for possible use in branching batch
 files.

 Program Started : 11/17/97
 Finished        : 11/17/97
 Lines           : 90 (this file)
 Aprox. Hrs.     : 1/2 }

program Login_2;

uses
 Crt, Std, Dos;

const
 VerNum = '2.0';

type
 UserRecord = record
   Name : string[16];
   Pass : string[16];
   ID   : integer;
  end; {record}

var
 User  : UserRecord;
 UsrFile : file of UserRecord;
 LogFile : text;
 OnFile  : text;
 Pass  : string[12];

procedure Init;
 var
  Jnk  : UserRecord;
  Path : PathStr;
 begin
  CheckBreak := false;
  assign(UsrFile, 'C:\WINDOWS\SYSTEM\USER.DAT');
  assign(LogFile, 'C:\WINDOWS\SYSTEM\USER.LOG');
  assign(OnFile,  'C:\WINDOWS\SYSTEM\USER.ON');
  Path := fsearch('C:\WINDOWS\SYSTEM\USER.LOG', GetEnv('PATH'));
  if Path = '' then
   begin
    rewrite(LogFile);
    writeln(LogFile, '--- USER LOG FILE ---');
    close(LogFile);
   end;
  Path := fsearch('C:\WINDOWS\SYSTEM\USER.DAT', GetEnv('PATH'));
  if Path = '' then
   begin
    Clear;
    writeln('User data file not found!');
    writeln('Program halting.');
    halt(1);
   end;
 end;

procedure DrawScreen;
 begin
  BackGround_I;
  delay(115);
  DrawWindow(29,10,51,14,4,'Login v' + VerNum);
  gotoxy(31,11);
  write('Name : ');
  gotoxy(31,13);
  write('Pass : ');
  textbackground(black);
  gotoxy(38,11);
  write('            ');
  gotoxy(38,13);
  write('            ');
  Cursor;
 end;

procedure GetName;
 var
  Name  : string[12];
  Found : boolean;
 begin
  Found := false;
   repeat
    Name := GetString(38,11,12,locked,visable,upper);
    reset(UsrFile);
    while (not Eof(UsrFile)) and (not Found) do
     begin
      read(UsrFile, User);
      if DeScramble(User.Name) = Name then Found := true;
     end;
    close(UsrFile);
   until Found;
 end;

procedure GetPass;
 begin
   repeat
    Pass := GetString(38,13,12,unlock,dots,upper);
   until (Pass = DeScramble(User.Pass)) or (Pass = '#ESC#');
 end;

procedure UpdateLogfile;
 var
  Year, Month, Day, DOW  : word;
  Hour, Min, Sec, Sec100 : word;
 begin
  append(LogFile);
  GetDate(Year, Month, Day, DOW);
  GetTime(Hour, Min, Sec, Sec100);
  write(LogFile, DeScramble(User.Name), ' at ', Hour, ':', Min, ':',
   Sec, ' on ', Month, '/', Day, '/', Year);
  close(LogFile);
  rewrite(OnFile);
  write(OnFile, User.Name);
  close(OnFile);
 end;

begin
 Init;
 DrawScreen;
  repeat
   GetName;
   GetPass;
  until Pass <> '#ESC#';
 UpdateLogfile;
 Clear;
 Halt(User.ID);
end.