

Program Dj1;

uses
 crt;

var
 X : integer;
 c : char;

procedure Getup;
 begin
  randomize;
  textcolor(white);
  textbackground(black);
 end;

procedure Goo;
 begin
  clrscr;
  writeln('Are you cool.');
  writeln('1)Yes');
  writeln('2)No');
 end;

procedure Answer;
 begin
  write(':');
  readln(x);
 end;

procedure cool;
 begin
  clrscr;
  writeln('Your cool.');
 end;




procedure suck;
 begin
   clrscr;
   if (x = 2)then
    begin
     writeln('You suck.');
    end
    else
    begin
     getup;
    end;
 end;

procedure stall;
 begin
  repeat
   textcolor(white);
  until keypressed;
 end;

procedure go2;
 begin
  if x = 1 then
   begin
    cool;
   end else
   begin
    suck;
   end;
 end;

begin
 getup;
 goo;
 answer;
 go2;
 stall;
end.
