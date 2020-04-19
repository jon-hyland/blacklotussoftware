program BugZapper;

uses
 Crt;

type
 array1 = array[1..25] of integer;

var
 X : array1;
 Y : array1;
 j, k, r1, r2 : integer;
 NX, NY, OX, OY : integer;
 Bug : integer;

procedure Init;
 begin
  randomize;
  for j := 1 to 24 do
   begin
    X[j] := 0;
    Y[j] := 0;
   end;
 end;


procedure Cursor;
 begin
  gotoxy(1,24);
 end;

procedure DrawScreen;
 begin
  textbackground(black);
  textcolor(black);
  Cursor;
  write(chr(219));
  textcolor(lightblue);
  clrscr;
  gotoxy(1, 12);
  for j := 1 to 80 do write('-');
  Cursor;
  textcolor(white);
 end;

procedure RandomPlaces;
 var
  OkNum : boolean;
 begin
  for j := 1 to 25 do
   begin
     repeat
      r1 := random(80)+1;
      r2 := random(24)+1;
      OkNum := true;
      for k := 1 to j do
       if X[j] = r1 then OkNum := false;
      if r2 = 12 then OkNum := false;
     until OkNum;
    X[j] := r1;
    Y[j] := r2;
    gotoxy(X[j], Y[j]);
    write('X');
    Cursor;
   end;
 end;

function GetBug : integer;
 begin
   repeat
    r1 := random(25)+1;
   until X[r1] <> 0;
  GetBug := r1;
 end;

procedure GetMoveTo;
 var
  OkMove : boolean;
 begin
  OX := X[Bug];
  OY := Y[Bug];
   repeat
    r1 := random(4)+1;
    r2 := random(3)+1;
     case r1 of
      1 : NX := OX + r2;
      2 : NX := OX - r2;
      3 : NY := OY + r2;
      4 : NY := OY - r2;
     end;
    if NX > 60 then NX := 60;
    if NX < 1 then NX := 0;
    if NY > 24 then NY := 24;
    if NY < 1 then NY := 1;
    OkMove := true;
    for j := 1 to 25 do
     begin
      if j <> Bug then
       if (X[j] = NX) and (Y[j] = NY) then OkMove := false;
     end;
   until OkMove;
 end;

procedure ZapBug;
 begin
  for j := 1 to 10 do
   begin
    if (j mod 2) = 1 then
     begin
      sound(200);
      textcolor(yellow);
      gotoxy(X[Bug], Y[Bug]);
      write('X');
     end
    else
     begin
      sound(500);
      textcolor(darkgray);
      gotoxy(X[Bug], Y[Bug]);
      write('X');
     end;
    Cursor;
    delay(10);
   end;
  nosound;
  textcolor(lightblue);
  gotoxy(X[Bug], Y[Bug]);
  write('-');
  Cursor;
  X[Bug] := 0;
  Y[Bug] := 0;
  TextColor(white);
 end;

begin
 Init;
 DrawScreen;
 RandomPlaces;
  repeat
   Bug := GetBug;
   GetMoveTo;
   gotoxy(OX,OY);
   write(' ');
   gotoxy(NX,NY);
   write('X');
   Cursor;
   if NY = 12 then ZapBug;
  until KeyPressed;
end.