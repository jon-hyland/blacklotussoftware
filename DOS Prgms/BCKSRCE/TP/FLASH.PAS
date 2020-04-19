program Flash1_0;

uses
 Crt;

{$I FLASHPIC.PIC}

type
 AnsArray = array [1..3999] of byte;
 RemArray = array[1..100] of integer;
 BlinkType = (On, Off);

var
 Screen : AnsArray absolute $B800:0000;
 Flash  : RemArray;
 Num    : integer;
 Key    : char;
 Quit   : boolean;
 Lose   : boolean;
 x      : integer;
 Button : integer;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(30,10);
  write('- Flash  v1.0 -');
  gotoxy(25,12);
  write('(c) 1996  BlackWolf Productions');
  Cursor;
  readkey;
 end;

procedure Init;
 var
  x : integer;
 begin
  randomize;
  for x := 1 to 100 do
   Flash[x] := 0;
  Num := 1;
  Quit := false;
  Lose := false;
 end;

procedure DrawScreen;
 begin
  clrscr;
  Move(FlashPic, Screen, 4000);
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  textcolor(white);
  Cursor;
 end;

procedure Blink(Num : integer; Blink : BlinkType);
 var
  x, y  : integer;
  j, k  : integer;
  Color : integer;
 begin
   case Num of
    1 : Color := 12;
    2 : Color := 9;
    3 : Color := 13;
    4 : Color := 10;
   end; {case}
  if Blink = Off then Color := Color - 8;
   case Num of
    1, 4 : x := 33;
    2    : x := 21;
    3    : x := 45;
   end; {case}
   case Num of
    1    : y := 5;
    2, 3 : y := 10;
    4    : y := 15;
   end; {case}
  textcolor(Color);
  for k := y to y + 3 do
   for j := x to x + 9 do
    begin
     gotoxy(j,k);
     write(#219);
    end;
  Cursor;
 end;

begin
 Title;
 Init;
 DrawScreen;
  repeat
   delay(500);
   Flash[Num] := random(4)+1;
   for x := 1 to Num do
    begin
     Blink(Flash[x], On);
     sound(100 + (Flash[x] * 100));
     delay(200);
     Blink(Flash[x], Off);
     nosound;
     delay(200);
    end;

   x := 1;
    repeat
      repeat
       Key := readkey;
      until Key in ['H', 'K', 'P', 'M', #27];
      case Key of
       'H' : Button := 1;
       'K' : Button := 2;
       'M' : Button := 3;
       'P' : Button := 4;
      end; {case}
     Blink(Button, On);
     if Button <> Flash[x] then
      sound(75)
     else
      sound(100 + (Button * 100));
     delay(200);
     nosound;
     Blink(Button, Off);
     if Button <> Flash[x] then Lose := true;
     x := x + 1;
    until Lose or Quit or (x > Num);
   Num := Num + 1;
  until Lose or Quit;

end.