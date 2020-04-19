program PlayMusic;

uses
 Crt;

var
 j : integer;
const
  Music : array[1..16] of integer = (121,121,186,121,196,121,186,121,98,98,
                                     146,156,92,92,138,146);
  Del : array[1..16] of integer = (15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
                                    0, 15, 15, 15, 0, 15 );


begin
 clrscr;
 j := 1;
  repeat
   sound(Music[j]);
   delay(300-Del[j]);
   nosound;
   delay(Del[j]);
   j := j + 1;
   if j > 16 then j := 1;
  until KeyPressed;
end.
