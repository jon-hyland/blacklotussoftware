program Poker;

uses
 Crt, PkrGraph;

type
 Deck_Type = array[1..52] of integer;
 Hand_Type = array[1..5] of integer;

var
 Deck,
 Discard     : Deck_Type;
 YourHand,
 CompHand    : Hand_Type;
 DeckTot,
 DiscardTot,
 YourHandTot,
 CompHandTot : integer;
 TimesBet    : integer;
 Call        : boolean;

procedure GameInit;
 begin
  randomize;
 end;

procedure Shuffle;
  var
   j : integer;
   r : integer;
   c : integer;
  begin
   for j := 1 to 52 do
    Deck[j] := j;
   for j := 1 to 52 do
    begin
     ShuffleDraw(j);
      repeat
       r := random(52)+1;
      until r <> j;
     c := Deck[j];
     Deck[j] := Deck[r];
     Deck[r] := c;
    end;
  end;

procedure LevelInit;
 var
  j : integer;
 begin
  for j := 1 to 52 do
   Discard[j] := 0;
  DiscardTot := 0;
  Shuffle;
  DeckTot := 52;
  for j := 1 to 5 do
   begin
    YourHand[j] := 0;
    CompHand[j] := 0;
   end;
  YourHandTot := 0;
  CompHandTot := 0;
  Call :=  false;
 end;

procedure DealCards;
 var
  j : integer;
 begin
  for j := 1 to 5 do
   begin
    YouDraw;
    YourHand[YourHandTot + 1] := Deck[DeckTot];
    YourHandTot := YourHandTot + 1;
    Deck[DeckTot] := 0;
    DeckTot := DeckTot - 1;
    DrawCard(YourHandTot, YourHand[YourHandTot]);
    CompDraw;
    CompHand[CompHandTot + 1] := Deck[DeckTot];
    CompHandTot := CompHandTot + 1;
    Deck[DeckTot] := 0;
    DeckTot := DeckTot - 1;
   end;
 end;

begin
 GameInit;
 TitleScreen;
  {repeat}
   PlayScreen;
   LevelInit;
   DealCards;

   TimesBet := 0;


   readkey;

  {until Done;}
end.