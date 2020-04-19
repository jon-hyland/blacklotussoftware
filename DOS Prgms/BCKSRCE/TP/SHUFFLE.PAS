program Test;

uses
 Crt;

type
 Matrix = array[1..52] of integer;

var
 Deck : Matrix;
 c : Integer;
 j, k : integer;
 y1, y2 : integer;
 c1 : string[2];
 c2 : string[1];
 c3 : integer;

procedure Shuffle;
 var
  c : Integer;
  j, k : integer;
  y1, y2 : integer;
 begin
  randomize;
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

procedure ShowCards;
 begin
  clrscr;
  for j := 1 to 52 do
   begin
    if Deck[j] > 100 then c2 := 'S';
    if Deck[j] > 200 then c2 := 'C';
    if Deck[j] > 300 then c2 := 'D';
    if Deck[j] > 400 then c2 := 'H';
    if c2 = 'S' then c3 := Deck[j]-100;
    if c2 = 'C' then c3 := Deck[j]-200;
    if c2 = 'D' then c3 := Deck[j]-300;
    if c2 = 'H' then c3 := Deck[j]-400;
    c3 := c3 + 1;
    str(c3,c1);
    if c3 = 11 then c1 := 'J';
    if c3 = 12 then c1 := 'Q';
    if c3 = 13 then c1 := 'K';
    if c3 = 14 then c1 := 'A';
    writeln(c1,c2);
    readkey;
   end;
 end;

begin
 Shuffle;
 ShowCards;
end.

{Cards are numbered between 101 - 413.
  1st number (1-4):
   1 = Spades
   2 = Clubs
   3 = Diamonds
   4 = Hearts
  2nd & 3rd number (01-13):
   1 = 2
   2 = 3
   3 = 4
   4 = 5
   5 = 6
   6 = 7
   7 = 8
   8 = 9
   9 = 10
   10 = Jack
   11 = Queen
   12 = King
   13 = Ace}
