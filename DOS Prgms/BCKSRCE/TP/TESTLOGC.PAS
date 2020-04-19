program TestLogic;

uses
 Crt, PkrLogic;

var
 Hand : HandType;
 Card : integer;
 j, k : integer;
 Suit : integer;
 TempCard : integer;

begin
 textcolor(white);
 clrscr;
  repeat
   writeln('Type in a hand of cards.');
   for j := 1 to 5 do
    begin
      repeat
       write('Card #', j, ' : ');
       readln(Card);
      until (Card > 0) and (Card < 53);
     Hand[j] := Card;
    end;
   OrderHand(Hand);
   writeln;
   write('Hand : ');
   for j := 1 to 5 do
    begin
     TempCard := Hand[j];
     Suit := 1;
     while TempCard > 13 do
      begin
       TempCard := TempCard - 13;
       Suit := Suit + 1;
      end;
      case TempCard of
       1 : write('A');
       2..10 :write(TempCard);
       11 : write('J');
       12 : write('Q');
       13 : write('K');
      end; {case}
     if Suit = 1 then write('H  ');
     if Suit = 2 then write('D  ');
     if Suit = 3 then write('C  ');
     if Suit = 4 then write('S  ');
    end;

   writeln;
   if SmallStrait(Hand) then
    begin
     writeln('Small Strait.');
     writeln;
    end;
   if TwoKind(Hand) then
    begin
     writeln;
     writeln('Two of a kind.');
    end;
   if TwoPairs(Hand) then
    begin
     writeln;
     writeln('Two Pairs.');
    end;
   if ThreeKind(Hand) then
    begin
     writeln;
     writeln('Three of a kind.');
     writeln('Highest : ', ThreeKindCard(Hand));
    end;
   if Strait(Hand) then
    begin
     writeln;
     writeln('Strait');
    end;
   if Flush(Hand) then
    begin
     writeln;
     writeln('Flush');
    end;
   if FullHouse(Hand) then
    begin
     writeln;
     writeln('FullHouse');
    end;
   if FourKind(Hand) then
    begin
     writeln;
     writeln('Four of a kind');
    end;
   if StraitFlush(Hand) then
    begin
     writeln;
     writeln('Strait flush');
    end;
   writeln('Value : ', HandValue(Hand):0:6);
   write('----------------------------');
   readkey;
   writeln;
  until 1 = 2;
end.


