program EditUser;

uses
 Crt, Std;

type
 UserFileType = record
   Name     : string[12];
   Password : string[12];
   Security : integer;
  end;

var
 User : UserFileType;
 UserFile : file of UserFileType;

procedure Init;
 begin
  assign(UserFile, 'C:\DOS\USER.DAT');
 end;

procedure Password;
 var
  Pass : string[12];
  Junk : UserFileType;
 begin
  Clear;
  DrawWindow(25,10,55,12,1,'System Password');
  Pass := GetString(36,11,12,locked,,);
  EraseWindow(25,10,55,12);
  reset(UserFile);
  read(UserFile, Junk);
  close(USerFile);
  if Junk.Password <> Pass then
   begin
    textcolor(white);
    textbackground(black);
    clrscr;
    Halt(0);
   end;
 end;

procedure CreateUserFile;
 var
  Pass1,
  Pass2 : string[12];
 begin
  DrawWindow(21,4,62,8,1,'Input');
  gotoxy(23,5);
  write('Enter Login Name : ');
  gotoxy(23,6);
  write('Enter Login Password : ');
  gotoxy(23,7);
  write('Reenter Login Password : ');
  User.Name := GetString(42,5,12,locked,visable);
   repeat
    Pass1 := GetString(46,6,12,locked,hidden);
    Pass2 := GetString(48,7,12,locked,hidden);
   until Pass1 = Pass2;
  User.Password := Pass1;
  reset(UserFile);
  write(UserFile, User);
  close(UserFile);
  EraseWindow(21,4,62,8);
 end;

begin
 Init;
 Password;
 CreateUserFile;
end.


