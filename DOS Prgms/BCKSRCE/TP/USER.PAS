program UserManager_v1_0;

uses
 Crt, Std;

type
 UserFileType = record
   Name     : string[16];
   Password : string[16];
   Security : integer;
  end;

var
 User     : UserFileType;
 UserFile : file of UserFileType;
 TotUser  : integer;
 UserNum  : integer;
 Key      : char;

procedure Password;
 var
  Pass : string[12];
  Junk : UserFileType;
 begin
  Clear;
  DrawWindow(31,8,48,10,1,'Password');
  Pass := GetString(34,9,12,locked,hidden,upper);
  EraseWindow(25,8,55,10);
  reset(UserFile);
  read(UserFile, Junk);
  close(UserFile);
  Junk.Password := DeScramble(Junk.Password);
  if Junk.Password <> Pass then
   begin
    textcolor(white);
    textbackground(black);
    clrscr;
    Halt(0);
   end;
 end;

procedure LoadUser(UserNum : integer);
 var
  x    : integer;
  Junk : UserFileType;
 begin
  reset(UserFile);
  for x := 1 to UserNum - 1 do
   read(UserFile, Junk);
  read(UserFile, User);
  close(UserFile);
  User.Name := DeScramble(User.Name);
  User.Password := DeScramble(User.Password);
 end;

procedure OutputUser;
 var
  x : integer;
 begin
  textcolor(white);
  textbackground(black);
  gotoxy(40,7);
  write('            ');
  gotoxy(40,9);
  write('            ');
  gotoxy(45,11);
  write(' ');
  gotoxy(40,7);
  write(User.Name);
  gotoxy(40,9);
  for x := 1 to length(User.Password) do
   begin
    write('*');
   end;
  gotoxy(45,11);
  write(User.Security);
  Cursor;
 end;

procedure DrawUserWindow;
 begin
  Clear;
  DrawWindow(27,5,53,15,1,'User Info');
  gotoxy(29,7);
  write('UserName : ');
  gotoxy(29,9);
  write('Password : ');
  gotoxy(29,11);
  write('Security : ');
  textcolor(yellow);
  gotoxy(29,13);
  write('[N]ew User  [+-] Scroll');
  gotoxy(29,14);
  write('[Esc] Quit  [D]el User');
  textbackground(black);
  gotoxy(40,7);
  write('            ');
  gotoxy(40,9);
  write('            ');
  gotoxy(45,11);
  write(' ');
  Cursor;
 end;

procedure Init;
 var
  Junk : UserFileType;
 begin
  assign(UserFile, 'C:\DOS\USER.DAT');
  reset(UserFile);
  TotUser := 0;
  while not Eof(UserFile) do
   begin
    read(UserFile, Junk);
    TotUser := TotUser + 1;
   end;
  close(UserFile);
  UserNum := 1;
 end;

procedure GetNewUser;
 var
  Pass1,
  Pass2  : string;
  Junk   : UserFileType;
 begin
  textcolor(white);
  textbackground(black);
  gotoxy(40,7);
  write('            ');
  gotoxy(40,9);
  write('            ');
  gotoxy(45,11);
  write(' ');
  TotUser := TotUser + 1;
  User.Name := Scramble(GetString(40,7,12,locked,visable,upper));
   repeat
    Pass1 := GetString(40,9,12,locked,hidden,upper);
    textbackground(blue);
    gotoxy(29,9);
    write('Verify   : ');
    Pass2 := GetString(40,9,12,locked,hidden,upper);
    textbackground(blue);
    gotoxy(29,9);
    write('Password : ');
   until Pass1 = Pass2;
  User.Password := Scramble(Pass1);
  User.Security := trunc(Str2Real(GetString(45,11,1,locked,visable,upper)));
  reset(UserFile);
  while not Eof(UserFile) do
   read(UserFile, Junk);
  write(UserFile, User);
  Cursor;
  UserNum := TotUser;
 end;

procedure DeleteUser;
 var
  SwapFile : file of UserFileType;
  Num      : integer;
  Tran     : UserFileType;
 begin
  assign(SwapFile, 'C:\DOS\SWAP.DAT');
  reset(UserFile);
  rewrite(SwapFile);
  for Num := 1 to TotUser do
   begin
    read(UserFile, Tran);
    if Num <> UserNum then
     write(SwapFile, Tran);
   end;
  TotUser := TotUser - 1;
  if UserNum > TotUser then UserNum := TotUser;
  close(SwapFile);
  close(UserFile);
  reset(SwapFile);
  rewrite(UserFile);
  for Num := 1 to TotUser do
   begin
    read(SwapFile, Tran);
    write(UserFile, Tran);
   end;
  close(UserFile);
  close(SwapFile);
  LoadUser(UserNum);
  OutputUser;
 end;

begin
 Init;
 Password;
 LoadUser(UserNum);
 DrawUserWindow;
 OutputUser;
  repeat
   Key := readkey;
   if Key = #0 then Key := readkey;
    case Key of
     '+', 'H', 'M' :
      begin
       UserNum := UserNum + 1;
       if UserNum > TotUser then UserNum := 1;
       LoadUser(UserNum);
       OutputUser;
      end;
     '-', 'P', 'K' :
      begin
       UserNum := UserNum - 1;
       if UserNum < 1 then UserNum := TotUser;
       LoadUser(UserNum);
       OutputUser;
      end;
     'N', 'n' :
      begin
       GetNewUser;
      end;
     'D', 'd', 'S' :
      begin
       DrawWindow(27,18,53,20,4,'Warning!');
       gotoxy(29,19);
       write('Delete this user? (Y/N)');
       Cursor;
        repeat
         Key := readkey;
         Key := upcase(Key);
        until Key in ['Y','N'];
       if Key = 'Y' then DeleteUser;
       EraseWindow(27,18,53,20);
      end;
    end; {case}
  until Key = #27;
 textcolor(white);
 textbackground(black);
 clrscr;
end.