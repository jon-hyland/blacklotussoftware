program BlackJack;

uses
 Crt;

type
 array1 = array[1..20] of integer;

var
 Money : integer;
 Pot : integer;
 Card : integer;
 YourTotal : integer;
 CompTotal : integer;
 Call : boolean;
 GameDone : boolean;
 Hand : array1;
 HCards : integer;

procedure Title;
 begin
  ClrScr;
  writeln('                       - BlackJack -');
  writeln('                       by Jon Hyland');
  writeln;
  writeln('The object of the game is to get as close to 21 points without');
  writeln('going over. You begin the game with $100 and have a chance to');
  writeln('bet after every time you draw a card. The computer will always');
  writeln('match what you put in but will never raise. Either one can call');
  writeln('at any time. Best hand keeps the pot.');
  writeln;
  write('                 Press [Return] to continue..');
  readln;
 end;

procedure YouDrawCard;
 var
  CardVal : integer;
  AceVal : integer;
  j : integer;
 begin
  writeln;
  writeln('--------- Your Turn ---------');
  writeln;
  Card := random(13)+1;
  HCards := HCards + 1;
  Hand[HCards] := Card;
  for j := 1 to HCards do
   write('  --- ');
  writeln;
  for j := 1 to HCards do
   begin
    write(' | ');
     case Hand[j] of
      2..9 : write(Hand[j]);
      10   : write('0');
      1    : write('A');
      11   : write('J');
      12   : write('Q');
      13   : write('K');
     end; {case}
    write(' |');
   end;
  writeln;
  for j := 1 to HCards do
   write('  --- ');
  writeln;
  writeln;
  write('You draw a ');
   case Card of
    2..10 : writeln(Card, '.');
    1     : writeln('Ace.');
    11    : writeln('Jack.');
    12    : writeln('Queen.');
    13    : writeln('King.');
   end; {case}
  if (Card >= 2) and (Card <= 10) then
   CardVal := Card
  else
   if Card <> 1 then
    CardVal := 10
   else
    begin
      repeat
       write('What will the Ace be worth (1 or 11) : ');
       readln(AceVal);
      until (AceVal = 1) or (AceVal = 11);
     CardVal := AceVal;
    end;
  YourTotal := YourTotal + CardVal;
  write('Your total is ', YourTotal, '.');
  readln;
 end;

procedure RaiseBet;
 var
  Key : char;
  Raise : real;
 begin
  writeln;
  writeln('Money in pot: $', Pot);
  writeln('You have $', Money);
   repeat
    write('Raise (Y/N) : ');
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then
   begin
     repeat
      write('Raise by $');
      readln(Raise);
      if Raise > Money then writeln('You only have $', Money);
     until Raise <= Money;
    Money := Money - trunc(Raise);
    Pot := Pot + trunc(Raise * 2);
   end;
 end;

function YouCall : boolean;
 var
  Key : char;
 begin
   repeat
    writeln;
    write('Call (Y/N) : ');
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then YouCall := true else YouCall := false;
 end;

procedure CompDrawCard;
 begin
  writeln;
  writeln('------ Computers Turn -------');
  writeln;
  Card := random(13)+1;
  if Card > 10 then Card := 10;
  if Card = 1 then
   if (CompTotal + 11) <= 21 then
    Card := 11
   else
    Card := 1;
  CompTotal := CompTotal + Card;
  write('The computer draws a card.');
  readln;
 end;

function CompCall : boolean;
 begin
  writeln;
  if CompTotal < 17 then
   begin
    CompCall := false;
    write('The computer doesn''t call.');
    readln;
   end
  else
   begin
    CompCall := true;
    write('The computer calls.');
    readln;
   end;
 end;

procedure FindWinner;
 begin
  writeln;
  writeln('--------- Hand Over ---------');
  writeln;
  writeln('Your Total     : ', YourTotal);
  writeln('Computer Total : ', CompTotal);
  writeln('Pot = $', Pot);
  writeln;
  if ((YourTotal > CompTotal) and (YourTotal <= 21)) or
     ((CompTotal > 21) and (YourTotal <= 21)) then
   begin
    writeln('You win!');
    write('You keep the pot.');
    Money := Money + Pot;
    Pot := 0;
   end;
  if ((YourTotal < CompTotal) and (CompTotal <= 21)) or
     ((YourTotal > 21) and (CompTotal <= 21)) then
   begin
    writeln('You lose.');
    write('The computer keeps the pot.');
    Pot := 0;
   end;
  if ((YourTotal > 21) and (CompTotal > 21)) or
     (YourTotal = CompTotal) then
   begin
    writeln('Tie game.');
    write('The pot stays.');
   end;
  readln;
 end;

function AskDone : boolean;
 var
  Key : char;
 begin
  writeln;
   repeat
    write('Keep playing (Y/N) : ');
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then AskDone := false else AskDone := true;
 end;

begin
 Randomize;
 Title;
 Money := 100;
 Pot := 0;
  repeat
   YourTotal := 0;
   CompTotal := 0;
   for HCards := 1 to 20 do
    Hand[HCards] := 0;
   HCards := 0;
    repeat
     YouDrawCard;
     RaiseBet;
     Call := YouCall;
     CompDrawCard;
     if not Call then
      Call := CompCall;
    until Call;
   FindWinner;
   GameDone := AskDone;
  until GameDone;
end.