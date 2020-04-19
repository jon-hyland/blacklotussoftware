unit PkrGraph;

{---------------} interface {-------------------------------------------}
procedure Cursor;
procedure TitleScreen;
procedure PlayScreen;
procedure ShuffleDraw(x : integer);
procedure YouDraw;
procedure YouDiscard;
procedure CompDiscard;
procedure CompDraw;
procedure DrawCard(Place, Card : integer);

{------} implementation {-------------------------------------------------}
uses
 Crt;

type
 SuitGrid = array[1..7, 1..4] of char;
 NumbGrid = array[1..3, 1..3] of char;
 OthrGrid = array[1..5, 1..3] of char;

var
 Heart,
 Diamond,
 Club,
 Spade : SuitGrid;
 Ace,
 Two,
 Three,
 Four,
 Five,
 Six,
 Seven,
 Eight,
 Nine,
 Jack : NumbGrid;
 Ten,
 Queen,
 King : OthrGrid;

procedure MakeGraphics;
 var
  j, k : integer;
 begin
  for k := 1 to 4 do
   for j := 1 to 7 do
    begin
     Heart[j,k] := ' ';
     Diamond[j,k] := ' ';
     Club[j,k] := ' ';
     Spade[j,k] := ' ';
    end;
  Heart[2,1] := chr(220);
  Heart[3,1] := chr(220);
  Heart[5,1] := chr(220);
  Heart[6,1] := chr(220);
  Heart[1,2] := chr(219);
  Heart[2,2] := chr(219);
  Heart[3,2] := chr(219);
  Heart[4,2] := chr(219);
  Heart[5,2] := chr(219);
  Heart[6,2] := chr(219);
  Heart[7,2] := chr(219);
  Heart[2,3] := chr(223);
  Heart[3,3] := chr(219);
  Heart[4,3] := chr(219);
  Heart[5,3] := chr(219);
  Heart[6,3] := chr(223);
  Heart[4,4] := chr(223);
  Diamond[4,1] := chr(220);
  Diamond[2,2] := chr(220);
  Diamond[3,2] := chr(219);
  Diamond[4,2] := chr(219);
  Diamond[5,2] := chr(219);
  Diamond[6,2] := chr(220);
  Diamond[2,3] := chr(223);
  Diamond[3,3] := chr(219);
  Diamond[4,3] := chr(219);
  Diamond[5,3] := chr(219);
  Diamond[6,3] := chr(223);
  Diamond[4,4] := chr(223);
  Club[3,1] := chr(220);
  Club[4,1] := chr(220);
  Club[5,1] := chr(220);
  Club[1,2] := chr(220);
  Club[2,2] := chr(220);
  Club[3,2] := chr(219);
  Club[4,2] := chr(219);
  Club[5,2] := chr(219);
  Club[6,2] := chr(220);
  Club[7,2] := chr(220);
  Club[1,3] := chr(223);
  Club[2,3] := chr(223);
  Club[3,3] := chr(223);
  Club[4,3] := chr(219);
  Club[5,3] := chr(223);
  Club[6,3] := chr(223);
  Club[7,3] := chr(223);
  Club[4,4] := chr(223);
  Spade[4,1] := chr(220);
  Spade[2,2] := chr(220);
  Spade[3,2] := chr(219);
  Spade[4,2] := chr(219);
  Spade[5,2] := chr(219);
  Spade[6,2] := chr(220);
  Spade[1,3] := chr(219);
  Spade[2,3] := chr(219);
  Spade[3,3] := chr(223);
  Spade[4,3] := chr(219);
  Spade[5,3] := chr(223);
  Spade[6,3] := chr(219);
  Spade[7,3] := chr(219);
  Spade[4,4] := chr(223);
  for k := 1 to 3 do
   for j := 1 to 3 do
    begin
     Ace[j,k] := ' ';
     Two[j,k] := ' ';
     Three[j,k] := ' ';
     Four[j,k] := ' ';
     Five[j,k] := ' ';
     Six[j,k] := ' ';
     Seven[j,k] := ' ';
     Eight[j,k] := ' ';
     Nine[j,k] := ' ';
     Jack[j,k] := ' ';
    end;
  for k := 1 to 3 do
   for j := 1 to 5 do
    begin
     Ten[j,k] := ' ';
     Queen[j,k] := ' ';
     King[j,k] := ' ';
    end;
  Ace[1,1] := chr(220);
  Ace[2,1] := chr(220);
  Ace[3,1] := chr(220);
  Ace[1,2] := chr(219);
  Ace[2,2] := chr(220);
  Ace[3,2] := chr(219);
  Ace[1,3] := chr(219);
  Ace[3,3] := chr(219);
  Two[1,1] := chr(220);
  Two[2,1] := chr(220);
  Two[3,1] := chr(220);
  Two[1,2] := chr(220);
  Two[2,2] := chr(220);
  Two[3,2] := chr(219);
  Two[1,3] := chr(219);
  Two[2,3] := chr(220);
  Two[3,3] := chr(220);
  Three[1,1] := chr(220);
  Three[2,1] := chr(220);
  Three[3,1] := chr(220);
  Three[1,2] := chr(220);
  Three[2,2] := chr(220);
  Three[3,2] := chr(219);
  Three[1,3] := chr(220);
  Three[2,3] := chr(220);
  Three[3,3] := chr(219);
  Four[1,1] := chr(220);
  Four[3,1] := chr(220);
  Four[1,2] := chr(219);
  Four[2,2] := chr(220);
  Four[3,2] := chr(219);
  Four[3,3] := chr(219);
  Five[1,1] := chr(220);
  Five[2,1] := chr(220);
  Five[3,1] := chr(220);
  Five[1,2] := chr(219);
  Five[2,2] := chr(220);
  Five[3,2] := chr(220);
  Five[1,3] := chr(220);
  Five[1,3] := chr(220);
  Five[2,3] := chr(220);
  Five[3,3] := chr(219);
  Six[1,1] := chr(220);
  Six[2,1] := chr(220);
  Six[3,1] := chr(220);
  Six[1,2] := chr(219);
  Six[2,2] := chr(220);
  Six[3,2] := chr(220);
  Six[1,3] := chr(219);
  Six[2,3] := chr(220);
  Six[3,3] := chr(219);
  Seven[1,1] := chr(220);
  Seven[2,1] := chr(220);
  Seven[3,1] := chr(220);
  Seven[3,2] := chr(219);
  Seven[3,3] := chr(219);
  Eight[1,1] := chr(220);
  Eight[2,1] := chr(220);
  Eight[3,1] := chr(220);
  Eight[1,2] := chr(219);
  Eight[2,2] := chr(220);
  Eight[3,2] := chr(219);
  Eight[1,3] := chr(219);
  Eight[2,3] := chr(220);
  Eight[3,3] := chr(219);
  Nine[1,1] := chr(220);
  Nine[2,1] := chr(220);
  Nine[3,1] := chr(220);
  Nine[1,2] := chr(219);
  Nine[2,2] := chr(220);
  Nine[3,2] := chr(219);
  Nine[3,3] := chr(219);
  Ten[1,1] := chr(220);
  Ten[3,1] := chr(220);
  Ten[4,1] := chr(220);
  Ten[5,1] := chr(220);
  Ten[1,2] := chr(219);
  Ten[3,2] := chr(219);
  Ten[5,2] := chr(219);
  Ten[1,3] := chr(219);
  Ten[3,3] := chr(219);
  Ten[4,3] := chr(220);
  Ten[5,3] := chr(219);
  Jack[3,1] := chr(220);
  Jack[3,2] := chr(219);
  Jack[1,3] := chr(219);
  Jack[2,3] := chr(220);
  Jack[3,3] := chr(219);
  Queen[1,1] := chr(220);
  Queen[2,1] := chr(220);
  Queen[3,1] := chr(220);
  Queen[4,1] := chr(220);
  Queen[1,2] := chr(219);
  Queen[4,2] := chr(219);
  Queen[1,3] := chr(219);
  Queen[2,3] := chr(220);
  Queen[3,3] := chr(219);
  Queen[4,3] := chr(219);
  Queen[5,3] := chr(220);
  King[1,1] := chr(220);
  King[4,1] := chr(220);
  King[1,2] := chr(219);
  King[2,2] := chr(220);
  King[3,2] := chr(223);
  King[1,3] := chr(219);
  King[3,3] := chr(223);
  King[4,3] := chr(220);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure TitleScreen;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  gotoxy(33,10);
  write('- Poker  v1.0 -');
  readkey;
 end;

procedure PlayScreen;
 var
  j, k : integer;
  Key : char;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  for j := 1 to 80 do
   begin
    if (j <= 20) or (j > 60) then
     begin
      textcolor(red);
      textbackground(black);
     end
    else
     begin
      textcolor(lightred);
      textbackground(red);
     end;
    for k := 1 to 3 do
     begin
      if k = 1 then gotoxy(j,1);
      if k = 2 then gotoxy(j,21);
      if k = 3 then gotoxy(j,24);
       case j of
        1..5, 21..25, 56..60, 76..80 : write(chr(176));
        6..10, 26..30, 51..55, 71..75 : write(chr(177));
        11..15, 31..35, 46..50, 66..70 : write(chr(178));
        16..20, 36..45, 61..65 : write(chr(219));
       end; {case}
     end;
   end;
  for k := 1 to 24 do
   begin
     case k of
      1..6, 19..24 :
       begin
        textcolor(red);
        textbackground(black);
       end;
      7..17 :
       begin
        textcolor(lightred);
        textbackground(red);
       end;
     end;
     case k of
      1,2,7,8,17,18,23,24   : Key := chr(176);
      3,9,16,22             : Key := chr(177);
      4,5,10,11,14,15,20,21 : Key := chr(178);
      6,12,13,17,19,23,24   : Key := chr(219);
     end; {case}
    gotoxy(1,k);
    write(Key,Key);
    gotoxy(79,k);
    write(Key,Key);
   end;
  textcolor(lightred);
  textbackground(black);
  for j := 34 to 47 do
   begin
     case j of
      34,35,46,47 : Key := chr(176);
      36,37,44,45 : Key := chr(177);
      38,39,42,43 : Key := chr(178);
      40, 41      : Key := chr(219);
     end; {case}
    gotoxy(j,4);
    write(Key);
    gotoxy(j,8);
    write(Key);
   end;
  for k := 5 to 7 do
   begin
     case k of
      5,7 : Key := chr(177);
      6   : Key := chr(178);
     end; {case}
    gotoxy(34,k);
    write(Key, Key);
    gotoxy(46,k);
    write(Key, Key);
   end;
  textcolor(lightred);
  textbackground(blue);
  for k := 3 to 9 do
   for j := 13 to 23 do
    begin
     gotoxy(j,k);
     if (j mod 2) = 1 then write(chr(223)) else write(chr(220));
    end;
  Cursor;
  readkey;
 end;

procedure ShuffleDraw(x : integer);
 begin
  textcolor(lightred);
  textbackground(black);
  if x = 1 then
   begin
    gotoxy(33,22);
    textcolor(red);
    write('Shu');
    textcolor(lightred);
    write('ffl');
    textcolor(yellow);
    write('ing ');
    textcolor(lightred);
    write('Car');
    textcolor(red);
    write('ds..');
    gotoxy(40, 23);
    textcolor(yellow);
    write('of ');
    textcolor(lightred);
    write('52');
   end;
  gotoxy(37, 23);
  write(x);
  Cursor;
  delay(50);
  if x = 52 then
   begin
    textcolor(white);
    textbackground(black);
    gotoxy(33,22);
    write('                  ');
    gotoxy(37,23);
    write('         ');
    Cursor;
   end;
 end;

procedure YouDraw;
 const
  DelayTime = 100;
 var
  j, k : integer;
 begin
  textcolor(lightgray);
  for k := 3 to 9 do
   for j := 13 to 23 do
    begin
     gotoxy(j,k);
     write(chr(219));
    end;
  Cursor;
  delay(DelayTime);
  gotoxy(13,10);
  for j := 13 to 23 do
   write(chr(219));
  textcolor(lightred);
  textbackground(blue);
  gotoxy(13,3);
  for j := 13 to 23 do
   if (j mod 2) = 1 then write(chr(223)) else write(chr(220));
  Cursor;
  delay(DelayTime);
  for k := 4 to 9 do
   begin
    for j := 13 to 23 do
     begin
      gotoxy(j,k);
      if (j mod 2) = 1 then write(chr(223)) else write(chr(220));
     end;
    Cursor;
    delay(DelayTime);
   end;
  textbackground(black);
  gotoxy(13,10);
  for j := 13 to 23 do
   write(' ');
  Cursor;
 end;

procedure CompDraw;
 const
  DelayTime = 100;
 var
  x, y : integer;
 begin
  textcolor(lightgray);
  for y := 3 to 9 do
   for x := 13 to 23 do
    begin
     gotoxy(x,y);
     write(chr(219));
    end;
  Cursor;
  delay(DelayTime);
  gotoxy(13,2);
  for x := 13 to 23 do
   write(chr(219));
  textcolor(lightred);
  textbackground(blue);
  for y := 9 downto 3 do
   begin
    gotoxy(13,y);
    for x := 13 to 23 do
     if (x mod 2) = 0 then write(chr(220)) else write(chr(223));
    Cursor;
    delay(DelayTime);
   end;
  textcolor(white);
  textbackground(black);
  gotoxy(13,2);
  for x := 13 to 23 do
   write(' ');
  Cursor;
  delay(DelayTime);
 end;

procedure YouDiscard;
 const
  DelayTime = 100;
 var
  x, y : integer;
 begin
  textcolor(lightgray);
  for y := 10 downto 4 do
   begin
    gotoxy(57, y);
    for x := 57 to 67 do
     write(chr(219));
    Cursor;
    delay(DelayTime);
   end;
  gotoxy(57,3);
  for x := 57 to 67 do
   write(chr(219));
  gotoxy(57,10);
  for x := 57 to 67 do
   write(' ');
  Cursor;
  delay(DelayTime);
  textcolor(lightred);
  textbackground(blue);
  for y := 3 to 9 do
   for x := 57 to 67 do
    begin
     gotoxy(x,y);
     if (x mod 2) = 0 then write(chr(220)) else write(chr(223));
    end;
  textcolor(white);
  textbackground(black);
  Cursor;
 end;

procedure CompDiscard;
 const
  DelayTime = 100;
 var
  x, y : integer;
 begin
  textcolor(lightgray);
  for y := 2 to 8 do
   begin
    gotoxy(57, y);
    for x := 57 to 67 do
     write(chr(219));
    Cursor;
    delay(DelayTime);
   end;
  gotoxy(57,9);
  for x := 57 to 67 do
   write(chr(219));
  gotoxy(57,2);
  for x := 57 to 67 do
   write(' ');
  Cursor;
  delay(DelayTime);
  textcolor(lightred);
  textbackground(blue);
  for y := 3 to 9 do
   for x := 57 to 67 do
    begin
     gotoxy(x,y);
     if (x mod 2) = 0 then write(chr(220)) else write(chr(223));
    end;
  textcolor(white);
  textbackground(black);
  Cursor;
 end;

procedure DrawCard(Place, Card : integer);
 var
  x, y : integer;
  j, k : integer;
  Suit : integer;
 begin
  x := (Place * 14) - 7;
  y := 11;
  textbackground(lightgray);
  textcolor(black);
  for k := y to y+6 do
   for j := x to x+10 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  Suit := 1;
  while Card > 13 do
   begin
    Card := Card - 13;
    Suit := Suit + 1;
   end;
  textcolor(red);
  if Suit > 2 then
   textcolor(black);
  for k := 1 to 4 do
   for j := 1 to 7 do
    begin
     gotoxy(j+x-1+2, k+y-1+3);
      case Suit of
       1 : write(Heart[j,k]);
       2 : write(Diamond[j,k]);
       3 : write(Club[j,k]);
       4 : write(Spade[j,k]);
      end; {case}
    end;
  if (Card <> 10) and (Card <> 12) and (Card <> 13) then
   begin
    for k := 1 to 3 do
     for j := 1 to 3 do
      begin
       gotoxy(j+x-1+4, k+y-1);
        case Card of
         1 : write(Ace[j,k]);
         2 : write(Two[j,k]);
         3 : write(Three[j,k]);
         4 : write(Four[j,k]);
         5 : write(Five[j,k]);
         6 : write(Six[j,k]);
         7 : write(Seven[j,k]);
         8 : write(Eight[j,k]);
         9 : write(Nine[j,k]);
         11 : write(Jack[j,k]);
        end; {case}
      end;
   end
  else
   begin
    for k := 1 to 3 do
     for j := 1 to 5 do
      begin
       gotoxy(j+x-1+3, k+y-1);
        case Card of
         10 : write(Ten[j,k]);
         12 : write(Queen[j,k]);
         13 : write(King[j,k]);
        end; {case}
      end;
   end;
  textcolor(white);
  textbackground(black);
  Cursor;
 end;

{------------------}
var
 j, k : integer;
begin
 MakeGraphics;
end.
