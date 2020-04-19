program Test;

{$N+,E+}

var
 Seed : extended;
 j : integer;
 Num : array[1..100] of integer;

function Pwr(n : real; e : integer) : extended;
 var
  j : integer;
  nn : real;
 begin
  nn := 1;
  for j := 1 to e do nn := nn * n;
  Pwr := nn;
 end;

function RealMod(Nmr, Dnm : extended) : extended;
 begin
  RealMod := ((Nmr / Dnm) - int(Nmr / Dnm)) * Dnm;
 end;

function RandomX : extended;
 begin
  Seed := RealMod((Pwr(7,5) * Seed),(Pwr(2,31)-1));
  RandomX := Seed;
 end;

function RandomJ(Range : integer) : integer;
 var
  Rand : extended;
 begin
  Rand := RandomX;
  while (Rand > 1) do Rand := Rand / 10;
  Rand := (Rand * 13) + 1;
  RandomJ := trunc(Rand);
 end;

begin
 for j := 1 to 100 do Num[j] := 0;
 write('Seed: ');
 readln(Seed);
 for j := 1 to 25 do
  begin
   writeln(RandomJ(13));
  end;
 readln;
end.