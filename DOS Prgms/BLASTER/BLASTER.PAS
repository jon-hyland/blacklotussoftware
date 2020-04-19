program Blaster;

uses
 Crt;

{$I PLAYSCR.PIK}

type
 array1 = array[1..80, 1..25] of integer;
 array2 = array[1..5] of integer;

var
 Screen : array2 absolute $B800:0000;
 Scrn : array1;
 EnemyX : array2;
 EnemyY : array2;
 ShipX : integer;
 Key : char;
 j, k, t  : integer;
 Done : boolean;

procedure Init;
 begin
  Done := false;
  textcolor(white);
  textbackground(black);
  for k := 1 to 25 do
   begin
    for j := 1 to 80 do Scrn[j,k] := 0;
   end;
  for j := 1 to 5 do
   begin
    EnemyX[j] := 0;
    EnemyY[j] := 0;
   end;
  ShipX := 40;
 end;

procedure Clear;
 begin
  clrscr;
  textcolor(black);
  write(chr(219));
  gotoxy(1,1);
  textcolor(white);
 end;

procedure Cursor;
 begin
  gotoxy(1,1);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(35,10);
  write('- Blaster -');
  Cursor;
  readkey;
 end;

procedure DrPlayScreen;
 begin
  clrscr;
  Move(PlayScrn, Screen, 4000);
 end;


procedure DrShip(x : integer);
 begin
  gotoxy(x-2, 23);
  textcolor(red);
  write(chr(213));
  textcolor(lightred);
  write(chr(220));
  textcolor(yellow);
  write(chr(202));
  textcolor(lightred);
  write(chr(220));
  textcolor(red);
  write(chr(184));
  Cursor;
 end;

procedure ErShip(x : integer);
 begin
  gotoxy(x-2, 23);
  write('     ');
  Cursor;
 end;

procedure ShipFire(x : integer);
 var
  tk : integer;
 begin
  textcolor(lightblue);
  sound(700);
  tk := 22;
   repeat
    gotoxy(x, tk);
    write(chr(179));
    tk := tk - 1;
   until ((tk < 1) or (Scrn[x, tk+1] = 1));
  Cursor;
  delay(25);
  nosound;
  delay(50);
  textcolor(white);
  tk := 22;
   repeat
    gotoxy(x, tk);
    write(' ');
    tk := tk - 1;
   until ((tk < 1) or (Scrn[ShipX, tk+1] = 1));
  Cursor;
 end;

procedure DrEnemy(x, y : integer);
 begin
  gotoxy(x-2, y);
  textcolor(darkgray);
  write(chr(218));
  textcolor(lightgray);
  write(chr(223));
  textcolor(white);
  write(chr(203));
  textcolor(lightgray);
  write(chr(223));
  textcolor(darkgray);
  write(chr(191));
  Cursor;
 end;

procedure ErEnemy(x, y : integer);
 begin
  gotoxy(x-2, y);
  write('     ');
  Cursor;
 end;

procedure EnemyFire(x, y : integer);
 var
  tk : integer;
 begin
  textcolor(lightred);
  sound(500);
  tk := y+1;
   repeat
    gotoxy(x, tk);
    write(chr(179));
    tk := tk + 1;
   until (tk = ShipX-1) or (Scrn[x, tk] = 1);
  Cursor;
  delay(25);
  nosound;
  delay(50);
  textcolor(white);
  tk := y+1;
   repeat
    gotoxy(x, tk);
    write(' ');
    tk := tk + 1;
   until (tk = ShipX-1) or (Scrn[x, tk] = 1);
  Cursor;
 end;




begin
 Init;
 Title;
  repeat


  until Done;


end.