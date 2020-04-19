program Crazy8s;

uses
 Crt;

type
 NumOfCards = array[1..52] of integer;
 ArrayInt = array[1..10, 1..29] of integer;
 ArrayStr = array[1..10, 1..29] of string[1];

var
 OrigMode : Word;
 Deck : NumOfCards;
 Plr1Hnd : NumOfCards;
 Plr2Hnd : NumOfCards;
 Discard : NumOfCards;
 DeckCds : integer;
 Plr1Cds : integer;
 Plr2Cds : integer;
 Plr1Pts : integer;
 Plr2Pts : integer;
 DsrdCds : integer;
 Hand : Integer;
 Card : String;
 Play : Boolean;
 Player : integer;
 CrdSuit : string;
 CrdNum : string;
 CrdVal : integer;
 PointCard : integer;
 key : char;
 Msg : boolean;
 NumPass : integer;
 Plr1NP : integer;
 Plr2NP : integer;
 YNPoint : integer;
 j : integer;
 press : integer;

procedure Init;
 begin
  OrigMode:=LastMode;
  randomize;
  textbackground(black);
  textcolor(white);
 end;

procedure Cursor;
 begin
  textcolor(black);
  textbackground(black);
  gotoxy(1,1);
  write(' ');
  gotoxy(1,1);
 end;


procedure Title;
 var
  TitleFor : ArrayInt;
  TitleBck : ArrayInt;
  TitleCnt : ArrayInt;
  TitleStr : ArrayStr;
  j, k, x, y : integer;
  GoodPt : boolean;
 begin
  for j := 1 to 10 do
   begin
    for k := 1 to 29 do
     begin
      TitleStr[j, k] := chr(255);
     end;
   end;
  TitleStr[01,03] := chr(220);
  TitleStr[01,04] := chr(220);
  TitleStr[01,05] := chr(220);
  TitleStr[01,06] := chr(220);
  TitleStr[01,08] := chr(220);
  TitleStr[01,09] := chr(220);
  TitleStr[01,10] := chr(220);
  TitleStr[01,11] := chr(220);
  TitleStr[01,13] := chr(220);
  TitleStr[01,14] := chr(220);
  TitleStr[01,15] := chr(220);
  TitleStr[01,16] := chr(220);
  TitleStr[01,18] := chr(220);
  TitleStr[01,19] := chr(220);
  TitleStr[01,20] := chr(220);
  TitleStr[01,21] := chr(220);
  TitleStr[01,22] := chr(220);
  TitleStr[01,24] := chr(220);
  TitleStr[01,28] := chr(220);
  TitleStr[02,03] := chr(219);
  TitleStr[02,08] := chr(219);
  TitleStr[02,09] := chr(220);
  TitleStr[02,10] := chr(220);
  TitleStr[02,11] := chr(219);
  TitleStr[02,13] := chr(219);
  TitleStr[02,14] := chr(220);
  TitleStr[02,15] := chr(220);
  TitleStr[02,16] := chr(219);
  TitleStr[02,20] := chr(220);
  TitleStr[02,21] := chr(223);
  TitleStr[02,22] := chr(255);
  TitleStr[02,25] := chr(223);
  TitleStr[02,26] := chr(220);
  TitleStr[02,27] := chr(223);
  TitleStr[03,03] := chr(223);
  TitleStr[03,04] := chr(223);
  TitleStr[03,05] := chr(223);
  TitleStr[03,06] := chr(223);
  TitleStr[03,08] := chr(223);
  TitleStr[03,10] := chr(223);
  TitleStr[03,11] := chr(223);
  TitleStr[03,13] := chr(223);
  TitleStr[03,16] := chr(223);
  TitleStr[03,18] := chr(223);
  TitleStr[03,19] := chr(223);
  TitleStr[03,20] := chr(223);
  TitleStr[03,21] := chr(223);
  TitleStr[03,22] := chr(223);
  TitleStr[03,26] := chr(223);
  TitleStr[05,01] := chr(220);
  TitleStr[05,02] := chr(220);
  TitleStr[05,03] := chr(220);
  TitleStr[05,04] := chr(220);
  TitleStr[05,06] := chr(220);
  TitleStr[05,07] := chr(220);
  TitleStr[05,08] := chr(220);
  TitleStr[05,10] := chr(220);
  TitleStr[05,11] := chr(220);
  TitleStr[05,12] := chr(220);
  TitleStr[05,13] := chr(220);
  TitleStr[05,15] := chr(220);
  TitleStr[05,18] := chr(220);
  TitleStr[05,20] := chr(220);
  TitleStr[05,21] := chr(220);
  TitleStr[05,22] := chr(220);
  TitleStr[05,23] := chr(220);
  TitleStr[05,24] := chr(220);
  TitleStr[05,26] := chr(220);
  TitleStr[05,27] := chr(220);
  TitleStr[05,28] := chr(220);
  TitleStr[05,29] := chr(220);
  TitleStr[06,01] := chr(219);
  TitleStr[06,02] := chr(220);
  TitleStr[06,03] := chr(220);
  TitleStr[06,07] := chr(219);
  TitleStr[06,10] := chr(219);
  TitleStr[06,12] := chr(220);
  TitleStr[06,13] := chr(220);
  TitleStr[06,15] := chr(219);
  TitleStr[06,16] := chr(220);
  TitleStr[06,17] := chr(220);
  TitleStr[06,18] := chr(219);
  TitleStr[06,22] := chr(219);
  TitleStr[06,26] := chr(219);
  TitleStr[06,27] := chr(220);
  TitleStr[06,28] := chr(220);
  TitleStr[06,29] := chr(220);
  TitleStr[07,01] := chr(223);
  TitleStr[07,02] := chr(223);
  TitleStr[07,03] := chr(223);
  TitleStr[07,04] := chr(223);
  TitleStr[07,06] := chr(223);
  TitleStr[07,07] := chr(223);
  TitleStr[07,08] := chr(223);
  TitleStr[07,10] := chr(223);
  TitleStr[07,11] := chr(223);
  TitleStr[07,12] := chr(223);
  TitleStr[07,13] := chr(223);
  TitleStr[07,15] := chr(223);
  TitleStr[07,18] := chr(223);
  TitleStr[07,22] := chr(223);
  TitleStr[07,26] := chr(223);
  TitleStr[07,27] := chr(223);
  TitleStr[07,28] := chr(223);
  TitleStr[07,29] := chr(223);
  TitleStr[09,25] := 'v';
  TitleStr[09,26] := '1';
  TitleStr[09,27] := '.';
  TitleStr[09,28] := '0';
  TitleStr[10,08] := chr(157);
  TitleStr[10,10] := 'D';
  TitleStr[10,11] := 'e';
  TitleStr[10,12] := 'a';
  TitleStr[10,13] := 't';
  TitleStr[10,14] := 'h';
  TitleStr[10,16] := 'S';
  TitleStr[10,17] := 'l';
  TitleStr[10,18] := 'a';
  TitleStr[10,19] := 'y';
  TitleStr[10,20] := 'e';
  TitleStr[10,21] := 'r';
  TitleStr[10,23] := chr(157);
  for j := 1 to 29 do TitleFor[1, j] := 4;
  for j := 1 to 29 do TitleFor[2, j] := 12;
  for j := 1 to 29 do TitleFor[3, j] := 14;
  for j := 1 to 29 do TitleFor[4, j] := 0;
  for j := 1 to 29 do TitleFor[5, j] := 4;
  for j := 1 to 29 do TitleFor[6, j] := 12;
  for j := 1 to 29 do TitleFor[7, j] := 14;
  for j := 1 to 29 do TitleFor[8, j] := 0;
  TitleFor[3, 04] := 0;
  TitleFor[3, 05] := 0;
  TitleFor[3, 06] := 0;
  TitleFor[3, 11] := 0;
  TitleFor[3, 18] := 0;
  TitleFor[3, 20] := 0;
  TitleFor[3, 21] := 0;
  TitleFor[3, 22] := 0;
  TitleFor[7, 02] := 0;
  TitleFor[7, 03] := 0;
  TitleFor[7, 04] := 0;
  TitleFor[7, 06] := 0;
  TitleFor[7, 08] := 0;
  TitleFor[7, 11] := 0;
  TitleFor[7, 12] := 0;
  TitleFor[7, 26] := 0;
  TitleFor[7, 27] := 0;
  TitleFor[7, 28] := 0;
  TitleFor[9, 25] := 12;
  TitleFor[9, 26] := 12;
  TitleFor[9, 27] := 12;
  TitleFor[9, 28] := 12;
  TitleFor[10, 08] := 04;
  TitleFor[10, 10] := 04;
  TitleFor[10, 11] := 04;
  TitleFor[10, 12] := 12;
  TitleFor[10, 13] := 12;
  TitleFor[10, 14] := 14;
  TitleFor[10, 16] := 14;
  TitleFor[10, 17] := 12;
  TitleFor[10, 18] := 12;
  TitleFor[10, 19] := 12;
  TitleFor[10, 20] := 04;
  TitleFor[10, 21] := 04;
  TitleFor[10, 23] := 04;
  for j := 1 to 10 do
   begin
    for k := 1 to 29 do
     begin
      TitleBck[j, k] := 0;
     end;
   end;
  TitleBck[3, 03] := 7;
  TitleBck[3, 04] := 7;
  TitleBck[3, 05] := 7;
  TitleBck[3, 06] := 7;
  TitleBck[3, 08] := 7;
  TitleBck[3, 11] := 7;
  TitleBck[3, 13] := 7;
  TitleBck[3, 16] := 7;
  TitleBck[3, 18] := 7;
  TitleBck[3, 19] := 7;
  TitleBck[3, 20] := 7;
  TitleBck[3, 21] := 7;
  TitleBck[3, 22] := 7;
  TitleBck[3, 26] := 7;
  TitleBck[7, 01] := 7;
  TitleBck[7, 02] := 7;
  TitleBck[7, 03] := 7;
  TitleBck[7, 04] := 7;
  TitleBck[7, 06] := 7;
  TitleBck[7, 07] := 7;
  TitleBck[7, 08] := 7;
  TitleBck[7, 10] := 7;
  TitleBck[7, 11] := 7;
  TitleBck[7, 12] := 7;
  TitleBck[7, 13] := 7;
  TitleBck[7, 15] := 7;
  TitleBck[7, 18] := 7;
  TitleBck[7, 22] := 7;
  TitleBck[7, 26] := 7;
  TitleBck[7, 27] := 7;
  TitleBck[7, 28] := 7;
  TitleBck[7, 29] := 7;
  clrscr;
  for j := 1 to 10 do
   begin
    for k := 1 to 29 do
     begin
      TitleCnt[j, k] := 0;
     end;
   end;
  for j := 1 to 290 do
   begin
    GoodPt := false;
     repeat
      x := random(29)+1;
      y := random(10)+1;
      if TitleCnt[y, x] = 0 then GoodPt := true;
     until GoodPt = true;
    TitleCnt[y, x] := 1;
    textcolor(TitleFor[y, x]);
    textbackground(TitleBck[y, x]);
    gotoxy(x+26, y+3);
    write(TitleStr[y, x]);
    delay(1);
   end;
  cursor;
  readkey;
 end;

procedure Shuffle;
 var
  c : Integer;
  j, k : integer;
  y1, y2 : integer;
 begin
  for j := 1 to 52 do Deck[j] := 0;
  for j := 1 to 52 do
   begin
    y1 := 0;
    while y1 = 0 do
     begin
      c := (random(13)+1) + ((random(4)+1)*100);
      y2 := 1;
      for k := 1 to 52 do if Deck[k] = c then y2 := 0;
      if y2 = 1 then y1 := 1;
     end;
    Deck[j] := c;
   end;
  DeckCds := 52;
 end;

procedure Deal;
 var
  j : integer;
  p : integer;
 begin
  Plr1Cds := 0;
  Plr2Cds := 0;
  for j := 1 to 52 do
   begin
    Plr1Hnd[j] := 0;
    Plr2Hnd[j] := 0;
   end;
  p := 1;
  for j := 1 to 14 do
   begin
    if p = 1 then
     begin
      Plr1Hnd[Plr1Cds+1] := Deck[DeckCds];
      Deck[DeckCds] := 0;
      DeckCds := DeckCds - 1;
      Plr1Cds := Plr1Cds + 1;
     end;
    if p = 2 then
     begin
      Plr2Hnd[Plr2Cds+1] := Deck[DeckCds];
      Deck[DeckCds] := 0;
      DeckCds := DeckCds - 1;
      Plr2Cds := Plr2Cds + 1;
     end;
    if p = 1 then p := 2 else p := 1;
   end;
  Discard[1] := Deck[DeckCds];
  DsrdCds := 1;
  Deck[DeckCds] := 0;
  DeckCds := DeckCds - 1;
 end;

function Num2Crd(Num : Integer) : String;
 var
  j : integer;
  c1 : string;
  c2 : string;
  c3 : integer;
 begin
  if Num > 100 then c2 := chr(6);
  if Num > 200 then c2 := chr(5);
  if Num > 300 then c2 := chr(4);
  if Num > 400 then c2 := chr(3);
  if c2 = chr(6) then c3 := Num - 100;
  if c2 = chr(5) then c3 := Num - 200;
  if c2 = chr(4) then c3 := Num - 300;
  if c2 = chr(3) then c3 := Num - 400;
  c3 := c3 + 1;
  str(c3,c1);
  if c3 = 11 then c1 := 'J';
  if c3 = 12 then c1 := 'Q';
  if c3 = 13 then c1 := 'K';
  if c3 = 14 then c1 := 'A';
  Num2Crd := c1 + c2;
  crdnum := c1;
  crdsuit := c2;
  if CrdNum = 'A' then CrdVal := 1;
  if CrdNum = '2' then CrdVal := 2;
  if CrdNum = '3' then CrdVal := 3;
  if CrdNum = '4' then CrdVal := 4;
  if CrdNum = '5' then CrdVal := 5;
  if CrdNum = '6' then CrdVal := 6;
  if CrdNum = '7' then CrdVal := 7;
  if CrdNum = '8' then CrdVal := 25;
  if CrdNum = '9' then CrdVal := 9;
  if CrdNum = '10' then CrdVal := 10;
  if CrdNum = 'J' then CrdVal := 10;
  if CrdNum = 'Q' then CrdVal := 10;
  if CrdNum = 'K' then CrdVal := 10;
 end;

procedure DrawScreen;
 var
  j : integer;
 begin
  clrscr;
  textcolor(red);
  for j := 2 to 78 do
   begin
    gotoxy(j,2);
    write(chr(219));
    gotoxy(j,20);
    write(chr(219));
    gotoxy(j,24);
    write(chr(219));
   end;
  for j := 2 to 24 do
   begin
    gotoxy(2,j);
    write(chr(219), chr(219));
    gotoxy(78,j);
    write(chr(219), chr(219));
   end;
  for j := 21 to 23 do
   begin
    gotoxy(54,j);
    write(chr(219), chr(219));
   end;
  for j := 2 to 32 do
   begin
    gotoxy(j,4);
    write(chr(219));
   end;
  for j := 46 to 79 do
   begin
    gotoxy(j,4);
    write(chr(219));
   end;
  gotoxy(31,3);
  write(chr(219),chr(219));
  gotoxy(46,3);
  write(chr(219),chr(219));
  textcolor(lightred);
  gotoxy(2,2);
  write(chr(219), chr(219));
  gotoxy(78,2);
  write(chr(219), chr(219));
  gotoxy(2,20);
  write(chr(219), chr(219));
  gotoxy(54,20);
  write(chr(219), chr(219));
  gotoxy(78,20);
  write(chr(219), chr(219));
  gotoxy(2,24);
  write(chr(219), chr(219));
  gotoxy(54,24);
  write(chr(219), chr(219));
  gotoxy(78,24);
  write(chr(219), chr(219));
  gotoxy(2,4);
  write(chr(219), chr(219));
  gotoxy(31,4);
  write(chr(219), chr(219));
  gotoxy(46,4);
  write(chr(219), chr(219));
  gotoxy(78,4);
  write(chr(219), chr(219));
  gotoxy(31,2);
  write(chr(219), chr(219));
  gotoxy(46,2);
  write(chr(219), chr(219));
  gotoxy(5,3);
  textcolor(red);
  write('C');
  textcolor(lightred);
  write('a');
  textcolor(yellow);
  write('r');
  textcolor(lightred);
  write('d');
  textcolor(red);
  write('s:');
  textcolor(lightred);
  write(' You:   Computer:');
  gotoxy(49,3);
  textcolor(red);
  write('P');
  textcolor(lightred);
  write('o');
  textcolor(yellow);
  write('i');
  textcolor(lightred);
  write('nt');
  textcolor(red);
  write('s:');
  textcolor(lightred);
  write(' You:    Computer:');
  textcolor(yellow);
  if Plr1Cds < 10 then gotoxy(17,3) else gotoxy(16,3);
  write(Plr1Cds);
  if Plr2Cds < 10 then gotoxy(29,3) else gotoxy(28,3);
  write(Plr2Cds);
  if Plr1Pts < 100 then gotoxy(62,3) else gotoxy(61,3);
  write(Plr1Pts);
  if Plr2Pts < 100 then gotoxy(75,3) else gotoxy(74,3);
  write(Plr2Pts);
  textcolor(red);
  for j := 33 to 45 do
   begin
    gotoxy(j,4);
    write(chr(219));
   end;
  gotoxy(34,3);
  write('Dk');
  textcolor(lightred);
  write(':   ');
  textcolor(red);
  write('Dc');
  textcolor(lightred);
  write(':');
  textcolor(yellow);
  if DeckCds < 10 then gotoxy(38,3) else gotoxy(37,3);
  write(DeckCds);
  if DsrdCds < 10 then gotoxy(44,3) else gotoxy(43,3);
  write(DsrdCds);
  window(12,6,30,17);
  for j := 1 to 209 do
   begin
    if j/2 = int(j/2) then textcolor(white) else textcolor(blue);
    write(chr(219));
   end;
  window(1,1,80,25);
 end;

procedure DrawHand;
 var
  j : integer;
 begin
  gotoxy(5,21);
  write('                                           ');
  gotoxy(5,22);
  write('                                           ');
  for j := 1 to Plr1Cds do
   begin
    Num2Crd(Plr1Hnd[j]);
    if ((crdsuit = chr(3)) or (crdsuit = chr(4))) then textcolor(lightred) else textcolor(darkgray);
    if CrdNum = '10' then CrdNum := '0';
    gotoxy((j*2)+3,21);
    write(CrdNum);
    gotoxy((j*2)+3,22);
    write(CrdSuit);
   end;
  if ((DeckCds > 0) or (Plr1Cds > 21)) then
   begin
    textcolor(yellow);
    gotoxy(50,21);
    write('Drw');
    gotoxy(51,22);
    write(chr(31));
   end else
   begin
    textcolor(darkgray);
    gotoxy(50,21);
    write('Pas');
    gotoxy(51,22);
    write(chr(254));
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

procedure DrawDiscard;
 begin
  textbackground(lightgray);
  window(48,6,66,16);
  clrscr;
  Num2Crd(Discard[DsrdCds]);
  if ((crdsuit = chr(3)) or (crdsuit = chr(4))) then textcolor(lightred) else textcolor(black);
  gotoxy(3,2);
  write(crdnum);
  gotoxy(3,3);
  write(crdsuit);
  gotoxy(17,9);
  write(crdsuit);
  gotoxy(17,10);
  write(crdnum);
  window(54,10,60,14);
  if crdsuit = chr(3) then
   begin
    write(chr(220),chr(219),chr(219),chr(220),chr(219),chr(219),chr(220),
    chr(219),chr(219),chr(219),chr(219),chr(219),chr(219),chr(219),chr(223),
    chr(219),chr(219),chr(219),chr(219),chr(219),chr(223),chr(255),chr(255),
    chr(223),chr(219),chr(223),chr(255),chr(255));
   end;
  if crdsuit = chr(4) then
   begin
    write(chr(255),chr(255),chr(220),chr(219),chr(220),chr(255),chr(255),
    chr(220),chr(219),chr(219),chr(219),chr(219),chr(219),chr(220),chr(223),
    chr(219),chr(219),chr(219),chr(219),chr(219),chr(223),chr(255),chr(255),
    chr(223),chr(219),chr(223),chr(255),chr(255));
   end;
  if crdsuit = chr(5) then
   begin
    write(chr(255),chr(255),chr(219),chr(219),chr(219),chr(255),chr(255),
    chr(220),chr(220),chr(219),chr(219),chr(219),chr(220),chr(220),chr(219),
    chr(219),chr(219),chr(219),chr(219),chr(219),chr(219),chr(255),chr(255),
    chr(255),chr(219),chr(255),chr(255),chr(255));
   end;
  if crdsuit = chr(6) then
   begin
    write(chr(255),chr(255),chr(220),chr(219),chr(220),chr(255),chr(255),
    chr(255),chr(219),chr(219),chr(219),chr(219),chr(219),chr(255),chr(219),
    chr(219),chr(219),chr(219),chr(219),chr(219),chr(219),chr(223),chr(223),
    chr(255),chr(219),chr(255),chr(223),chr(223));
   end;
  window(1,1,80,25);
  textbackground(black);
 end;

procedure Plr1Discard;
 var
  t : integer;
  j : integer;
 begin
  textcolor(white);
  t := 19;
   repeat
    gotoxy(48,t);
    for j := 1 to 19 do write(chr(219));
    cursor;
    delay(25);
    textcolor(white);
    t := t - 1;
   until t = 8;
   repeat
    gotoxy(48,t);
    for j := 1 to 19 do write(chr(219));
    gotoxy(48,t+11);
    write('                   ');
    cursor;
    delay(25);
    textcolor(white);
    t := t - 1;
   until t = 5;
   textcolor(yellow);
   if DsrdCds < 10 then gotoxy(44,3) else gotoxy(43,3);
   write(DsrdCds);
   cursor;
 end;

procedure Plr1DrawCard;
 var
  t : integer;
  b : integer;
  j : integer;
  c : integer;
 begin
  textcolor(yellow);
  gotoxy(37,3);
  write('  ');
  if DeckCds < 10 then gotoxy(38,3) else gotoxy(37,3);
  write(DeckCds);
  t := 6;
  window(12,6,30,17);
  textcolor(white);
  for j := 1 to 209 do write(chr(219));
  window(1,1,80,25);
  cursor;
  delay(25);
  for t := 7 to 9 do
   begin
    b := t + 10;
    gotoxy(12,b);
    textcolor(white);
    for j := 1 to 19 do write(chr(219));
    c := 1;
    if t = 8 then c := 2;
    gotoxy(12,t-1);
    for j := 1 to 19 do
     begin
      if c = 1 then textcolor(blue) else textcolor(white);
      if DeckCds < 1 then textcolor(black);
      write(chr(219));
      if c = 1 then c := 2 else c := 1;
     end;
    cursor;
    delay(25);
   end;
  for t := 9 to 16 do
   begin
    if t / 2 = int(t / 2) then c := 1 else c := 2;
    gotoxy(12,t);
    for j := 1 to 19 do
     begin
      if c = 1 then textcolor(blue) else textcolor(white);
      if DeckCds < 1 then textcolor(black);
      write(chr(219));
      if c = 1 then c := 2 else c := 1;
     end;
    cursor;
    delay(25);
   end;
  for t := 17 to 19 do
   begin
    gotoxy(12,t);
    write('                   ');
    cursor;
    delay(25);
   end;
 end;

procedure Plr2DrawCard;
 var
  j : integer;
  k : integer;
  t : integer;
  c : integer;
 begin
  textcolor(yellow);
  gotoxy(37,3);
  write('  ');
  if DeckCds < 10 then gotoxy(38,3) else gotoxy(37,3);
  write(DeckCds);
  textcolor(white);
  for j := 1 to 11 do
   begin
    for k := 1 to 19 do
     begin
      gotoxy(k + 11, j + 5);
      write(chr(219));
     end;
   end;
  cursor;
  delay(25);
  textcolor(white);
  gotoxy(12,5);
  for j := 1 to 19 do write(chr(219));
  c := 0;
  gotoxy(12,16);
  for j := 1 to 19 do
   begin
    if c = 0 then textcolor(blue) else textcolor(white);
    if DeckCds < 1 then textcolor(black);
    write(chr(219));
    if c = 0 then c := 1 else c := 0;
   end;
  cursor;
  delay(25);
  t := 15;
  for j := 1 to 10 do
   begin
    gotoxy(12,t);
    t := t - 1;
    for k := 1 to 19 do
     begin
      if c = 0 then textcolor(blue) else textcolor(white);
      if DeckCds < 1 then textcolor(black);
      write(chr(219));
      if c = 0 then c := 1 else c := 0;
     end;
    cursor;
    delay(25);
   end;
  gotoxy(12,5);
  write('                   ');
  cursor;
  delay(25);
 end;

procedure Plr2Discard;
 var
  t : integer;
  j : integer;
 begin
  textcolor(white);
  for t := 5 to 15 do
   begin
    for j := 1 to 19 do
     begin
      gotoxy(j+47,t);
      write(chr(219));
     end;
    cursor;
    delay(25);
    textcolor(white);
   end;
  gotoxy(48,16);
  for j := 1 to 19 do write(chr(219));
  gotoxy(48,5);
  write('                   ');
  cursor;
  delay(25);
  textcolor(yellow);
  if DsrdCds < 10 then gotoxy(44,3) else gotoxy(43,3);
  write(DsrdCds);
 end;

procedure Plr1PickCard;
 var
  enter : boolean;
  press : integer;
  done : boolean;
  goodcard : boolean;
  dcn : string;
  dcs : string;
  j : integer;
  SuitPoint : integer;
  Pass : boolean;
 begin
  Pass := false;
  textcolor(yellow);
  gotoxy((PointCard*2)+3, 23);
  write(chr(24));
  Cursor;
  GoodCard := false;
  if Msg = false then
   begin
    gotoxy(56,21);
    write('                     ');
    gotoxy(56,22);
    write('                     ');
    gotoxy(56,23);
    write('                     ');
    gotoxy(59,22);
    textcolor(red);
    write('Di');
    textcolor(lightred);
    write('sca');
    textcolor(yellow);
    write('rd o');
    textcolor(lightred);
    write('r Dr');
    textcolor(red);
    write('aw');
   end;
  Cursor;
   repeat
     repeat
       repeat
         repeat
          press := 0;
          key := ReadKey;
           case Key of
            #75: press := 1;
            #77: press := 2;
           end;
          if ord(key) = 13 then press := 3;
          if ord(key) = 27 then DrawEnd;
         until press > 0;
        if press < 3 then
         begin
          gotoxy((PointCard*2)+3, 23);
          write(' ');
          if press = 1 then
           begin
            PointCard := PointCard - 1;
            if PointCard < 1 then PointCard := 24;
            if PointCard < 24 then if PointCard > Plr1Cds then PointCard := Plr1Cds;
           end;
          if press = 2 then
           begin
            PointCard := PointCard + 1;
            if PointCard > 24 then PointCard := 1;
            if PointCard > Plr1Cds then PointCard := 24;
           end;
          gotoxy((PointCard*2)+3, 23);
          textcolor(yellow);
          write(chr(24));
          Cursor;
          if Msg = true then
           begin
            gotoxy(56,21);
            write('                     ');
            gotoxy(56,22);
            write('                     ');
            gotoxy(56,23);
            write('                     ');
            gotoxy(59,22);
            textcolor(red);
            write('Di');
            textcolor(lightred);
            write('sca');
            textcolor(yellow);
            write('rd o');
            textcolor(lightred);
            write('r Dr');
            textcolor(red);
            write('aw');
            Msg := false;
           end;
         end;
        if press = 3 then enter := true;
       until enter = true;
      done := true;
      if PointCard = 24 then                    {Draw Card}
       begin
        if ((DeckCds > 0) and (Plr1Cds < 22)) then
         begin
          Plr1Cds := Plr1Cds + 1;
          Plr1Hnd[Plr1Cds] := Deck[DeckCds];
          Deck[DeckCds] := 0;
          DeckCds := DeckCds - 1;
          Plr1DrawCard;
          Num2Crd(Plr1Hnd[Plr1Cds]);
          if ((crdsuit = chr(3)) or (crdsuit = chr(4))) then textcolor(lightred) else textcolor(darkgray);
          if CrdNum = '10' then CrdNum := '0';
          gotoxy((Plr1Cds*2)+3, 21);
          write(CrdNum);
          gotoxy((Plr1Cds*2)+3, 22);
          write(CrdSuit);
          textcolor(yellow);
          gotoxy(16,3);
          write('  ');
          if Plr1Cds < 10 then gotoxy(17,3) else gotoxy(16,3);
          write(Plr1Cds);
          if ((DeckCds < 1) or (Plr1Cds > 21)) then
           begin
            textcolor(darkgray);
            gotoxy(50,21);
            write('Pas');
            gotoxy(51,22);
            write(chr(254));
           end;
          Cursor;
          done := false;
          press := 0;
          enter := false;
         end else
         begin
          Pass := true;
         end;
       end;
     until ((Done = true) or (Pass = true));
    Num2Crd(Discard[DsrdCds]);
    dcn := CrdNum;
    dcs := CrdSuit;
    Num2Crd(Plr1Hnd[PointCard]);
    if CrdNum = '8' then GoodCard := true;
    if CrdNum = dcn then GoodCard := true;
    if CrdSuit = dcs then GoodCard := true;
    if GoodCard = false then
     begin
      gotoxy(56,21);
      write('                     ');
      gotoxy(56,22);
      write('                     ');
      gotoxy(56,23);
      write('                     ');
      textcolor(red);
      gotoxy(62,21);
      write('T');
      textcolor(lightred);
      write('ha');
      textcolor(yellow);
      write('t c');
      textcolor(lightred);
      write('ar');
      textcolor(red);
      write('d');
      gotoxy(60,22);
      write('ca');
      textcolor(lightred);
      write('n''t');
      textcolor(yellow);
      write(' be ');
      textcolor(lightred);
      write('us');
      textcolor(red);
      write('ed.');
      gotoxy(59,23);
      write('Ple');
      textcolor(lightred);
      write('ase ');
      textcolor(yellow);
      write('tr');
      textcolor(lightred);
      write('y aga');
      textcolor(red);
      write('in.');
      Cursor;
      Msg := true;
      sound(200);
      delay(300);
      nosound;
      done := false;
      press := 0;
      enter := false;
     end;
   until ((GoodCard = true) or (Pass = true));
  if Pass = false then
   begin
    DsrdCds := DsrdCds + 1;
    Discard[DsrdCds] := Plr1Hnd[PointCard];
    for j := PointCard to Plr1Cds do
     begin
      if j < Plr1Cds then Plr1Hnd[j] := Plr1Hnd[j+1] else Plr1Hnd[j] := 0;
     end;
    Plr1Cds := Plr1Cds - 1;
    DrawHand;
    textcolor(yellow);
    gotoxy(16,3);
    write('  ');
    if Plr1Cds < 10 then gotoxy(17,3) else gotoxy(16,3);
    write(Plr1Cds);
    if Plr1Cds > 0 then
     begin
      if PointCard >= Plr1Cds then
       begin
        gotoxy((PointCard*2)+3, 23);
        write(' ');
        PointCard := Plr1Cds;
        gotoxy((PointCard*2)+3, 23);
        textcolor(yellow);
        write(chr(24));
       end;
     end else
     begin
      gotoxy((PointCard*2)+3, 23);
      write(' ');
     end;
    Plr1Discard;
    DrawDiscard;
    Cursor;
    Num2Crd(Discard[DsrdCds]);
    if CrdNum = '8' then
     begin
      gotoxy(56,21);
      write('                     ');
      gotoxy(56,22);
      write('                     ');
      gotoxy(56,23);
      write('                     ');
      gotoxy(62,21);
      textcolor(red);
      write('W');
      textcolor(lightred);
      write('ha');
      textcolor(yellow);
      write('t S');
      textcolor(lightred);
      write('ui');
      textcolor(red);
      write('t?');
      gotoxy(60,22);
      textcolor(lightred);
      write(chr(3), '   ', chr(4), '   ');
      textcolor(darkGray);
      write(chr(5), '   ', chr(6));
      SuitPoint := 1;
      textcolor(yellow);
      gotoxy(60,23);
      write(chr(24));
       repeat
         repeat
          press := 0;
          key := ReadKey;
           case Key of
            #75: press := 1;
            #77: press := 2;
           end;
          if ord(key) = 13 then press := 3;
         until press > 0;
        if press < 3 then
         begin
          gotoxy((SuitPoint*4)+56, 23);
          write(' ');
          if press = 2 then
           begin
            SuitPoint := SuitPoint + 1;
            if SuitPoint > 4 then SuitPoint := 1;
           end;
          if press = 1 then
           begin
            SuitPoint := SuitPoint - 1;
            if SuitPoint < 1 then SuitPoint := 4;
           end;
          gotoxy((SuitPoint*4)+56, 23);
          write(chr(24));
         end;
       until press = 3;
      if Discard[DsrdCds] > 400 then Discard[DsrdCds] := Discard[DsrdCds] - 400;
      if Discard[DsrdCds] > 300 then Discard[DsrdCds] := Discard[DsrdCds] - 300;
      if Discard[DsrdCds] > 200 then Discard[DsrdCds] := Discard[DsrdCds] - 200;
      if Discard[DsrdCds] > 100 then Discard[DsrdCds] := Discard[DsrdCds] - 100;
      if SuitPoint = 1 then Discard[DsrdCds] := Discard[DsrdCds] + 400;
      if SuitPoint = 2 then Discard[DsrdCds] := Discard[DsrdCds] + 300;
      if SuitPoint = 3 then Discard[DsrdCds] := Discard[DsrdCds] + 200;
      if SuitPoint = 4 then Discard[DsrdCds] := Discard[DsrdCds] + 100;
      gotoxy(56,21);
      write('                     ');
      gotoxy(56,22);
      write('                     ');
      gotoxy(56,23);
      write('                     ');
     end;
   end;
  if Pass = true then NumPass := NumPass + 1 else NumPass := 0;
 end;

procedure Plr2PickCard;
 var
  FoundCard : boolean;
  DN : string;
  DS : string;
  CN : integer;
  CV : integer;
  k : integer;
  Nh, Nd, Nc, Ns : integer;
  Ps : string;
  Pass : boolean;
 begin
  Pass := false;
  gotoxy(56,21);
  write('                     ');
  gotoxy(56,22);
  write('                     ');
  gotoxy(56,23);
  write('                     ');
  gotoxy(60,22);
  textcolor(red);
  write('Co');
  textcolor(lightred);
  write('mpu');
  textcolor(yellow);
  write('ter');
  textcolor(lightred);
  write(' Tu');
  textcolor(red);
  write('rn');
  Cursor;
  FoundCard := false;
   repeat
    delay(1000);
    CN := 0;
    Num2Crd(Discard[DsrdCds]);
    DN := CrdNum;
    DS := CrdSuit;
    if random(3)+1 = 1 then                 {Pick last card in}
     begin                                  {hand that will work}
      for k := 1 to Plr2Cds do
       begin
        Num2Crd(Plr2Hnd[k]);
        if CrdNum <> '8' then
         begin
          if ((CrdNum = DN) or (CrdSuit = DS)) then
           begin
            CN := k;
            FoundCard := true;
           end;
         end;
       end;
     end else
     begin                                  {Pick best card in hand}
      CV := 0;
      for k := 1 to Plr2Cds do
       begin
        Num2Crd(Plr2Hnd[k]);
        if CrdNum <> '8' then
         begin
          if ((CrdNum = DN) or (CrdSuit = DS)) then
           begin
            if CrdVal > CV then
             begin
              FoundCard := true;
              CV := CrdVal;
              CN := k;
             end;
           end;
         end;
       end;
     end;
    if FoundCard = false then               {Look for 8's}
     begin
      for k := 1 to Plr2Cds do
       begin
        Num2Crd(Plr2Hnd[k]);
        if CrdNum = '8' then
         begin
          FoundCard := true;
          CN := k;
         end;
       end;
     end;
    if FoundCard = false then               {Draw from pile}
     begin
      if DeckCds > 0 then
       begin
        Plr2Cds := Plr2Cds + 1;
        Plr2Hnd[Plr2Cds] := Deck[DeckCds];
        Deck[DeckCds] := 0;
        DeckCds := DeckCds - 1;
        Plr2DrawCard;
        textcolor(yellow);
        gotoxy(28,3);
        write('  ');
        if Plr2Cds < 10 then gotoxy(29,3) else gotoxy(28,3);
        write(Plr2Cds);
        cursor;
        if DeckCds < 1 then
         begin
          textcolor(darkgray);
          gotoxy(50,21);
          write('Pas');
          gotoxy(51,22);
          write(chr(254));
          cursor;
         end;
       end else
       begin
        Pass := true;                         {Computer Passes}
        gotoxy(56,21);
        write('                     ');
        gotoxy(56,22);
        write('                     ');
        gotoxy(56,23);
        write('                     ');
        gotoxy(59,22);
        textcolor(red);
        write('Com');
        textcolor(lightred);
        write('put');
        textcolor(yellow);
        write('er P');
        textcolor(lightred);
        write('ass');
        textcolor(red);
        write('es..');
        cursor;
        sound(200);
        delay(100);
        nosound;
        Msg := true;
       end;
     end;
   until ((FoundCard = true) or (Plr2Cds > 22)  or (Pass = true));
  if FoundCard = true then                         {Discard}
   begin
    Num2Crd(Plr2Hnd[CN]);
    if ((CrdNum <> DN) and (CrdSuit <> DS) and (CrdNum <> '8')) then
     begin
      gotoxy(2,1);
      write('Error! Computer can''t discard!');
      cursor;
      sound(200);
      delay(500);
      nosound;
      readkey;
      halt(3);
     end;
    if CrdNum <> '8' then
     begin
      DsrdCds := DsrdCds + 1;
      Discard[DsrdCds] := Plr2Hnd[CN];
      for k := CN to Plr2Cds do
       begin
        Plr2Hnd[k] := Plr2Hnd[k+1];
       end;
      Plr2Cds := Plr2Cds - 1;
      textcolor(yellow);
      gotoxy(28,3);
      write('  ');
      if Plr2Cds < 10 then gotoxy(29,3) else gotoxy(28,3);
      write(Plr2Cds);
      Plr2Discard;
      DrawDiscard;
     end else
     begin
      DsrdCds := DsrdCds + 1;
      Discard[DsrdCds] := Plr2Hnd[CN];
      for k := CN to Plr2Cds do
       begin
        Plr2Hnd[k] := Plr2Hnd[k+1];
       end;
      Plr2Cds := Plr2Cds - 1;
      textcolor(yellow);
      gotoxy(28,3);
      write('  ');
      if Plr2Cds < 10 then gotoxy(29,3) else gotoxy(28,3);
      write(Plr2Cds);
      Plr2Discard;
      DrawDiscard;
      Nh := 0;
      Nd := 0;
      Nc := 0;
      Ns := 0;
      for k := 1 to Plr2Cds do
       begin
        Num2Crd(Plr2Hnd[k]);
        if CrdNum <> '8' then
         begin
          if CrdSuit = chr(3) then Nh := Nh + 1;
          if CrdSuit = chr(4) then Nd := Nd + 1;
          if CrdSuit = chr(5) then Nc := Nc + 1;
          if CrdSuit = chr(6) then Ns := Ns + 1;
         end;
       end;
      if ((Nh >= Nd) and (Nh >= Nc) and (Nh >= Ns)) then Ps := chr(3);
      if ((Nd >= Nh) and (Nd >= Nc) and (Nd >= Ns)) then Ps := chr(4);
      if ((Nc >= Nh) and (Nc >= Nd) and (Nc >= Ns)) then Ps := chr(5);
      if ((Ns >= Nh) and (Ns >= Nd) and (Ns >= Nc)) then Ps := chr(6);
      if Discard[DsrdCds] > 400 then Discard[DsrdCds] := Discard[DsrdCds] - 400;
      if Discard[DsrdCds] > 300 then Discard[DsrdCds] := Discard[DsrdCds] - 300;
      if Discard[DsrdCds] > 200 then Discard[DsrdCds] := Discard[DsrdCds] - 200;
      if Discard[DsrdCds] > 100 then Discard[DsrdCds] := Discard[DsrdCds] - 100;
      if Ps = chr(3) then Discard[DsrdCds] := Discard[DsrdCds] + 400;
      if Ps = chr(4) then Discard[DsrdCds] := Discard[DsrdCds] + 300;
      if Ps = chr(5) then Discard[DsrdCds] := Discard[DsrdCds] + 200;
      if Ps = chr(6) then Discard[DsrdCds] := Discard[DsrdCds] + 100;
      gotoxy(59,22);
      write('               ');
      textcolor(red);
      gotoxy(59,21);
      write('Com');
      textcolor(lightred);
      write('put');
      textcolor(yellow);
      write('er C');
      textcolor(lightred);
      write('han');
      textcolor(red);
      write('ged');
      gotoxy(63,22);
      write('S');
      textcolor(lightred);
      write('ui');
      textcolor(yellow);
      write('t');
      textcolor(lightred);
      write(' t');
      textcolor(red);
      write('o');
      gotoxy(66,23);
      if ((Ps = chr(3)) or (Ps = chr(4))) then textcolor(lightred) else textcolor(darkgray);
      write(Ps);
      cursor;
      sound(200);
      delay(100);
      nosound;
      Msg := true;
     end;
   end;
  if Pass = true then NumPass := NumPass + 1 else NumPass := 0;
 end;

begin
 Init;
 Title;
 Plr1Pts := 0;
 Plr2Pts := 0;
 Hand := 1;
 Play := true;
 Msg := false;
 Player := random(2)+1;
 while Play = true do
  begin
   shuffle;
   deal;
   PointCard := 1;
   DrawScreen;
   DrawDiscard;
   DrawHand;
    repeat
     if Player = 1 then Plr1PickCard;
     if Player = 2 then Plr2PickCard;
     if Player = 1 then Player := 2 else Player := 1;
    until ((Plr1Cds < 1) or (Plr2Cds < 1) or (NumPass > 1));
   if Plr1Cds < 1 then
    begin
     gotoxy(56,21);
     write('                     ');
     gotoxy(56,22);
     write('                     ');
     gotoxy(56,23);
     write('                     ');
     gotoxy(61,22);
     textcolor(red);
     write('Yo');
     textcolor(lightred);
     write('u W');
     textcolor(yellow);
     write('in ');
     textcolor(lightred);
     write('Ha');
     textcolor(red);
     write('nd!');
     cursor;
     for j := 1 to 3 do
      begin
       sound(200);
       delay(100);
       sound(300);
       delay(100);
      end;
     nosound;
     readkey;
    end;
   if Plr2Cds < 1 then
    begin
     gotoxy(56,21);
     write('                     ');
     gotoxy(56,22);
     write('                     ');
     gotoxy(56,23);
     write('                     ');
     gotoxy(58,22);
     textcolor(red);
     write('Comp');
     textcolor(lightred);
     write('uter ');
     textcolor(yellow);
     write('Win');
     textcolor(lightred);
     write('s H');
     textcolor(red);
     write('and!');
     cursor;
     for j := 1 to 3 do
      begin
       sound(200);
       delay(100);
       sound(300);
       delay(100);
      end;
     nosound;
     readkey;
    end;
   if NumPass > 1 then
    begin
     gotoxy(56,21);
     write('                     ');
     gotoxy(56,22);
     write('                     ');
     gotoxy(56,23);
     write('                     ');
     gotoxy(62,21);
     textcolor(red);
     write('Ha');
     textcolor(lightred);
     write('nd ');
     textcolor(yellow);
     write('O');
     textcolor(lightred);
     write('ve');
     textcolor(red);
     write('r!');
     gotoxy(61,23);
     textcolor(red);
     write('Nei');
     textcolor(lightred);
     write('th');
     textcolor(yellow);
     write('er ');
     textcolor(lightred);
     write('Wi');
     textcolor(red);
     write('ns.');
     cursor;
     for j := 1 to 3 do
      begin
       sound(200);
       delay(100);
       sound(300);
       delay(100);
      end;
     nosound;
     readkey;
    end;
   Plr1NP := 0;
   Plr2NP := 0;
   if Plr1Cds > 0 then
    begin
     for j := 1 to Plr1Cds do
      begin
       Num2Crd(Plr1Hnd[j]);
       Plr2NP := Plr2NP + CrdVal;
      end;
    end;
   if Plr2Cds > 0 then
    begin
     for j := 1 to Plr2Cds do
      begin
       Num2Crd(Plr2Hnd[j]);
       Plr1NP := Plr1NP + CrdVal;
      end;
    end;
   gotoxy(56,21);
   write('                     ');
   gotoxy(56,22);
   write('                     ');
   gotoxy(56,23);
   write('                     ');
   gotoxy(61,21);
   textcolor(red);
   write('Ne');
   textcolor(lightred);
   write('w ');
   textcolor(yellow);
   write('Po');
   textcolor(lightred);
   write('in');
   textcolor(red);
   write('ts:');
   gotoxy(62,22);
   textcolor(red);
   write('Y');
   textcolor(lightred);
   write('o');
   textcolor(yellow);
   write('u');
   textcolor(lightred);
   write(':');
   gotoxy(62,23);
   textcolor(red);
   write('Co');
   textcolor(lightred);
   write('m');
   textcolor(yellow);
   write('pu');
   textcolor(lightred);
   write('te');
   textcolor(red);
   write('r:');
   textcolor(yellow);
   gotoxy(67,22);
   write(Plr1NP);
   gotoxy(72,23);
   write(Plr2NP);
   Plr1Pts := Plr1Pts + Plr1NP;
   Plr2Pts := Plr2Pts + Plr2NP;
   if Plr1Pts < 100 then gotoxy(62,3) else gotoxy(61,3);
   write(Plr1Pts);
   if Plr2Pts < 100 then gotoxy(75,3) else gotoxy(74,3);
   write(Plr2Pts);
   cursor;
   readkey;
   gotoxy(56,21);
   write('                     ');
   gotoxy(56,22);
   write('                     ');
   gotoxy(56,23);
   write('                     ');
   gotoxy(61,21);
   textcolor(red);
   write('Ke');
   textcolor(lightred);
   write('ep ');
   textcolor(yellow);
   write('Pla');
   textcolor(lightred);
   write('yin');
   textcolor(red);
   write('g?');
   gotoxy(63,22);
   textcolor(lightred);
   write('Yes   No');
   YNPoint := 64;
   textcolor(yellow);
   gotoxy(YNPoint, 23);
   write(chr(24));
   cursor;
    repeat
      repeat
       press := 0;
       key := ReadKey;
        case Key of
         #75: press := 1;
         #77: press := 2;
        end;
       if ord(key) = 13 then press := 3;
      until press > 0;
     if press < 3 then
      begin
       textcolor(yellow);
       gotoxy(YNPoint, 23);
       write(' ');
       if YNPoint = 64 then YNPoint := 69 else YNPoint := 64;
       gotoxy(YNPoint, 23);
       write(chr(24));
       cursor;
      end;
    until press = 3;
   if YNPoint = 69 then Play := false;
  end;
 DrawEnd;
end.
