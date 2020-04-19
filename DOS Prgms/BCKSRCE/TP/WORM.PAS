program Worm;

uses
 Crt;

type
 ScreenType = array[1..80, 1..24] of boolean;
 WormType = array[1..50] of integer;

var
 Bomb : ScreenType;
 Coin : ScreenType;
 CoinsLeft : integer;
 Level : integer;
 Dead : boolean;
 WormX : WormType;
 WormY : WormType;
 WormLength : integer;

procedure Init;
 var
  j, k : integer;
 begin
  randomize;
  textcolor(white);
  textbackground(black);
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     Bomb[j,k] := false;
     Coin[j,k] := false;
    end;
  for j := 1 to 50 do
   begin
    WormX[j] := 0;
    WormY[j] := 0;
   end;
  Dead := false;
  Level := 1;
 end;

procedure Level;
 var
  TotStuff : integer;
  j : integer;
  x, y : integer;

 function WormTouchCoin : boolean;
  var
   j : integer;
  begin
   WormToughCoin := false;
   for j := 1 to WormLength do
    if Coin[WormX[j], WormY[j]] then WormTouchCoin := true;
  end;

 begin
  TotStuff := Level * 5;
  CoinsLeft := TotStuff;
  WormLength := TotStuff;
  textcolor(yellow);
  for j := 1 to CoinsLeft do
   begin
    x := random(80)+1;
    y := random(24)+1;
    Coin[x, y] := true;
    gotoxy(x,y);
    write('o');
   end;
   repeat
    x := random(80)+1;
    y := random(24 - WormLength)+1;
    WormX[1] := x;
    WormY[1] := y;
    for j := 2 to WormLength do
     begin
      WormX[j] := WormX[1];
      WormY[j] := (WormY[j-1] + 1);
     end;
   until not WormTouchCoin;



