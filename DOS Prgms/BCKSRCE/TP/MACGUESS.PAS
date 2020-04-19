program GuessGame;

uses
 Crt;

var
 Seed : real;
 OldSeed : real;
 Number,
 Tries,
 Guess : integer;
 PlayAgain : char;

procedure GetSeed;
 var
  Dv : real;
 begin
  repeat
   write('Number (999-9999) : ');
   readln(Seed);
  until (Seed >= 999) and (Seed <= 9999);
  repeat
   write('Number (1-10) : ');
   readln(Dv);
  until (Dv >= 1) and (Dv <= 10);
  OldSeed := Seed / Dv;
 end;

function RandNum(Range : integer) : integer;
 var
  CountUntil : integer;
  Count : integer;
  Rand : integer;
 begin
  CountUntil := trunc(Seed / (OldSeed / 100));
  for Count := 1 to CountUntil do
   begin
     repeat
      OldSeed := Seed;
      Seed := Seed * OldSeed;
      while Seed > 1 do Seed := Seed / 10;
      if (Count mod 2) = 0 then
       Rand := trunc(Seed * (Range + 1)) - 1
      else
       Rand := Range - ((trunc(Seed * (Range + 1)) - 1)  - 1);
      while Seed < 1000 do Seed := Seed * 10;
     until (Rand >= 1) and (Rand <= Range);
   end;
  RandNum := Rand;
 end;

begin
 GetSeed;
  repeat
   ClrScr;
   writeln('You need to guess the random number between 1 and 1000 in as');
   writeln('little tries as possible.');
   Tries := 0;
   Number := RandNum(1000);
    repeat
     Tries := Tries + 1;
     writeln;
     writeln('Try #', Tries);
      repeat
       write('What is your guess (1-1000): ');
       readln(Guess);
      until (Guess >= 1) and (Guess <= 1000);
     if Guess < Number then writeln('Too low.');
     if Guess > Number then writeln('Too high.');
    until Guess = Number;
   writeln('You win!');
    repeat
     write('Play again (Y/N): ');
     readln(PlayAgain);
     if PlayAgain = 'y' then PlayAgain := 'Y';
     if PlayAgain = 'n' then PlayAgain := 'N';
    until (PlayAgain = 'Y') or (PlayAgain = 'N');
  until PlayAgain = 'N';
end.
