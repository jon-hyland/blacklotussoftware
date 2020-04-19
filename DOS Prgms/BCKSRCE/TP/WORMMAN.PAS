program Worm;

uses
 Crt, Std;

const
 Rocks   = 10;
 StLen   = 5;
 DelTime = 25;

type
 ObjType = array[1..40, 1..24] of boolean;
 InfType = array[1..40, 1..24] of integer;
 LocType = array[1..25] of integer;

var
 Rock      : ObjType;
 Seg       : ObjType;
 SegFClr   : InfType;
 SegBClr   : InfType;
 SegShade  : InfType;
 Segs      : integer;
 Tot       : integer;
 X, Y,
 FColor,
 BColor,
 Shade  : LocType;
 nx, ny : integer;
 i      : integer;
 Dir    : integer;

procedure Init;
 var
  i, j, k : integer;
  DirP    : integer;
  nx, ny  : integer;
  GoodPos : boolean;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 40 do
    Rock[j,k] := false;
  textcolor(darkgray);
  textbackground(lightgray);
  for i := 1 to Rocks do
   begin
     repeat
      j := random(40)+1;
      k := random(24)+1;
     until not Rock[j,k];
    Rock[j,k] := true;
    gotoxy(j*2-1,k);
    write(#220, #223);
    Cursor;
   end;
  Segs := 25 - StLen;
  for i := 1 to Segs do
   begin
     repeat
      j := random(40)+1;
      k := random(24)+1;
     until (not Rock[j,k]) and (not Seg[j,k]);
     repeat
      SegFClr[j,k] := random(15)+1;
      SegBClr[j,k] := random(7);
     until not (SegFClr[j,k] in [7..8]);
    SegShade[j,k] := random(3)+1;
    textcolor(SegFClr[j,k]);
    textbackground(SegBClr[j,k]);
    gotoxy(j*2-1,k);
    write(chr(175+SegShade[j,k]), chr(175+SegShade[j,k]));
    Cursor;
   end;
  DirP := random(4)+1;
   repeat
    j := random(40)+1;
    k := random(24)+1;
   until (not Rock[j,k]) and (not Seg[j,k]);
  for i := StLen downto 1 do
   begin
     repeat
      FColor[i] := random(15)+1;
     until not (FColor[i] in [7..8]);
    BColor[i] := random(7);
    Shade[i] := random(3)+1;
    if i = 1 then
     begin
      if FColor[01] = BColor[1] then FColor[1] := 15;
      Shade[1] := 75;
     end;
    gotoxy(j*2-1,k);
    textcolor(FColor[i]);
    textbackground(BColor[i]);
    write(chr(175+Shade[i]), chr(175+Shade[i]));
    Cursor;
     repeat
      nx := j;
      ny := k;
       case DirP of
        1 : ny := ny - 1;
        2 : nx := nx + 1;
        3 : ny := ny + 1;
        4 : nx := nx - 1;
       end; {case}
      if nx < 1 then nx := 40;
      if nx > 40 then nx := 1;
      if ny < 1 then ny := 24;
      if ny > 24 then ny := 1;
      GoodPos := true;
      if Rock[j,k] or Seg[j,k] then
       begin
        GoodPos := false;
        DirP := random(4)+1;
       end;
     until GoodPos;
    X[i] := nx;
    Y[i] := ny;
    j := nx;
    k := ny;
   end;
  Tot := StLen;
  Dir := random(4)+1;
 end;

begin
 BlackLotusIntro;
 Init;
  repeat
    repeat
     nx := X[1];
     ny := Y[1];
      case Dir of
       1 : ny := ny - 1;
       2 : nx := nx + 1;
       3 : ny := ny + 1;
       4 : nx := nx - 1;
      end; {case}
     if nx > 40 then nx := 1;
     if nx < 1 then nx := 40;
     if ny > 24 then ny := 1;
     if ny < 1 then ny := 24;
     if Rock[nx,ny] then
      Dir := random(4)+1;
    until not Rock[nx,ny];
   if Seg[nx,ny] then
    begin
     Tot := Tot + 1;
     FColor[Tot] := SegFClr[nx,ny];
     BColor[Tot] := SegBClr[nx,ny];
     Shade[Tot] := SegShade[nx,ny];
    end;
   textcolor(white);
   textbackground(black);
   gotoxy(X[Tot]*2-1,Y[Tot]);
   write('  ');
   for i := Tot downto 2 do
    begin
     X[Tot] := X[Tot-1];
     Y[Tot] := Y[Tot-1];
     gotoxy(X[Tot]*2-1, Y[Tot]);
     textcolor(FColor[Tot]);
     textbackground(BColor[Tot]);
     write(chr(175+Shade[Tot]), chr(175+Shade[Tot]));
     Cursor;
    end;
   X[1] := nx;
   Y[1] := ny;
   gotoxy(X[1]*2-1, Y[1]);
   textcolor(FColor[1]);
   textbackground(BColor[1]);
   write(chr(150+Shade[1]), chr(150+Shade[1]));
   Cursor;
   delay(DelTime);
  until KeyPressed;
 FadeOut;
end.


