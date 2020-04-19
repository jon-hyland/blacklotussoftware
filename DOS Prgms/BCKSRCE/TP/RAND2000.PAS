{This program creates a series of 10 random levels for RunGame2000 and
 stores them in RUN2000.LEV. It will rewrite over existing levels each
 execution so run at your own risk. }

program MakeLevels;

uses
 Crt;

const
{ TotRocks = 250;
 TotTrees = 150;
 TotEnemy = 30;
 TotCoin  = 10; }
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
 Lev     : LevelRecord;
 LFile   : file of LevelRecord;
 Num     : integer;

const
 TotRocks = 200;

procedure MakeRandomLevel(Level : integer);
 var
  i, j, k : integer;
 begin
  randomize;
  Lev.ID := Level;
  Lev.EnTot := (Level * 10) + 5;
  Lev.CnTot := (Level * 3) + 4;
  Lev.XOff  := 40;
  Lev.YOff  := 12;
  Lev.StX   := 80;
  Lev.StY   := 24;
  for k := 1 to 48 do
   for j := 1 to 160 do
    begin
     Lev.Chr[j,k] := ' ';
     Lev.Dat[j,k] := 0;
     Lev.Clr[j,k] := 0;
     Lev.BCl[j,k] := 0;
    end;
  Lev.Chr[Lev.StX, Lev.StY] := #234;
  Lev.Clr[Lev.StX, Lev.StY] := 15;
  Lev.BCl[Lev.StX, Lev.StY] := 0;
  Lev.Dat[Lev.StX, Lev.StY] := 5;
  for i := 1 to TotRocks do
   begin
     repeat
      j := random(160)+1;
      k := random(48)+1;
     until Lev.Dat[j,k] = 0;
    Lev.Dat[j,k] := 1;
    Lev.Chr[j,k] := chr(random(3)+176);
     case random(4) of
      0 : Lev.Clr[j,k] := 7;
      1 : Lev.Clr[j,k] := 8;
      2 : Lev.Clr[j,k] := 6;
      3 : Lev.Clr[j,k] := 4;
     end; {case}
     repeat
       case random(4) of
        0 : Lev.BCl[j,k] := 7;
        1 : Lev.BCl[j,k] := 0;
        2 : Lev.BCl[j,k] := 6;
        3 : Lev.BCl[j,k] := 4;
       end; {case}
     until Lev.Clr[j,k] <> Lev.BCl[j,k];
   end;
  for i := 1 to Lev.EnTot do
   begin
     repeat
      j := random(160)+1;
      k := random(48)+1;
     until Lev.Dat[j,k] = 0;
    Lev.Chr[j,k] := #157;
    Lev.Clr[j,k] := random(15)+1;
    Lev.BCl[j,k] := 0;
    Lev.Dat[j,k] := 3;
   end;
  for i := 1 to Lev.CnTot do
   begin
     repeat
      j := random(160)+1;
      k := random(48)+1;
     until Lev.Dat[j,k] = 0;
    Lev.Chr[j,k] := '*';
    Lev.Clr[j,k] := 9;
    Lev.BCl[j,k] := 0;
    Lev.Dat[j,k] := 4;
   end;
 end;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 writeln('Rand_Make2000 -- Jon Hyland 1/27/98');
 writeln('Resetting level file..');
 assign(LFile, 'RUN2000.LEV');
 rewrite(LFile);
 writeln('Making level #');
 for Num := 1 to 10 do
  begin
   gotoxy(15,3);
   write(Num);
   MakeRandomLevel(Num);
   write(LFile, Lev);
  end;
 close(LFile);
 writeln;
 write('Finished.');
 readkey;
end.

