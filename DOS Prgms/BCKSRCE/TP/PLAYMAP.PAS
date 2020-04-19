 program PlayGame;

uses
 Crt;

type
 MapType = record
   Name   : string[25];
   Char   : array[1..78, 1..18] of char;
   Color  : array[1..78, 1..18] of integer;
   BColor : array[1..78, 1..18] of integer;
   Solid  : array[1..78, 1..18] of boolean;
  end;

const
 MapStartX = 3;
 MapStartY = 5;
 StartX    = 69;
 StartY    = 17;

var
 Map     : MapType;
 MapFile : file of MapType;
 x, y    : integer;
 Key     : char;
 MapX,
 MapY    : integer;
 Quit    : boolean;
 OldX,
 OldY    : integer;
 OldMapX,
 OldMapY : integer;
 Dir     : integer;
 BadMove : boolean;
 NewMap  : boolean;

procedure ReadMap(MapX, MapY : integer);
 var
  j, k : integer;
  JunkMap : MapType;
 begin
  reset(MapFile);
  for k := 1 to (MapY-1) do
   for j := 1 to 5 do
    read(MapFile, JunkMap);
  for j := 1 to (MapX-1) do
   read(MapFile, JunkMap);
  read(MapFile, Map);
  close(MapFile);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure DrawMap;
 var
  Screen : array[1..78, 1..18] of boolean;
  i, j, k : integer;
  Tot : integer;
 begin
  Tot := 78 * 18;
  for k := 1 to 18 do
   for j := 1 to 78 do
    Screen[j,k] := false;
  for i := 1 to Tot do
   begin
     repeat
      j := random(78)+1;
      k := random(18)+1;
     until not Screen[j,k];
    Screen[j,k] := true;
    gotoxy(j+1,k+1);
    textcolor(Map.Color[j,k]);
    textbackground(Map.BColor[j,k]);
    write(Map.Char[j,k]);
    Cursor;
    if (i/2) = (trunc(i)) then delay(1);
   end;
 end;

procedure FadeOut;
 const
  XInc = (80 / 24);
 var
  i, j, k : integer;
  xa, xb : real;
  ya, yb : integer;
 begin
  ya := 1;
  yb := 24;
  xa := 1;
  xb := 80;
  textcolor(black);
  gotoxy(2,25);
  for j := 1 to 78 do
   write(#219);
  for i := 1 to 12 do
   begin
    for j := 1 to 80 do
     begin
      gotoxy(j,ya);
      write(#219);
      gotoxy(j,yb);
      write(#219);
      Cursor;
     end;
    ya := ya + 1;
    yb := yb - 1;
    for k := ya to yb do
     begin
      for j := trunc(xa) to trunc(xa + XInc) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
      for j := trunc(xb - XInc) to trunc(xb) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
     end;
    xa := xa + XInc;
    xb := xb - XInc;
    delay(15);
   end;
  textcolor(white);
  textbackground(black);
  clrscr;
 end;

procedure DrawGuy;
 begin
  textcolor(Map.Color[OldX,OldY]);
  textbackground(Map.BColor[OldX,OldY]);
  gotoxy(OldX+1, OldY+1);
  write(Map.Char[OldX, OldY]);
  Cursor;
  textcolor(white);
  textbackground(Map.BColor[x,y]);
  gotoxy(x+1, y+1);
  write(#234);
  Cursor;
 end;

procedure Init;
 var
  j, k : integer;
 begin
  randomize;
  x := StartX;
  y := StartY;
  assign(MapFile, 'EDITMAP.DAT');
  MapX := MapStartX;
  MapY := MapStartY;
  ReadMap(MapX,MapY);
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  gotoxy(1,1);
  textcolor(white);
  write(#218);
  gotoxy(80,1);
  write(#191);
  gotoxy(2,1);
  for j := 2 to 79 do
   write(#196);
  for k := 2 to 19 do
   begin
    gotoxy(1,k);
    write(#179);
    gotoxy(80,k);
    write(#179);
   end;
  gotoxy(1,20);
  write(#192);
  gotoxy(80,20);
  write(#217);
  gotoxy(2,20);
  for j := 2 to 79 do
   write(#196);
  DrawMap;
  textcolor(white);
  textbackground(Map.BColor[x,y]);
  gotoxy(x+1,y+1);
  write(#234);
  Cursor;
  Quit := false;
  Dir := 0;
 end;

begin
 Init;
  repeat
    repeat
     OldMapX := MapX;
     OldMapY := MapY;
     OldX := x;
     OldY := y;
     BadMove := false;
      case Dir of
       1 : y := y - 1;
       2 : x := x - 1;
       3 : y := y + 1;
       4 : x := x + 1;
      end; {case}
     if x > 78 then
      begin
       if MapX <> 5 then
        begin
         MapX := MapX + 1;
         x := 1;
        end
       else
        BadMove := true;
      end;
     if x < 1 then
      begin
       if MapX <> 1 then
        begin
         MapX := MapX - 1;
         x := 78;
        end
       else
        BadMove := true;
      end;
     if y > 18 then
      begin
       if MapY <> 5 then
        begin
         MapY := MapY + 1;
         y := 1;
        end
       else
        BadMove := true;
      end;
     if y < 1 then
      begin
       if MapY <> 1 then
        begin
         MapY := MapY - 1;
         y := 18;
        end
       else
        BadMove := true;
      end;
     NewMap := ((MapX <> OldMapX) or (MapY <> OldMapY));
     if NewMap then
      ReadMap(MapX, MapY);
     if Map.Solid[x,y] then
      BadMove := true;
     if BadMove then
      begin
       x := OldX;
       y := OldY;
       if NewMap then
        begin
         MapX := OldMapX;
         MapY := OldMapY;
         ReadMap(MapX, MapY);
        end;
      end
     else
      if Dir <> 0 then DrawGuy;
       case Dir of
        1, 3 : delay(120);
        2, 4 : delay(75);
       end; {case}
    until KeyPressed or NewMap;
   if KeyPressed then
    begin
      repeat
       Key := readkey;
      until not KeyPressed;
      case Key of
       'H' : if Dir <> 1 then Dir := 1 else Dir := 0;
       'K' : if Dir <> 2 then Dir := 2 else Dir := 0;
       'P' : if Dir <> 3 then Dir := 3 else Dir := 0;
       'M' : if Dir <> 4 then Dir := 4 else Dir := 0;
       #27 : Quit := true;
      end; {case}
    end;
   if NewMap then
    begin
     DrawMap;
     DrawGuy;
     Dir := 0;
    end;
  until Quit;
 FadeOut;
end.



