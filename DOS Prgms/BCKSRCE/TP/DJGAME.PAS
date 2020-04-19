program manmove;

uses
  crt;

type
  screensz = array[1..50,1..24] of boolean;

var
  obj : screensz;
  x : integer;
  y : integer;
  key : char;
  ox, oy  : integer;
  bx, by : integer;
  obx,oby : integer;
  s,os : integer;
  bs,obs : integer;

procedure cursor;
 begin
   gotoxy(1,25);
 end;

procedure select1;
   begin
     textcolor(blue);
     if s = 1 then
       begin
         gotoxy(2,13);
         writeln('*');
         gotoxy(2,os+12);
         writeln(' ');
       end;
     if s = 2 then
       begin
         gotoxy(2,14);
         writeln('*');
         gotoxy(2,os+12);
         writeln(' ');
       end;
     if s = 3 then
       begin
         gotoxy(2,15);
         writeln('*');
         gotoxy(2,os+12);
         writeln(' ');
       end;
     s := os;
     s := s + 1;
     if s = 4 then s := 1;
    end;

procedure select2;
   begin
     textcolor(red);
     if bs = 1 then
       begin
         gotoxy(68,13);
         writeln('*');
         gotoxy(68,obs+12);
         writeln(' ');
       end;
     if bs = 2 then
        begin
         gotoxy(68,14);
         writeln('*');
         gotoxy(68,obs+12);
         writeln(' ');
        end;
     if bs = 3 then
       begin
         gotoxy(68,15);
         writeln('*');
         gotoxy(68,obs+12);
         writeln(' ');
       end;
     bs := obs;
     bs := bs + 1;
     if bs = 4 then bs := 1
   end;

procedure setup;
  var
    i,j,k : integer;
  begin
    s := 1;
    bs := 1;
    textcolor(black);
    textbackground(lightgray);
    clrscr;
    textcolor(lightgray);
    gotoxy(1,25);
    write(#219);
    textcolor(black);
    randomize;
    for k := 1 to 24 do
      for j := 1 to 50 do
        obj[j,k] := false;
    for i := 1 to 100 do
      begin
        j := random(50)+1;
        k := random(24)+1;
        obj[j,k] := true;
        gotoxy(j+16,k);
        write(#219);
      end;
      repeat
        x := random(50)+1;
        y := random(24)+1;
      until not obj[x,y];
    gotoxy(x+16,y);
    textcolor(red);
    write(#2);
  end;

procedure secplayer;
 var
  c : integer;

 begin
   repeat
     bx := random(50)+1;
     by := random(24)+1;
    until not obj[bx,by];
     gotoxy(bx+16,by);
     textcolor(blue);
     write(#2);
   c := random(5)+1;
   if c = 1 or 2 then

 end;

procedure screen;

var
i,k,x,y : integer;

begin
 y := 1;
 textcolor(black);
 for i := 1 to 24 do
  begin
   gotoxy(66,i);
   write(#219);
   gotoxy(16,i);
   write(#219);
  end;
textcolor(blue);
   begin
    gotoxy(2,3);
    writeln('Player 1');
    gotoxy(2,6);
    writeln('Health');
    gotoxy(2,9);
    writeln('Weapon');
    gotoxy(2,12);
    writeln('Ammo');
    writeln('   Gun    :');
    writeln('   Rocket :');
    writeln('   Bomb   :');
   end;
textcolor(red);
   begin
    gotoxy(68,3);
    writeln('Player 2');
    gotoxy(68,6);
    writeln('Health');
    gotoxy(68,9);
    writeln('Weapon');
    gotoxy(68,12);
     writeln('Ammo');
    gotoxy(68,13);
     writeln('  Gun    :');
    gotoxy(68,14);
     writeln('  Rocket :');
    gotoxy(68,15);
     writeln('  Bomb   :');
   end;
end;

procedure move;
  begin
  key := readkey;
    if key in ['S','A','W','D','H','K','P','M','/','Z'] then
      if key in ['H','K','P','M'] then
        begin
          gotoxy(x+16,y);
          write(' ');
          ox := x;
          oy := y;
        end;
      if key in ['S','A','W','D'] then
        begin
          gotoxy(bx+16,by);
          write(' ');
          obx := bx;
          oby := by;
        end;
      if key in ['/'] then
        select1;
      if key in ['Z'] then
        select2;
       case key of
         'H' : y := y - 1;
         'W' : by := by - 1;
         'K' : x := x - 1;
         'A' : bx := bx - 1;
         'P' : y := y + 1;
         'S' : by := by + 1;
         'M' : x := x + 1;
         'D' : bx := bx + 1;
       end;
     if y < 1 then y := oy;
     if by < 1 then by := oby;
     if y > 24 then y := oy;
     if by > 24 then by := oby;
     if x < 1 then x := ox;
     if bx < 1 then  bx := obx;
     if x > 49 then x := ox;
     if bx > 49 then bx := obx;
     if obj[x,y] then
       begin
         textcolor(red);
         x := ox;
         y := oy;
       end;
     if obj[bx,by] then
       begin
        textcolor(blue);
        bx := obx;
        by := oby;
       end;
     if Key in ['H','K','P','M'] then
     if y = by then
     if x = bx then
       begin
         textcolor(red);
         x := ox;
         y := oy;
       end;
     if Key in ['A','S','D','W'] then
     if by = y then
     if bx = x then
       begin
         textcolor(blue);
         by := oby;
         bx := obx;
       end;
     gotoxy(x+16,y);
     textcolor(red);
     write(#2);
     gotoxy(bx+16,by);
     textcolor(blue);
     write(#2);
  end;

begin
 setup;
 secplayer;
 screen;
 select1;
 select2;
repeat
 move;
 cursor;
until key = (#24);
end.