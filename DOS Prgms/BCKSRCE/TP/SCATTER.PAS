program Test;

uses
 Crt, Std;

procedure DissolveText(Str : string);
 var
  sx      : integer;
  seglen  : integer;
  ChX,
  ChY,
  ChColor,
  ChDir   : array[1..50] of integer;
  i, j, k : integer;
  Left    : integer;
  ChNum   : integer;
 begin
  Clear;
  sx := 40 - length(Str) div 2;
  seglen := length(Str) div 5;
  j := 0;
  for i := 1 to 5 do
   begin
    if i in [1..2, 4..5] then
     ChNum := seglen
    else
     ChNum := seglen + (length(Str) mod 2);
    for k := 1 to ChNum do
     begin
      j := j + 1;
      ChX[j] := sx + (j-1);
      ChY[j] := 10;
      ChDir[j] := random(8)+1;
       case i of
        1, 5 : ChColor[j] := 4;
        2, 4 : ChColor[j] := 14;
        3    : ChColor[j] := 7;
       end; {case}
      textcolor(ChColor[j]);
      gotoxy(sx+(j-1), 10);
      write(Str[j]);
     end;
   end;
  delay(250);
  Left := length(Str);
  while (Left > 0) do
   begin
     repeat
      i := random(length(Str)) + 1;
     until (ChX[i] in [1..80]) and (ChY[i] in [1..24]);
    gotoxy(ChX[i], ChY[i]);
    write(' ');
     case ChDir[i] of
      1 : ChY[i] := ChY[i] - 1;
      2 :
       begin
        ChX[i] := ChX[i] + 1;
        ChY[i] := ChY[i] - 1;
       end;
      3 : ChX[i] := ChX[i] + 1;
      4 :
       begin
        ChX[i] := ChX[i] + 1;
        ChY[i] := ChY[i] + 1;
       end;
      5 : ChY[i] := ChY[i] + 1;
      6 :
       begin
        ChX[i] := ChX[i] - 1;
        ChY[i] := ChY[i] + 1;
       end;
      7 : ChX[i] := ChX[i] - 1;
      8 :
       begin
        ChX[i] := ChX[i] - 1;
        ChY[i] := ChY[i] - 1;
       end;
     end; {case}
    if ((ChX[i] in [1..80]) and (ChY[i] in [1..24])) then
     begin
      gotoxy(ChX[i], ChY[i]);
      textcolor(ChColor[j]);
      write(Str[i]);
      Cursor;
     end
    else
     Left := Left - 1;
    delay(2);
   end;
 end;

begin
 DissolveText('sadjklhsdafjhsdafjklhasdfkljhasdf');
 readkey;
end.