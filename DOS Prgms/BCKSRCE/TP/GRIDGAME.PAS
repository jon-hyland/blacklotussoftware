program GridGame;

uses
 Crt;

type
 GridType = record
   Solid : array[1..5, 1..5] of boolean;
   Color : array[1..5, 1..5] of integer;
  end;

var
 Grid  : GridType;
 x, y  : integer;
 ox,oy : integer;
 nx,ny : integer;
 Turns : integer;
 Quit  : boolean;
 Key   : char;
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
  j, k : integer;
  rx, ry : integer;
 begin
  randomize;
  Turns := 0;
  for k := 1 to 5 do
   for j := 1 to 5 do
    Grid.Solid[j,k] := false;
  Clear;
  for k := 1 to 5 do
   for j := 1 to 5 do
    begin
      repeat
       rx := random(5)+1;
       ry := random(5)+1;
      until not Grid.Solid[rx,ry];
     Grid.Solid[rx,ry] := true;
     if ((rx <> 1) or (ry <> 1)) then
      begin
        case k of
         1 : Grid.Color[rx,ry] := 9;
         2 : Grid.Color[rx,ry] := 12;
         3 : Grid.Color[rx,ry] := 14;
         4 : Grid.Color[rx,ry] := 10;
         5 : Grid.Color[rx,ry] := 13;
        end; {case}
       textcolor(Grid.Color[rx,ry]);
       gotoxy((rx*5)+24, (ry*2)+3);
       write(#219, #219, #219, #219, #219);
       gotoxy((rx*5)+24, (ry*2)+4);
       write(#219, #219, #219, #219, #219);
       Cursor;
      end;
    end;
  Grid.Solid[1,1] := false;
  textcolor(white);
  gotoxy(34,16);
  write('Grid Game  v1.0');
  gotoxy(36,18);
  write('Turns : 0');
  x := 2;
  y := 1;
  Quit := false;
 end;

function CanMove : boolean;
 var
  Empty : boolean;
 begin
  Empty := false;
  if y-1 in [1..5] then
   if not Grid.Solid[x,y-1] then
    Empty := true;
  if x-1 in [1..5] then
   if not Grid.Solid[x-1,y] then
    Empty := true;
  if x+1 in [1..5] then
   if not Grid.Solid[x+1,y] then
    Empty := true;
  if y+1 in [1..5] then
   if not Grid.Solid[x,y+1] then
    Empty := true;
  CanMove := Empty;
 end;

procedure GetEmpty(var x, y : integer);
 var
  j, k : integer;
  Empty : boolean;
 begin
  if y-1 in [1..5] then
   if not Grid.Solid[x,y-1] then
    begin
     x := x;
     y := y-1;
    end;
  if x-1 in [1..5] then
   if not Grid.Solid[x-1,y] then
    begin
     x := x-1;
     y := y;
    end;
  if x+1 in [1..5] then
   if not Grid.Solid[x+1,y] then
    begin
     x := x+1;
     y := y;
    end;
  if y+1 in [1..5] then
   if not Grid.Solid[x,y+1] then
    begin
     x := x;
     y := y+1;
    end;
 end;

function Done : boolean;
 var
  j, k      : integer;
  Bad       : boolean;
  LineColor : integer;
 begin
  Bad := false;
  for k := 1 to 5 do
   begin
    if Grid.Solid[1,k] then
     LineColor := Grid.Color[1,k]
    else
     LineColor := Grid.Color[2,k];
    for j := 2 to 5 do
     if (Grid.Color[j,k] <> LineColor) and (Grid.Solid[j,k]) then
      Bad := true;
   end;
  Done := not Bad;
 end;

begin
 Init;
  repeat
   textcolor(Grid.Color[x,y]);
   gotoxy((x*5)+26, (y*2)+3);
   write(#223);
   gotoxy((x*5)+26, (y*2)+4);
   write(#220);
   Cursor;
    repeat
     Key := readkey;
    until Key in ['H','K','P','M',#13,#27,';'];
   ox := x;
   oy := y;
    case Key of
     'H' : y := y - 1;
     'K' : x := x - 1;
     'P' : y := y + 1;
     'M' : x := x + 1;
     #27 : Quit := true;
     #13 :
      if CanMove then
       begin
        GetEmpty(nx,ny);
        Grid.Solid[nx,ny] := true;
        Grid.Color[nx,ny] := Grid.Color[x,y];
        Grid.Solid[x,y] := false;
        Grid.Color[x,y] := 0;
        textcolor(black);
        gotoxy((x*5)+24, (y*2)+3);
        write(#219, #219, #219, #219, #219);
        gotoxy((x*5)+24, (y*2)+4);
        write(#219, #219, #219, #219, #219);
        textcolor(Grid.Color[nx,ny]);
        gotoxy((nx*5)+24, (ny*2)+3);
        write(#219, #219, #219, #219, #219);
        gotoxy((nx*5)+24, (ny*2)+4);
        write(#219, #219, #219, #219, #219);
        Turns := Turns + 1;
        textcolor(white);
        gotoxy(44,18);
        write(Turns);
        Cursor;
        x := nx;
        y := ny;
       end;
    end; {case}
   if x > 5 then x := 1;
   if x < 1 then x := 5;
   if y < 1 then y := 5;
   if y > 5 then y := 1;
   if not Grid.Solid[x,y] then
    begin
      case Key of
       'H' : y := y - 1;
       'K' : x := x - 1;
       'P' : y := y + 1;
       'M' : x := x + 1;
       #27 : Quit := true;
      end; {case}
     if x > 5 then x := 1;
     if x < 1 then x := 5;
     if y < 1 then y := 5;
     if y > 5 then y := 1;
    end;
   if (x <> ox) or (y <> oy) then
    begin
     textcolor(Grid.Color[ox,oy]);
     gotoxy((ox*5)+26, (oy*2)+3);
     write(#219);
     gotoxy((ox*5)+26, (oy*2)+4);
     write(#219);
     Cursor;
    end;
  until Quit or Done;
 if Done then
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
   readkey;
  end;
 clrscr;
end.
