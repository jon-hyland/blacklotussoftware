program SpaceBlasters;

uses
 Crt;

type
 EnemyShip = array[1..10] of integer;

var
 EnemyX : EnemyShip;
 EnemyY : EnemyShip;
 Key : char;
 j, k : integer;
 press : integer;
 ShipX : integer;
 ShipY : integer;

procedure Reset;
 var
  GoodPos : boolean;
 begin
  randomize;
  ShipX := 38;
  ShipY := 24;
  for j := 1 to 10 do
   begin
    GoodPos := false;
     repeat
      EnemyX[j] := random(78)+2;
      EnemyY[j] := random(20)+2;
      if j > 1 then
       begin
        for k := 1 to j - 1 do
         begin
          if EnemyX[j] <> EnemyX[k] then if EnemyY[j] <> EnemyY[k] then GoodPos := true;
         end;
       end else
       begin
        GoodPos := true;
       end;
     until GoodPos = true;
   end;
 end;

procedure Cursor;
 begin
  textcolor(black);
  textbackground(black);
  gotoxy(1,1);
  write(' ');
  gotoxy(1,1);
 end;

procedure Title;
 begin
  clrscr;
  gotoxy(35,10);
  textcolor(white);
  write('Space Blasters');
  Cursor;
  readkey;
 end;

procedure DrawScreen;
 begin
  clrscr;
  textcolor(white);
  for j := 1 to 10 do
   begin
    gotoxy(EnemyX[j], EnemyY[j]);
    write('0');
   end;
  gotoxy(ShipX, ShipY);
  write('<^>');
 end;

procedure ShipLeft;
 begin
  gotoxy(ShipX, ShipY);
  write('   ');
  ShipX := ShipX - 1;
  if ShipX < 2 then ShipX := 2;
  gotoxy(ShipX, ShipY);
  textcolor(white);
  write('<^>');
  Cursor;
 end;

procedure ShipRight;
 begin
  gotoxy(ShipX, ShipY);
  write('   ');
  ShipX := ShipX + 1;
  if ShipX > 77 then ShipX := 77;
  gotoxy(ShipX, ShipY);
  textcolor(white);
  write('<^>');
  Cursor;
 end;

procedure ShipFire;
 var
  FireY : integer;
  Hit : boolean;
 begin
  Hit := false;
  FireY := ShipY - 1;
   repeat
    gotoxy(ShipX+1, FireY);
    textcolor(white);
    write('|');
    Cursor;
    delay(5);
    for j := 1 to 10 do
     begin
      if ShipX+1 = EnemyX[j] then if FireY = EnemyY[j] then Hit := true;
     end;
    gotoxy(ShipX+1, FireY);
    write(' ');
    Cursor;
    FireY := FireY - 1;
   until ((Hit = true) or (FireY < 1));
 end;

begin
 Reset;
 Title;
 DrawScreen;
  repeat
   if KeyPressed = true then
    begin
     Key := Readkey;
     press := 0;
      case Key of
       #75: press := 1;
       #77: press := 2;
      end;
     if key = ' ' then press := 3;
     if press = 1 then ShipLeft;
     if press = 2 then ShipRight;
     if press = 3 then ShipFire;
    end;
  until ord(key) = 27;
end.