program Casino;

uses
 Crt;

var
 money : integer;
 bet : integer;
 number : integer;
 play : boolean;
 rndmnum : integer;
 j : integer;
 lines : integer;
 pa : string;

begin
 randomize;
 clrscr;
 money := 100;
 play := true;
 lines := 1;
  repeat
   writeln('You have $', money, '.');
   lines := lines + 1;
    repeat
     write('How much will you bet $');
     readln(bet);
     lines := lines + 1;
    until ((bet <= money) and (bet > 0));
    repeat
     write('What will the number be (1-10): ');
     readln(number);
     lines := lines + 1;
    until ((number >= 1) and (number <= 10));
    if lines > 24 then lines := 24;
    write('Number:');
    for j := 1 to random(250) do
     begin
      gotoxy(9, lines);
      write('  ');
      gotoxy(9, lines);
      rndmnum := random(10)+1;
      write(rndmnum);
      delay(10);
     end;
    readkey;
    if rndmnum = number then
     begin
      writeln;
      writeln('You win!!');
      writeln('You get $', bet * 10, '!');
      lines := lines + 3;
      money := money + bet * 10;
     end
     else begin
      writeln;
      writeln('You lose.');
      writeln('You pay $', bet, '.');
      lines := lines + 3;
      money := money - bet;
      if money < 0 then money := 0;
      if money = 0 then
       begin
        writeln('You are out of money.');
        writeln('Game Over');
        readkey;
        halt;
       end;
     end;
     repeat
      write('Play Again (Y/N): ');
      lines := lines + 1;
      readln(pa);
     until ((pa = 'y') or (pa = 'Y') or (pa = 'n') or (pa = 'N'));
    if ((pa = 'n') or (pa = 'N')) then play := false;
    writeln;
    lines := lines + 1;
  until play = false;
 clrscr;
end.

