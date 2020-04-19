program Dice;

uses
 Crt;

var
 Four,
 Six,
 Eight,
 Ten,
 Hundred,
 Twelve,
 Twenty : integer;
 j : integer;
 Key : char;

begin
 randomize;
  repeat
   Four := random(4)+1;
   Six := random(6)+1;
   Eight := random(8)+1;
   Ten := random(10)+1;
   Hundred := random(10) * 10;
   Twelve := random(12)+1;
   Twenty := random(20)+1;
   clrscr;
   writeln('1) Four    --> ', Four);
   writeln;
   writeln('2) Six     --> ', Six);
   writeln;
   writeln('3) Eight   --> ', Eight);
   writeln;
   writeln('4) Ten     --> ', Ten);
   writeln;
   writeln('5) Hundred --> ', Hundred);
   writeln;
   writeln('6) Twelve  --> ', Twelve);
   writeln;
   writeln('7) Twenty  --> ', Twenty);
   writeln;
   write('Press any key for reroll or (Esc) to end..');
   Key := readkey;
  until ord(Key) = 27;
end.
