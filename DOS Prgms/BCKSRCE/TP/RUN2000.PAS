program RunGame2000;

uses
 Crt, Std;

const
 VerNum     = 'v1.0';
 MaxEnemy   = 250;

type
 LevelRecord = record
   ID, EnTot, CnTot, XOff, YOff, StX, StY : integer;
   Chr  : array[1..160, 1..48] of char;    {ASCII character}
   Clr  : array[1..160, 1..48] of integer; {Foreground color}
   BCl  : array[1..160, 1..48] of integer; {Background color}
   Dat  : array[1..160, 1..48] of integer; {0=empty 1=Solid 2=Pass 3=Enemy 4=Coin}
  end;
 EnemyLoc  = array[1..MaxEnemy] of integer;

var
 LFile   : file of LevelRecord;
 Lev     : LevelRecord;
 LevNum  : integer;
 LevTot  : integer;
 EnX,
 EnY,
 EnC,
 EnDr    : EnemyLoc;
 En,
 x, y,
 xoff,
 yoff    : integer;

procedure Title;
 begin
  delay(78*2);
  Clear;
  DrawWindow(29,8,52,15,4,'Info');
  gotoxy(32,9);
  textcolor(yellow);
  write('- RunGame 2000! -');
  textcolor(lightgray);
  gotoxy(38,10);
  write(VerNum);
  textcolor(white);
  gotoxy(36,12);
  write('(c) 1998');
  gotoxy(31, 13);
  write('Black Lotus Software');
  textcolor(cyan);
  gotoxy(32,14);
  write('Jon Hyland 1/29/98');
  Cursor;
  ClearBuffer;
  readkey;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  for k := yoff+1 to yoff+24 do
   for j := xoff+1 to xoff+80 do
    begin
     gotoxy(j-xoff, k-yoff);
     textcolor(Lev.Clr[j,k]);
     textbackground(Lev.BCl[j,k]);
     write(Lev.Chr[j,k]);
    end;
  Cursor;
 end;

{Refresh set to true when you want level screen to be redrawn after message,
 use this when message comes durring play, etc (not before screen is drawn).}
procedure QuickMessage(St : string; Refresh : boolean);
 begin
  DrawWindow(40-(length(St) div 2)-2, 10, 40+(length(St) div 2)+2, 12, 4, 'Message');
  BreakDelay(250);
  ClearBuffer;
  if Refresh then DrawScreen;
 end;

procedure LoadLevel(Num : integer);
 var
  i, j, k : integer;
 begin
  reset(LFile);
  seek(LFile, Num-1);
  read(LFile, Lev);
  close(LFile);
  xoff := Lev.XOff;
  yoff := Lev.YOff;
  x := Lev.StX;
  y := Lev.StY;
  i := 0;
  for k := 1 to 48 do
   for j := 1 to 160 do
    if Lev.Dat[j,k] = 3 then
     begin
      i := i + 1;
      EnX[i] := j;
      EnY[i] := k;
      EnDr[i] := random(9)+1;
      EnC[i] := Lev.Clr[j,k];
     end;
  if i <> Lev.EnTot then
   begin
    QuickMessage('Enemy count error!', false);
    Lev.EnTot := i;
   end;
 end;

procedure FadeScreen;
 const
  Tot     = 80 * 24;
  DelTime = 4;
 var
  i, j, k : integer;
  Done : array[1..80, 1..24] of boolean;
 begin
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Done[j,k] := false;
  for i := 1 to Tot do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Done[j,k];
    Done[j,k] := true;
    if (j+xoff <> x) or (k+yoff <> y) then
     begin
      gotoxy(j,k);
      textcolor(Lev.Clr[j+xoff, k+yoff]);
      textbackground(Lev.BCl[j+xoff, k+yoff]);
      write(Lev.Chr[j+xoff, k+yoff]);
      Cursor;
     end;
    if random(25) = 0 then delay(DelTime);
   end;
 end;

{Needs to init level file and load appropriate level.}
procedure Init;
 begin
  randomize;
  assign(LFile, 'RUN2000.LEV');
  reset(LFile); {---}
  LevTot := filesize(LFile);
  close(LFile);
  LevNum := 1;
 end;

procedure StartLevel(LevNum : integer);
 const
  DelTime = 150;
 var
  i : integer;
 begin
  LoadLevel(LevNum);
  FadeScreen;
  DrawScreen;
  textcolor(Lev.Clr[x,y]);
  textbackground(Lev.BCl[x,y]);
  for i := 1 to 3 do
   begin
    gotoxy(x-xoff, y-yoff);
    write(' ');
    Cursor;
    delay(DelTime);
    gotoxy(x-xoff, y-yoff);
    write(Lev.Chr[x,y]);
    Cursor;
    delay(DelTime);
   end;
 end;

begin
 BlackLotusIntro;
 Title;
 Init;
  repeat {Goes here at start of level}
   StartLevel(LevNum);



  until 1=1;

 readkey;
end.






