program ShuffleNumber2CardString;

uses
 Crt;

var
 CrdNum : string;
 CrdSuit : String;
 Card : integer;
 Key : char;

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
  CrdNum := c1;
  CrdSuit := c2;
 end;

begin
 clrscr;
 repeat
  Card := (random(13)+1) + ((random(4)+1)*100);
  writeln('Card Number: ', Card);
  Num2Crd(Card);
  writeln('Card Number: ', CrdNum);
  writeln('Card Suit: ', CrdSuit);
  key := readkey;
  writeln;
 until ord(key) = 27;
end.