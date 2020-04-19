program AnarchistArena;

uses
 Crt, Std, Dos;

type
 ObjType = array[1..40, 1..10] of boolean;
 PlayerStats = record
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
 Obj       : ObjType;
 User1     : PlayerStats;
 User2     : PlayerStats;
 SFile     : file of PlayerStats;
 HandInfo,
 RangeInfo,
 ArmorInfo : WeaponInfo;
 Hand,
 Range,
 Armor     : integer;
 U1ID,
 U2ID      : integer;

procedure MakeNewPlayer;
 var
  User : PlayerStats;
  x    : integer;
  Sex  : string[1];
  Jnk  : PlayerStats;
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
  reset(SFile);
  while not Eof(SFile) do
   read(SFile, Jnk);
  write(SFile, User);
  close(SFile);
 end;

{$I KILL.INC}
procedure Init;
 var
  j, k : integer;
  Jnk  : PathStr;
  Trsh : PlayerStats;
  Tot  : integer;
 begin
  assign(SFile, 'KILL.DAT');
  Jnk := fsearch('KILL.DAT',GetEnv('PATH'));
  Trsh.Name := '{EMPTY}';
  if Jnk = '' then
   begin
    rewrite(SFile);
    write(SFile, Trsh);
    close(SFile);
   end;
  Tot := 0;
  reset(SFile);
  while not eof(SFile) do
   begin
    read(SFile, Trsh);
    Tot := Tot + 1;
   end;
  close(SFile);
  if Tot < 2 then
   begin
    rewrite(SFile);
    DrawWindow(25,8,55,11,2,'Info');
    gotoxy(27,9);
    write('There must be at least');
    gotoxy(27,10);
    write('two players for this game.');
    MakeNewPlayer;
    MakeNewPlayer;
   end;
  Clear;
 end;

procedure GetPlayers;
 var
  Jnk : PlayerStats;
  Chart : array[1..10] of record
    Name  : string[12];
    Sex   : boolean;
    Kills : integer;
   end;
  x, y : integer;
 begin
  for x := 1 to 10 do
   begin
    Chart[x].Name := 'EMPTY';
    Chart[x].Sex := true;
    Chart[x].Kills := 0;
   end;
  reset(SFile);
  x := 1;
  while (x <= 10) and not(Eof(SFile)) do
   begin
    read(SFile, Jnk);
    Chart[x].Name := Jnk.Name;
    Chart[x].Sex := Jnk.Sex;
    Chart[x].Kills := Jnk.Kills;
    x := x + 1;
   end;
  close(SFile);
  DrawWindow(20,6,60,18,0,'Choose Player');

  for y := 1 to 10 do
   begin
    gotoxy(22,y+7);
    write(Chart[y].Name);
    for x := 1 to (14-length(Chart[y].Name)) do
     write(' ');
    write(Chart[x].Kills);
   end;


 readkey;




 end;

begin
 BlackLotusIntro;
 Init;
 GetPlayers;
end.