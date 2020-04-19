program RunGame;

uses
 Crt;

type
 ObjType = array[1..80,1..24] of boolean;
 EnemyType = array[1..5] of shortint;

const
 TotObj = 100;
 DelayTime = 50;

var
 Obj    : ObjType;
 EnemyX : EnemyType;
 EnemyY : EnemyType;
 x, y   : integer;
 Key    : char;
 i,j,k  : integer;
 Dead,
 Quit   : boolean;
 Dir    : integer;
 ex, ey : integer;
 ox, oy : integer;
 Move   : integer;

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

procedure Title;
 begin
  Clear;
  gotoxy(35,10);
  write('- Dumb Run Game  v1.0 -');
  gotoxy(30,12);
  write('(c) 1996 Hyland Productions');
  Cursor;
  readkey;
 end;

procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  textcolor(yellow);
  for i := 1 to TotObj do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    gotoxy(j,k);
    write(#249);
    Cursor;
   end;
  textcolor(yellow);
  for i := 1 to 5 do
   begin
     repeat
      EnemyX[i] := random(80)+1;
      EnemyY[i] := random(24)+1;
     until not Obj[EnemyX[i],EnemyY[i]];
    Obj[EnemyX[i], EnemyY[i]] := true;
    gotoxy(EnemyX[i], EnemyY[i]);
    write(#157);
    Cursor;
   end;
   repeat
    x := random(80)+1;
    y := random(24)+1;
   until not Obj[x,y];
  textcolor(lightblue);
  gotoxy(x,y);
  write(#234);
  Cursor;
  for i := 1 to 5 do
   Obj[EnemyX[i], EnemyY[i]] := false;
  Dead := false;
  Quit := false;
  Dir := 0;
 end;

procedure DelayCancel(Count : integer);
 var
  i : integer;
 begin
  i := 0;
  while (not KeyPressed) and (i < Count) do
   begin
    i := i + 1;
    delay(2);
   end;
 end;

function GoodMove(ex, ey : integer) : integer;
 var
  XDif, YDif : integer;
 begin
  XDif := x - ex;
  YDif := y - ey;
  if abs(XDif) >= abs(YDif) then
   if XDif > 0 then
    GoodMove := 4
   else
    GoodMove := 2
  else
   if YDif > 0 then
    GoodMove := 3
   else
    GoodMove := 1;
 end;

begin
 Title;
 Init;
  repeat
   if KeyPressed then
    begin
      repeat
       Key := readkey;
      until not KeyPressed;
      case Key of
       #27 : Quit := true;
       'H' : if Dir <> 1 then Dir := 1 else Dir := 0;
       'K' : if Dir <> 2 then Dir := 2 else Dir := 0;
       'P' : if Dir <> 3 then Dir := 3 else Dir := 0;
       'M' : if Dir <> 4 then Dir := 4 else Dir := 0;
      end; {case}
    end;
   ox := x;
   oy := y;
    case Dir of
     1 : y := y - 1;
     2 : x := x - 1;
     3 : y := y + 1;
     4 : x := x + 1;
    end; {case}
   if x > 80 then x := 1;
   if x < 1 then x := 80;
   if y > 24 then y := 1;
   if y < 1 then y := 24;
   if Obj[x,y] then
    begin
     x := ox;
     y := oy;
     Dir := 0;
    end;
   if Dir <> 0 then
    begin
     textcolor(lightblue);
     gotoxy(ox,oy);
     write(' ');
     gotoxy(x,y);
     write(#234);
    end;
   for i := 1 to 5 do
    if (x = EnemyX[i]) and (y = EnemyY[i])
     then Dead := true;
   if (not Dead) or (not Quit) then
    begin
     for i := 1 to 5 do
      begin
       ex := EnemyX[i];
       ey := EnemyY[i];
       ox := ex;
       oy := ey;
       Move := random(5);
       if Move > 2 then
        Move := random(5)+1
       else
        Move := GoodMove(ex,ey);
        case Move of
         1 : ey := ey - 1;
         2 : ex := ex - 1;
         3 : ey := ey + 1;
         4 : ex := ex + 1;
        end; {case}
       if ex > 80 then ex := 80;
       if ex < 1 then ex := 1;
       if ey > 24 then ey := 24;
       if ey < 1 then ey := 1;
       if Obj[ex,ey] then
        begin
         ex := ox;
         ey := oy;
        end;
       textcolor(lightred);
       gotoxy(ox,oy);
       write(' ');
       gotoxy(ex,ey);
       write(#157);
       Cursor;
       EnemyX[i] := ex;
       EnemyY[i] := ey;
      end;
    end;
   DelayCancel(DelayTime);
  until Dead or Quit;
 if Dead then
  begin
   for j := 1 to 200 do
    begin
     sound(random(1000)+1);
     delay(1);
    end;
   end
  else
   begin
    for j := 1 to 10 do
     begin
      sound(j * 100);
      delay(10);
     end;
    for j := 9 downto 1 do
     begin
      sound(j * 100);
      delay(10);
     end;
   end;
 nosound;
 clrscr;
end.


