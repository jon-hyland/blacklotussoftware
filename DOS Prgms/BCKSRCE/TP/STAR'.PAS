program ScrnSav;

uses
 Crt, Std;

const
 TotStart = 100;

type
 LocType = array[1..250] of integer;

var
 x, y, xd, yd, c : LocType;

procedure InitStar(Num : integer);
 begin
  x[Num] := 40;
  y[Num] := 12;
   case random(4) of
    0 :
     begin
      xd[Num] := 1;
      yd := random(24)+1;
     end;
    1 :
     begin
      xd[Num] := random(80)+1;
      yd[Num] := 1;
     end;
    2 :
     begin
      xd[Num] := 24;
      yd[Num] := random(24)+1;
     end;
    3 :
     begin
      xd[Num] := random(80)+1;
      yd[Num] := 24;
     end;
   end; {case}
  c[Num] := random(15)+1;
 end;

procedure Init;
 var
  i : integer;
 begin
  randomize;

