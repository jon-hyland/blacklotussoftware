{ --==BLS Standard Unit==--
 -- Block Cruncher Build v1.0--

 (c) 1994-1997 Black Lotus Software
 All programming by Jon Hyland.

 This is a collection of standard routines pulled
 from the complete STD.PAS library.  Only coding
 needed by Block Cruncher v1.2 is included in
 this build.

 Written and compiled using Borland Turbo Pascal v7.0.

 Use or possession of this source code is prohibitted unless
 direct permission is granted by author. }

unit Std;

{---------------} interface {-------------------------------------------}

uses
 Crt, Dos;

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
 DW_DelayTime : integer; { DrawWindow }

procedure Clear;
procedure Cursor;
procedure BlackLotusIntro;
procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
procedure EraseWindow(x1, y1, x2, y2 : integer);
function GetString(XPos, YPos : integer; Length : integer;
 Unlock : boolean; Hidden : boolean; Convert : integer) : string;
function Str2Real(S : string) : real;
procedure FadeOut;
procedure ClearBuffer;
procedure ViewText(FileName : string);



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
    delay(DW_DelayTime);
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
    Valid responses are visable/dots.
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


{ClearBuffer v1.0
(c) 1994 Black Lotus Software
Procedure clears all characters from keyboard buffer.
 + Useful before a break or pause. }
procedure ClearBuffer;
 var
  Jnk : char;
 begin
  if KeyPressed then
    repeat
     Jnk := readkey;
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
  Cha      : array[1..78, 1..100] of char;
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


begin
 DW_DelayTime := DelayTimeDefault;
end.

