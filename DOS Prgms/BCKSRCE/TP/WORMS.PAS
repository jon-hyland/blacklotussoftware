program LotsaWorms;

uses
 Crt;

type
 WormType = array[1..25] of integer;

var
 WormY      : array[1..10] of WormType;
 WormX      : array[1..10] of WormType;
 WormLength : array[1..10] of integer;
 WormColor  : array[1..10] of integer;
 WormDir    : array[1..10] of integer;
 WormNum    : integer;
 GoodMove   : boolean;
 NewX,
 NewY       : integer;
 j          : integer;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Init;
 var
  j, k      : integer;
  ColorUsed : array[1..15] of boolean;
  GoodMove  : boolean;
 begin
  randomize;
  Clear;
  for j := 1 to 15 do
   ColorUsed[j] := false;
  for j := 1 to 10 do
   begin
    WormLength[j] := random(5)+6;
    WormDir[j] := random(4)+1;
     repeat
      WormColor[j] := random(15)+1;
     until not ColorUsed[WormColor[j]];
    ColorUsed[WormColor[j]] := true;
    WormX[j][1] := random(40)+1;
    WormY[j][1] := random(24)+1;
    for k := 2 to WormLength[j] do
     begin
       repeat
        GoodMove := true;
        WormX[j][k] := WormX[j][k-1];
        WormY[j][k] := WormY[j][k-1];
         case random(4) of
          1 : WormX[j][k] := WormX[j][k-1] - 1;
          2 : WormX[j][k] := WormX[j][k-1] + 1;
          3 : WormY[j][k] := WormY[j][k-1] - 1;
          4 : WormY[j][k] := WormY[j][k-1] + 1;
         end; {case}
        if WormX[j][k] > 40 then GoodMove := false;
        if WormX[j][k] < 1 then GoodMove := false;
        if WormY[j][k] > 24 then GoodMove := false;
        if WormY[j][k] < 1 then GoodMove := false;
       until GoodMove;
     end;
    textcolor(WormColor[j]);
    for k := WormLength[j] downto 1 do
     begin
      gotoxy((WormX[j][k]*2)-1, WormY[j][k]);
       case k of
        1     : write(#219, #219);
        2..10 : write(#178, #178);
       end; {case}
     end;
    Cursor;
   end;
 end;

function SpotColor(x, y : integer) : integer;
 var
  Worm   : integer;
  Seg    : integer;
  Found  : boolean;
 begin
  Found := false;
  if not Found then
   for Worm := 1 to 10 do
    for Seg := 1 to WormLength[Worm] do
     if (WormX[Worm][Seg] = x) and (WormY[Worm][Seg] = y) then
      SpotColor := WormColor[Worm];
  if not Found then SpotColor := 0;
 end;

begin
 Init;
  repeat
   WormNum := random(10)+1;
    repeat
     GoodMove := true;
     NewX := WormX[WormNum][1];
     NewY := WormY[WormNum][1];
     if random(10) = 0 then WormDir[WormNum] := random(4)+1;
      case WormDir[WormNum] of
       1 : NewY := NewY - 1;
       2 : NewX := NewX - 1;
       3 : NewY := NewY + 1;
       4 : NewX := NewX + 1;
      end; {case}
     if NewX > 40 then GoodMove := false;
     if NewX < 1 then GoodMove := false;
     if NewY > 24 then GoodMove := false;
     if NewY < 1 then GoodMove := false;
     if not GoodMove then WormDir[WormNum] := random(4)+1;
    until GoodMove;
   textcolor(SpotColor(WormX[WormNum][WormLength[WormNum]],
    WormY[WormNum][WormLength[WormNum]]));
   gotoxy((WormX[WormNum][WormLength[WormNum]]*2)-1, WormY[WormNum][WormLength[WormNum]]);
   write(#219, #219);
   for j := WormLength[WormNum] downto 2 do
    begin
     WormX[WormNum][j] := WormX[WormNum][j-1];
     WormY[WormNum][j] := WormY[WormNum][j-1];
    end;
   textcolor(WormColor[WormNum]);
   gotoxy((WormX[WormNum][2]*2)-1, WormY[WormNum][2]);
   write(#178, #178);
   gotoxy((WormX[WormNum][1]*2)-1, WormY[WormNum][2]);
   write(#219, #219);
   Cursor;

   readkey;

  until KeyPressed;

end.