program OldMaid;

uses
 Crt;

type
 NumOfCards = array[1..52] of integer;

var
 Deck : NumOfCards;
 DeckCds : integer;
 Plr1Hnd : NumOfCards;
 Plr1Cds : integer;
 Plr2Hnd : NumOfCards;
 Plr2Cds : integer;
 Plr1Dwn : NumOfCards;
 Plr1Dds : integer;
 Plr2Dwn : NumOfCards;
 Plr2Dds : integer;
 CrdSuit : string;
 CrdNum : string;
 j, k : integer;

procedure Init;
 begin
  randomize;
  textbackground(black);
  textcolor(white);
 end;

procedure Reset;
 begin
 end;

procedure Title;
 begin
  clrscr;
  gotoxy(35,10);
  write('Old Maid');
  readkey;
 end;

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
  DeckCds := 52;
  for j := 1 to DeckCds do
   begin
    if DeckCds > 51 then
     begin
      if ((Deck[j] - 400 = 11) or (Deck[j] - 300 = 11) or (Deck[j] - 200 = 11)
      or (Deck[j] - 100 = 11)) then
       begin
        for k := j to DeckCds do
         begin
          if k < DeckCds then Deck[k] := Deck[k+1] else Deck[k] := 0;
         end;
        DeckCds := DeckCds - 1;
       end;
     end;
   end;
 end;

procedure Deal;
 var
  j : integer;
  p : integer;
 begin
  p := random(2)+1;
  Plr1Cds := 0;
  Plr2Cds := 0;
  for j := 1 to 52 do
   begin
    Plr1Hnd[j] := 0;
    Plr2Hnd[j] := 0;
    Plr1Dwn[j] := 0;
    Plr2Dwn[j] := 0;
   end;
  Plr1Cds := 0;
  Plr2Cds := 0;
  Plr1Dds := 0;
  Plr2Dds := 0;
  for j := 1 to DeckCds do
   begin
    if p = 1 then Plr1Hnd[Plr1Cds] := Deck[DeckCds];
    if p = 2 then Plr2Hnd[Plr2Cds] := Deck[DeckCds];
    if p = 1 then Plr1Cds := Plr1Cds + 1;
    if p = 2 then Plr2Cds := Plr2Cds + 1;
    if p = 1 then p := 2 else p := 1;
    DeckCds := DeckCds - 1;
   end;
 end;

function Num2Crd(Num : Integer) : String;
 var
  j : integer;
  c1 : string;
  c2 : string;
  c3 : integer;
 begin
  if Num > 100 then c2 := chr(6);
  if Num > 200 then c2 := chr(5);
  if Num > 300 then c2 := chr(4);
  if Num > 400 then c2 := chr(3);
  if c2 = chr(6) then c3 := Num - 100;
  if c2 = chr(5) then c3 := Num - 200;
  if c2 = chr(4) then c3 := Num - 300;
  if c2 = chr(3) then c3 := Num - 400;
  c3 := c3 + 1;
  str(c3,c1);
  if c3 = 11 then c1 := 'J';
  if c3 = 12 then c1 := 'Q';
  if c3 = 13 then c1 := 'K';
  if c3 = 14 then c1 := 'A';
  Num2Crd := c1 + c2;
  crdnum := c1;
  crdsuit := c2;
 end;

begin
 Init;
 Reset;
 Title;
 Shuffle;
 Deal;
