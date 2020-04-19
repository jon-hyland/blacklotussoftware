{This version completed 10/28/96.
 All coding by Jon Hyland.
 Source code requires CDTIT.PAS to compile.
 Program requires CHARSET.DAT to run.

 Tot Lines : 2812
 File Size : 66134}

program CoolDraw2_1;

uses
 Crt, Dos;

type
 PicType = record
   Char  : array[1..80, 1..24] of char;
   Color : array[1..80, 1..24] of integer;
  end;
 CharSetType = array[1..10] of char;

var
 Pic        : PicType;
 PicFile    : file of PicType;
 x, y       : integer;
 ox, oy     : integer;
 CSet       : CharSetType;
 CSetFile   : file of CharSetType;
 SetNum     : integer;
 Color      : integer;
 Key        : char;
 Quit       : boolean;
 MenuNum    : integer;
 MenuChoice : integer;
 InMenu     : boolean;
 FileName   : string;
 Changed    : boolean;

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

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

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

procedure XY;
 begin
  textcolor(lightblue);
  textbackground(black);
  gotoxy(3,25);
  write(x:2);
  gotoxy(6,25);
  write(y:2);
  gotoxy(x,y);
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

procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 const
  DelayTime = 40;
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
  textcolor(darkgray);
  textbackground(black);
  for k := y1+1 to y2 do
   for j := x2+1 to x2+2 do
    begin
     gotoxy(j,k);
     write(Pic.Char[j,k]);
    end;
  for j := x1+2 to x2+2 do
   begin
    gotoxy(j, y2+1);
    write(Pic.Char[j,k]);
   end;
  textcolor(white);
  textbackground(BackColor);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
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

procedure DrawBar;
 var
  j : shortint;
 begin
  textcolor(white);
  textbackground(red);
  gotoxy(1,1);
  write('   File     Edit     Options                     ');
  write('                Prgm     Info  ');
  textcolor(darkgray);
  textbackground(black);
  gotoxy(1,2);
  for j := 1 to 80 do
   write(Pic.Char[j,2]);
  Cursor;
 end;

procedure EraseBar;
 var
  j : integer;
 begin
  gotoxy(1,1);
  for j := 1 to 80 do
   begin
    SetColor(Pic.Color[j,1]);
    write(Pic.Char[j,1]);
   end;
  gotoxy(1,2);
  for j := 1 to 80 do
   begin
    SetColor(Pic.Color[j,2]);
    write(Pic.Char[j,2]);
   end;
  Cursor;
 end;

procedure DrawMenu(x1, y1, x2, y2, xn : integer; Name : string);
 var
  j, k : integer;
  FColor, BColor : integer;
 begin
  textcolor(yellow);
  textbackground(red);
  gotoxy(xn, y1-1);
  write(Name);
  textcolor(lightred);
  gotoxy(xn-3, y1-1);
  write(#176, #177, #178);
  gotoxy(xn+length(Name), y1-1);
  write(#178, #177, #176);
  textcolor(white);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(darkgray);
  textbackground(black);
  for k := y1+1 to y2+1 do
   begin
    gotoxy(x2+1, k);
    write(Pic.Char[x2+1, k], Pic.Char[x2+2, k]);
   end;
  gotoxy(x1+2, y2+1);
  for j := x1+2 to x2 do
   write(Pic.Char[j, y2+1]);
  Cursor;
  textcolor(white);
  textbackground(red);
  gotoxy(x1,y1);
  write(#213);
  for j := x1 + 1 to x2 - 1 do
   write(#205);
  gotoxy(xn,y1);
  write(#181);
  for j := 1 to length(Name)-2 do
   write(' ');
  write(#198);
  gotoxy(x2,y1);
  write(#184);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1,k);
    write(#179);
    gotoxy(x2,k);
    write(#179);
   end;
  gotoxy(x1,y2);
  write(#212);
  for j := x1+1 to x2-1 do
   write(#205);
  write(#190);
  Cursor;
 end;

procedure EraseMenu(x1, y1, x2, y2, xn : integer; Name : string);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(red);
  gotoxy(xn-3, y1-1);
  write('   ', Name, '   ');
  for k := y1 to y2+1 do
   for j := x1 to x2+2 do
    begin
     SetColor(Pic.Color[j,k]);
     if k = 2 then
      begin
       textcolor(darkgray);
       textbackground(black);
      end;
     gotoxy(j,k);
     write(Pic.Char[j,k]);
     Cursor;
    end;
  Cursor;
 end;

procedure DrawMenu2(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(red);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(darkgray);
  textbackground(black);
  for k := y1+1 to y2+1 do
   begin
    gotoxy(x2+1, k);
    write(Pic.Char[x2+1, k], Pic.Char[x2+2, k]);
   end;
  gotoxy(x1+2, y2+1);
  for j := x1+2 to x2 do
   write(Pic.Char[j, y2+1]);
  Cursor;
  textcolor(white);
  textbackground(red);
  gotoxy(x1-1,y1);
  write(#198, #209);
  gotoxy(x2,y1);
  write(#184);
  gotoxy(x1+1, y1);
  for j := x1+1 to x2-1 do
   write(#205);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1,k);
    write(#179);
    gotoxy(x2,k);
    write(#179);
   end;
  gotoxy(x1,y2);
  write(#212);
  gotoxy(x2,y2);
  write(#190);
  gotoxy(x1+1,y2);
  for j := x1+1 to x2-1 do
   write(#205);
  Cursor;
 end;

procedure EraseMenu2(x1, y1, x2, y2, LastMenuY2 : integer);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(red);
  gotoxy(x1-1,y1);
  write(#179);
  for k := y1 to y2+1 do
   for j := x1 to x2+2 do
    begin
     SetColor(Pic.Color[j,k]);
     if (j in [x1, x1+1]) and (k <= LastMenuY2+1) then
      begin
       textcolor(darkgray);
       textbackground(black);
      end;
     gotoxy(j,k);
     write(Pic.Char[j,k]);
     Cursor;
    end;
  Cursor;
 end;

procedure DrawInfo;
 begin
  DrawWindow(23,8,59,13,4,'Info');
  textcolor(yellow);
  gotoxy(33,9);
  write('Cool Draw  v2.1');
  gotoxy(27,10);
  write('(c) 1996 Hyland Productions');
  textcolor(lightgray);
  gotoxy(29,12);
  write('Programmed by Jon Hyland');
  Cursor;
 end;

{$I CDTIT.PAS}
procedure Title;
 const
  Stars = 100;
 var
  j, k : integer;
  rx, ry  : integer;
  Rem     : array[1..80, 1..24] of boolean;
 begin
  randomize;
  Clear;
  for k := 1 to 24 do
   for j := 1 to 80 do
    Rem[j,k] := false;
  textcolor(white);
  for j := 1 to Stars do
   begin
     repeat
      rx := random(80)+1;
      ry := random(24)+1;
     until (not(rx in [17..65])) or (not(ry in [4..19]));
    gotoxy(rx,ry);
    write('.');
   end;
  for k := 1 to 24 do
   begin
    for j := 1 to 80 do
     begin
       repeat
        rx := random(80)+1;
        ry := random(24)+1;
       until not Rem[rx,ry];
      Rem[rx,ry] := true;
      if PicChar[rx,ry] <> ' ' then
       begin
         gotoxy(rx,ry);
        SetColor(PicColor[rx,ry]);
        write(PicChar[rx,ry]);
        Cursor;
       end;
     end;
    delay(10);
   end;
  Cursor;
  readkey;
 end;

procedure Init;
 var
  j, k : integer;
 begin
  assign(CSetFile, 'CHARSET.DAT');
  SetNum := 6;
  Color := 116;
  for k := 1 to 24 do
   for j := 1 to 80 do
    begin
     Pic.Char[j,k] := ' ';
     Pic.Color[j,k] := 116;
    end;
  x := 1;
  y := 1;
  Quit := false;
  MenuNum := 1;
  FileName := '';
  MenuChoice := 1;
  Changed := false;
 end;

procedure LoadSet(Num : integer);
 var
  j : integer;
 begin
  reset(CSetFile);
  for j := 1 to Num do
   read(CSetFile, CSet);
  close(CSetFile);
  textcolor(white);
  textbackground(red);
  gotoxy(13,25);
  for j := 1 to 10 do
   begin
    if j < 10 then write(j) else write('0');
    write('=', CSet[j], ' ');
   end;
  Cursor;
 end;

procedure PutText(Text : string);
 var
  j : integer;
 begin
  textcolor(white);
  textbackground(black);
  gotoxy(13,25);
  for j := 1 to 10 do
   write('    ');
  textcolor(yellow);
  textbackground(blue);
  gotoxy(31-trunc(length(Text)/2), 25);
  write(' ', Text, ' ');
  Cursor;
 end;

procedure DrawScreen;
 var
  j : integer;
 begin
  Clear;
  textcolor(blue);
  textbackground(black);
  gotoxy(2,25);
  write('(  ,  )');
  LoadSet(SetNum);
  SetColor(Color);
  gotoxy(56,25);
  write('Color');
  textcolor(lightgray);
  textbackground(black);
  gotoxy(65,25);
  write('(   )=Menu');
  textcolor(yellow);
  gotoxy(66,25);
  write('Esc');
  Cursor;
 end;

procedure PutChar(Char : char);
 begin
  gotoxy(x,y);
  Pic.Char[x,y] := Char;
  Pic.Color[x,y] := Color;
  SetColor(Pic.Color[x,y]);
  write(Pic.Char[x,y]);
  x := x + 1;
  if x > 80 then
   begin
    x := 1;
    y := y + 1;
    if y > 24 then y := 1;
   end;
  if not Changed then Changed := true;
 end;

procedure GetColors;
 var
  j      : integer;
  Key    : char;
  Fg     : boolean;
  FColor,
  BColor : integer;
  AColor : integer;
 begin
  DrawMenu2(32,3,69,6);
  for j := 0 to 15 do
   begin
    textcolor(j);
    gotoxy((j*2) + 36, 4);
    write(#219, #219);
    if j < 8 then
     begin
      gotoxy((j*2) + 36, 5);
      write(#219, #219);
     end;
   end;
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
  Fg := true;
   repeat
    textbackground(black);
    gotoxy((FColor*2)+36, 4);
    if FColor <> 0 then
     textcolor(FColor)
    else
     textcolor(darkgray);
    write(#222, #221);
    gotoxy((BColor*2)+36, 5);
    if BColor <> 0 then
     textcolor(BColor)
    else
     textcolor(darkgray);
    write(#222, #221);
    textcolor(white);
    textbackground(red);
    if Fg then
     begin
      gotoxy(34,4);
      write(#16);
      gotoxy(34,5);
      write(' ');
     end
    else
     begin
      gotoxy(34,4);
      write(' ');
      gotoxy(34,5);
      write(#16);
     end;
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['K','M'] then
         begin
          textcolor(FColor);
          gotoxy((FColor*2)+36, 4);
          write(#219,#219);
          textcolor(BColor);
          gotoxy((BColor*2)+36, 5);
          write(#219,#219);
         end;
         case Key of
          'H', 'P' : Fg := not Fg;
          'K' : if Fg then
            FColor := FColor - 1
           else
            BColor := BColor - 1;
          'M' : if Fg then
            FColor := FColor + 1
           else
            BColor := BColor + 1;
         end; {case}
        if FColor > 15 then FColor := 0;
        if FColor < 0 then FColor := 15;
        if BColor > 7 then BColor := 0;
        if BColor < 0 then BColor := 7;
       end;
     end; {case}
    if FColor > 8 then
     AColor := (BColor+1) * 100
    else
     AColor := (BColor+1) * 10;
    AColor := (FColor+1) + AColor;
    SetColor(AColor);
    gotoxy(56,25);
    write('Color')
   until (Key = #13) or (Key = #27);
  if Key = #13 then
   begin
    Color := AColor;
    InMenu := false;
   end;
  if Key = #27 then
   begin
    SetColor(Color);
    gotoxy(56,25);
    write('Color')
   end;
  EraseMenu2(32,3,69,6,5);
 end;

procedure GetCharSet;
 var
  TotSet    : integer;
  JunkSet   : CharSetType;
  j, k      : integer;
  NewSetNum : integer;
 begin
  NewSetNum := SetNum;
  TotSet := 0;
  reset(CSetFile);
  while not Eof(CSetFile) do
   begin
    read(CSetFile, JunkSet);
    TotSet := TotSet + 1;
   end;
  DrawMenu2(32,4,57,TotSet+5);
  reset(CSetFile);
  for k := 1 to TotSet do
   begin
    read(CSetFile, JunkSet);
    gotoxy(36,k+4);
    for j := 1 to 10 do
     write(JunkSet[j], ' ');
   end;
   repeat
    gotoxy(34, NewSetNum + 4);
    write(#16);
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','P'] then
         begin
          gotoxy(34, NewSetNum + 4);
          write(' ');
          Cursor;
         end;
         case Key of
          'H' : NewSetNum := NewSetNum - 1;
          'P' : NewSetNum := NewSetNum + 1;
         end; {case}
        if NewSetNum > TotSet then NewSetNum := 1;
        if NewSetNum < 1 then NewSetNum := TotSet;
       end;
     end; {case}
    LoadSet(NewSetNum);
   until (Key = #13) or (Key = #27);
  if Key = #13 then
   begin
    InMenu := false;
    SetNum := NewSetNum;
   end;
  if Key = #27 then
   begin
    LoadSet(SetNum);
   end;
  EraseMenu2(32,4,57,TotSet+5,5);
 end;

procedure CopySection;
 var
  Piece      : PicType;
  StartX,
  StartY,
  EndX,
  EndY       : integer;
  TotX, TotY : integer;
  NewX, NewY : integer;
  ox, oy     : integer;
  Key        : char;
  j, k       : integer;
  BColor     : integer;
 begin
   EraseMenu(11,2,20,9,13,'Edit');
   EraseBar;
   PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  if Color > 99 then
   if (trunc(Color / 100)-1) <> 4 then
    BColor := 4
   else
    BColor := 5
  else
   if (trunc(Color / 10)-1) <> 4 then
    BColor := 4
   else
    BColor := 5;
   XY;
   textcolor(white);
   textbackground(BColor);
   write(Pic.Char[x,y]);
   PutText('Select lower/right corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        ox := x;
        oy := y;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX then x := StartX;
        if y > 24 then y := 24;
        if y < StartY then y := StartY;
        if x > ox then
         for k := StartY to y do
          for j := ox+1 to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y > oy then
         for k := oy+1 to y do
          for j := StartX to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y < oy then
         for k := y+1 to oy do
          for j := StartX to x+1 do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
        if x < ox then
         for k := StartY to oy do
          for j := x+1 to ox do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
       end;
     end; {case}
   until Key = #13;
  EndX := x;
  EndY := y;
  TotX := EndX - StartX + 1;
  TotY := EndY - StartY + 1;
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     gotoxy(j,k);
     SetColor(Pic.Color[j,k]);
     write(Pic.Char[j,k]);
     Piece.Color[j-(StartX-1), k-(StartY-1)] := Pic.Color[j,k];
     Piece.Char[j-(StartX-1), k-(StartY-1)] := Pic.Char[j,k];
    end;
  x := StartX;
  y := StartY;
  PutText('Move section. (S)tamp or (Enter).');
   repeat
     repeat
      XY;
      for k := 1 to TotY do
       for j := 1 to TotX do
        begin
         gotoxy(j+x-1, k+y-1);
         SetColor(Piece.Color[j,k]);
         write(Piece.Char[j,k]);
        end;
      XY;
      Key := readkey;
      Key := upcase(Key);
       case Key of
        #0 :
         begin
          XY;
          Key := readkey;
          if Key in ['H','K','P','M'] then
           for k := 1 to TotY do
            for j := 1 to TotX do
             begin
              gotoxy(j+x-1, k+y-1);
              SetColor(Pic.Color[j+x-1,k+y-1]);
              write(Pic.Char[j+x-1,k+y-1]);
             end;
          XY;
           case Key of
            'H' : y := y - 1;
            'K' : x := x - 1;
            'P' : y := y + 1;
            'M' : x := x + 1;
           end; {case}
          if x > (80-TotX+1) then x := (80-TotX+1);
          if x < 1 then x := 1;
          if y > (24-TotY+1) then y := (24-TotY+1);
          if y < 1 then y := 1;
         end;
       end; {case}
     until (Key = #13) or (Key = 'S');
    NewX := x;
    NewY := y;
    for k := 1 to TotY do
     for j := 1 to TotX do
      begin
       Pic.Color[j+x-1, k+y-1] := Piece.Color[j,k];
       Pic.Char[j+x-1, k+y-1] := Piece.Char[j,k];
      end;
   until Key = #13;
  if not Changed then Changed := true;
  LoadSet(SetNum);
  InMenu := false;
 end;

procedure FillSection;
 var
  j, k       : integer;
  Key        : char;
  Ground     : char;
  StartX,
  StartY,
  EndX, EndY : integer;
  OBColor     : integer;
  OFColor     : integer;
  NBColor     : integer;
  NFColor     : integer;
  NColor     : integer;
 begin
  EraseMenu(11,2,20,9,13,'Edit');
  EraseBar;
  PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  SplitColor(Pic.Color[x,y], NFColor, NBColor);
  if NBColor = 4 then NBColor := 5 else NBColor := 4;
  XY;
  textcolor(white);
  textbackground(NBColor);
  write(Pic.Char[x,y]);
  PutText('Select lower/right corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        ox := x;
        oy := y;
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX then x := StartX;
        if y > 24 then y := 24;
        if y < StartY then y := StartY;
        if x > ox then
         for k := StartY to y do
          for j := ox+1 to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(NBColor);
            write(Pic.Char[j,k]);
           end;
        if y > oy then
         for k := oy+1 to y do
          for j := StartX to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(NBColor);
            write(Pic.Char[j,k]);
           end;
        if y < oy then
         for k := y+1 to oy do
          for j := StartX to x+1 do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
        if x < ox then
         for k := StartY to oy do
          for j := x+1 to ox do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
       end;
     end; {case}
   until Key = #13;
  EndX := x;
  EndY := Y;
  PutText('Fill Fore/bacK/Both?');
  textcolor(white);
  textbackground(blue);
  gotoxy(27,25);
  write('F');
  gotoxy(35,25);
  write('K');
  gotoxy(37,25);
  write('B');
  Cursor;
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['F','B','K'];
  Ground := Key;
  SplitColor(Color, NFColor, NBColor);
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     SplitColor(Pic.Color[j,k], OFColor, OBColor);
     if Ground = 'F' then MixColor(NColor, NFColor, OBColor);
     if Ground = 'K' then MixColor(NColor, OFColor, NBColor);
     if Ground = 'B' then MixColor(NColor, NFColor, NBColor);
     Pic.Color[j,k] := NColor;
     gotoxy(j,k);
     SetColor(Pic.Color[j,k]);
     write(Pic.Char[j,k]);
    end;
  if not Changed then Changed := true;
  LoadSet(SetNum);
  Cursor;
  InMenu := false;
 end;

procedure MoveSection;
 var
  j, k            : integer;
  FColor, BColor  : integer;
  StartX, StartY,
  EndX, EndY,
  TotX, TotY,
  NewX, NewY      : integer;
  Piece           : PicType;
 begin
  EraseMenu(11,2,20,9,13,'Edit');
  EraseBar;
  PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  if BColor = 4 then BColor := 5 else BColor := 4;
  XY;
  textcolor(white);
  textbackground(BColor);
  write(Pic.Char[x,y]);
  PutText('Select lower/right corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        ox := x;
        oy := y;
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX then x := StartX;
        if y > 24 then y := 24;
        if y < StartY then y := StartY;
        if x > ox then
         for k := StartY to y do
          for j := ox+1 to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y > oy then
         for k := oy+1 to y do
          for j := StartX to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y < oy then
         for k := y+1 to oy do
          for j := StartX to x+1 do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
        if x < ox then
         for k := StartY to oy do
          for j := x+1 to ox do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
       end;
     end; {case}
   until Key = #13;
  EndX := x;
  EndY := Y;
  TotX := EndX - StartX + 1;
  TotY := EndY - StartY + 1;
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     Piece.Color[j-(StartX-1), k-(StartY-1)] := Pic.Color[j,k];
     Piece.Char[j-(StartX-1), k-(StartY-1)]  := Pic.Char[j,k];
     Pic.Color[j,k] := Color;
     Pic.Char[j,k] := ' ';
    end;
  x := StartX;
  y := StartY;
  PutText('Move section. (Enter) = Done.');
   repeat
    for k := 1 to TotY do
     for j := 1 to TotX do
      begin
       gotoxy(j+(x-1), k+(y-1));
       SetColor(Piece.Color[j,k]);
       write(Piece.Char[j,k]);
      end;
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','K','P','M'] then
         begin
          for k := 1 to TotY do
           for j := 1 to TotX do
            begin
             gotoxy(j+(x-1), k+(y-1));
             SetColor(Pic.Color[j+(x-1),k+(y-1)]);
             write(Pic.Char[j+(x-1),k+(y-1)]);
            end;
         end;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > (80 - TotX + 1) then
         x := (80 - TotX + 1);
        if x < 1 then x := 1;
        if y > (24 - TotY + 1) then
         y := (24 - TotY + 1);
        if y < 1 then y := 1;
       end;
     end; {case}
   until Key = #13;
  NewX := x;
  NewY := y;
  for k := 1 to TotY do
   for j := 1 to TotX do
    begin
     Pic.Color[j+(NewX-1), k+(NewY-1)] := Piece.Color[j,k];
     Pic.Char[j+(NewX-1), k+(NewY-1)] := Piece.Char[j,k];
    end;
  if not Changed then Changed := true;
  LoadSet(SetNum);
  InMenu := false;
 end;

procedure ChangeSection;
 var
  Key        : char;
  j, k       : integer;
  StartX,
  StartY,
  EndX, EndY : integer;
  BColor     : integer;
  GoodChar   : boolean;
 begin
  EraseMenu(11,2,20,9,13,'Edit');
  EraseBar;
  PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  if BColor = 4 then
   BColor := 5
  else
   BColor := 4;
  XY;
  textcolor(white);
  textbackground(BColor);
  write(Pic.Char[x,y]);
  PutText('Select lower/right corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        ox := x;
        oy := y;
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX then x := StartX;
        if y > 24 then y := 24;
        if y < StartY then y := StartY;
        if x > ox then
         for k := StartY to y do
          for j := ox+1 to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y > oy then
         for k := oy+1 to y do
          for j := StartX to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y < oy then
         for k := y+1 to oy do
          for j := StartX to x+1 do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
        if x < ox then
         for k := StartY to oy do
          for j := x+1 to ox do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
       end;
     end; {case}
   until Key = #13;
  EndX := x;
  EndY := Y;
  LoadSet(SetNum);
  textcolor(yellow);
  textbackground(blue);
  gotoxy(19,24);
  write('Fill area with what char?');
  Cursor;
  GoodChar := false;
   repeat
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          ';'..'D' :
           begin
            GoodChar := true;
            Key := CSet[ord(Key)-58];
           end;
         end; {case}
       end;
      #32..#126 : GoodChar := true;
     end; {case}
   until GoodChar;
  gotoxy(19,24);
  for j := 19 to 19+25 do
   begin
    SetColor(Pic.Color[j,24]);
    write(Pic.Char[j,24]);
   end;
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     Pic.Char[j,k] := Key;
     gotoxy(j,k);
     SetColor(Pic.Color[j,k]);
     write(Pic.Char[j,k]);
    end;
  if not Changed then Changed := true;
  InMenu := false;
 end;

procedure FlipSection;
 var
  j, k    : integer;
  StartX,
  StartY,
  EndX,
  EndY    : integer;
  Piece   : PicType;
  BColor  : integer;
  Smart   : boolean;
 function VFlip(Cha : char) : char;
  const
   Flip : array[1..46] of char = (#243, #242, #17, #16, #40, #41,
    #47, #92, #60, #62, #123, #125, #91, #93, #169, #170, #174,
    #175, #218, #191, #192, #217, #195, #180, #201, #187, #200,
    #188, #204, #185, #213, #184, #212, #190, #198, #181, #214,
    #183, #211, #189, #199, #182, #221, #222, #27, #26);
  var
   j : integer;
   Found : boolean;
  begin
   j := 0;
   Found := false;
    repeat
     j := j + 1;
     if Flip[j] = Cha then Found := true;
    until Found or (j >= 46);
   if Found then
    if (j div 2) <> (j / 2) then
     Cha := Flip[j+1]
    else
     Cha := Flip[j-1];
   VFlip := Cha;
  end;
 function HFlip(Cha : char) : char;
  const
   Flip : array[1..32] of char = (#24, #25, #30, #31, #47, #92,
    #218, #217, #192, #191, #193, #194, #201, #188, #200, #187,
    #202, #203, #213, #190, #212, #184, #207, #209, #214, #189,
    #211, #183, #208, #210, #223, #220);
  var
   j : integer;
   Found : boolean;
  begin
   Found := false;
   j := 0;
    repeat
     j := j + 1;
     if Flip[j] = Cha then Found := true;
    until Found or (j >= 32);
   if Found then
    if (j div 2) <> (j / 2) then
     Cha := Flip[j+1]
    else
     Cha := Flip[j-1];
   HFlip := Cha;
  end;
 begin
  EraseMenu(11,2,20,9,13,'Edit');
  EraseBar;
  PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  if BColor = 4 then
   BColor := 5
  else BColor := 4;
  XY;
  textcolor(white);
  textbackground(BColor);
  write(Pic.Char[x,y]);
  PutText('Select lower/right corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        ox := x;
        oy := y;
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX then x := StartX;
        if y > 24 then y := 24;
        if y < StartY then y := StartY;
        if x > ox then
         for k := StartY to y do
          for j := ox+1 to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y > oy then
         for k := oy+1 to y do
          for j := StartX to x do
           begin
            gotoxy(j,k);
            textcolor(white);
            textbackground(BColor);
            write(Pic.Char[j,k]);
           end;
        if y < oy then
         for k := y+1 to oy do
          for j := StartX to x+1 do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
        if x < ox then
         for k := StartY to oy do
          for j := x+1 to ox do
           begin
            gotoxy(j,k);
            SetColor(Pic.Color[j,k]);
            write(Pic.Char[j,k]);
           end;
       end;
     end; {case}
   until Key = #13;
  EndX := x;
  EndY := Y;
  PutText('Use SmartFlip? (Y/N)');
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['Y','N'];
  Smart := Key = 'Y';
  PutText('Flip (H)orz / (V)ert?');
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['H','V'];
  LoadSet(SetNum);
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     if Key = 'V' then
      begin
       Piece.Color[j,k] := Pic.Color[EndX - (j - StartX), k];
       Piece.Char[j,k] := Pic.Char[EndX - (j - StartX), k];
       if Smart then Piece.Char[j,k] := VFlip(Piece.Char[j,k]);
      end;
     if Key = 'H' then
      begin
       Piece.Color[j,k] := Pic.Color[j, EndY - (k - StartY)];
       Piece.Char[j,k] := Pic.Char[j, EndY - (k - StartY)];
       if Smart then Piece.Char[j,k] := HFlip(Piece.Char[j,k]);
      end;
    end;
  for k := StartY to EndY do
   for j := StartX to EndX do
    begin
     Pic.Color[j,k] := Piece.Color[j,k];
     Pic.Char[j,k] := Piece.Char[j,k];
     SetColor(Pic.Color[j,k]);
     gotoxy(j,k);
     write(Pic.Char[j,k]);
    end;
  if not Changed then Changed := true;
  InMenu := false;
 end;

procedure SpillArea;
 var
  Need       : array[1..80, 1..24] of boolean;
  CurrentX,
  CurrentY   : integer;
  j, k       : integer;
  Key        : char;
  FirstColor : integer;
  Found      : boolean;
 begin
  EraseMenu(11,2,20,9,13,'Edit');
  EraseBar;
  PutText('Select drop spot.');
  for k := 1 to 24 do
   for j := 1 to 80 do
    Need[j,k] := false;
   repeat
    XY;
     repeat
      Key := readkey;
     until Key in ['H','K','P','M',#13];
     case Key of
      'H' : y := y - 1;
      'K' : x := x - 1;
      'P' : y := y + 1;
      'M' : x := x + 1;
     end; {case}
   until Key = #13;
  CurrentX := x;
  CurrentY := y;
  FirstColor := Pic.Color[CurrentX, CurrentY];
  if FirstColor <> Color then
   begin
     repeat
      Pic.Color[CurrentX, CurrentY] := Color;
      SetColor(Pic.Color[CurrentX, CurrentY]);
      gotoxy(CurrentX, CurrentY);
      write(Pic.Char[CurrentX, CurrentY]);
      Need[CurrentX, CurrentY] := false;
      if (CurrentX in [1..80]) and (CurrentY-1 in [1..24]) then
       if Pic.Color[CurrentX, CurrentY-1] = FirstColor then
        Need[CurrentX, CurrentY-1] := true;
      if (CurrentX-1 in [1..80]) and (CurrentY in [1..24]) then
       if Pic.Color[CurrentX-1, CurrentY] = FirstColor then
        Need[CurrentX-1, CurrentY] := true;
      if (CurrentX+1 in [1..80]) and (CurrentY in [1..24]) then
       if Pic.Color[CurrentX+1, CurrentY] = FirstColor then
        Need[CurrentX+1, CurrentY] := true;
      if (CurrentX in [1..80]) and (CurrentY+1 in [1..24]) then
       if Pic.Color[CurrentX, CurrentY+1] = FirstColor then
        Need[CurrentX, CurrentY+1] := true;
      Found := false;
      for k := 1 to 24 do
       for j := 1 to 80 do
        if not Found then
         if Need[j,k] then
          begin
           Found := true;
           CurrentX := j;
           CurrentY := k;
          end;
     until not Found;
   end;
  LoadSet(SetNum);
  if not Changed then Changed := true;
  InMenu := false;
 end;

procedure PrgmWindow;
 var
  j, k    : integer;
  StartX,
  StartY,
  EndX,
  EndY    : integer;
 begin
  EraseMenu(64,2,75,4,66,'Prgm');
  EraseBar;
  PutText('Select upper/left corner.');
   repeat
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 1;
        if x < 1 then x := 80;
        if y > 24 then y := 1;
        if y < 1 then y := 24;
       end;
     end; {case}
   until Key = #13;
  StartX := x;
  StartY := y;
  SetColor(Color);
  gotoxy(x,y);
  write(#218, #191);
  gotoxy(x,y+1);
  write(#192, #217);
  x := x + 1;
  y := y + 1;
  PutText('Select lower/right corner.');
   repeat
    if ((y-StartY+1) >= 3) and ((x-StartX+1) >= 7) then
     begin
      SetColor(Color);
      textcolor(white);
      gotoxy((StartX+3)+trunc((x-StartX-8)/2),
       trunc(((y-StartY+1)/2)-2)+StartY+1);
      write(x-StartX+1, 'x', y-StartY+1);
     end;
    XY;
    Key := readkey;
     case Key of
      #0 :
       begin
        ox := x;
        oy := y;
        Key := readkey;
        if Key in ['H','K','P','M'] then
         if ((y-StartY+1) >= 3) and ((x-StartX+1) >= 7) then
          begin
           SetColor(Color);
           textcolor(white);
           gotoxy((StartX+3)+trunc((x-StartX-8)/2),
            trunc(((y-StartY+1)/2)-2)+StartY+1);
           write('   ');
           if (x-StartX+1) > 9 then write(' ');
           if (y-StartY+1) > 9 then write(' ');
          end;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x > 80 then x := 80;
        if x < StartX+1 then x := StartX+1;
        if y > 24 then y := 24;
        if y < StartY+1 then y := StartY+1;
        if x > ox then
         begin
          SetColor(Color);
          for k := StartY to y do
           begin
            gotoxy(ox, k);
            if k in [StartY, y] then write(#196) else write(' ');
           end;
          for k := StartY to y do
           begin
            gotoxy(x, k);
            if not (k in [StartY, y]) then write(#179) else
             if k = StartY then write(#191) else write(#217);
           end;
         end;
        if x < ox then
         begin
          SetColor(Color);
          for k := StartY to y do
           begin
            gotoxy(x, k);
            if not (k in [StartY, y]) then write(#179) else
             if k = StartY then write(#191) else write(#217);
           end;
          for k := StartY to y do
           begin
            SetColor(Pic.Color[ox,k]);
            gotoxy(ox, k);
            write(Pic.Char[ox,k]);
           end;
         end;
        if y > oy then
         begin
          SetColor(Color);
          for j := StartX to x do
           begin
            gotoxy(j, oy);
            if j in [StartX, x] then write(#179) else write(' ');
           end;
          for j := StartX to x do
           begin
            gotoxy(j, y);
            if not (j in [StartX, x]) then write(#196) else
             if j = StartX then write(#192) else write(#217);
           end;
         end;
        if y < oy then
         begin
          SetColor(Color);
          for j := StartX to x do
           begin
            gotoxy(j, y);
            if not (j in [StartX, x]) then write(#196) else
             if j = StartX then write(#192) else write(#217);
           end;
          for j := StartX to x do
           begin
            SetColor(Pic.Color[j,oy]);
            gotoxy(j,oy);
            write(Pic.Char[j,oy]);
           end;
         end;
       end;
     end; {case}
   until (Key = #13) or (Key = #27);
  EndX := x;
  EndY := Y;
  if Key = #13 then
   begin
    for k := StartY to EndY do
     for j := StartX to EndX do
      begin
       Pic.Color[j,k] := Color;
       if (j in [StartX, EndX]) or (k in [StartY, EndY]) then
        begin
         if (j = StartX) and (k = StartY) then
          Pic.Char[j,k] := #218
         else if (j = EndX) and (k = StartY) then
          Pic.Char[j,k] := #191
         else if (j = StartX) and (k = EndY) then
          Pic.Char[j,k] := #192
         else if (j = EndX) and (k = EndY) then
          Pic.Char[j,k] := #217
         else
          if (k in [StartY+1..EndY-1]) then
           Pic.Char[j,k] := #179
          else
           Pic.Char[j,k] := #196;
        end
       else
        Pic.Char[j,k] := ' ';
       gotoxy(j,k);
       SetColor(Pic.Color[j,k]);
       write(Pic.Char[j,k]);
      end;
    DrawWindow(30,8,52,12,5,'Window Info');
    gotoxy(32,9);
    write('Coors : ', StartX:2, ',', StartY:2, ',', EndX:2, ',', EndY:2);
    gotoxy(32,11);
    write('Write Point : ', StartX+2);
    Cursor;
    readkey;
    for k := 8 to 13 do
     for j := 30 to 54 do
      begin
       gotoxy(j,k);
       SetColor(Pic.Color[j,k]);
       write(Pic.Char[j,k]);
      end;
    if not Changed then Changed := true;
   end
  else
   begin
    for k := StartY to EndY do
     for j := StartX to EndX do
      begin
       gotoxy(j,k);
       SetColor(Pic.Color[j,k]);
       write(Pic.Char[j,k]);
      end;
   end;
  x := StartX;
  y := StartY;
  InMenu := false;
  LoadSet(SetNum);
 end;

function GetFileName : string;
 var
  Name     : string;
  Chars    : array[1..12] of char;
  x        : integer;
  j        : integer;
  Key      : char;
  Dec      : boolean;
  DecNum   : integer;
  GoodChar : boolean;
 begin
  textcolor(white);
  textbackground(black);
  gotoxy(28,7);
  write('            ');
  for j := 1 to 12 do
   Chars[j] := ' ';
  Name := '';
  x := 1;
  Dec := false;
   repeat
    gotoxy(x+27, 7);
    GoodChar := false;
     repeat
      Key := readkey;
      Key := upcase(Key);
       case Key of
        #13, #8, #27 : GoodChar := true;
        'A'..'Z' : GoodChar := true;
        '0'..'9', '_' : if x <> 1 then GoodChar := true;
        '.' : if not Dec then GoodChar := true;
       end; {case}
      if Dec and (x > (DecNum + 3)) and not(Key in [#13, #8, #27]) then
       GoodChar := false;
      if (not Dec) and (x > 8) and not(Key in [#13, #8, '.', #27]) then
       GoodChar := false;
     until GoodChar;
    if Key = '.' then
     begin
      Dec := true;
      DecNum := x;
     end;
     case Key of
      #27 : ;
      #13 : ;
      #8  :
       begin
        if (Chars[x] = '.') or (Chars[x-1] = '.') then Dec := false;
        Chars[x] := ' ';
        write(' ');
        x := x - 1;
        if x < 1 then x := 1;
        Chars[x] := ' ';
        gotoxy(x+27, 7);
        write(' ');
       end;
     else
      begin
       write(Key);
       Chars[x] := Key;
       x := x + 1;
       if x > 12 then x := 12;
      end;
     end; {case}
   until (Key = #13) or (Key = #27);
  if not Dec then
   begin
    Chars[x] := '.';
    Chars[x+1] := 'P';
    Chars[x+2] := 'I';
    Chars[x+3] := 'C';
   end;
  for j := 1 to 12 do
   if Chars[j] <> ' ' then
    Name := concat(Name, Chars[j]);
  textbackground(red);
  gotoxy(28, 7);
  write(Name);
  for j := length(Name)+1 to 12 do
   write(' ');
  GetFileName := Name;
  if Key = #27 then
   GetFileName := 'quit';
 end;

procedure SaveAs;
 var
  Key         : char;
  OldFileName : string;
  Quit        : boolean;
 begin
  OldFileName := FileName;
  DrawMenu2(16,6,41,8);
  gotoxy(18,7);
  write('Save As : ');
   repeat
    FileName := GetFileName;
    Quit := FileName = 'quit';
    if FileName = 'quit' then FileName := '';
    if Quit or (FileName = '') then
     FileName := OldFileName
    else
     begin
      Key := 'Y';
      if FSearch(FileName, '') <> '' then
       begin
        DrawMenu2(42,7,67,11);
        gotoxy(45,8);
        write('File already exists!');
        gotoxy(44,9);
        write('Replace existing file?');
        gotoxy(52,10);
        write('( / )');
        textcolor(yellow);
        gotoxy(53,10);
        write('Y');
        gotoxy(55,10);
        write('N');
        Cursor;
         repeat
          Key := readkey;
          Key := upcase(Key);
         until Key in ['Y','N'];
        EraseMenu2(42,7,67,11,9);
       end;
     end;
   until (Key = 'Y') or not InMenu or Quit;
  if (Key = 'Y') and (InMenu) then
   begin
    assign(PicFile, FileName);
    rewrite(PicFile);
    write(PicFile, Pic);
    close(PicFile);
    Changed := false;
    InMenu := false;
   end;
  EraseMenu2(16,6,41,8,9);
 end;

procedure Save;
 var
  Key : char;
 begin
  if FileName <> '' then
   begin
    DrawMenu2(16,5,41+length(FileName),8);
    gotoxy(18,6);
    write('Save current file as ', FileName, '?');
    gotoxy(31,7);
    write('( / )');
    textcolor(yellow);
    gotoxy(32,7);
    write('Y');
    gotoxy(34,7);
    write('N');
    Cursor;
     repeat
      Key := readkey;
      Key := upcase(Key);
     until Key in ['Y','N'];
    if Key = 'Y' then
     begin
      assign(PicFile, FileName);
      rewrite(PicFile);
      write(PicFile, Pic);
      close(PicFile);
      Changed := false;
      InMenu := false;
     end;
    EraseMenu2(16,5,41+length(FileName),8,9);
   end
  else
   SaveAs;
 end;

procedure NewPic;
 var
  Key  : char;
  j, k : integer;
 begin
  Key := 'Y';
  if Changed then
   begin
    DrawMenu2(16,3,41,7);
    textcolor(yellow);
    gotoxy(18,4);
    write('File has been changed!');
    gotoxy(19,5);
    write('Erase current file?');
    gotoxy(26,6);
    write('(');
    textcolor(white);
    write('Y');
    textcolor(yellow);
    write('/');
    textcolor(white);
    write('N');
    textcolor(yellow);
    write(')');
    Cursor;
     repeat
      Key := readkey;
      Key := upcase(Key);
     until Key in ['Y','N'];
    EraseMenu2(16,4,41,8,9);
   end;
  if Key = 'Y' then
   begin
    Changed := false;
    for k := 1 to 24 do
     for j := 1 to 80 do
      begin
       Pic.Color[j,k] := 116;
       Pic.Char[j,k] := ' ';
       gotoxy(j,k);
       SetColor(Pic.Color[j,k]);
       write(Pic.Char[j,k]);
      end;
    FileName := '';
   end
  else
   EraseMenu2(16,3,45,8,9);
  if Key = 'Y' then InMenu := false;
 end;

procedure Open;
 var
  FileInfo    : SearchRec;
  TotFile,
  FileNum     : integer;
  TotPage,
  PageNum     : integer;
  TotPageFile,
  PageFileNum : integer;
  i, j, k     : integer;
  Name        : array[1..15] of string[12];
  Found       : boolean;
  Quit        : boolean;
  NewPage     : boolean;
 procedure LoadPage(Num : integer);
  var
   j, k : integer;
  begin
   findfirst('*.PIC', AnyFile, FileInfo);
   for k := 1 to (Num - 1) do
    for j := 1 to 15 do
     if (k<>1) or (j<>1) then
      findnext(FileInfo);
   TotPageFile := TotFile - ((Num - 1) * 15);
   if TotPageFile > 15 then TotPageFile := 15;
   if PageFileNum > TotPageFile then PageFileNum := TotPageFile;
   for k := 1 to TotPageFile do
    begin
     if (Num = 1) and (k = 1) then
      findfirst('*.PIC', AnyFile, FileInfo)
     else
      findnext(FileInfo);
     Name[k] := FileInfo.Name;
    end;
  end;
 begin
  Quit := false;
  if Changed then
   begin
    DrawMenu2(16,4,41,8);
    textcolor(yellow);
    gotoxy(18,5);
    write('File has been changed!');
    gotoxy(19,6);
    write('Open without saving?');
    gotoxy(26,7);
    write('(');
    textcolor(white);
    write('Y');
    textcolor(yellow);
    write('/');
    textcolor(white);
    write('N');
    textcolor(yellow);
    write(')');
    Cursor;
     repeat
      Key := readkey;
      Key := upcase(Key);
     until Key in ['Y','N'];
    EraseMenu2(16,4,41,8,9);
    Quit := Key = 'N';
   end;
  if not Quit then
   begin
    TotFile := 0;
    findfirst('*.PIC', AnyFile, FileInfo);
    Found := DosError = 0;
    if Found then
     TotFile := TotFile + 1;
     repeat
      findnext(FileInfo);
      if DosError = 0 then
       TotFile := TotFile + 1;
     until DosError <> 0;
    DrawMenu2(16,4,31,20);
    TotPage := trunc((TotFile-1) / 15) + 1;
    PageNum := 1;
    FileNum := 1;
    PageFileNum := 1;
     repeat
      if not Found then
       begin
        textcolor(white);
        gotoxy(20,5);
        write('<none>');
        Cursor;
        readkey;
        Key := #27;
       end
      else
       begin
        textcolor(lightgray);
        LoadPage(PageNum);
        for k := 1 to 15 do
         begin
          gotoxy(18,k+4);
          write('            ');
          if k <= TotPageFile then
           begin
            gotoxy(18,k+4);
            for j := 1 to length(Name[k]) do
             case Name[k][j] of
              '.' :
               for i := 1 to (10-j) do
                write(' ');
             else
              write(Name[k][j]);
             end; {case}
           end;
         end;
         repeat
          textcolor(white);
          gotoxy(18,PageFileNum+4);
          for j := 1 to length(Name[PageFileNum]) do
           case Name[PageFileNum][j] of
            '.' :
             for i := 1 to (10-j) do
              write(' ');
           else
            write(Name[PageFileNum][j]);
           end; {case}
          Cursor;
           repeat
            Key := readkey;
           until Key in ['H','P','I','Q',#13,#27];
          NewPage := false;
          if Key in ['H','P'] then
           begin
            textcolor(lightgray);
            gotoxy(18,PageFileNum+4);
            for j := 1 to length(Name[PageFileNum]) do
             case Name[PageFileNum][j] of
              '.' :
               for i := 1 to (10-j) do
                write(' ');
             else
              write(Name[PageFileNum][j]);
             end; {case}
            Cursor;
           end;
           case Key of
            'H' : PageFileNum := PageFileNum - 1;
            'P' : PageFileNum := PageFileNum + 1;
           end; {case}
          if PageFileNum < 1 then
           begin
            PageFileNum := 15;
            PageNum := PageNum - 1;
            if PageNum < 1 then
             begin
              PageNum := 1;
              PageFileNum := 1;
             end
            else
             begin
              NewPage := true;
             end;
           end;
          if (PageFileNum > TotPageFile) and not NewPage then
           begin
            PageFileNum := 1;
            PageNum := PageNum + 1;
            if PageNum > TotPage then
             begin
              PageNum := TotPage;
              PageFileNum := TotPageFile;
             end
            else
             begin
              NewPage := true;
             end;
           end;
         until (Key in ['I','Q',#13,#27]) or NewPage;
         case Key of
          'I' : PageNum := PageNum - 1;
          'Q' : PageNum := PageNum + 1;
         end; {case}
        if PageNum < 1 then PageNum := 1;
        if PageNum > TotPage then PageNum := TotPage;
       end;
     until Key in [#13, #27];
    if Key = #13 then
     begin
      Changed := false;
      FileName := Name[PageFileNum];
      assign(PicFile, FileName);
      reset(PicFile);
      read(PicFile, Pic);
      for k := 1 to 24 do
       for j := 1 to 80 do
        begin
         gotoxy(j,k);
         SetColor(Pic.Color[j,k]);
         write(Pic.Char[j,k]);
        end;
      Cursor;
      InMenu := false;
     end;
    if Key = #27 then
     EraseMenu2(16,4,31,20,9);
   end;
 end;

procedure ChangeDir;
 var
  DirC    : array[1..35] of char;
  DirS    : string[35];
  Key     : char;
  j       : integer;
  Found   : boolean;
  Tot     : integer;
  Quit    : boolean;
 begin
  DrawMenu2(16,7,54,10);
  gotoxy(18,8);
  write('New Directory : ');
  textbackground(black);
  gotoxy(18,9);
  write('                                   ');
  Quit := false;
  for j := 1 to 35 do
   DirC[j] := ' ';
  j := 1;
   repeat
    gotoxy(17+j,9);
     repeat
      Key := readkey;
      if Key = #0 then
        repeat
         Key := readkey;
        until not KeyPressed;
     until Key in [#33..#126, #8, #13, #27];
     case Key of
      #33..#126 :
       begin
        DirC[j] := upcase(Key);
        gotoxy(17+j,9);
        write(DirC[j]);
        j := j + 1;
        if j > 35 then j := 35;
       end;
      #8 :
       begin
        DirC[j] := ' ';
        gotoxy(17+j,9);
        write(DirC[j]);
        j := j - 1;
        if j < 1 then j := 1;
        DirC[j] := ' ';
        gotoxy(17+j,9);
        write(DirC[j]);
        gotoxy(j+17,9);
       end;
      #27 : Quit := true;
     end; {case}
   until Key in [#13, #27];
  if not Quit then
   begin
    Found := false;
    for j := 35 downto 1 do
     if not Found then
      if DirC[j] <> ' ' then
       begin
        Found := true;
        Tot := j;
       end;
    DirS := '';
    for j := 1 to Tot do
     DirS := concat(DirS, DirC[j]);
    textbackground(red);
    gotoxy(18,9);
    write('                                   ');
    gotoxy(18,9);
    write(DirS);
    {$I-}
    ChDir(DirS);
    if IOResult <> 0 then
     begin
      DrawMenu2(55,9,78,11);
      textcolor(yellow);
      gotoxy(57,10);
      write('Directory not found!');
      Cursor;
      readkey;
      EraseMenu2(55,9,78,11,10);
     end;
    {$I+}
   end;
  EraseMenu2(16,7,54,10,9);
 end;

procedure FileMenu;
 const
  ChoiceName : array[1..6] of string =
   ('New', 'Open', 'Save', 'Save As', 'Change Dir', 'Quit');
 var
  Key        : char;
  j, k       : integer;
 begin
  DrawMenu(1,2,15,9,4,'File');
  for k := 1 to 6 do
   begin
    textcolor(lightgray);
    gotoxy(3,k+2);
    write(ChoiceName[k]);
   end;
   repeat
    textbackground(red);
    textcolor(white);
    gotoxy(3, MenuChoice+2);
    write(ChoiceName[MenuChoice]);
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','P'] then
         begin
          textcolor(lightgray);
          gotoxy(3,MenuChoice+2);
          write(ChoiceName[MenuChoice]);
          Cursor;
         end;
         case Key of
          'H' : MenuChoice := MenuChoice - 1;
          'P' : MenuChoice := MenuChoice + 1;
          'K' : MenuNum := MenuNum - 1;
          'M' : MenuNum := MenuNum + 1;
         end; {case}
        if Key in ['K','M'] then MenuChoice := 1;
        if MenuChoice > 6 then MenuChoice := 1;
        if MenuChoice < 1 then MenuChoice := 6;
        if MenuNum > 5 then MenuNum := 1;
        if MenuNum < 1 then MenuNum := 5;
       end;
      #27 : InMenu := false;
      #13 :
       begin
         case MenuChoice of
          1 : NewPic;
          2 : Open;
          3 : Save;
          4 : SaveAs;
          5 : ChangeDir;
          6 :
           begin
            Quit := true;
            InMenu := false;
            if Quit and Changed then
             begin
              DrawMenu2(16,8,41,12);
              textcolor(yellow);
              gotoxy(18,9);
              write('File has been changed!');
              gotoxy(19,10);
              write('Quit without saving?');
              gotoxy(26,11);
              write('(');
              textcolor(white);
              write('Y');
              textcolor(yellow);
              write('/');
              textcolor(white);
              write('N');
              textcolor(yellow);
              write(')');
              Cursor;
               repeat
                Key := readkey;
                Key := upcase(Key);
               until Key in ['Y','N'];
              Quit := Key = 'Y';
              InMenu := not Quit;
              EraseMenu2(16,8,41,12,9);
             end;
           end;
         end; {case}
       end;
     end; {case}
   until (not InMenu) or (MenuNum <> 1);
  if (InMenu) or (Key <> #13) or (MenuChoice in [3,4]) then
   EraseMenu(1,2,15,9,4,'File');
 end;

procedure EditMenu;
 const
  ChoiceName : array[1..6] of string =
  ('Copy', 'Fill', 'Move', 'Change', 'Flip', 'Spill');
 var
  Key    : char;
  j, k   : integer;
 begin
  DrawMenu(11,2,20,9,13,'Edit');
  textcolor(lightgray);
  for k := 1 to 6 do
   begin
    gotoxy(13,k+2);
    write(ChoiceName[k]);
   end;
   repeat
    textbackground(red);
    textcolor(white);
    gotoxy(13,MenuChoice+2);
    write(ChoiceName[MenuChoice]);
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','P'] then
         begin
          textcolor(lightgray);
          gotoxy(13,MenuChoice+2);
          write(ChoiceName[MenuChoice]);
          Cursor;
         end;
         case Key of
          'H' : MenuChoice := MenuChoice - 1;
          'P' : MenuChoice := MenuChoice + 1;
          'K' : MenuNum := MenuNum - 1;
          'M' : MenuNum := MenuNum + 1;
         end; {case}
        if Key in ['K','M'] then MenuChoice := 1;
        if MenuChoice > 6 then MenuChoice := 1;
        if MenuChoice < 1 then MenuChoice := 6;
        if MenuNum > 6 then MenuNum := 1;
        if MenuNum < 1 then MenuNum := 6;
       end;
      #27 : InMenu := false;
      #13 :
       begin
         case MenuChoice of
          1 : CopySection;
          2 : FillSection;
          3 : MoveSection;
          4 : ChangeSection;
          5 : FlipSection;
          6 : SpillArea;
         end; {case}
       end;
     end; {case}
   until (not InMenu) or (MenuNum <> 2);
  if (InMenu) or (Key <> #13) then
   EraseMenu(11,2,20,9,13,'Edit');
 end;

procedure OptionsMenu;
 const
  ChoiceName : array[1..2] of string = ('Colors', 'Char Set');
 var
  Key    : char;
  j, k   : integer;
 begin
  DrawMenu(20,2,31,5,22,'Options');
  textcolor(lightgray);
  for k := 1 to 2 do
   begin
    gotoxy(22,k+2);
    write(ChoiceName[k]);
   end;
   repeat
    textbackground(red);
    textcolor(white);
    gotoxy(22,MenuChoice+2);
    write(ChoiceName[MenuChoice]);
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','P'] then
         begin
          textcolor(lightgray);
          gotoxy(22,MenuChoice+2);
          write(ChoiceName[MenuChoice]);
          Cursor;
         end;
         case Key of
          'H' : MenuChoice := MenuChoice - 1;
          'P' : MenuChoice := MenuChoice + 1;
          'K' : MenuNum := MenuNum - 1;
          'M' : MenuNum := MenuNum + 1;
         end; {case}
        if Key in ['K','M'] then MenuChoice := 1;
        if MenuChoice > 2 then MenuChoice := 1;
        if MenuChoice < 1 then MenuChoice := 2;
        if MenuNum > 5 then MenuNum := 1;
        if MenuNum < 1 then MenuNum := 5;
       end;
      #27 : InMenu := false;
      #13 :
       begin
         case MenuChoice of
          1 : GetColors;
          2 : GetCharSet;
         end; {case}
       end;
     end; {case}
   until (not InMenu) or (MenuNum <> 3);
  EraseMenu(20,2,31,5,22,'Options');
 end;

procedure PrgmMenu;
 const
  ChoiceName : array[1..1] of string = ('Window');
 var
  Key    : char;
  j, k   : integer;
 begin
  DrawMenu(64,2,75,4,66,'Prgm');
  textcolor(lightgray);
  for k := 1 to 1 do
   begin
    gotoxy(66,k+2);
    write(ChoiceName[k]);
   end;
   repeat
    textbackground(red);
    textcolor(white);
    gotoxy(66,MenuChoice+2);
    write(ChoiceName[MenuChoice]);
    Cursor;
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
        if Key in ['H','P'] then
         begin
          textcolor(lightgray);
          gotoxy(66,MenuChoice+2);
          write(ChoiceName[MenuChoice]);
          Cursor;
         end;
         case Key of
          'H' : MenuChoice := MenuChoice - 1;
          'P' : MenuChoice := MenuChoice + 1;
          'K' : MenuNum := MenuNum - 1;
          'M' : MenuNum := MenuNum + 1;
         end; {case}
        if Key in ['K','M'] then MenuChoice := 1;
        if MenuChoice > 1 then MenuChoice := 1;
        if MenuChoice < 1 then MenuChoice := 1;
        if MenuNum > 5 then MenuNum := 1;
        if MenuNum < 1 then MenuNum := 5;
       end;
      #27 : InMenu := false;
      #13 :
       begin
         case MenuChoice of
          1 : PrgmWindow;
         end; {case}
       end;
     end; {case}
   until (not InMenu) or (MenuNum <> 4);
  if (Key <> #13) then
   EraseMenu(64,2,75,4,66,'Prgm');
 end;

procedure InfoMenu;
 var
  Key  : char;
  j, k : integer;
 begin
  textcolor(lightred);
  textbackground(red);
  gotoxy(72,1);
  write(#176, #177, #178);
  gotoxy(79,1);
  write(#178, #177);
  textcolor(yellow);
  gotoxy(75,1);
  write('Info');
  Cursor;
   repeat
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'K' : MenuNum := MenuNum - 1;
          'M' : MenuNum := MenuNum + 1;
         end; {case}
        if Key in ['K','M'] then MenuChoice := 1;
        if MenuNum > 5 then MenuNum := 1;
        if MenuNum < 1 then MenuNum := 5;
       end;
      #27 : InMenu := false;
      #13 :
       begin
        DrawInfo;
        readkey;
        for k := 8 to 14 do
         for j := 23 to 61 do
          begin
           SetColor(Pic.Color[j,k]);
           gotoxy(j,k);
           write(Pic.Char[j,k]);
          end;
        Cursor;
        InMenu := false;
       end;
     end; {case}
   until (not InMenu) or (MenuNum <> 5);
  textcolor(white);
  gotoxy(72,1);
  write('   Info  ');
  Cursor;
 end;

procedure Menu;
 begin
  DrawBar;
  InMenu := true;
   repeat
     case MenuNum of
      1 : FileMenu;
      2 : EditMenu;
      3 : OptionsMenu;
      4 : PrgmMenu;
      5 : InfoMenu;
     end; {case}
   until not InMenu;
  EraseBar;
 end;

begin
 Title;
 Init;
 DrawScreen;
  repeat
   XY;
   Key := readkey;
    case Key of
     #0 :
      begin
       Key := readkey;
        case Key of
         'H' : y := y - 1;
         'K' : x := x - 1;
         'P' : y := y + 1;
         'M' : x := x + 1;
         'G' : x := 1;
         'O' : x := 80;
         'I' : y := 1;
         'Q' : y := 24;
         ';'..'D' : PutChar(CSet[ord(Key)-58]);
        end; {case}
       if x > 80 then x := 1;
       if x < 1 then x := 80;
       if y > 24 then y := 1;
       if y < 1 then y := 24;
      end;
     #27 :
      begin
       Menu;
      end;
     #32..#126 : PutChar(Key);
     #8 :
      begin
       Pic.Char[x,y] := ' ';
       Pic.Color[x,y] := 116;
       gotoxy(x,y);
       SetColor(Pic.Color[x,y]);
       write(Pic.Char[x,y]);
       x := x - 1;
       if x < 1 then
        begin
         x := 80;
         y := y - 1;
         if y < 1 then
          begin
           x := 1;
           y := 1;
          end;
        end;
       Pic.Char[x,y] := ' ';
       Pic.Color[x,y] := 116;
       gotoxy(x,y);
       SetColor(Pic.Color[x,y]);
       write(Pic.Char[x,y]);
       XY;
       if not Changed then Changed := true;
      end;
     #9 :
      begin
       x := x + 5;
       if x > 80 then
        begin
         x := 1;
         y := y + 1;
         if y > 24 then
          begin
           x := 80;
           y := 24;
          end;
        end;
       XY;
      end;
     #13 :
      begin
       x := 1;
       y := y + 1;
       if y > 24 then y := 1;
      end;
    end; {case}
  until Quit;
 if Changed or (Filename <> '') then
  FadeOut
 else
  begin
   textcolor(white);
   textbackground(black);
   clrscr;
  end;
end.