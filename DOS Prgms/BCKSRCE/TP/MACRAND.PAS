program Test;

var
 j : integer;
 Seed : real;
 OldSeed : real;

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
 for j := 1 to 100 do
  writeln('Rand Num ', j, ': ', RandNum(100));
 readln;
end.