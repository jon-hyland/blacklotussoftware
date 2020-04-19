program DropCrap;

uses
 Crt;

type
 ScreenType = array[1..5, 1..5] of integer;

var
 Obj : ScreenType;
 Color : integer;

procedure Init;
 var
  j, k : integer;
 begin
  for k := 1 to 24 do
   for j := 1 to 80 do
    ScreenType[j,k] := 0;

