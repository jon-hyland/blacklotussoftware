program PhoneSounds;

uses
 Crt;

var
 Choice : integer;

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
 begin
  Choice := 1;
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
  textcolor(darkgray);
  textbackground(black);
  for k := y1+1 to y2 do
   begin
    gotoxy(x2+1,k);
    write(#176, #176);
   end;
  for j := x1+2 to x2+2 do
   begin
    gotoxy(j, y2+1);
    write(#176);
   end;
  textcolor(white);
  textbackground(BackColor);
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

procedure GetUserPassword;
 var
  PassS    : string[12];
  PassC    : array[1..12] of char;
  x        : integer;
  j        : integer;
  Key      : char;
  GoodPass : boolean;
 begin
  Clear;
  DrawWindow(32,5,47,7,4,'Password');
  textbackground(black);
   repeat
    x := 1;
    for j := 1 to 12 do
     begin
      PassC[j] := ' ';
      gotoxy(j+33, 6);
      write(' ');
     end;
     repeat
      gotoxy(x+33, 6);
       repeat
        Key := readkey;
        Key := upcase(Key);
        if Key = #0 then readkey;
       until Key in [#32..#126, #13, #8];
       case Key of
        #32..#126 :
         begin
          PassC[x] := Key;
          write('*');
          x := x + 1;
          if x > 12 then x := 12;
         end;
        #8 :
         begin
          PassC[x] := ' ';
          write(PassC[x]);
           x := x - 1;
          if x < 1 then x := 1;
          gotoxy(x+33, 6);
          PassC[x] := ' ';
          write(PassC[x]);
         end;
       end; {case}
     until Key in [#13];
    PassS := '';
    if Key = #13 then
     for j := 1 to x-1 do
      PassS := concat(PassS, PassC[j]);
    GoodPass := PassS = '286343.975';
   until GoodPass;
 end;

procedure Title;
 begin
  Clear;
  DrawWindow(24,10,56,13,1,'Info');
  gotoxy(30,11);
  write('Phone Boxing  v2.0');
  gotoxy(26,12);
  write('(c) 1996 Black Lotus Software');
  Cursor;
  readkey;
 end;

procedure MainMenu;
 var
  Key    : char;
 begin
  Clear;
  DrawWindow(23,8,55,14,1,'Main Menu');
  textcolor(yellow);
  gotoxy(27,9);
  write('1  Nickel Simulation');
  gotoxy(27,10);
  write('2  Dime Simulation');
  gotoxy(27,11);
  write('3  Quarter Simulation');
  gotoxy(27,12);
  write('4  Coin Return');
  gotoxy(27,13);
  write('5  Quit');
  Cursor;
  textcolor(lightred);
   repeat
    gotoxy(25,Choice + 8);
    write(#157);
    Cursor;
     repeat
      Key := readkey;
     until Key in ['H','K','P','M',#13,'1'..'5'];
    if Key <> #13 then
     begin
      gotoxy(25,Choice + 8);
      write(' ');
      Cursor;
     end;
     case Key of
      'H','K'  : Choice := Choice - 1;
      'P','M'  : Choice := Choice + 1;
      '1'..'5' : Choice := ord(Key)-48;
     end; {case}
    if Choice > 5 then Choice := 1;
    if Choice < 1 then Choice := 5;
   until Key in [#13, '1'..'5'];
 end;

begin
 GetUserPassword;
 Init;
 Title;
  repeat
   MainMenu;
   if Choice in [1..4] then
    begin
     textcolor(lightgreen);
     gotoxy(25,Choice + 8);
     write(#157);
     Cursor;
     delay(500);
    end;
    case Choice of
     1 :
      begin
       sound(2200 and 1700);
       delay(66);
       nosound;
      end;
     2 :
      begin
       sound(2200 and 1700);
       delay(66);
       nosound;
       delay(66);
       sound(2200 and 1700);
       delay(66);
       nosound;
      end;
     3 :
      begin
       sound(2200 and 1700);
       delay(33);
       nosound;
       delay(33);
       sound(2200 and 1700);
       delay(33);
       nosound;
       delay(33);
       sound(2200 and 1700);
       delay(33);
       nosound;
       delay(33);
       sound(2200 and 1700);
       delay(33);
       nosound;
       delay(33);
       sound(2200 and 1700);
       delay(33);
       nosound;
      end;
     4 :
      begin
       sound(2600);
       delay(90);
       nosound;
       delay(60);
       sound(1100 and 1700);
       delay(900);
       nosound;
      end;
    end; {case}
   if Choice in [1..4] then
    begin
     textcolor(lightred);
     gotoxy(25,Choice + 8);
     write(#157);
     Cursor;
    end;
  until Choice = 5;
end.


