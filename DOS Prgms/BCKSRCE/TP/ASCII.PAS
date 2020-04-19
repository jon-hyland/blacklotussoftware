{ This program requires CHART.DAT to compile. }

program ASCII;

uses
 Crt;

const
 StartX = 1;
 StartY = 1;
 EndX   = 15;
 EndY   = 10;

var
 x, y : integer;
 j, k : integer;
 Key  : char;
 Chart  : array[1..80, 1..24] of char;
 ChartFile : text;

procedure Init;
 var
  j, k : integer;
 begin
  assign(ChartFile, 'CHART.DAT');
  reset(ChartFile);
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     read(ChartFile, Chart[j,k]);
     if j = 80 then readln(ChartFile);
    end;
  close(ChartFile);
  x := StartX;
  y := StartY;
 end;

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

procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 const
  DelayTime = 20;
 procedure Box(x1, y1, x2, y2 : integer);
  var
   x : integer;
   y : integer;
  begin
   for y := y1 to y2 do
    begin
     gotoxy(x1, y);
     for x := x1 to x2 do
      write(#219);
    end;
   Cursor;
  end;
 var
  j, k : integer;
  ya, yb : integer;
  xa, xb : real;
  Times : integer;
  XInc : real;
 begin
  textcolor(BackColor);
  Times := (y2-y1+1) - trunc((y2-y1+1)/2);
  XInc := ((x2-x1+1)/2) / Times;
  ya := trunc((y2-y1+1)/2+y1);
  yb := ya;
  xa := trunc((x2-x1+1)/2+x1-XInc);
  xb := trunc((x2-x1+1)/2+x1+XInc);
  for j := 1 to Times - 1 do
   begin
    Box(trunc(xa), ya, trunc(xb), yb);
    delay(DelayTime);
    xa := xa - XInc;
    xb := xb + XInc;
    ya := ya - 1;
    yb := yb + 1;
   end;
  textcolor(white);
  textbackground(BackColor);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  gotoxy(x1,y1);
  write(#218);
  gotoxy(x1,y2);
  write(#192);
  for j := x1+1 to x2-1 do
   begin
    gotoxy(j, y1);
    write(#196);
    gotoxy(j,y2);
    write(#196);
   end;
  gotoxy(trunc(x1+((x2-x1+1)-length(Name))/2)-2, y1);
  write(#180, ' ', Name, ' ', #195);
  gotoxy(x2,y1);
  write(#191);
  gotoxy(x2,y2);
  write(#217);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1, k);
    write(#179);
    gotoxy(x2, k);
    write(#179);
   end;
  Cursor;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  Clear;
  DrawWindow(31,6,49,19,1,'ASCII');
  textcolor(lightgray);
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     gotoxy(j+32,k+6);
     write(Chart[j,k]);
    end;
  gotoxy(33, 18);
  write('Char Num : ');
  textcolor(white);
  write('#');
  textcolor(darkgray);
  textbackground(black);
  gotoxy(18,25);
  write('Quick ASCII Chart  v1.0   (c) 1996 Jon Hyland');
 end;

begin
 Init;
 DrawScreen;
  repeat
   textcolor(yellow);
   textbackground(blue);
   gotoxy(x+32,y+6);
   write(Chart[x,y]);
   textcolor(white);
   gotoxy(45,18);
   write('   ');
   gotoxy(45,18);
   write(ord(Chart[x,y]));
   Cursor;
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in ['H','K','P','M', #27];
   if Key <> #27 then
    begin
     textcolor(lightgray);
     textbackground(blue);
     gotoxy(x+32,y+6);
     write(Chart[x,y]);
     Cursor;
    end;
    case Key of
     'H' : y := y - 1;
     'K' : x := x - 1;
     'P' : y := y + 1;
     'M' : x := x + 1;
    end; {case}
   if x > EndX then x := StartX;
   if x < StartX then x := EndX;
   if y > EndY then y := StartY;
   if y < StartY then y := EndY;
  until Key = #27;
 textcolor(white);
 textbackground(black);
 clrscr;
end.