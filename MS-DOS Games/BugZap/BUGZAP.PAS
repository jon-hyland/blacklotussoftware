program BugZapper;

uses
 Crt, Std;

type
 LocType = array[1..25] of integer;
 ObjType = array[1..80, 1..24] of boolean;

var
 BugX,
 BugY,
 BugDir,
 BugColor : LocType;
 Obj      : ObjType;
 Fry      : ObjType;
 Tot      : integer;
 Bug      : integer;
 ox, oy   : integer;
 Zap      : integer;
 j, k     : integer;

{$I BUGZAP.IMG}
procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     gotoxy(j,k);
     SetColor(BugZapColor[j,k]);
     write(BugZapChar[j,k]);
     Obj[j,k] := false;
     Fry[j,k] := false;
    end;
  Tot := random(20)+6;
  for i := 1 to 25 do
   begin
    BugX[i] := 0;
    BugY[i] := 0;
   end;

  for j := 36 to 42 do
   begin
    Obj[j,8] := true;
    Obj[j,13] := true;
   end;
  Obj[36,9] := true;
  Obj[42,9] := true;
  Obj[36,12] := true;
  Obj[42,12] := true;
  for k := 9 to 12 do
   for j := 37 to 41 do
    Fry[j,k] := true;

  for i := 1 to Tot do
   begin
     repeat
      Bug := random(25);
     until BugX[Bug] = 0;
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until (not Obj[j,k]) and (not Fry[j,k]);
    BugX[Bug] := j;
    BugY[Bug] := k;
    BugColor[Bug] := random(15)+1;
    BugDir[Bug] := random(8);
    gotoxy(BugX[Bug], BugY[Bug]);
    textcolor(BugColor[Bug]);
    write(#15);
    Cursor;
   end;
 end;

function GetDir : integer;
 var
  XDif,
  YDif  : integer;
 begin
  if random(5) = 0 then
   BugDir[Bug] := random(8)+1;
  if BugDir[Bug] <= 4 then
   GetDir := BugDir[Bug]
  else
   begin
    XDif := 39 - BugX[Bug];
    YDif := 10 - BugY[Bug];
    if abs(XDif) > abs(YDif) then
     if XDif > 0 then GetDir := 4 else GetDir := 2
    else
     if YDif > 0 then GetDir := 3 else GetDir := 1;
   end;
 end;

procedure NewBug;
 var
  h, i, j, k : integer;
 begin
  if Tot < 25 then
   begin
     repeat
      i := random(25);
     until BugX[i] = 0;
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until (not Obj[j,k]) and (not Fry[j,k]);
    BugX[i] := j;
    BugY[i] := k;
    BugColor[i] := random(15)+1;
    BugDir[i] := random(8);
    gotoxy(BugX[i], BugY[i]);
    textcolor(BugColor[i]);
    write(#15);
    Cursor;
   end;
 end;

begin
 Init;
  repeat
    repeat
     Bug := random(25)+1;
    until BugX[Bug] <> 0;
   ox := BugX[Bug];
   oy := BugY[Bug];
    case GetDir of
     1 : BugY[Bug] := BugY[Bug] - 1;
     2 : BugX[Bug] := BugX[Bug] - 1;
     3 : BugY[Bug] := BugY[Bug] + 1;
     4 : BugX[Bug] := BugX[Bug] + 1;
    end; {case}
   if Obj[BugX[Bug], BugY[Bug]] then
    begin
     BugDir[Bug] := random(8)+1;
     BugX[Bug] := ox;
     BugY[Bug] := oy;
    end;
   if BugX[Bug] > 80 then
    begin
     BugX[Bug] := 80;
     BugDir[Bug] := random(8)+1;
    end;
   if BugX[Bug] < 1 then
    begin
     BugX[Bug] := 1;
     BugDir[Bug] := random(8)+1;
    end;
   if BugY[Bug] > 24 then
    begin
     BugY[Bug] := 24;
     BugDir[Bug] := random(8)+1;
    end;
   if BugY[Bug] < 1 then
    begin
     BugY[Bug] := 1;
     BugDir[Bug] := random(8)+1;
    end;
   if Fry[BugX[Bug], BugY[Bug]] then
    begin
     textcolor(darkgray);
     gotoxy(ox,oy);
     write(BugZapChar[ox,oy]);
     BugX[Bug] := 0;
     BugY[Bug] := 0;
     NewBug;
     Zap := Zap + 25;
    end
   else
    begin
     textcolor(darkgray);
     gotoxy(ox,oy);
     write(BugZapChar[ox,oy]);
     textcolor(BugColor[Bug]);
     gotoxy(BugX[Bug], BugY[Bug]);
     write(#15);
     Cursor;
    end;
   if Zap > 0 then
    begin
     Zap := Zap - 1;
     if (Zap / 2) <> trunc(Zap / 2) then
      begin
       textcolor(white);
       textbackground(lightgray);
      end
     else
      begin
       textcolor(lightblue);
       textbackground(blue);
      end;
     for k := 9 to 12 do
      for j := 37 to 41 do
       begin
        gotoxy(j,k);
        write(BugZapChar[j,k]);
       end;
     Cursor;
     textbackground(black);
     for j := 1 to 5 do
      begin
       sound(random(150)+1);
       delay(1);
      end;
    end
   else
    begin
     nosound;
     delay(5);
    end;
  until KeyPressed;
 FadeOut;
end.