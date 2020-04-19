program dj2;

uses
 crt;

Var
 c : char;

procedure start;
 begin
  clrscr;
  randomize;
  textcolor(white);
  textbackground(black);
 end;

procedure cool;
 begin
  writeln('Are you cool');
  writeln('1)Yes');
  writeln('2)No');
 end;

procedure read;
 begin
  c := readkey;
  clrscr;
  cool;
  writeln(C);
  writeln('Press Enter');
 end;

procedure repea;
 begin
  if (c = '1') then
   begin
    clrscr;
    writeln('Your cool.');
    writeln('Press Enter');
   end else
   begin
    clrscr;
    writeln('You suck.');
   end;
  writeln('Press Enter');
 end;

procedure e;
 begin
  textcolor(white);
 end;

begin
 start;
 cool;
 read;
 repeat e;
 until keypressed;
 repea;
 repeat e;
 until keypressed;
end.
