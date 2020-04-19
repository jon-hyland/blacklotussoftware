program War;

uses
 Crt;

type
 NumOfCards = array[1..52] of integer;

var
 Deck : NumOfCards;
 Plr1Hnd : NumOfCards;
 Plr2Hnd : NumOfCards;
 Plr1Cds : integer;
 Plr2Cds : integer;
 Play : Boolean;

procedure Shuffle;
 var
  c : Integer;
  j, k : integer;
  y1, y2 : integer;
 begin
  for j := 1 to 52 do Deck[j] := 0;
  for j := 1 to 52 do
   begin
    y1 := 0;
    while y1 = 0 do
     begin
      c := (random(13)+1) + ((random(4)+1)*100);
      y2 := 1;
      for k := 1 to 52 do if Deck[k] = c then y2 := 0;
      if y2 = 1 then y1 := 1;
     end;
    Deck[j] := c;
   end;
 end;

procedure Split;
 var
  j : integer;
  p : integer;
 begin
  p := 1;
  Plr1Cds := 0;
  Plr2Cds := 0;
  for j := 1 to 52 do
   begin
    if p = 1 then
     begin
      Plr1Hnd[Plr1Cds+1] := Deck[j];
      Plr1Cds := Plr1Cds + 1;
      Deck[j] := 0;
     end;
    if p = 2 then
     begin
      Plr2Hnd[Plr2Cds+1] := Deck[j];
      Plr2Cds := Plr2Cds + 1;
      Deck[j] := 0;
     end;
    if p = 1 then p := 2 else p := 1;
   end;
  if (Plr1Cds <> 26) or (Plr2Cds <> 26) then
   begin
    writeln('Error! Cards were not dealt right!!');
    readkey;
    halt;
   end;
 end;

procedure DrawScreen;
 var
  c, x, y, j : integer;
 begin
  clrscr;
  textbackground(0);
  x := 2;
  y := 2;
  c := 1;
  for j := 1 to 209 do
   begin
    if c = 1 then textcolor(9);
    if c = 2 then textcolor(15);
    gotoxy(x,y);
    write(chr(219));
    x := x + 1;
    if x > 20 then
     begin
      x := 2;
      y := y + 1;
     end;
    if c = 1 then c := 2 else c := 1;
   end;
  x := 61;
  y := 14;
  c := 1;
  for j := 1 to 209 do
   begin
    if c = 1 then textcolor(9);
    if c = 2 then textcolor(15);
    gotoxy(x,y);
    write(chr(219));
    x := x + 1;
    if x > 79 then
     begin
      x := 61;
      y := y + 1;
     end;
    if c = 1 then c := 2 else c := 1;
   end;
 end;





begin
 randomize;
 Play := true;
 Shuffle;
 Split;
 DrawScreen;
 readkey;
end.