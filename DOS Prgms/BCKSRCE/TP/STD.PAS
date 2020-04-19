{Standard Unit v1.0
These are a collection of functions and procedures I wrote and
commonly use.  Any can be used with a "uses Std" declaration.
                                      JH }

unit Std;

{---------------} interface {-------------------------------------------}

uses
 Crt, FSMouse, Dos;

const
{Expressions for GetString
 Unlock : boolean }
  unlock  = true;
  locked  = false;
{Hidden : boolean }
  dots    = true;
  visable = false;
{Convert : integer }
  reg     = 0;
  upper   = 1;
  lower   = 2;

var
 DelayTime : integer; { DrawWindow }
 Mouse     : TMouse;  { Contains mouse functions }
 MArea     : array[1..80, 1..24] of integer; {Pointer to ExID}

procedure Clear;
procedure Cursor;
procedure BlackLotusIntro;
procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
procedure EraseWindow(x1, y1, x2, y2 : integer);
function GetString(XPos, YPos : integer; Length : integer;
 Unlock : boolean; Hidden : boolean; Convert : integer) : string;
function Int2Str(I : longint) : string;
function Str2Real(S : string) : real;
function Pow(Base, Power : integer) : longint;
function Scramble(Str : string) : string;
function DeScramble(Str : string) : string;
procedure CopyText(FileName1, FileName2 : string);
procedure FadeOut;
procedure SetColor(Color : integer);
procedure SplitColor(Color : integer; var FColor, BColor : integer);
procedure MixColor(var Color : integer; FColor, BColor : integer);
procedure ClearBuffer;
procedure ViewText(FileName : string);
function ToLower(Cha : char) : char;
function EditString(sx, sy, Len : integer; Str : string;
 Break : boolean; Hidden : boolean; Convert : integer) : string;
procedure PutString(sx, sy, Len : integer; Str : string);
function StrUpper(Str : string) : string;
function StrLower(Str : string) : string;
procedure MouseOn;
procedure MouseOff;
procedure Show;
procedure Hide;
function GetClick : integer;
function MouseX : integer;
function MouseY : integer;
procedure Pause;
procedure BreakDelay(DelTime : longint);
function Exist(FileName : string) : boolean;
function InParamStr(Str : string) : boolean;
procedure FadeOut2;
procedure Background_I(Reset : boolean);
procedure MWatch;
procedure DrawButton(x1, y1, x2, y2, Color : integer; {..}
 Caption : string; ExID : integer);
procedure EraseButton(x1, y1, x2, y2, Color : integer);
function MHit : integer;
function StatusKey : char;

{------} implementation {-------------------------------------------------}
{Clear v1.0
(c) 1995 Black Lotus Software
Procedure clears screen and draws an invisable black box at bottom/left
screen corner. To be used with Cursor procedure. }
procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  textcolor(white);
  gotoxy(1,1);
 end;


{Cursor v1.0
(c) 1996 Black Lotus Software
Procedure makes cursor "invisable" by moving it to bottom/left corner.
 + Screen must have been cleared with Clear. }
procedure Cursor;
 begin
  gotoxy(1,25);
 end;


{Black Lotus Intro  v1.0
(c) 1997 Black Lotus Software
Procedure draws logo and then dissolves. }
procedure BlackLotusIntro;
 var
  Str     : string;
  ChD,
  ChC,
  ChX,
  ChY     : array[1..23] of integer;
  i, j    : integer;
  c, d    : integer;
  Left    : integer;
 begin
  randomize;
  Str := 'Black Lotus Productions';
  Clear;
  for i := 1 to 4 do
   begin
    c := 0;
    for j := 29 to 51 do
     begin
      c := c + 1;
      d := c;
      if i in [1] then if d in [5..19] then d := 4;
      if i in [2] then if d in [8..16] then d := 7;
      if i in [3] then if d in [11..13] then d := 10;
       case d of
        1..4, 20..23  : textcolor(red);
        5..7, 17..19  : textcolor(lightred);
        8..10, 14..16 : textcolor(yellow);
        11..13        : textcolor(lightgray);
       end; {case}
      gotoxy(j,10);
      write(Str[c]);
      Cursor;
     end;
    delay(78);
   end;
  for j := 1 to 23 do
   begin
    ChX[j] := j+28;
    ChY[j] := 10;
    ChD[j] := random(8)+1;
     case j of
      1..4, 20..23  : ChC[j] := 4;
      5..7, 17..19  : ChC[j] := 12;
      8..10, 14..16 : ChC[j] := 14;
      11..13        : ChC[j] := 7;
     end; {case}
   end;
  delay(78*3);
  Left := 23;
  while Left > 0 do
   begin
     repeat
      j := random(23)+1;
     until (ChX[j] in [1..80]) and (ChY[j] in [1..24]);
    textcolor(white);
    textbackground(black);
    gotoxy(ChX[j], ChY[j]);
    write(' ');
    Cursor;
     case ChD[j] of
      1 :
       begin
        ChX[j] := ChX[j] - 1;
        ChY[j] := ChY[j] - 1;
       end;
      2 : ChY[j] := ChY[j] - 1;
      3 :
       begin
        ChX[j] := ChX[j] + 1;
        ChY[j] := ChY[j] - 1;
       end;
      4 : ChX[j] := ChX[j] + 1;
      5 :
       begin
        ChX[j] := ChX[j] + 1;
        ChY[j] := ChY[j] + 1;
       end;
      6 : ChY[j] := ChY[j] + 1;
      7 :
       begin
        ChX[j] := ChX[j] - 1;
        ChY[j] := ChY[j] + 1;
       end;
      8 : ChX[j] := ChX[j] - 1;
     end; {case}
    if (not (ChX[j] in [1..80])) or (not (ChY[j] in [1..24])) then
     Left := Left - 1
    else
     begin
      textcolor(ChC[j]);
      gotoxy(ChX[j], ChY[j]);
      write(Str[j]);
      Cursor;
     end;
    delay(2);
   end;
 end;


{DrawWindow 1.0
(c) 1996 Black Lotus Software
Procedure draws text window and centers the title on top line.
 + x1, y1, x2, y2 are the four corners for text window.
 + BackColor indicates background box color.
 + Name is the string centered on top of text window.
 + DelayTime is a global var that controls window delay time.
 + DelayTimeDefault is the default value of DelayTime.
var
 DelayTime : integer; }
const
 DelayTimeDefault = 20;
procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 procedure Box(x1, y1, x2, y2 : integer);
  var
   x : integer;
   y : integer;
  begin
   for y := y1 to y2 do
    begin
     gotoxy(x1, y);
     for x := x1 to x2 do
      write(#219);
    end;
   Cursor;
  end;
 var
  j, k   : integer;
  ya, yb : integer;
  xa, xb : real;
  Times  : integer;
  XInc   : real;
 begin
  textcolor(BackColor);
  Times := (y2-y1+1) - trunc((y2-y1+1)/2);
  XInc := ((x2-x1+1)/2) / Times;
  ya := trunc((y2-y1+1)/2+y1);
  yb := ya;
  xa := trunc((x2-x1+1)/2+x1-XInc);
  xb := trunc((x2-x1+1)/2+x1+XInc);
  for j := 1 to Times - 1 do
   begin
    Box(trunc(xa), ya, trunc(xb), yb);
    delay(DelayTime);
    xa := xa - XInc;
    xb := xb + XInc;
    ya := ya - 1;
    yb := yb + 1;
   end;
  textcolor(white);
  textbackground(BackColor);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  if (x2 <= 78) and (y2 <= 23) then
   begin
    textcolor(darkgray);
    textbackground(black);
    for k := y1+1 to y2 do
     begin
      gotoxy(x2+1,k);
      write(#176, #176);
     end;
    for j := x1+2 to x2+2 do
     begin
      gotoxy(j, y2+1);
      write(#176);
     end;
   end;
  textcolor(white);
  textbackground(BackColor);
  gotoxy(x1,y1);
  write(#218);
  gotoxy(x1,y2);
  write(#192);
  for j := x1+1 to x2-1 do
   begin
    gotoxy(j, y1);
    write(#196);
    gotoxy(j,y2);
    write(#196);
   end;
  gotoxy(trunc(x1+((x2-x1+1)-length(Name))/2)-2, y1);
  write(#180, ' ', Name, ' ', #195);
  gotoxy(x2,y1);
  write(#191);
  gotoxy(x2,y2);
  write(#217);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1, k);
    write(#179);
    gotoxy(x2, k);
    write(#179);
   end;
  Cursor;
 end;


{EraseWindow 1.0
(c) 1996 Black Lotus Software
Procedure erases text windows created with DrawWindow.
 + x1, y1, x2, y2 are the four corners for text window. }
procedure EraseWindow(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(black);
  for k := y1 to y2+1 do
   for j := x1 to x2+2 do
    begin
     gotoxy(j, k);
     write(' ');
    end;
  Cursor;
 end;


{GetString 1.0
(c) 1997 Black Lotus Software
Function is a funntional one line string editor/input.
 + XPos YPos are starting coors of line.
 + Length is max number of chars.
 + Unlock is weather user can break out of
    function with (Esc) key. If so, function returns '#ESC'.
    Valid responses are unlock/locked.
 + Hidden is if the user can see characters typed.
    Valid responses are visable/hidden.
 + All characters can be converted to upper or lower case
    with Convert variable.
    Valid responses are reg/upper/lower. }
function GetString(XPos, YPos : integer; Length : integer;
 Unlock : boolean; Hidden : boolean; Convert : integer) : string;
 var
  x     : integer;
  StrC  : array[1..50] of char;
  StrS  : string;
  j     : integer;
  Found : boolean;
  Tot   : integer;
  Key   : char;
 begin
  x := 1;
  for j := 1 to 50 do
   StrC[j] := ' ';
  textcolor(white);
  textbackground(black);
  gotoxy(XPos, YPos);
  for j := 1 to Length do
   write(' ');
   repeat
    gotoxy(x+(XPos-1), YPos);
     repeat
      Key := readkey;
      if Key = #0 then
       begin
        while KeyPressed do
         Key := readkey;
        Key := #0;
       end;
      if (not Unlock) and (Key = #27) then Key := #0;
     until Key in [#32..#126, #13, #8, #27];
     case Key of
      #32..#126 :
       begin
        if Convert = 1 then Key := upcase(Key);
        if Convert = 2 then Key := chr(ord(Key)-32);
        StrC[x] := Key;
        if not Hidden then
         write(StrC[x])
        else
         write('*');
        x := x + 1;
        if x > Length then x := Length;
       end;
      #8 :
       begin
        StrC[x] := ' ';
        write(StrC[x]);
        x := x - 1;
        if x < 1 then x := 1;
        StrC[x] := ' ';
        gotoxy(x+(XPos-1), YPos);
        write(StrC[x]);
       end;
     end; {case}
   until Key in [#27, #13];
  Found := false;
  for j := 50 downto 1 do
   if not Found then
    if StrC[j] <> ' ' then
     begin
      Found := true;
      Tot := j;
     end;
  StrS := '';
  for j := 1 to Tot do
   StrS := StrS + StrC[j];
  if Key <> #27 then
   GetString := StrS
  else
   GetString := '#ESC#';
 end;

{Int2Str 1.0
(c) 1997 BlackLotusSoftware
Function converts an integer value to a string.
 + More powerful than str(i, s)
 + Allows usage in string formulas }
function Int2Str(I : longint) : string;
 var
  S : string;
 begin
  str(I, S);
  Int2Str := S;
 end;

{Str2Real 1.0
(c) 1995 Black Lotus Software
Function converts any string to a real number.
 + Handles decimal points
 + Ignores non-number characters }
function Str2Real(S : string) : real;
 var
  Ch : char;
  Num : real;
  Dec : boolean;
  Dv : real;
  Neg : boolean;
 begin
  Num := 0;
  Dec := false;
  Dv := 1;
  Neg := false;
  while S <> '' do
   begin
    Ch := S[1];
    if Ch in ['0'..'9'] then
     if not Dec then
      Num := Num * 10 + ord(Ch) - 48
     else
      begin
       Dv := Dv * 10;
       Num := Num + (ord(Ch) - 48) / Dv;
      end;
    if Ch = '.' then Dec := true;
    if Ch = '-' then Neg := true;
    delete(S,1,1);
   end;
  if not Neg then Str2Real := Num
  else Str2Real := -Num;
 end;


{Pow v1.2
(c) 1995 Black Lotus Software
This function raises Base to Power. }
function Pow(Base, Power : integer) : longint;
 var
  x : integer;
  j : integer;
 begin
  x := Base;
  for j := 1 to (Power - 1) do
   x := x * Base;
  if Power = 0 then x := 1;
  Pow := x;
 end;


{Scramble 1.0
(c) 1997 Black Lotus Software
Function recieves string and returns encrypted version.
To be used with DeScramble function.
 + Max string length is 100 chars.
 + Chars *may* be limited to #32..#126. }
function Scramble(Str : string) : string;
 var
  New  : array[1..104] of char;
  NewS : string[104];
  Seed : integer;
  x    : integer;
  Num  : integer;
 begin
  randomize;
  Seed := random(9000)+1000;
  Num := Seed;
  for x := 1 to 104 do
   New[x] :=  ' ';
  for x := 3 downto 0 do
   begin
    New[4-x] := chr(trunc(Num/(Pow(10,x))) + 48);
    Num := Num - (trunc(Num/(Pow(10,x))) * pow(10,x));
   end;
  for x := 1 to length(Str) do
   begin
    RandSeed := Seed;
    New[x+4] := chr(ord(Str[x]) + random(125));
    Seed := random(9000)+1000;
   end;
  NewS := '';
  for x := 1 to (length(Str) + 4) do
   NewS := NewS + New[x];
  Scramble := NewS;
 end;


{DeScramble 1.0
(c) 1997 Black Lotus Software
Function recieves encrypted string and returns unencrypted version.
To be used with Scramble function.
 + Max string length is 100+4 chars. }
function DeScramble(Str : string) : string;
 var
  New  : array[1..100] of char;
  NewS : string[100];
  Seed : integer;
  x    : integer;
  Code : string[4];
 begin
  Code := '';
  for x := 1 to 4 do
   Code := Code + Str[x];
  Seed := trunc(Str2Real(Code));
  for x := 1 to (length(Str)-4) do
   begin
    RandSeed := Seed;
    New[x] := chr(ord(Str[x+4]) - random(125));
    Seed := random(9000)+1000;
   end;
  NewS := '';
  for x := 1 to (length(Str) - 4) do
   NewS := NewS + New[x];
  DeScramble := NewS;
 end;


{CopyText v1.0
(c) 1997 Black Lotus Software
Procedure copys a text file to another name/location.
 + Each FileName can include a path, but must include a filename. }
procedure CopyText(FileName1, FileName2 : string);
 var
  File1 : text;
  File2 : text;
  Str : string;
 begin
  assign(File1, FileName1);
  assign(File2, FileName2);
  rewrite(File2);
  reset(File1);
  while not Eof(File1) do
   begin
    readln(File1, Str);
    writeln(File2, Str);
   end;
  close(File1);
  close(File2);
 end;


{FadeOut v2.4
(c) 1996 Black Lotus Software
Procedure clears screen from edges to center.
Usually used at program termination. }
procedure FadeOut;
 const
  XInc = (80 / 24);
 var
  i, j, k : integer;
  xa, xb  : real;
  ya, yb  : integer;
 begin
  ya := 1;
  yb := 24;
  xa := 1;
  xb := 80;
  textcolor(black);
  gotoxy(2,25);
  for j := 1 to 78 do
   write(#219);
  for i := 1 to 12 do
   begin
    for j := 1 to 80 do
     begin
      gotoxy(j,ya);
      write(#219);
      Cursor;
      gotoxy(j,yb);
      write(#219);
      Cursor;
     end;
    ya := ya + 1;
    yb := yb - 1;
    for k := ya to yb do
     begin
      for j := trunc(xa) to trunc(xa + XInc) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
      for j := trunc(xb - XInc) to trunc(xb) do
       begin
        gotoxy(j,k);
        write(#219);
        Cursor;
       end;
     end;
    xa := xa + XInc;
    xb := xb - XInc;
    delay(15);
   end;
  textcolor(white);
  textbackground(black);
  clrscr;
 end;

procedure SetColor(Color : integer);
 var
  FG : integer;
  BG : integer;
 begin
  if Color > 100 then
   begin
    BG := trunc(Color / 100) - 1;
    FG := Color - ((BG + 1) * 100) - 1;
   end
  else
   begin
    BG := trunc(Color / 10) - 1;
    FG := Color - ((BG + 1) * 10) - 1;
   end;
  textcolor(FG);
  textbackground(BG);
 end;

procedure SplitColor(Color : integer; var FColor, BColor : integer);
 begin
  if Color > 100 then
   begin
    BColor := trunc(Color / 100) - 1;
    FColor := Color - ((BColor + 1) * 100) - 1;
   end
  else
   begin
    BColor := trunc(Color / 10) - 1;
    FColor := Color - ((BColor + 1) * 10) - 1;
   end;
 end;

procedure MixColor(var Color : integer; FColor, BColor : integer);
 begin
  if FColor > 8 then
   Color := ((BColor+1) * 100)
  else
   Color := ((BColor+1) * 10);
  Color := Color + FColor + 1;
 end;

procedure ClearBuffer;
 var
  Key : char;
 begin
  if KeyPressed then
    repeat
     Key := readkey;
    until not KeyPressed;
 end;


{ViewText 1.0
(c) 1997 Black Lotus Software
Procedure views the specifided text file, allowing screen
scrolling, until the Esc key is pressed.
 + FileName is the string of the path+filename of the file to be viewed
 + Up/Down arrows scroll one line.
 + PageUp/PageDown scroll one page.
{$M 32768,0,655360}
procedure ViewText(FileName : string);
 var
  TFile    : text;
  Cha      : array[1..78, 1..250] of char;
  j, k     : integer;
  Key      : char;
  Ch       : char;
  OffSet   : integer;
  LastOS   : integer;
  LastLine : integer;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := OffSet+1 to OffSet+22 do
    for j := 1 to 78 do
     begin
      gotoxy(j+1, k-OffSet+1);
      write(Cha[j,k]);
     end;
   Cursor;
  end;
 begin
  LastOS := 1;
  for k := 1 to 250 do
   for j := 1 to 78 do
    Cha[j,k] := ' ';
  assign(TFile, FileName);
  reset(TFile);
  j := 1;
  k := 1;
  while (not Eof(TFile)) and (k <= 250) do
   begin
    read(TFile, Ch);
     case Ch of
      #32..#126 :
       begin
        Cha[j,k] := Ch;
        j := j + 1;
        if j > 78 then
         begin
          j := 1;
          k := k + 1;
         end;
       end;
      #13 : j := 1;
      #10 : k := k + 1;
     end; {case}
   end;
  LastLine := k;
  close(TFile);
  Clear;
  DrawWindow(1,1,80,24,1,FileName);
  OffSet := 0;
  textcolor(yellow);
   repeat
    if OffSet <> LastOS then DrawPage;
    LastOS := OffSet;
     repeat
      Key := readkey;
     until Key in [#27, 'H', 'P', 'I', 'Q'];
     case Key of
      'H' : OffSet := OffSet - 1;
      'P' : OffSet := OffSet + 1;
      'I' : OffSet := OffSet - 22;
      'Q' : OffSet := OffSet + 22;
     end; {case}
    if OffSet < 0 then OffSet := 0;
    if OffSet > LastLine-22 then OffSet := LastLine - 22;
   until Key = #27;
  EraseWindow(1,1,80,24);
 end;

function ToLower(Cha : char) : char;
 begin
  if Cha in ['A'..'Z'] then
   ToLower := chr(ord(Cha)+32)
  else
   ToLower := Cha;
 end;

function EditString(sx, sy, Len : integer; Str : string;
 Break : boolean; Hidden : boolean; Convert : integer) : string;
 var
  x    : integer;
  NewS : string;
  NewC : array[1..100] of char;
  Key  : char;
  j    : integer;
 begin
  NewS := Str;
  if length(NewS) > Len then delete(NewS, Len+1, length(NewS));
  for j := 1 to 100 do
   NewC[j] := ' ';
  for j := 1 to length(NewS) do
   NewC[j] := NewS[j];
  textcolor(white);
  textbackground(black);
  gotoxy(sx, sy);
  for j := 1 to Len do
   write(' ');
  gotoxy(sx, sy);
  if not Hidden then
   write(Str)
  else
   for j := 1 to length(NewS) do
    write('*');
  x := length(Str)+1;
  if x > Len then x := Len;
   repeat
    gotoxy(sx+x-1, sy);
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
       end;
      #32..#126 :
       begin
        if Convert = 1 then Key := upcase(Key);
        if Convert = 2 then Key := tolower(Key);
        NewC[x] := Key;
        if not Hidden then
         write(NewC[x])
        else
         write('*');
        x := x + 1;
        if x > Len then x := Len;
       end;
      #8 :
       begin
        NewC[x] :=  ' ';
        write(NewC[x]);
        x := x - 1;
        if x < 1 then x := 1;
        NewC[x] := ' ';
        gotoxy(sx+x-1, sy);
        write(NewC[x]);
       end;
      #27 : if not Break then Key := #0;
     end; {case}
   until Key in [#13, #27];
  if Key = #27 then
   EditString := '#ESC#'
  else
   begin
    NewS := '';
    for j := 1 to x-1 do
     NewS := NewS + NewC[j];
    if (x = Len) and (NewC[x] <> ' ') then
     NewS := NewS + NewC[x];
    EditString := NewS;
   end;
 end;

{PutString 1.0
(c) 1997 Black Lotus Software
Procedure outputs string to x,y coordinates with the given length of Len.
 Usages :
 + Printing formated text to string using preset screen colors.
   Tailing blanks are formated as well. }
procedure PutString(sx, sy, Len : integer; Str : string);
 var
  x : integer;
 begin
  gotoxy(sx,sy);
  for x := 1 to Len do
   if length(Str) >= x then
    write(Str[x])
   else
    write(' ');
 end;

function StrUpper(Str : string) : string;
 var
  x : integer;
 begin
  for x := 1 to length(Str) do
   Str[x] := upcase(Str[x]);
  StrUpper := Str;
 end;

function StrLower(Str : string) : string;
 var
  x : integer;
 begin
  for x := 1 to length(Str) do
   Str[x] := ToLower(Str[x]);
  StrLower := Str;
 end;

procedure MouseOn;
 var
  j, k : integer;
 begin
  for k := 1 to 24 do
   for j := 1 to 80 do
    MArea[j,k] := 0;
  Mouse.Init;
  Clear;
  Mouse.ShowMouse;
 end;

procedure MouseOff;
 begin
  Mouse.HideMouse;
  Mouse.Done;
 end;

procedure Show;
 begin
  Mouse.ShowMouse;
 end;

procedure Hide;
 begin
  Mouse.HideMouse;
 end;

{If button is held down it will return num
 after button is released. }
function GetClick : integer;
 var
  Click : integer;
 begin
  Click := Mouse.ButtonPressed;
  if Click <> 0 then
   while Mouse.ButtonPressed = Click do ;
  GetClick := Click;
 end;

function MouseX : integer;
 begin
  MouseX := Mouse.GetY+1;
 end;

function MouseY : integer;
 begin
  MouseY := Mouse.GetX+1;
 end;

procedure Pause;
 var
  Click : integer;
 begin
  Click := 0;
  while (not KeyPressed) and (Click = 0) do
   Click := GetClick;
  ClearBuffer;
 end;

{This procedure will delay for specified time, but will continue if
 key if pressed.  (Key remains in buffer)}
procedure BreakDelay(DelTime : longint);
 var
  i : longint;
 begin
  i := 0;
  while (i < DelTime) and (not KeyPressed) do
   begin
    delay(1);
    i := i + 1;
   end;
 end;

function Exist(FileName : string) : boolean;
 var
  Pth : PathStr;
 begin
  Pth := fsearch(FileName, GetEnv('PATH'));
  Exist := Pth <> '';
 end;

function InParamStr(Str : string) : boolean;
 var
  x     : integer;
  Found : boolean;
 begin
  Found := false;
  for x := 1 to paramcount do
   if paramstr(x) = Str then Found := true;
  InParamStr := Found;
 end;

procedure FadeOut2;
 var
  x, y  : integer;
  Dot   : array[1..80, 1..25] of boolean;
  Times : integer;
 begin
  textcolor(white);
  textbackground(black);
  for y := 1 to 25 do
   for x := 1 to 80 do
    Dot[x,y] := false;
  Dot[80,25] := true;
  Dot[1,25] := true;
  for Times := 3 to (80*25) do
   begin
     repeat
      x := random(80)+1;
      y := random(25)+1;
     until not Dot[x,y];
    gotoxy(x,y);
    write(' ');
    Cursor;
    delay(trunc(DelayTime / 50));
   end;
  clrscr;
 end;

var
 BgClr1,
 BgClr2 : integer;

procedure Background_I(Reset : boolean);
 var
  x, y, c : integer;
 begin
  textbackground(black);
  if Reset then
   begin
    randomize;
    Clear;
     repeat
      BgClr1 := random(15)+1;
      BgClr2 := random(15)+1;
     until BgClr1 <> BgClr2;
   end;
  c := 1;
  for y := 1 to 24 do
   for x := 1 to 40 do
    begin
     if (y mod 2) <> 0 then
      begin
        case c of
         1    : textcolor(BgClr1);
         2, 4 : textcolor(black);
         3    : textcolor(BgClr2);
        end; {case}
      end
     else
      begin
        case c of
         1, 3    : textcolor(black);
         2       : textcolor(BgClr1);
         4       : textcolor(BgClr2);
        end; {case}
      end;
     gotoxy(x*2-1,y);
     write(#176, #176);
     c := c + 1;
     if c > 4 then c := 1;
    end;
  Cursor;
 end;


{Adding "[x]" to end of Caption string, where x is a one
diget value of string length, indicates character to
be highlighted in yellow (for Keyboard shortcuts).}
procedure DrawButton(x1, y1, x2, y2, Color : integer; {..}
Caption : string; ExID : integer);
 var
  j, k  : integer;
  Last3 : string[3];
  HPos  : integer;
 begin
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     MArea[j,k] := ExID;
     textbackground(Color);
     textcolor(white);
     gotoxy(j,k);
     write(' ');
    end;
  Last3 := copy(Caption, length(Caption)-2, 3);
  if Last3[1] = '[' then
   begin
    HPos := trunc(Str2Real(Last3[2]));
    delete(Caption, length(Caption)-2, 3);
   end
  else
   HPos := 0;
  if ((x2-x1+1) - length(Caption)) > 1 then
   gotoxy(x1+(((x2-x1+1) - length(Caption)) div 2), y1)
  else
   gotoxy(x1,y1);
  for j := 1 to length(Caption) do
   begin
    if j = HPos then textcolor(yellow) else textcolor(white);
    write(Caption[j]);
   end;
  Cursor;
 end;

procedure EraseButton(x1, y1, x2, y2, Color : integer);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(Color);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     MArea[j,k] := 0;
     gotoxy(j,k);
     write(' ');
    end;
 end;



{This can a good programming tool used to pause execution, but
shows mouse positions, button pressed, and variable stored in
MArea.}
procedure MWatch;
 begin
  Show;
  textcolor(lightgreen);
  textbackground(cyan);
  gotoxy(2,24);
  write(' x=   y=    Click=   ExID=   ');
   repeat
    textcolor(lightgreen);
    gotoxy(5,24);
    write('  ');
    gotoxy(5,24);
    write(MouseX);
    gotoxy(10,24);
    write('  ');
    gotoxy(10,24);
    write(MouseY);
    gotoxy(20,24);
    write(Mouse.ButtonPressed);
    textcolor(yellow);
    gotoxy(28,24);
    write('   ');
    gotoxy(28,24);
    write(MArea[MouseX, MouseY]);
    Cursor;
   until (Mouse.ButtonPressed = 2) or KeyPressed;
  ClearBuffer;
 end;

function MHit : integer;
 begin
  if Mouse.ButtonPressed <> 0 then
   begin
    if MArea[MouseX, MouseY] <> 0 then
     begin
      MHit := MArea[MouseX, MouseY];
      while Mouse.ButtonPressed <> 0 do ;
     end;
   end
  else
   MHit := 0;
 end;

function StatusKey : char;
 begin
  if Keypressed then
   StatusKey := readkey
  else
   StatusKey := #187;
 end;

begin
 DelayTime := DelayTimeDefault;
end.

