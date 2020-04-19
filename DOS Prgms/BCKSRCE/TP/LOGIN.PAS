program Login_v1_1;

uses
 Crt, Dos, Std;

type
 UserFileType = record
   Name     : string[16];
   Password : string[16];
   Security : integer;
  end;

var
 Directory : string;
 UserFile  : file of UserFileType;
 User      : UserFileType;
 Security  : integer;
 Failed    : text;

procedure Init;
 var
  Path : PathStr;
 begin
  CheckBreak := false;
  Directory := paramstr(1);
  if Directory[length(Directory)] <> '\' then
   Directory := Directory + '\';
  assign(UserFile, Directory + 'USER.DAT');
  assign(Failed, Directory + 'LOGIN.BAD');
  Path := fsearch(Directory + 'LOGIN.BAD', GetEnv('PATH'));
  if Path = '' then
   begin
    rewrite(Failed);
    writeln(Failed, '-- Login Bad Name/Password file --');
    writeln(Failed);
    close(Failed);
   end;
  Clear;
  textcolor(darkgray);
  gotoxy(42,25);
  write('(c) 1996  Black Lotus Software');
 end;

procedure DrawInputWindow;
 begin
  DrawWindow(21,4,60,10,1,'Input');
  gotoxy(23,6);
  write('Enter Login Name : ');
  gotoxy(23,8);
  write('Enter Login Password : ');
  textbackground(black);
  gotoxy(42,6);
  write('            ');
  gotoxy(46,8);
  write('            ');
  Cursor;
 end;

function GetUserName : string;
 var
  NameS    : string[12];
  NameC    : array[1..12] of char;
  x        : integer;
  j        : integer;
  Key      : char;
  GoodName : boolean;
  JunkUser : UserFileType;
 begin
  textcolor(white);
  textbackground(black);
   repeat
    x := 1;
    for j := 1 to 12 do
     begin
      NameC[j] := ' ';
      gotoxy(j+41, 6);
      write(' ');
     end;
     repeat
      gotoxy(x+41, 6);
       repeat
        Key := readkey;
        Key := upcase(Key);
        if Key = #0 then readkey;
       until Key in [#32..#126, #13, #8];
       case Key of
        #32..#126 :
         begin
          NameC[x] := Key;
          write(NameC[x]);
          x := x + 1;
          if x > 12 then x := 12;
         end;
        #8 :
         begin
          NameC[x] := ' ';
          write(NameC[x]);
           x := x - 1;
          if x < 1 then x := 1;
          gotoxy(x+41, 6);
          NameC[x] := ' ';
          write(NameC[x]);
         end;
       end; {case}
     until Key in [#13];
    NameS := '';
    if Key = #13 then
     for j := 1 to x-1 do
      NameS := concat(NameS, NameC[j]);
    GoodName := false;
    if Key = #13 then
     begin
      reset(UserFile);
      while not Eof(UserFile) do
       begin
        read(UserFile, JunkUser);
        JunkUser.Name := DeScramble(JunkUser.Name);
        if NameS = JunkUser.Name then
         begin
          GoodName := true;
          Security := JunkUser.Security;
         end;
       end;
      close(UserFile);
      if not GoodName then
       begin
        append(Failed);
        writeln(Failed, 'Bad Name : ', NameS);
        close(Failed);
       end;
     end;
   until GoodName;
  GetUserName := NameS;
 end;

function GetUserPassword : string;
 var
  PassS    : string[12];
  PassC    : array[1..12] of char;
  x        : integer;
  j        : integer;
  Key      : char;
  GoodPass : boolean;
  JunkUser : UserFileType;
 begin
  textcolor(white);
  textbackground(black);
   repeat
    x := 1;
    for j := 1 to 12 do
     begin
      PassC[j] := ' ';
      gotoxy(j+45, 8);
      write(' ');
     end;
     repeat
      gotoxy(x+45, 8);
       repeat
        Key := readkey;
        Key := upcase(Key);
        if Key = #0 then readkey;
       until Key in [#32..#126, #13, #8];
       case Key of
        #32..#126 :
         begin
          PassC[x] := Key;
          write('*');
          x := x + 1;
          if x > 12 then x := 12;
         end;
        #8 :
         begin
          PassC[x] := ' ';
          write(PassC[x]);
           x := x - 1;
          if x < 1 then x := 1;
          gotoxy(x+45, 8);
          PassC[x] := ' ';
          write(PassC[x]);
         end;
       end; {case}
     until Key in [#13];
    PassS := '';
    if Key = #13 then
     for j := 1 to x-1 do
      PassS := concat(PassS, PassC[j]);
    GoodPass := false;
    if Key = #13 then
     begin
      reset(UserFile);
      while not Eof(UserFile) do
       begin
        read(UserFile, JunkUser);
        JunkUser.Password := DeScramble(JunkUser.Password);
        if PassS = JunkUser.Password then GoodPass := true;
       end;
      close(UserFile);
      if not GoodPass then
       begin
        append(Failed);
        writeln(Failed, 'Bad Pass : ', PassS);
        close(Failed);
       end;
     end;
   until GoodPass;
  GetUserPassword := PassS;
 end;

procedure EraseScreen;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
 end;

begin
 Init;
 DrawInputWindow;
 User.Name := GetUserName;
 User.Password := GetUserPassword;
 EraseScreen;
 Halt(Security);
end.