program TestBLSIntro;

uses
 Crt, Std;

procedure BlackLotusIntro;
 var
  Str     : string;
  ChD,
  ChC,
  ChX,
  ChY     : array[1..23] of integer;
  i, j    : integer;
  c, d    : integer;
  Left    : integer;
 begin
  randomize;
  Str := 'Black Lotus Productions';
  Clear;
  for i := 1 to 4 do
   begin
    c := 0;
    for j := 29 to 51 do
     begin
      c := c + 1;
      d := c;
      if i in [1] then if d in [5..19] then d := 4;
      if i in [2] then if d in [8..16] then d := 7;
      if i in [3] then if d in [11..13] then d := 10;
       case d of
        1..4, 20..23  : textcolor(red);
        5..7, 17..19  : textcolor(lightred);
        8..10, 14..16 : textcolor(yellow);
        11..13        : textcolor(lightgray);
       end; {case}
      gotoxy(j,10);
      write(Str[c]);
      Cursor;
     end;
    delay(50);
   end;
  delay(200);
  for j := 1 to 23 do
   begin
    ChX[j] := j+28;
    ChY[j] := 10;
    ChD[j] := random(8)+1;
     case j of
      1..4, 20..23  : ChC[j] := 4;
      5..7, 17..19  : ChC[j] := 12;
      8..10, 14..16 : ChC[j] := 14;
      11..13        : ChC[j] := 7;
     end; {case}
   end;
  Left := 23;
  while Left > 0 do
   begin
     repeat
      j := random(23)+1;
     until (ChX[j] in [1..80]) and (ChY[j] in [1..24]);
    textcolor(white);
    textbackground(black);
    gotoxy(ChX[j], ChY[j]);
    write(' ');
    Cursor;
     case ChD[j] of
      1 :
       begin
        ChX[j] := ChX[j] - 1;
        ChY[j] := ChY[j] - 1;
       end;
      2 : ChY[j] := ChY[j] - 1;
      3 :
       begin
        ChX[j] := ChX[j] + 1;
        ChY[j] := ChY[j] - 1;
       end;
      4 : ChX[j] := ChX[j] + 1;
      5 :
       begin
        ChX[j] := ChX[j] + 1;
        ChY[j] := ChY[j] + 1;
       end;
      6 : ChY[j] := ChY[j] + 1;
      7 :
       begin
        ChX[j] := ChX[j] - 1;
        ChY[j] := ChY[j] + 1;
       end;
      8 : ChX[j] := ChX[j] - 1;
     end; {case}
    if (not (ChX[j] in [1..80])) or (not (ChY[j] in [1..24])) then
     Left := Left - 1
    else
     begin
      textcolor(ChC[j]);
      gotoxy(ChX[j], ChY[j]);
      write(Str[j]);
      Cursor;
     end;
    delay(2);
   end;
 end;


begin
 BlackLotusIntro;
end.