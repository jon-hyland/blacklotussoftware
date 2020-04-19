program AnarchistCookbookReader_v1_0;

uses
 Crt;

type
 AnaType = record
   StartLine : integer;
   Cha : array[1..80, 1..250] of char;
  end;

var
 Ana     : AnaType;
 AnaFile : text;

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

procedure ClearAna;
 var
  j, k : integer;
 begin
  for k := 1 to 250 do
   for j := 1 to 80 do
    Ana.Cha[j,k] := ' ';
  Ana.StartLine := 0;
 end;

procedure Init;
 begin
  assign(AnaFile, 'C:\ANARCHY\ANARCHY.TXT');
  ClearAna;
 end;

procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 const
  DelayTime = 40;
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
  j, k   : integer;
  ya, yb : integer;
  xa, xb : real;
  Times  : integer;
  XInc   : real;
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

procedure FadeOut;
 const
  XInc = (80 / 24);
 var
  i, j, k : integer;
  xa, xb  : real;
  ya, yb  : integer;
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
      Cursor;
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

procedure Title;
 var
  j, k : integer;
 begin
  Clear;
  DrawWindow(25,8,58,17,4,'Info');
  textcolor(yellow);
  gotoxy(27,9);
  write('Anarchist Cookbook Reader v1.0');
  gotoxy(31,10);
  write('(c) 1996 Death Slayer');
  textcolor(lightgray);
  gotoxy(28,12);
  write('This program was written to');
  gotoxy(28,13);
  write('view ANARCHY.TXT, compiled');
  gotoxy(28,14);
  write('from seperate DOC files put');
  gotoxy(28,15);
  write('together by Exodus from the');
  gotoxy(28,16);
  write('Black Gate BBS.');
  Cursor;
  readkey;
  textcolor(white);
  textbackground(black);
  for k := 8 to 17 do
   for j := 25 to 58 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
 end;

procedure LoadAnaAtLine(Line : integer);
 var
  j, k  : integer;
  RCha  : char;
 begin
  reset(AnaFile);
  ClearAna;
  for k := 1 to Line - 1 do
   readln(AnaFile);
  Ana.StartLine := Line;
  j := 1;
  k := 1;
   repeat
    read(AnaFile, RCha);
     case RCha of
      #13 : k := k + 1;
      #10 : j := 1;
     else
      begin
       if (j in [1..80]) and (k in [1..250]) then
        Ana.Cha[j,k] := RCha;
       j := j + 1;
      end;
     end; {case}
   until k > 250;
  close(AnaFile);
 end;

begin
 Init;
 Title;
end.













