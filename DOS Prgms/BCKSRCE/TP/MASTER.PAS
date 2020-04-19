{Program started 11/15/97.
 Program finished 11/17/97.
 Lines : 267 (This file)
 Aprox. Hrs. : 3 1/2

 This is the first real program I am writing incorporating mouse support.
 It it intended for use with LOGIN v2.  Jon Hyland }

program LoginMaster;

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
 UFile : file of UserRecord;
 Num   : integer;
 Tot   : integer;
 Key   : char;

procedure Security;
 var
  Pass : string;
 begin
  DrawWindow(32,11,47,13,4,'Password');
  Pass := GetString(34,12,12,locked,dots,upper);
  if Pass <> DeScramble('9264‰H|•9ªMeHG') then
   begin
    Clear;
    Halt(0);
   end;
 end;

procedure LoadUser(Num : integer);
 var
  x : integer;
 begin
  reset(UFile);
  for x := 1 to Num do
   if not Eof(UFile) then
    read(UFile, User);
  close(UFile);
 end;

procedure Init;
 var
  Jnk  : UserRecord;
  Path : PathStr;
 begin
  assign(UFile, 'C:\WINDOWS\SYSTEM\USER.DAT');
  Path := fsearch('C:\WINDOWS\SYSTEM\USER.DAT', GetEnv('PATH'));
  if Path = '' then
   begin
    rewrite(UFile);
    Jnk.Name := Scramble('[DELETE ME]');
    Jnk.Pass := Scramble('');
    Jnk.ID := 0;
    write(UFile, Jnk);
    close(UFile);
   end;
  Tot := 0;
  reset(UFile);
  while not Eof(UFile) do
   begin
    read(UFile, Jnk);
    Tot := Tot + 1;
   end;
  close(UFile);
  Num := Tot;
  LoadUser(Num);
  MouseOn;
 end;

procedure UpdateScreen;
 var
  x : integer;
 begin
  textcolor(white);
  textbackground(black);
  PutString(34,9,12,DeScramble(User.Name));
  gotoxy(34,11);
  write('            ');
  gotoxy(34,11);
  for x := 1 to length(DeScramble(User.Pass)) do
   write('*');
  gotoxy(34,13);
  write('  ');
  gotoxy(34,13);
  write(User.ID);
  Cursor;
 end;

procedure DrawScreen;
 begin
  Background_I(true);
  delay(50);
  DrawWindow(25,8,55,16,1,'Master User v' + VerNum);
  gotoxy(27,9);
  write('Name : ');
  gotoxy(27,11);
  write('Pass : ');
  gotoxy(27,13);
  write('ID   : ');
  textcolor(yellow);
  textbackground(cyan);
  gotoxy(27,15);
  write('Quit');
  gotoxy(34,15);
  write('New');
  gotoxy(40,15);
  write('Del');
  gotoxy(46,15);
  write(' ', #27, ' ');
  gotoxy(51,15);
  write(' ', #26, ' ');
  UpdateScreen;
  Show;
 end;

procedure DeleteUser(Num : integer);
 var
  x    : integer;
  Swap : file of UserRecord;
  Jnk  : UserRecord;
 begin
  if Tot > 1 then
   begin
    assign(Swap, 'C:\WINDOWS\SYSTEM\SWAP.DAT');
    rewrite(Swap);
    reset(UFile);
    for x := 1 to Tot do
     if not Eof(UFile) then
      begin
       read(UFile, Jnk);
       if x <> Num then
        write(Swap, Jnk);
      end;
    close(UFile);
    close(Swap);
    rewrite(UFile);
    reset(Swap);
    while not Eof(Swap) do
     begin
      read(Swap, Jnk);
      write(UFile, Jnk);
     end;
    close(UFile);
    close(Swap);
    Tot := 0;
    reset(UFile);
    while not Eof(UFile) do
     begin
      read(UFile, Jnk);
      Tot := Tot + 1;
     end;
    close(UFile);
    if Num > Tot then Num := Tot;
    LoadUser(Num);
    UpdateScreen;
   end;
 end;

procedure NewUser;
 var
  Jnk  : UserRecord;
  Jnk2 : UserRecord;
  Ver  : string;
  Low  : integer;
  Hit  : boolean;
 begin
  Hide;
  textcolor(white);
  textbackground(black);
  gotoxy(34,11);
  write('            ');
  gotoxy(34,13);
  write('  ');
  User.Name := Scramble(GetString(34,9,12,unlock,visable,upper));
  if DeScramble(User.Name) <> '#ESC#' then
   begin
     repeat
      User.Pass := GetString(34,11,12,locked,dots,upper);
      textbackground(blue);
      gotoxy(27,11);
      write('Verify:');
      Ver := GetString(34,11,12,locked,dots,upper);
      textbackground(blue);
      gotoxy(27,11);
      write('Pass : ');
     until User.Pass = Ver;
    User.Pass := Scramble(User.Pass);
    Low := 1;
     repeat
      reset(UFile);
      Hit := false;
      while not Eof(UFile) do
       begin
        read(UFile, Jnk);
        if Jnk.ID = Low then Hit := true;
       end;
      close(UFile);
      if Hit then Low := Low + 1;
     until not Hit;
    User.ID := Low;
    reset(UFile);
    while not Eof(UFile) do
     read(UFile, Jnk);
    write(UFile, User);
    close(UFile);
    Tot := Tot + 1;
    Num := Tot;
   end;
  LoadUser(Num);
  UpdateScreen;
  Show;
 end;

function MonitorMouse(Pass : char) : char;
 var
  Click : integer;
  Rtrn  : char;
 begin
  Rtrn := #0;
  Click := GetClick;
   case Click of
    1 :
     begin
      if (MouseX in [27..30]) and (MouseY in [15]) then Rtrn := #27;
      if (MouseX in [34..36]) and (MouseY in [15]) then Rtrn := 'N';
      if (MouseX in [40..42]) and (MouseY in [15]) then Rtrn := 'D';
      if (MouseX in [46..48]) and (MouseY in [15]) then Rtrn := '-';
      if (MouseX in [51..53]) and (MouseY in [15]) then Rtrn := '+';
     end;
    2 :
     begin
     end;
   end; {case}
  if Rtrn <> #0 then MonitorMouse := Rtrn else MonitorMouse := Pass;
 end;

begin
 BlackLotusIntro(false);
 Security;
 Init;
 DrawScreen;
  repeat
   Key := #0;
   Key := MonitorMouse(Key);
   if KeyPressed then Key := readkey;
    case Key of
     'H', 'K', '-':
      begin
       Num := Num - 1;
       if Num < 1 then Num := Tot;
       LoadUser(Num);
       UpdateScreen;
      end;
     'P', 'M', '+' :
      begin
       Num := Num + 1;
       if Num > Tot then Num := 1;
       LoadUser(Num);
       UpdateScreen;
      end;
     'D', 'd' : DeleteUser(Num);
     'N', 'n' : NewUser;
    end; {case}
  until Key = #27;
 MouseOff;
 FadeOut;
end.