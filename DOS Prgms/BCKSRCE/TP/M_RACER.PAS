program AnimalMazeRace;

uses
 Crt;

type
 ScreenType = array[1..80, 1..23] of boolean;
 LocType    = array[1..5] of integer;

var
 Obj   : ScreenType;
 x     : LocType;
 y     : LocType;
 Dir   : LocType;
 Guy   : integer;
 ox,
 oy    : integer;
 j     : integer;

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
  j, k   : integer;
  OffSet : integer;
  Direc    : integer;
 begin
  randomize;
  OffSet := 0;
  Direc := 1;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
   repeat
    if Direc = 1 then
     for j := 1 + OffSet - 1 to 80 - OffSet do
      if j >= 1 then
       Obj[j,1+OffSet] := true;
    if Direc = 2 then
     for k := 1 + OffSet to 23 - OffSet do
      Obj[80-OffSet,k] := true;
    if Direc = 3 then
     for j := 80 - OffSet downto 1 + OffSet do
      Obj[j,23-OffSet] := true;
    if Direc = 4 then
     for k := 23 - OffSet downto 1 + OffSet + 2 do
      Obj[1+OffSet,k] := true;
    Direc := Direc + 1;
    if Direc > 4 then
     begin
      Direc := 1;
      OffSet := OffSet + 2;
     end;
   until OffSet > 10;
  for j := 1 to 5 do
   begin
    x[j] := 1;
    y[j] := 2;
    Dir[j] := 4;
   end;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  Clear;
  textcolor(darkgray);
  gotoxy(18,25);
  write('Animal Maze Runner  v1.0  (c) 1996 by Jon Hyland');
  textcolor(lightgray);
  for k := 1 to 23 do
   for j := 1 to 80 do
    if Obj[j,k] then
     begin
      gotoxy(j,k);
      write(#176);
     end;
  textcolor(lightgreen);
  gotoxy(69,12);
  write('$');
  textcolor(1);
  gotoxy(x[1], y[1]);
  write('X');
  Cursor;
 end;

function Done : boolean;
 var
  j : integer;
 begin
  Done := false;
  for j := 1 to 5 do
   if (x[j] = 69) and (y[j] = 12) then
    Done := true;
 end;

procedure Wipe;
 const
  Tot = 80 * 25;
 var
  Erased : array[1..80, 1..25] of boolean;
  j, k : integer;
  Count : integer;
 begin
  textcolor(white);
  textbackground(black);
  for k := 1 to 25 do
   for j := 1 to 80 do
    Erased[j,k] := false;
  for Count := 1 to Tot do
   begin
     repeat
      j := random(80)+1;
      k := random(25)+1;
     until not Erased[j,k];
    Erased[j,k] := true;
    if (j <> 80) or (k <> 25) then
     begin
      gotoxy(j,k);
      write(' ');
     end;
   end;
 end;

begin
 Init;
 DrawScreen;
  repeat
   Guy := random(5)+1;
   ox := x[Guy];
   oy := y[Guy];
    case Dir[Guy] of
     1 : x[Guy] := x[Guy] + 1;
     2 : y[Guy] := y[Guy] + 1;
     3 : x[Guy] := x[Guy] - 1;
     4 : y[Guy] := y[Guy] - 1;
    end; {case}
   if Obj[x[Guy], y[Guy]] then
    begin
     Dir[Guy] := Dir[Guy] + 1;
     if Dir[Guy] > 4 then Dir[Guy] := 1;
     x[Guy] := ox;
     y[Guy] := oy;
    end;
   gotoxy(ox,oy);
   write(' ');
   textcolor(Guy);
   gotoxy(x[Guy], y[Guy]);
   write('X');
   Cursor;
   for j := 1 to 5 do
    if (x[j] = ox) and (y[j] = oy) then
     begin
      gotoxy(ox,oy);
      textcolor(j);
      write('X');
      Cursor;
     end;
   if Dir[Guy] in [1,3] then delay(10) else delay(20);
  until Done or KeyPressed;
 if not KeyPressed then
  begin
   for j := 1 to 10 do
    begin
     sound(j*100);
     delay(25);
    end;
   for j := 9 downto 1 do
    begin
     sound(j*100);
     delay(25);
    end;
   nosound;
   Wipe;
  end
 else
  clrscr;
end.