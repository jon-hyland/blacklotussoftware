program CheapBlaster;

uses
 Crt, Std, Dos;

const
 TotShip = 25;

type
 ObjType  = array[1..80, 1..24] of boolean;
 LocType  = array[1..100] of integer;

var
 En  : ObjType;
 Shp : ObjType;
 EnX : LocType;
 EnY : LocType;
 EnC : LocType;
 Tot   : integer;
 x     : integer;


procedure DrawShip(x : integer);
 var
  j : integer;
 begin
  Shp[x,22] := true;
  for j := x-2 to x+2 do
   Shp[j,23] := true;
  Shp[x,24] := true;
  textcolor(lightgray);
  gotoxy(x, 22);
  write(#220);
  gotoxy(x-2, 23);
  write(#222, #220, #219, #220, #221);
  gotoxy(x, 24);
  write(#223);
  Cursor;
 end;

procedure EraseShip(x : integer);
 var
  j : integer;
 begin
  Shp[x,22] := false;
  for j := x-2 to x+2 do
   Shp[j,23] := false;
  Shp[x,24] := false;
  textcolor(black);
  gotoxy(x, 22);
  write(' ');
  gotoxy(x-2, 23);
  write('     ');
  gotoxy(x, 24);
  write(' ');
  Cursor;
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     En[j,k] := false;
     Shp[j,k] := false;
    end;
  for i := 1 to TotShip do
   begin
     repeat
      EnX[i] := random(80)+1;
      EnY[i] := random(20)+1;
     until not En[EnX[i], EnY[i]];
    En[EnX[i], EnY[i]] := true;
    gotoxy(EnX[i], EnY[i]);
    EnC[i] := random(15)+1;
    textcolor(EnC[i]);
    write('*');
    Cursor;
   end;
  x := random(76)+3;
  DrawShip(x);
  readkey; {}
 end;



begin
 BlackLotusIntro;
 Init;
  repeat




end.
