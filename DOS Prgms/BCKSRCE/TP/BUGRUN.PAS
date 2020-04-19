{This program was written from 2:11am to 2:32am, June 2nd 1997.
 It compiled and ran without errors on the first attempt, and
 has not been modified since.       J.H.

 (c) 1997  Black Lotus Software }

program Bugs;

uses
 Crt, Std;

type
 LocType = array[1..10] of integer;
 ObjType = array[1..80, 1..24] of boolean;

const
 TotObj   = 50;
 DelSpeed = 10;

var
 X, Y,
 Color,
 Dir    : LocType;
 Obj    : ObjType;
 Num    : integer;
 ox, oy : integer;

procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Obj[j,k] := false;
  for i := 1 to TotObj do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    textcolor(random(15)+1);
    gotoxy(j,k);
    write(#250);
    Cursor;
   end;
  for i := 1 to 10 do
   begin
     repeat
      j := random(80)+1;
      k := random(24)+1;
     until not Obj[j,k];
    Obj[j,k] := true;
    Color[i] := random(15)+1;
    X[i] := j;
    Y[i] := k;
    Dir[i] := random(8)+1;
    textcolor(Color[i]);
    gotoxy(j,k);
    write('*');
    Cursor;
   end;
 end;

begin
 Init;
  repeat
   Num := random(10)+1;
   Obj[X[Num], Y[Num]] := false;
   ox := X[Num];
   oy := Y[Num];
    case Dir[Num] of
     1 :
      begin
       X[Num] := X[Num] - 1;
       Y[Num] := Y[Num] + 1;
      end;
     2 : Y[Num] := Y[Num] + 1;
     3 :
      begin
       X[Num] := X[Num] + 1;
       Y[Num] := Y[Num] + 1;
      end;
     4 : X[Num] := X[Num] - 1;
     5 : X[Num] := X[Num] + 1;
     6 :
      begin
       X[Num] := X[Num] - 1;
       Y[Num] := Y[Num] - 1;
      end;
     7 : Y[Num] := Y[Num] - 1;
     8 :
      begin
       X[Num] := X[Num] + 1;
       Y[Num] := Y[Num] - 1;
      end;
    end; {case}
   if (X[Num] > 80) or (X[Num] < 1) or (Y[Num] > 24)
      or (Y[Num] < 1) or (Obj[X[Num], Y[Num]]) then
    begin
     Dir[Num] := random(8)+1;
     X[Num] := ox;
     Y[Num] := oy;
    end;
   textcolor(white);
   gotoxy(ox,oy);
   write(' ');
   textcolor(Color[Num]);
   gotoxy(X[Num], Y[Num]);
   write('*');
   Cursor;
   Obj[X[Num], Y[Num]] := true;
   delay(DelSpeed);
  until KeyPressed;
 FadeOut;
end.




