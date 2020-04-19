program SimpleAlarm;

uses
 Crt, Dos;

const
 Decb = 220;

var
 WHour,
 WMin : integer;
 Hour,
 Min,
 Sec,
 Sec100 : word;
 Alarm : boolean;
 LS : integer;
 Key : char;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 Alarm := false;
  repeat
   write('Enter Wake Hour (0..23) : ');
   readln(WHour);
  until WHour in [0..23];
  repeat
   write('Enter Wake Minute (0..59) : ');
   readln(WMin);
  until WMin in [0..59];
  repeat
   gettime(Hour, Min, Sec, Sec100);
   if (Hour = WHour) and (Min = WMin) then
    begin
     Alarm := true;
     textcolor(red);
     sound(Decb);
    end;
   writeln(Hour, ' : ', Min, ' : ', Sec, ' : ', Sec100);
   if KeyPressed then
    Key := readkey;
  until Key in [#27, #32, #13];
 nosound;
 clrscr;
end.


