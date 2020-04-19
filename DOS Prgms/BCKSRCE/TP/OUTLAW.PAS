{This version started 9/01/97.
 Completed 10/??/96.
 All coding by Jon Hyland.
 Source code requires STD.PAS to compile.
 Program requires OUTLAW.USR to execute.

 Tot Lines : ????
 File Size : ?????}

program TheOutlawsOrder;

uses
 Crt, Std, Dos;

const
 VerNum = '1.0';

type
 ObjType = array[1..40, 1..10] of boolean;
 PlayerRecType = record
   Name  : string[12];
   Sex   : boolean;
   TotHP : integer;
   HitPt : real;
   Hand  : integer;
   Range : integer;
   Armor : integer;
   Gold  : longint;
   Kills : integer;
  end;
 WeaponInfo = array[1..25] of record
   Name  : string[25];
   Power : real;
   Price : integer;
  end;

var
 Obj     : ObjType;
 User1   : PlayerRecType;
 User2   : PlayerRecType;
 UFile   : file of PlayerRecType;



procedure Title;
 begin
  Clear;
  DrawWindow(26,7,54,15,4,'Thou art in');
  textcolor(yellow);
  gotoxy(30,8);
  write('- The Outlaws Order -');
  gotoxy(38,9);
  write('v', VerNum);
  textcolor(lightblue);
  gotoxy(36,11);
  write('(c) 1997');
  gotoxy(31,12);
  write('Black Lotus Software');
  textcolor(lightgray);
  gotoxy(28,14);
  write('All coding by Jon Hyland.');
  Cursor;
  ClearBuffer;
  readkey;
 end;

procedure ResetUserFile;
 var
  Jnk  : PlayerRecType;
  x    : integer;
 begin
  rewrite(UFile);
  Jnk.Name := '[EMPTY]';
  Jnk.Sex := true;
  Jnk.TotHP := 0;
  Jnk.HitPt := 0;
  Jnk.Hand := 0;
  Jnk.Range := 0;
  Jnk.Armor := 0;
  Jnk.Gold := 0;
  Jnk.Kills := 0;
  for x := 1 to 10 do
   write(UFile, Jnk);
  close(UFile);
 end;

procedure


{procedure NewPlayer;
 var
  User : PlayerRecType;
  x    : integer;
  Sex  : string[1];
  Jnk  : PlayerRecType;
 begin
  DrawWindow(25,12,55,15,1,'New Player');
  gotoxy(27,13);
  write('Name : ');
  gotoxy(27,14);
  write('Sex (M/F) : ');
  User.Name := GetString(34,13,12,locked,visable,reg);
  textcolor(white);
  textbackground(blue);
  gotoxy(34,13);
  for x := 1 to 12 do
   if (x <= length(User.Name)) then
    write(User.Name[x])
   else
    write(' ');
   repeat
    Sex := GetString(34,14,1,locked,visable,upper);
   until Sex[1] in ['M', 'F'];
  textcolor(white);
  textbackground(blue);
  gotoxy(34,14);
  write(Sex);
  if Sex = 'F' then User.Sex := false else User.Sex := true;
  if Sex = 'M' then User.TotHP := 10 else User.TotHP := 8;
  User.HitPT := User.TotHP;
  User.Hand := 0;
  User.Range := 0;
  User.Armor := 0;
  User.Gold := 10;
  User.Kills := 0;
  reset(UFile);
  while not Eof(SFile) do
   read(SFile, Jnk);
  write(SFile, User);
 [close(SFile);
 end;           }

procedure Init;
 var
  j, k  : integer;
  Path  : PathStr;
  Tot   : integer;
  Jnk   : PlayerRecType;
 begin
  assign(UFile, 'OUTLAW.USR');
  Path := fsearch('OUTLAW.USR', GetEnv('PATH'));
  if Path = '' then ResetUserFile;
  Tot := 0;
  reset(UFile);
  for j := 1 to 10 do
   begin
    read(UFile, Jnk);
    if Jnk.Name <> '[EMPTY]' then Tot := Tot + 1;
   end;
  close(UFile);
  if Tot < 2 then
   begin
    NewPlayer;
    NewPlayer;
   end;
 end;














begin
 Title;
end.