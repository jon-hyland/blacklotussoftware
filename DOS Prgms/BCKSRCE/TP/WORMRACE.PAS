program WormRacer;

uses
 Crt, Std;

type
 ObjType = array[1..40, 1..24] of integer;
 LocType = array[1..7, 1..10] of integer;
 InfType = array[1..7] of integer;

var
 Obj   : ObjType;
 WormX,
 WormY : LocType;
 Len   : InfType;
 Num   : integer;

function DirOf(Num : integer) : integer;
 begin
  if WormY[Num, 1] < WormY[Num, 2] then DirOf := 1;
  if WormX[Num, 1] < WormX[Num, 2] then DirOf := 2;
  if WormY[Num, 1] > WormY[Num, 2] then DirOf := 3;
  if WormX[Num, 1] > WormX[Num, 2] then DirOf := 4;
 end;


procedure MasterReset;
 var
  h, i, j, k : integer;
  ox, oy     : integer;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 40 do
    Obj[j,k] := 0;
  for i := 1 to 7 do
   for h := 1 to 10 do
    begin
      repeat
       j := random(40)+1;
       k := random(24)+1;
      until Obj[j,k] = 0;
     Obj[j,k] := i;
     textcolor(i);
     gotoxy((j-1)*2, k);
     write(#222, #221);
     Cursor;
    end;
  for i := 1 to 7 do
   begin
     repeat
      WormX[i, 1] := random(40)+1;
      WormY[i, 1] := random(24)+1;
     until Obj[WormX[i, 1], WormY[i, 1]] = 0;
    Len[i] := 1;
    textcolor(yellow);
    textbackground(i);
    gotoxy((WormX[i, 1]-1)*2, WormY[i, 1]);
    if DirOf(i) in [1, 3] then
     write(#249, #249);
    if DirOf(i) = 2 then
     write(': ');
    if DirOf(i) = 4 then
     write(' :');
    Cursor;
   end;
 end;

begin
 MasterReset;

 readkey;
end.