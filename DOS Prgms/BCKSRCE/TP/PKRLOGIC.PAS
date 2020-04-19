unit PkrLogic;

{---------------} interface {-------------------------------------------}
type
 HandType = array[1..5] of integer;

procedure OrderHand(var Hand : HandType); {arranges hand in order of
                                          card number, large to small}
function TwoKind(Hand       : HandType) : boolean;
function TwoKindCard(Hand   : HandType) : integer;
function TwoPairs(Hand      : HandType) : boolean;
function ThreeKind(Hand     : HandType) : boolean;
function ThreeKindCard(Hand : HandType) : integer;
function Strait(Hand        : HandType) : boolean;
function Flush(Hand         : HandType) : boolean;
function FullHouse(Hand     : HandType) : boolean;
function FourKind(Hand      : HandType) : boolean;
function StraitFlush(Hand   : HandType) : boolean;
function SmallStrait(Hand   : HandType) : boolean;
function HandValue(Hand : HandType) : real;
function PossHandValue(Hand : HandType) : real;
{
function StraitNum(Hand     : HandType) : integer;
function FlushNum(Hand      : HandType) : integer;
}
{------} implementation {-------------------------------------------------}
var
 CardValue : integer;

procedure OrderHand(var Hand : HandType);
 var
  j,k : integer;
  THand : array[1..5] of integer;
  CardVal : array[1..5] of real;
  s : integer;
  big : real;
  bp : integer;
 begin
  for j := 1 to 5 do
   THand[j] := Hand[j];
  for j := 1 to 5 do
   begin
    s := 0;
    while THand[j] > 13 do
     begin
      THand[j] := THand[j] - 13;
      s := s + 1;
     end;
    CardVal[j] := THand[j] + s/4 - 1;
    if CardVal[j] < 1 then
     CardVal[j] := CardVal[j] + 13;
   end;
  for j := 1 to 5 do
   THand[j] := Hand[j];
  for j := 1 to 5 do
   begin
    big := CardVal[1];
    bp := 1;
    for k := 2 to 5 do
     if CardVal[k] > big then
      begin
       big := CardVal[k];
       bp := k;
      end;
    Hand[j] := THand[bp];
    CardVal[bp] := 0;
   end;
 end;

function TwoKind(Hand : HandType) : boolean;
 var
  j, k : integer;
 begin
  TwoKind := false;
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 4 do
   for k := (j+1) to 5 do
    if Hand[j] = Hand[k] then
     TwoKind := true;
 end;

function TwoKindCard(Hand : HandType) : integer;
 var
  j, k : integer;
  Highest : integer;
 begin
  Highest := 0;
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 4 do
   for k := (j+1) to 5 do
    if Hand[j] = Hand[k] then
     if Highest <> 1 then
      begin
       if Hand[j] = 1 then
        Highest := 1;
       if Hand[j] > Highest then
        Highest := Hand[j];
      end;
  TwoKindCard := Highest;
 end;

function TwoPairs(Hand : HandType) : boolean;
 var
  j : integer;
  CrdAmt : array[1..13] of integer;
  Num : integer;
 begin
  for j := 1 to 13 do
   CrdAmt[j] := 0;
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 5 do
   CrdAmt[Hand[j]] := CrdAmt[Hand[j]] + 1;
  Num := 0;
  for j := 1 to 13 do
   if CrdAmt[j] = 2 then
    Num := Num + 1;
  if Num = 2 then TwoPairs := true else TwoPairs := false;
 end;

function ThreeKind(Hand : HandType) : boolean;
 var
  j : integer;
  CrdAmt : array[1..13] of integer;
 begin
  ThreeKind := false;
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 13 do
   CrdAmt[j] := 0;
  for j := 1 to 5 do
   CrdAmt[Hand[j]] := CrdAmt[Hand[j]] + 1;
  for j := 1 to 13 do
   if CrdAmt[j] >= 3 then
    ThreeKind := true;
 end;

function ThreeKindCard(Hand : HandType) : integer;
 var
  j : integer;
  CrdAmt : array[1..13] of integer;
 begin
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 13 do
   CrdAmt[j] := 0;
  for j := 1 to 5 do
   CrdAmt[Hand[j]] := CrdAmt[Hand[j]] + 1;
  for j := 1 to 13 do
   if CrdAmt[j] >= 3 then
    ThreeKindCard := j;
 end;

function Strait(Hand : HandType) : boolean;
 var
  j, k : integer;
  Lowest : integer;
  Found : boolean;
 begin
  Strait := true;
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 5 do  {changes num of cards (ace = 13, two = 1, etc}
   begin
    if Hand[j] = 1 then Hand[j] := 14;
    Hand[j] := Hand[j] - 1;
   end;
  Lowest := Hand[1];
  for j := 2 to 5 do
   if Hand[j] < Lowest then
    Lowest := Hand[j];
  for j := Lowest to (Lowest + 4) do
   begin
    Found := false;
    for k := 1 to 5 do
     if Hand[k] = j then Found := true;
    if not Found then Strait := false;
   end;
 end;

function Flush(Hand : HandType) : boolean;
 var
  j : integer;
  Suit : array[1..5] of integer{1..4};
 begin
  for j := 1 to 5 do
   begin
    Suit[j] := 1;
    while Hand[j] > 13 do
     begin
      Hand[j] := Hand[j] - 13;
      Suit[j] := Suit[j] + 1;
     end;
   end;
  Flush := true;
  for j := 1 to 5 do
   if Suit[1] <> Suit[j] then
    Flush := false;
 end;

function FullHouse(Hand : HandType) : boolean;
 var
  j : integer;
  ThreeCard : integer;
  LCard1, LCard2 : integer;
 begin
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  if ThreeKind(Hand) then
   begin
    ThreeCard := ThreeKindCard(Hand);
    for j := 1 to 5 do
     if Hand[j] = ThreeCard then Hand[j] := 0;
    LCard1 := 0;
    LCard2 := 0;
    for j := 1 to 5 do
     begin
      if Hand[j] <> 0 then
       if LCard1 = 0 then LCard1 := Hand[j] else LCard2 := Hand[j];
     end;
    if LCard1 = LCard2 then
     FullHouse := true
    else
     FullHouse := false;
   end
  else
   FullHouse := false;
 end;

function FourKind(Hand : HandType) : boolean;
 var
  j : integer;
  CrdAmt : array[1..13] of integer;
 begin
  for j := 1 to 5 do
   while Hand[j] > 13 do
    Hand[j] := Hand[j] - 13;
  for j := 1 to 13 do
   CrdAmt[j] := 0;
  for j := 1 to 5 do
   CrdAmt[Hand[j]] := CrdAmt[Hand[j]] + 1;
  FourKind := false;
  for j :=1 to 13 do
   if CrdAmt[j] >= 4 then
    FourKind := true;
 end;

function StraitFlush(Hand : HandType) : boolean;
 begin
  if Strait(Hand) and Flush(Hand) then
   StraitFlush := true
  else
   StraitFlush := false;
 end;

function SmallStrait(Hand : HandType) : boolean;
 var
  j : integer;
  c : integer;
  Card, Suit : array[1..5] of integer;
  Off : integer;
 begin
  OrderHand(Hand);
  for j := 1 to 5 do
   begin
    Suit[j] := 1;
    Card[j] := Hand[j];
    while Card[j] > 13 do
     begin
      Card[j] := Card[j] - 13;
      Suit[j] := suit[j] + 1;
     end;
    Card[j] := Card[j] - 1;
    if Card[j] = 0 then Card[j] := 13;
   end;
  Off := 0;
  c := Card[1];
  j := 1;
  while j < 5 do
   begin
     repeat
      j := j + 1;
     until Card[j] <> c;
    if Card[j] <> c - 1 then
     Off := Off + 1;
    c := Card[j];
   end;
  if Off <= 1 then SmallStrait := true else SmallStrait := false;
 end;

function HandNum(Hand : HandType) : integer;
 begin
  if StraitFlush(Hand) then
   HandNum := 8 else
  if FourKind(Hand) then
   HandNum := 7 else
  if FullHouse(Hand) then
   HandNum := 6 else
  if Flush(Hand) then
   HandNum := 5 else
  if Strait(Hand) then
   HandNum := 4 else
  if ThreeKind(Hand) then
   HandNum := 3 else
  if TwoPairs(Hand) then
   HandNum := 2 else
  if TwoKind(Hand) then
   HandNum := 1 else
  HandNum := 0;
 end;

function HandValue(Hand : HandType) : real;
 var
  Num : integer;
  Card : array[1..5] of integer;
  Suit : array[1..5] of integer;
  j : integer;
  Value : real;
{-------------------------------------}
function Pow(n1, n2 : integer) : real;
 var
  j : integer;
  r : real;
 begin
  r := 1;
  for j := 1 to n2 do
   r := r * n1;
  Pow := r;
 end;
{-------------------------------------}
 begin
  OrderHand(Hand);
  for j := 1 to 5 do
   begin
    Suit[j] := 1;
    Card[j] := Hand[j];
    while Card[j] > 13 do
     begin
      Suit[j] := Suit[j] + 1;
      Card[j] := Card[j] - 13;
     end;
    Card[j] := Card[j] - 1;
    if Card[j] = 0 then Card[j] := 13;
   end;
  Num := HandNum(Hand);
  if Num = 0 then
   begin
    Value := 0;
    for j := 1 to 5 do
     Value := Value + Card[j] / Pow(100,j-1);
   end;
  if Num = 1 then
   begin
    Value := 13;
    for j := 2 to 5 do
     Value := Value + Card[j] / Pow(100,j-2);
   end;
  if Num = 2 then
   begin
    Value := 26;
    Value := Value + Card[1];
    Value := Value + Card[3] / 100;
    Value := Value + Card[5] / 10000;
   end;
  if Num = 3 then
   begin
    Value := 39;
    Value := Value + Card[1];
    Value := Value + Card[4] / 100;
    Value := Value + Card[5] / 10000;
   end;
  if Num = 4 then
   begin
    Value := 52;
    Value := Value + Card[1];
    Value := Value + (Suit[1] - 1) / 4;
   end;
  if Num = 5 then
   begin
   end;
  if Num = 6 then
   begin
    Value := 78;
    Value := Value + Card[1];
    Value := Value + Card[4] / 100;
   end;
  if Num = 7 then
   begin
    Value := 91;
    Value := Value + Card[1];
    Value := Value + Card[5] / 100;
   end;
  if Num = 8 then
   begin
    Value := 104;
    Value := Value + Card[1];
    Value := Value + (Suit[1] - 1) / 4;
   end;
  HandValue := Value;
 end;

function PossHandValue(Hand : HandType) : real;
 var
  Num : integer;
  j : integer;
  Card : array[1..5] of integer;
  Suit : array[1..5] of integer;
  Value : real;
 begin
  OrderHand(Hand);
  for j := 1 to 5 do
   begin
    Suit[j] := 1;
    Card[j] := Hand[j];
    while Card[j] > 13 do
     begin
      Suit[j] := Suit[j] + 1;
      Card[j] := Card[j] - 13;
     end;
    Card[j] := Card[j] - 1;
    if Card[j] = 0 then Card[j] := 13;
   end;
  if SmallStrait(Hand) then
   Num := 4;
  if ThreeKind(Hand) then
   Num := 3 else
  if TwoPairs(Hand) then
   Num := 2 else
  if TwoKind(Hand) then
   Num := 1 else
  Num := 0;



  Value := HandValue(Hand);
  if Num = 0 then
   Value := Value + (13 + Card[1]) / 3;
  if Num = 1 then
   Value := Value + (39 + Card[1]) / 13;
  if Num = 2 then
   Value := Value + (78 + Card[1]) / 13;
  if Num = 3 then
   Value := Value + (91 + Card[1]) / 26;



  PossHandValue := 0; {remove}
 end;


begin
end
.