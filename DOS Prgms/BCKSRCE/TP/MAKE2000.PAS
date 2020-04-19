program Make_2000;

uses
 Crt, Std, Dos;

type
 LevelRecord = record
   ID, EnTot, CnTot, XOff, YOff, StX, StY : integer;
   Chr  : array[1..160, 1..48] of char;    {ASCII character}
   Clr  : array[1..160, 1..48] of integer; {Foreground color}
   BCl  : array[1..160, 1..48] of integer; {Background color}
   Dat  : array[1..160, 1..48] of integer; {0=empty 1=Solid 2=Pass 3=Enemy 4=Coin}
  end;

var
 LFile    : file of LevelRecord;
 Lev      : LevelRecord;
 TotLev   : integer;
 LevNum   : integer;

procedure Init;
 var
  Pth : PathStr;
 begin
  assign(LFile, 'RUN2000.LEV');
  Pth := fsearch('RUN2000.LEV', getenv('PATH'));
  if Pth = '' then
   begin
    rewrite(LFile);
    close(LFile);
   end;
  reset(LFile);
  LevTot := filesize(LFile);
  close(LFile);

