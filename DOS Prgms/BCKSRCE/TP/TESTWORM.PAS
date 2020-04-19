program ControlWorm;

uses
 Crt;

type
 ObjType = array[1..40, 1..24] of boolean;
 CoorType = array[1..25] of integer;

var
 Obj : ObjType;
 WormObj : ObjType;
 WormX : CoorType;
 WormY : CoorType;
 Segs : integer;
 Key : char;
 Done : boolean;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  Clear;
  Segs := 10;
  k := random(24)+1;
  j := random(10)+1;
  textcolor(yellow);
  textbackground(darkgreen);
  for i := 1 to Segs do
   begin
    WormX[i] := i + j;
    WormY[i] := k;
    gotoxy(WormX[i]*2-1, WormY[i]);
    if i <> 1 then write('  ') else write(chr(249));
    Cursor;
   end;






