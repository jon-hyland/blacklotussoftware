program SpaceBlasters;

uses
 Crt, Std;

const
 StartRocks = 50;
 StartEnemy = 15;

type
 ObjType = array[1..80,1..40] of boolean;
 LocType = array[1..100] of integer;

var
 Obj    : ObjType;
 Ex, Ey,
 Ec     : LocType;
 Enemy  : integer;

procedure Init;
 var
  i, j, k : integer;
 begin
  for k := 1 to 40 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  for i := 1 to StartRocks do
   begin
     repeat
      j := random(80)+1;
      k := random(40)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
   end;
  for i := 1 to StartEnemy do
   begin
