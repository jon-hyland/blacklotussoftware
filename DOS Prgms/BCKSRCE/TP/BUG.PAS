program BugZapper;

uses
 Crt;

type
 BugLocationType = array[1..5] of integer;
 BugScreenType = array[1..80, 1..24] of boolean;

var
 BugX : BugLocationType;
 BugY : BugLocationType;
 Obj : BugScreenType;
 j, k : integer;
 Bug : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Init;
 begin
  randomize;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  for j := 38 to 42 do
   begin
    Obj[j,8]  := true;
    Obj[j,12] := true;
   end;
 end;

procedure DrawScreen;
 begin
  clrscr;
  textcolor(darkgray);
  for j := 1 to 7 do
   begin
    gotoxy(40,j);
    write(chr(179));
   end;
  textcolor(lightgray);
  gotoxy(38,8);
  write(chr(220), chr(220), chr(220), chr(220), chr(220));
  gotoxy(38,12);
  write(chr(223), chr(223), chr(223), chr(223), chr(223));
  textcolor(lightblue);
  gotoxy(39,9);
  write(chr(219), chr(219), chr(219));
  gotoxy(39,10);
  write(chr(219), chr(219), chr(219));
  gotoxy(39,11);
  write(chr(219), chr(219), chr(219));
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
 end;

procedure MakeBugs;
 var
  x, y : integer;
 begin
  textcolor(lightred);
  for j := 1 to 5 do
   begin
     repeat
      x := random(80)+1;
      y := random(24)+1;
     until not Obj[x,y];
    Obj[x,y] := true;
    BugX[j] := x;
    BugY[j] := y;
    gotoxy(x,y);
    write(chr(15));
    Cursor;
   end;
 end;

function PickBug : integer;
 begin
  PickBug := random(5)+1;
 end;

function BestMove(Bug : integer) : integer;
 var
  x, y : integer;
  XDist, YDist : integer;
 begin
  x := BugX[Bug];
  y := BugY[Bug];
  XDist := 40 - x;
  YDist := 10 - y;
  if abs(YDist) > abs(XDist) then
   begin
    if YDist > 0 then BestMove := 2;
    if YDist < 0 then BestMove := 8;
   end
  else
   begin
    if XDist > 0 then BestMove := 6;
    if XDist < 0 then BestMove := 4;
   end;
  if (x in [36..44]) and ((y = 7) or (y = 13)) then
   if x < 38 then
    if y = 7 then BestMove := 2 else BestMove := 8
   else
  BestMove := 4;
 end;

procedure MoveBug(Bug : integer);
 var
  Dir : integer;
  OX, OY : integer;
  X, Y : integer;
 begin
  Dir := random(10)+1;
  if (Dir = 5) or (Dir = 10) then
   Dir := BestMove(Bug);
  OX := BugX[Bug];
  OY := BugY[Bug];
  X := BugX[Bug];
  Y := BugY[Bug];
   case Dir of
    1 :
     begin
      X := X - 1;
      Y := Y + 1;
     end;
    2 : Y := Y + 1;
    3 :
     begin
      X := X + 1;
      Y := Y + 1;
     end;
    4 : X := X - 1;
    6 : X := X + 1;
    7 :
     begin
      X := X - 1;
      Y := Y - 1;
     end;
    8 : Y := Y - 1;
    9 :
     begin
      X := X + 1;
      Y := Y - 1;
     end;
   end; {case}
  if X > 80 then X := 80;
  if X < 1 then X := 1;
  if Y > 24 then Y := 24;
  if Y < 1 then Y := 1;
  if Obj[X,Y] then
   begin
    X := OX;
    Y := OY;
   end;
  textcolor(lightred);
  gotoxy(OX,OY);
  write(' ');
  gotoxy(X,Y);
  write(chr(15));
  Cursor;
  if (OY <= 7) and (OX = 40) then
   begin
    textcolor(darkgray);
    gotoxy(OX,OY);
    write(chr(179));
    Cursor;
   end;
  BugX[Bug] := X;
  BugY[Bug] := Y;
  Obj[OX,OY] := false;
  Obj[X,Y] := true;
  delay(10);
 end;

function Death(Bug : integer) : boolean;
 var
  x, y : integer;
 begin
  x := BugX[Bug];
  y := BugY[Bug];
  Death := ((x >= 39) and (x <= 41)) and ((y >= 9) and (y <= 11));
 end;

procedure DeadBug(Bug : integer);
 var
  x, y : integer;
 begin
  Obj[BugX[Bug], BugY[Bug]] := false;
  for j := 1 to 3 do
   begin
    textcolor(lightcyan);
    gotoxy(39,9);
    write(chr(219), chr(219), chr(219));
    gotoxy(39,10);
    write(chr(219), chr(219), chr(219));
    gotoxy(39,11);
    write(chr(219), chr(219), chr(219));
    Cursor;
    for k := 1 to 10 do
     begin
      sound(random(150)+1);
      delay(5);
     end;
    textcolor(blue);
    gotoxy(39,9);
    write(chr(219), chr(219), chr(219));
    gotoxy(39,10);
    write(chr(219), chr(219), chr(219));
    gotoxy(39,11);
    write(chr(219), chr(219), chr(219));
    Cursor;
    for k := 1 to 10 do
     begin
      sound(random(150)+1);
      delay(5);
     end;
   end;
  nosound;
  textcolor(blue);
  gotoxy(39,9);
  write(chr(219), chr(219), chr(219));
  gotoxy(39,10);
  write(chr(219), chr(219), chr(219));
  gotoxy(39,11);
  write(chr(219), chr(219), chr(219));
   repeat
     case random(4)+1 of
      1 :
       begin
        x := 1;
        y := random(24)+1;
       end;
      2 :
       begin
        x := 80;
        y := random(24)+1;
       end;
      3 :
       begin
        x := random(80)+1;
        y := 1;
       end;
      4 :
       begin
        x := random(80)+1;
        y := 24;
       end;
     end; {case}
   until not Obj[x,y];
  BugX[Bug] := x;
  BugY[Bug] := y;
  Obj[x,y] := true;
  textcolor(lightred);
  gotoxy(x,y);
  write(chr(15));
  Cursor;
 end;

begin
 Init;
 DrawScreen;
 MakeBugs;
  repeat
   Bug := PickBug;
   MoveBug(Bug);
   if Death(Bug) then DeadBug(Bug);
  until KeyPressed;
 clrscr;
end.




