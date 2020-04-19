program Creature;

uses
 Crt;

type
 array1 = array[1..15] of integer;

var
 OrigMode : Word;
 Money : integer;
 BetCreature : integer;
 MoneyBet : integer;
 x, y, j, k, l : integer;
 Play : boolean;
 GoodCreature : boolean;
 GoodPos : boolean;
 Key : char;
 CreaturePos : integer;
 GoodMoney : boolean;
 CreColor : byte;
 CreShape : string;
 RaceOver : boolean;
 CreaturePlace : array1;
 Win, Place, Show : integer;
 WinRace : boolean;
 MoneyGet : integer;
 PlayAgain : boolean;
 CreDone : array1;

procedure Init;
 begin
  OrigMode:=LastMode;
  Randomize;
  Money := 1000;
  Play := true;
 end;

procedure Cursor;
 begin
  textcolor(black);
  textbackground(black);
  gotoxy(1,1);
  write(chr(219));
  gotoxy(1,1);
 end;

procedure ClearWindow;
 begin
  gotoxy(49,21);
  write('                            ');
  gotoxy(49,22);
  write('                            ');
  gotoxy(49,23);
  write('                            ');
  cursor;
 end;

procedure MakeCreature(CreNum : integer);
 begin
  if CreNum = 0 then
   begin
    CreColor := 0;
    CreShape := ' ';
   end;
  if ((CreNum = 1) or (CreNum = 6) or (CreNum = 11)) then CreColor := 4;
  if ((CreNum = 2) or (CreNum = 7) or (CreNum = 12)) then CreColor := 12;
  if ((CreNum = 3) or (CreNum = 8) or (CreNum = 13)) then CreColor := 14;
  if ((CreNum = 4) or (CreNum = 9) or (CreNum = 14)) then CreColor := 7;
  if ((CreNum = 5) or (CreNum = 10) or (CreNum = 15)) then CreColor := 8;
  if CreNum < 6 then CreShape := chr(157);
  if ((CreNum > 5) and (CreNum < 10)) then CreShape := chr(226);
  if CreNum > 9 then CreShape := chr(145);
 end;

procedure Title;
 begin
  textcolor(white);
  textbackground(Black);
  clrscr;
  gotoxy(32,10);
  write('- CreatureRaces v1.0 -');
  gotoxy(34, 12);
  write('Jon Hyland 4/12/95');
  cursor;
  readkey;
 end;

procedure DrawTrack;
 begin
  clrscr;
  textcolor(black);
  gotoxy(1,1);
  write(chr(219), chr(219));
  x := 3;
  textcolor(DarkGray);
  textbackground(black);
  k := 1;
  for x := 3 to 77 do
   begin
    if x > 7 then
     begin
      textbackground(black);
      k := 2;
     end;
    if x > 12 then
     begin
      textbackground(black);
      k := 3;
     end;
    if x > 17 then
     begin
      textbackground(black);
      k := 4;
     end;
    if x > 22 then
     begin
      textbackground(lightgray);
      k := 3;
     end;
    if x > 27 then
     begin
      textbackground(lightgray);
      k := 2;
     end;
    if x > 32 then
     begin
      textbackground(lightgray);
      k := 1;
     end;
    if x > 37 then
     begin
      textbackground(lightgray);
      k := 0;
     end;
    if x > 43 then
     begin
      textbackground(lightgray);
      k := 1;
     end;
    if x > 48 then
     begin
      textbackground(lightgray);
      k := 2;
     end;
    if x > 53 then
     begin
      textbackground(lightgray);
      k := 3;
     end;
    if x > 58 then
     begin
      textbackground(black);
      k := 4;
     end;
    if x > 63 then
     begin
      textbackground(black);
      k := 3;
     end;
    if x > 68 then
     begin
      textbackground(black);
      k := 2;
     end;
    if x > 73 then
     begin
      textbackground(black);
      k := 1;
     end;
    gotoxy(x, 2);
    if k = 0 then write(' ');
    if k = 1 then write(chr(176));
    if k = 2 then write(chr(177));
    if k = 3 then write(chr(178));
    if k = 4 then write(chr(219));
    gotoxy(x, 20);
    if k = 0 then write(' ');
    if k = 1 then write(chr(176));
    if k = 2 then write(chr(177));
    if k = 3 then write(chr(178));
    if k = 4 then write(chr(219));
    gotoxy(x, 24);
    if k = 0 then write(' ');
    if k = 1 then write(chr(176));
    if k = 2 then write(chr(177));
    if k = 3 then write(chr(178));
    if k = 4 then write(chr(219));
   end;
  for y := 2 to 24 do
   begin
    if y > 2 then
     begin
      textbackground(black);
      k := 2;
     end;
    if y > 4 then
     begin
      textbackground(black);
      k := 3;
     end;
    if y > 5 then
     begin
      textbackground(black);
      k := 4;
     end;
    if y > 7 then
     begin
      textbackground(lightgray);
      k := 3;
     end;
    if y > 8 then
     begin
      textbackground(lightgray);
      k := 2;
     end;
    if y > 10 then
     begin
      textbackground(lightgray);
      k := 1;
     end;
    if y > 11 then
     begin
      textbackground(lightgray);
      k := 0;
     end;
    if y > 13 then
     begin
      textbackground(lightgray);
      k := 1;
     end;
    if y > 14 then
     begin
      textbackground(lightgray);
      k := 2;
     end;
    if y > 16 then
     begin
      textbackground(lightgray);
      k := 3;
     end;
    if y > 17 then
     begin
      textbackground(black);
      k := 4;
     end;
    if y > 19 then
     begin
      textbackground(black);
      k := 3;
     end;
    if y > 20 then
     begin
      textbackground(black);
      k := 2;
     end;
    if y > 22 then
     begin
      textbackground(black);
      k := 1;
     end;
    gotoxy(2, y);
    if k = 0 then write('  ');
    if k = 1 then write(chr(176), chr(176));
    if k = 2 then write(chr(177), chr(177));
    if k = 3 then write(chr(178), chr(178));
    if k = 4 then write(chr(219), chr(219));
    gotoxy(78, y);
    if k = 0 then write('  ');
    if k = 1 then write(chr(176), chr(176));
    if k = 2 then write(chr(177), chr(177));
    if k = 3 then write(chr(178), chr(178));
    if k = 4 then write(chr(219), chr(219));
   end;
  textcolor(darkgray);
  textbackground(lightgray);
  for y := 21 to 23 do
   begin
    gotoxy(23, y);
    write(chr(178), chr(178));
    gotoxy(47, y);
    write(chr(176), chr(176));
   end;
  textbackground(black);
  for j := 1 to 15 do
   begin
    if ((j = 1 ) or (j = 6) or (j = 11)) then textcolor(red);
    if ((j = 2 ) or (j = 7) or (j = 12)) then textcolor(lightred);
    if ((j = 3 ) or (j = 8) or (j = 13)) then textcolor(yellow);
    if ((j = 4 ) or (j = 9) or (j = 14)) then textcolor(lightgray);
    if ((j = 5 ) or (j = 10) or (j = 15)) then textcolor(darkgray);
    gotoxy(5, j+3);
    if j < 10 then write('0', j) else write(j);
    write(' ');
    if j > 10  then write(chr(145));
    if ((j > 5) and (j < 11)) then write(chr(226));
    if j < 6 then write(chr(157));
   end;
  textcolor(white);
  gotoxy(9,3);
  write(chr(194));
  gotoxy(9,19);
  write(chr(193));
  gotoxy(76,3);
  write(chr(210));
  gotoxy(76,19);
  write(chr(208));
  for y := 4 to 18 do
   begin
    gotoxy(9, y);
    write(chr(179));
    gotoxy(76, y);
    write(chr(186));
   end;
  for x := 10 to 75 do
   begin
    for y := 4 to 18 do
     begin
      gotoxy(x,y);
      write(chr(250));
     end;
   end;
  gotoxy(5, 21);
  write('Win   :');
  gotoxy(5, 22);
  write('Place :');
  gotoxy(5, 23);
  write('Show  :');
  gotoxy(26, 22);
  write('Money : $', Money);
  Cursor;
 end;

procedure AskCreature;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(57,21);
  write('What Creature');
  gotoxy(57,22);
  write('Do You Want?');
  gotoxy(58,23);
  write('(1-15):             ');
  gotoxy(66,23);
  read(BetCreature);
 end;

procedure AskPos;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(57,21);
  write('What Will Your');
  gotoxy(58,22);
  write('Creature Do?');
  gotoxy(54,23);
  write('(W)in (P)lace (S)how');
  Key := readkey;
  CreaturePos := 0;
  if ((Key = 'W') or (Key = 'w')) then CreaturePos := 1;
  if ((Key = 'P') or (Key = 'p')) then CreaturePos := 2;
  if ((Key = 'S') or (Key = 's')) then CreaturePos := 3;
  if CreaturePos <> 0 then GoodPos := true;
 end;

procedure AskMoneyBet;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(59,21);
  write('How Much');
  gotoxy(58,22);
  write('Money Will');
  gotoxy(57,23);
  write('You Bet? $ ');
  read(MoneyBet);
  if ((MoneyBet <= Money) and (MoneyBet > 0)) then GoodMoney := true;
 end;

procedure AboutToBegin;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(50,22);
  write('Race About to Begin...');
  for j := 1 to 5 do
   begin
    textcolor(white);
    gotoxy(73,22);
    write(6-j);
    cursor;
    delay(1000);
   end;
  textcolor(white);
  for y := 4 to 18 do
   begin
    gotoxy(9,y);
    write('__');
   end;
 end;

procedure DrawBet;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(51,21);
  write('Creature :');
  gotoxy(51,22);
  write('Position :');
  gotoxy(51,23);
  write('Money Bet: $', MoneyBet);
  gotoxy(62,21);
  write(BetCreature);
  textcolor(white);
  gotoxy(62,22);
  if CreaturePos = 1 then write('Win');
  if CreaturePos = 2 then write('Place');
  if CreaturePos = 3 then write('Show');
  cursor;
 end;

procedure Race;
 var
  r1, r2 : integer;
  Move : integer;
  OldPos : integer;
  Change : boolean;
  AnyLeft : boolean;
  Placed : boolean;
 begin
  RaceOver := false;
  for j := 1 to 15 do
   begin
    CreaturePlace[j] := 0;
    CreDone[j] := 0;
   end;
  Win := 0;
  Place := 0;
  Show := 0;
   repeat
    delay(25);
    r1 := random(15)+1;
    if CreDone[r1] = 0 then
     begin
      r2 := random(5)+1;
      if r2 < 4 then Move := 1;
      if r2 = 4 then Move := +2;
      if r2 = 5 then Move := +3;
      OldPos := CreaturePlace[r1];
      CreaturePlace[r1] := CreaturePlace[r1] + Move;
      if CreaturePlace[r1] < 0 then CreaturePlace[r1] := 0;
      if CreaturePlace[r1] > 66 then CreaturePlace[r1] := 67;
      if CreaturePlace[r1] >= 67 then
       begin
        CreDone[r1] := 1;
        Placed := false;
        if Placed = false then
         begin
          if Win = 0 then
           begin
            Win := r1;
            Placed := true;
           end;
         end;
        if Placed = false then
         begin
          if Place = 0 then
           begin
            Place := r1;
            Placed := true;
           end;
         end;
        if Placed = false then
         begin
          if Show = 0 then
           begin
            Show := r1;
            Placed := true;
           end;
         end;
        if Win > 0 then
         begin
          gotoxy(13,21);
          textcolor(white);
          write(Win);
         end;
        if Place > 0 then
         begin
          gotoxy(13,22);
          textcolor(white);
          write(Place);
         end;
        if Show > 0 then
         begin
          gotoxy(13,23);
          textcolor(white);
          write(Show);
         end;
        cursor;
       end;
      MakeCreature(r1);
      gotoxy(OldPos+8, r1+3);
      textcolor(white);
      if OldPos = 0 then write(' ');
      if OldPos = 1 then write('_');
      if OldPos = 2 then write('_');
      if OldPos > 2 then write(chr(250));
      textcolor(CreColor);
      gotoxy(CreaturePlace[r1]+8,r1+3);
      write(CreShape);
      Cursor;
     end;
    AnyLeft := false;
    for j := 1 to 15 do
     begin
      if CreDone[j] = 0 then AnyLeft := true;
     end;
    if AnyLeft = false then RaceOver := true;
   until RaceOver = true;
 end;

procedure AskPlayAgain;
 begin
  ClearWindow;
  textcolor(white);
  gotoxy(54,22);
  write('Keep Playing? (Y/N)');
  Key := readkey;
  if ((Key = 'y') or (Key = 'Y')) then
   begin
    Play := true;
    PlayAgain := true;
   end;
  if ((Key = 'n') or (Key = 'N')) then
   begin
    Play := false;
    PlayAgain := true;
   end;
 end;

procedure DrawEnd;
 var
  t, b, l, r, j, c : integer;
 begin
  t := 2;
  b := 24;
  l := 1;
  r := 39;
  c := 0;
  repeat
   for j := l*2 to r*2 do
    begin
     gotoxy(j, t);
     write(' ');
    end;
   for j := t to b do
    begin
     gotoxy(r*2, j);
     write('  ');
    end;
   j := r*2;
    repeat
     gotoxy(j, b);
     write(' ');
     j := j - 1;
    until j < l*2;
   j := b;
    repeat
     gotoxy(l*2, j);
     write('  ');
     j := j - 1;
    until j < t;
   t := t + 1;
   b := b - 1;
   r := r - 1;
   l := l + 1;
   cursor;
   delay(10);
   c := c + 1;
  until c > 40;
  textcolor(white);
  textbackground(black);
  clrscr;
  TextMode(OrigMode);
  Halt(3);
 end;

begin
 Init;
 Title;
 while Play = true do
  begin
   DrawTrack;
   GoodCreature := false;
    repeat
     AskCreature;
     if ((BetCreature > 0) and (BetCreature < 16)) then GoodCreature := true;
    until GoodCreature = true;
   GoodPos := false;
    repeat
     AskPos;
    until GoodPos = true;
   GoodMoney := false;
    repeat
     AskMoneyBet;
    until GoodMoney = true;
   Money := Money - MoneyBet;
   gotoxy(36,22);
   write('           ');
   gotoxy(35,22);
   write(Money);
   Cursor;
   AboutToBegin;
   DrawBet;
   Race;
   WinRace := false;
   if CreaturePos = 1 then if ((Win = BetCreature)) then
    begin
     WinRace := true;
     MoneyGet := MoneyBet * 15;
    end;
   if CreaturePos = 2 then if ((Win = BetCreature) or
    (Place = BetCreature)) then
    begin
     Winrace := true;
     MoneyGet := MoneyBet * 7;
    end;
   if CreaturePos = 3 then if ((Win = BetCreature) or
    (Place = BetCreature) or (Show = BetCreature)) then
    begin
     Winrace := true;
     MoneyGet := MoneyBet * 5;
    end;
   if WinRace = true then
    begin
     ClearWindow;
     gotoxy(54,21);
     textcolor(white);
     write('Your Creature ');
     if CreaturePos = 1 then write('Wins!');
     if CreaturePos = 2 then write('Places!');
     if CreaturePos = 3 then write('Shows!');
     gotoxy(58,22);
     write('You Collect');
     gotoxy(61,23);
     write('$', MoneyGet);
     Money := Money + MoneyGet;
     gotoxy(36,22);
     write('           ');
     gotoxy(35,22);
     write(Money);
     Cursor;
     readkey;
    end else
    begin
     ClearWindow;
     textcolor(white);
     gotoxy(56,22);
     write('Sorry. You Lose.');
     readkey;
     if Money <= 0 then
      begin
       ClearWindow;
       textcolor(white);
       gotoxy(54,22);
       write('You are out of money.');
       Cursor;
       readkey;
       DrawEnd;
      end;
    end;
   PlayAgain := false;
    repeat
     AskPlayAgain;
    until PlayAgain = true;
  end;
 DrawEnd;
end.