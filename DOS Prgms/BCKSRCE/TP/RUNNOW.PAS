program RunGame;

uses
 Crt, Std;

const
 VerNum  = 'v1.0';
 TotRock = 75;
 TotEn   = 10;

type
 ObjType = array[1..80, 1..24] of boolean;
 EnLocType = array[1..100] of integer;

var
 Obj       : ObjType;
 EnX, EnY,
 EnDr      : EnLocType;
 x, y      : integer;
 Key       : char;


procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  for i := 1 to TotRock do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    gotosy)j,k);
    write(#176);
    Cursor;
   end;
  for i := 1 to TotEn do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    EnX[i] := j;
    EnY[i] := k;
    EnDr[i] := random(9)+1;
    gotoxy(j,k);
    write('X');
    Cursor;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until not Obj[x,y];
  gotoxy(j,k);
  write(#234);
  Cursor;
 end;

begin
 BlackLotusIntro;
 Init;
  repeat
   while not Keypressed do {Enemys move}
    begin
    end;
   Key := readkey;
    case Key of
     #0 :
      begin
       Key := readkey;
        case Key of
         'H' : Dir := 8;
         'K' :




