program ObjectDrawer_1_0;

uses
 Crt;

type
 ObjType = record
   Name   : string[15];
   X, Y   : integer;
   Char   : array[1..10, 1..5] of char;
   Color  : array[1..10, 1..5] of integer;
   BColor : array[1..10, 1..5] of integer;
   Solid  : array[1..10, 1..5] of boolean;
  end;

var
 Obj      : ObjType;
 JunkObj  : ObjType;
 ObjFile  : file of ObjType;
 SwapFile : file of ObjType;
 x, y     : integer;
 DrawMode : boolean;
 Quit     : boolean;
 Key      : char;
 Color,
 BColor   : integer;
 Cha      : char;
 SetNum   : integer;
 CPoint   : integer;
 TotObj   : integer;
 ObjNum   : integer;
 j, k     : integer;
 Copy     : integer;

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

procedure ResetObj;
 var
  x, y : integer;
 begin
  Obj.Name := '';
  Obj.x := 10;
  Obj.y := 5;
  for y := 1 to 5 do
   for x := 1 to 10 do
    begin
     Obj.Char[x,y] := ' ';
     Obj.Color[x,y] := 15;
     Obj.BColor[x,y] := 0;
     Obj.Solid[x,y] := false;
    end;
 end;

procedure DrawWindow(x1, y1, x2, y2, BackColor : integer; Name : string);
 const
  DelayTime = 20;
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
  j, k : integer;
  ya, yb : integer;
  xa, xb : real;
  Times : integer;
  XInc : real;
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

procedure DrawShadow(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  textcolor(darkgray);
  textbackground(blue);
  for j := x1+2 to x2 do
   begin
    gotoxy(j, y2+1);
    write(#177);
   end;
  for k := y2+1 downto y1+1 do
   begin
    gotoxy(x2+1, k);
    write(#177, #177);
   end;
 end;

procedure FadeOut;
 const
  XInc = (80 / 24);
 var
  i, j, k : integer;
  xa, xb : real;
  ya, yb : integer;
 begin
  ya := 1;
  yb := 24;
  xa := 1;
  xb := 80;
  textcolor(black);
  for i := 1 to 12 do
   begin
    for j := 1 to 80 do
     begin
      gotoxy(j,ya);
      write(#219);
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

procedure AdjustXY;
 var
  j, k : integer;
  x, y : integer;
  Found : boolean;
 begin
  x := 10;
  y := 5;
  Found := false;
  for k := 5 downto 1 do
   begin
    for j := 1 to 10 do
     if (Obj.Char[j,k] <> ' ') or (Obj.Color[j,k] <> 15) or
        (Obj.BColor[j,k] <> 0) then Found := true;
    if not Found then y := y - 1;
   end;
  Found := false;
  for j := 10 downto 1 do
   begin
    for k := 1 to 5 do
     if (Obj.Char[j,k] <> ' ') or (Obj.Color[j,k] <> 15) or
        (Obj.BColor[j,k] <> 0) then Found := true;
    if not Found then x := x - 1;
   end;
  Obj.x := x;
  Obj.y := y;
  textcolor(white);
  textbackground(green);
  gotoxy(33,10);
  write(Obj.x:2);
  gotoxy(38,10);
  write(Obj.y);
 end;

procedure Init;
 var
  j : integer;
 begin
  ResetObj;
  Quit := false;
  DrawMode := true;
  x := 1;
  y := 1;
  Color := 15;
  BColor := 0;
  Cha := #219;
  SetNum := 6;
  CPoint := 4;
  TotObj := 0;
  assign(ObjFile, 'MAKEOBJ.DAT');
  assign(SwapFile, 'OBJSWAP.DAT');
  reset(ObjFile);
   repeat
    read(ObjFile, Obj);
    TotObj := TotObj + 1;
   until Eof(ObjFile);
  reset(ObjFile);
  read(ObjFile, Obj);
  ObjNum := 1;
  AdjustXY;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  Clear;
  DrawWindow(25,8,57,14,4,'Info');
  textcolor(yellow);
  gotoxy(31,9);
  write('Object Drawer  v1.0');
  gotoxy(28,10);
  write('(c) 1996 Hyland Productions');
  textcolor(lightgray);
  gotoxy(27,12);
  write('This program intended for use');
  gotoxy(27,13);
  write('with Map Editer 1.0.');
  Cursor;
  delay(750);
  Clear;
  DrawWindow(2,2,79,24,1,'Object Drawer  v1.0');
  textcolor(white);
  textbackground(black);
  for k := 5 to 9 do
   for j := 8 to 17 do
    begin
     gotoxy(j,k);
     write(' ');
     gotoxy(j,k+10);
     write(' ');
    end;
  textcolor(white);
  textbackground(lightgray);
  for k := 4 to 10 do
   begin
    gotoxy(6,k);
    write(#219);
    gotoxy(6,k+10);
    write(#219);
    gotoxy(19,k);
    write(#219);
    gotoxy(19,k+10);
    write(#219);
   end;
  for j := 7 to 18 do
   begin
    gotoxy(j,4);
    write(#223);
    gotoxy(j,14);
    write(#223);
    gotoxy(j,10);
    write(#220);
    gotoxy(j,20);
    write(#220);
   end;
  for k := 5 to 9 do
   begin
    gotoxy(7,k);
    write(' ');
    gotoxy(7,k+10);
    write(' ');
    gotoxy(18,k);
    write(' ');
    gotoxy(18,k+10);
    write(' ');
   end;
  Cursor;
  textcolor(yellow);
  textbackground(blue);
  gotoxy(6,11);
  write('Graphic Sector');
  gotoxy(7,21);
  write('Solid Sector');
  DrawWindow(48,4,74,17,4,'Main Menu');
  textcolor(yellow);
  textbackground(red);
  gotoxy(50,5);
  write('+ Next Object');
  gotoxy(50,6);
  write('- Last Object');
  gotoxy(50,8);
  write('N New Object');
  gotoxy(50,9);
  write('D Delete Object');
  gotoxy(50,10);
  write('O Copy Object');
  gotoxy(50,12);
  write('C Color Change');
  gotoxy(50,13);
  write('S Symbol Change (ASCII)');
  gotoxy(50,15);
  write('Tab Graphic/Solid Sec.');
  gotoxy(50,16);
  write('Q Quit');
  DrawShadow(48,4,74,17);
  DrawWindow(24,7,42,12,2,'Object');
  gotoxy(26,8);
  write(Obj.Name);
  gotoxy(26,9);
  write('No. ', ObjNum:3, ' of ', TotObj, '  ');
  gotoxy(26,10);
  write('Size : ', Obj.x:2, ' x ', Obj.y:1);
  gotoxy(26,11);
  write('Loc. : ', x:2, ', ', y:1);
  DrawShadow(24,7,42,12);
  DrawWindow(24,15,37,20,5,'Symbol');
  gotoxy(26,17);
  write('Char : ');
  textbackground(black);
  write(' ', Cha, ' ');
  textbackground(magenta);
  gotoxy(26, 18);
  write('Cha #: ', ord(Cha));
  DrawShadow(24,15,37,20);
  DrawWindow(39,19,76,22,0,'Colors');
  gotoxy(43,20);
  for j := 0 to 15 do
   begin
    textcolor(j);
    write(#219, #219);
   end;
  gotoxy(43,21);
  for j := 0 to 7 do
   begin
    textcolor(j);
    write(#219, #219);
   end;
  textcolor(white);
  textbackground(black);
  gotoxy(73,20);
  write(#222, #221);
  textcolor(darkgray);
  gotoxy(43,21);
  write(#222, #221);
  DrawShadow(41,19,76,22);
  for k := 1 to 5 do
   for j := 1 to 10 do
    begin
     textcolor(Obj.Color[j,k]);
     textbackground(Obj.BColor[j,k]);
     gotoxy(j+7, k+4);
     write(Obj.Char[j,k]);
     textcolor(white);
     textbackground(black);
     gotoxy(j+7, k+14);
     if Obj.Solid[j,k] then write(#219) else write(' ');
    end;
  gotoxy(8,5);
 end;

function PickChar : char;
 type
  SetType = array[1..10] of char;
  SetFileType = file of SetType;
 var
  j, k : integer;
  Key : char;
  TotSets : integer;
  SetFile : SetFileType;
  CSet : SetType;
 begin
  assign(SetFile, 'CHARSET.DAT');
  reset(SetFile);
  TotSets := 0;
   repeat
    read(SetFile, CSet);
    TotSets := TotSets + 1;
   until Eof(SetFile);
  reset(SetFile);
  for j := 1 to SetNum do
   read(SetFile, CSet);
  textcolor(white);
  textbackground(black);
  gotoxy(34,17);
  write(CSet[1]);
  textcolor(white);
  textbackground(magenta);
  gotoxy(26,16);
  write('Set #', SetNum);
  gotoxy(26,18);
  write(CSet);
  gotoxy(CPoint+25, 19);
  write(#24);
  Cursor;
   repeat
     repeat
      Key := readkey;
     until Key in ['H', 'K', 'P', 'M', #13];
    if Key in ['H', 'P'] then
     begin
       case Key of
        'H' : SetNum := SetNum - 1;
        'P' : SetNum := SetNum + 1;
       end; {case}
      if SetNum < 1 then SetNum := TotSets;
      if SetNum > TotSets then SetNum := 1;
      gotoxy(31,16);
      write(SetNum, '  ');
      reset(SetFile);
      for j := 1 to SetNum do
       read(SetFile, CSet);
      textcolor(white);
      textbackground(black);
      gotoxy(34,17);
      write(CSet[CPoint]);
      textcolor(white);
      textbackground(magenta);
      gotoxy(26,18);
      write(CSet);
      Cursor;
     end;
    if Key in ['K', 'M'] then
     begin
      gotoxy(CPoint+25, 19);
      write(' ');
       case Key of
        'K' : CPoint := CPoint - 1;
        'M' : CPoint := CPoint + 1;
       end; {case}
      if CPoint > 10 then CPoint := 1;
      if CPoint < 1 then CPoint := 10;
      textbackground(black);
      gotoxy(34,17);
      write(CSet[CPoint]);
      textbackground(magenta);
      gotoxy(CPoint+25, 19);
      write(#24);
      Cursor;
     end;
   until Key = #13;
  PickChar := CSet[CPoint];
  textcolor(white);
  gotoxy(26,16);
  write('       ');
  gotoxy(26,18);
  write('Cha #: ', ord(CSet[CPoint]):3);
  gotoxy(CPoint+25, 19);
  write(' ');
  Cursor;
 end;

procedure PickColors;
 var
  OldColor : integer;
  Key : char;
  Fg : boolean;
 begin
  textcolor(yellow);
  textbackground(black);
  gotoxy(41,20);
  write('->');
  Cursor;
  Fg := true;
   repeat
     repeat
      Key := readkey;
     until Key in [#13, 'H', 'K', 'P', 'M'];
    if Fg then OldColor := Color else OldColor := BColor;
    if Fg then
     begin
       case Key of
        'K' : Color := Color - 1;
        'M' : Color := Color + 1;
        'H', 'P' :
         begin
          Fg := false;
          textcolor(yellow);
          gotoxy(41,20);
          write('  ');
          gotoxy(41,21);
          write('->');
          Cursor;
         end;
       end; {case}
      if Color > 15 then Color := 0;
      if Color < 0 then Color := 15;
      textcolor(OldColor);
      gotoxy(OldColor * 2 + 43, 20);
      write(#219, #219);
      if Color <> 0 then textcolor(Color) else textcolor(darkgray);
      gotoxy(Color * 2 + 43, 20);
      write(#222, #221);
      Cursor;
     end
    else
     begin
       case Key of
        'K' : BColor := BColor - 1;
        'M' : BColor := BColor + 1;
        'H', 'P' :
         begin
          Fg := true;
          textcolor(yellow);
          gotoxy(41,20);
          write('->');
          gotoxy(41,21);
          write('  ');
          Cursor;
         end;
       end; {case}
      if BColor > 7 then BColor := 0;
      if BColor < 0 then BColor := 7;
      textcolor(OldColor);
      gotoxy(OldColor * 2 + 43, 21);
      write(#219, #219);
      if BColor <> 0 then textcolor(BColor) else textcolor(darkgray);
      gotoxy(BColor * 2 + 43, 21);
      write(#222, #221);
      Cursor;
     end;
   until Key = #13;
  if Fg then gotoxy(41,20) else gotoxy(41,21);
  write('  ');
  gotoxy(x+7, y+4);
 end;

function GetName : string;
 var
  Name : string[15];
  x    : integer;
  Key  : char;
 begin
  for x := 1 to 15 do
   Name[x] := ' ';
  textcolor(white);
  textbackground(black);
  gotoxy(26,8);
  write('               ');
  x := 1;
   repeat
    gotoxy(x+25, 8);
     repeat
      Key := readkey;
      if Key = #0 then
       begin
        Key := readkey;
        Key := #0;
       end;
     until Key in [#13, #8, #32..#126];
     case Key of
      #13 : ;
      #8 :
      if x > 1 then
       begin
        x := x - 1;
        Name[x] := ' ';
        gotoxy(25+x, 8);
        write(Name[x]);
       end;
     else
      begin
       Name[x] := Key;
       write(Name[x]);
       x := x + 1;
       if x > 15 then x := 1;
      end;
     end; {case}
   until (Key = #13);
  textbackground(green);
  gotoxy(26,8);
  for x := 1 to 15 do
   write(Name[x]);
  GetName := Name;
 end;

procedure MakeGrayBox;
 var
  j, k : integer;
 begin
  textcolor(darkgray);
  textbackground(red);
  for j := 48 to 70 do
   begin
    gotoxy(j,12);
    write(#177);
   end;
  for k := 9 to 12 do
   begin
    gotoxy(71,k);
    write(#177, #177);
   end;
  DrawWindow(46,8,70,11,7,'Message');
 end;

procedure EraseGrayBox;
 var
  j, k : integer;
 begin
  textbackground(blue);
  for k := 8 to 11 do
   begin
    gotoxy(46,k);
    write('  ');
   end;
  textbackground(red);
  for k := 8 to 12 do
   for j := 48 to 72 do
    begin
     gotoxy(j,k);
     if j = 48 then write(#179) else write(' ');
    end;
  textcolor(yellow);
  gotoxy(50,8);
  write('N New Object');
  gotoxy(50,9);
  write('D Delete Object');
  gotoxy(50,10);
  write('O Copy Object');
  gotoxy(50,12);
  write('C Color Change');
  Cursor;
 end;


function GetCopy : integer;
 var
  j, k : integer;
  x : integer;
  Key  : char;
 begin
  MakeGrayBox;
  gotoxy(49,9);
  write('Copying will erase');
  gotoxy(49,10);
  write('current object!');
  Cursor;
  readkey;
  gotoxy(48,9);
  write('Copy which object? ');
  gotoxy(48,10);
  write('<- | -> : ');
  write('      ');
  textbackground(black);
  x := 1;
   repeat
    gotoxy(58,10);
    write('    ');
    gotoxy(59,10);
    write(x);
    Cursor;
     repeat
      Key := readkey;
     until Key in [#13, 'K', 'M'];
     case Key of
      'K' : x := x - 1;
      'M' : x := x + 1;
     end; {case}
    if x > TotObj then x := 1;
    if x < 1 then x := TotObj;
   until Key = #13;
  EraseGrayBox;
  GetCopy := x;
 end;

procedure SaveObj;
 var
  TObj : ObjType;
  x : integer;
 begin
  reset(ObjFile);
  for x := 1 to ObjNum - 1 do
   read(ObjFile, TObj);
  write(ObjFile, Obj);
 end;

begin
 Init;
 DrawScreen;
  repeat
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in [#72, #80, #77, #75, #9, 'Q', 'S', 'C', #32, #13, '+', '-',
                  'N', 'D', 'O'];
   if Key in ['+', '-'] then
    begin
     reset(ObjFile);
     for j := 1 to ObjNum - 1 do
      read(ObjFile, JunkObj);
     write(ObjFile, Obj);
    end;
    case Key of
     'Q' : Quit := true;
     #72 : y := y - 1;
     #80 : y := y + 1;
     #77 : x := x + 1;
     #75 : x := x - 1;
     '+' : ObjNum := ObjNum + 1;
     '-' : ObjNum := ObjNum - 1;
     #9  : if DrawMode then DrawMode := false else DrawMode := true;
     'S' : Cha := PickChar;
     'C' : PickColors;
     #32 :
      begin
       if DrawMode then
        begin
         Obj.Char[x,y] := ' ';
         Obj.Color[x,y] := 15;
         Obj.BColor[x,y] := 0;
         textcolor(white);
         textbackground(black);
         gotoxy(x+7, y+4);
         write(' ');
         gotoxy(x+7, y+4);
        end;
      end;
     #13 :
      begin
       AdjustXY;
       if DrawMode then
        begin
         Obj.Char[x,y] := Cha;
         Obj.Color[x,y] := Color;
         Obj.BColor[x,y] := BColor;
         gotoxy(x+7, y+4);
         textcolor(Color);
         textbackground(BColor);
         write(Cha);
         gotoxy(x+7, y+4);
        end
       else
        begin
         if not Obj.Solid[x,y] then Obj.Solid[x,y] := true
          else Obj.Solid[x,y] := false;
         gotoxy(x+7, y+14);
         textcolor(white);
         textbackground(black);
         if Obj.Solid[x,y] then write(#219) else write(' ');
         gotoxy(x+7, y+14);
        end;
      end;
     'N' :
      begin
       SaveObj;
       reset(ObjFile);
       for j := 1 to TotObj do
        read(ObjFile, Obj);
       TotObj := TotObj + 1;
       textcolor(white);
       textbackground(green);
       gotoxy(37,9);
       write(TotObj, '  ');
       ObjNum := TotObj;
       gotoxy(30,9);
       write(ObjNum:3);
       ResetObj;
       gotoxy(33,10);
       write(Obj.x:2);
       gotoxy(38,10);
       write(Obj.y);
       gotoxy(33,11);
       write(x:2);
       gotoxy(37,11);
       write(y);
       textcolor(white);
       textbackground(black);
       for k := 1 to 5 do
        for j := 1 to 10 do
         begin
          gotoxy(j+7, k+4);
          write(' ');
          gotoxy(j+7, k+14);
          write(' ');
         end;
       MakeGrayBox;
       gotoxy(48,9);
       write('New object created.');
       gotoxy(48,10);
       write('Type object name.');
       Obj.Name := GetName;
       EraseGrayBox;
       x := 1;
       y := 1;
       gotoxy(x+7, y+4);
       SaveObj;
      end;
     'D' :
      begin
       if TotObj <= 1 then
        begin
         MakeGrayBox;
         gotoxy(48,9);
         write('Can''t delete last');
         gotoxy(48,10);
         write('object.');
         Cursor;
         readkey;
         EraseGrayBox;
        end
       else
        begin
         MakeGrayBox;
         gotoxy(48,9);
         write('Delete object? (Y/N)');
         Cursor;
          repeat
           Key := readkey;
           Key := upcase(Key);
          until Key in ['Y', 'N'];
         EraseGrayBox;
         if Key = 'Y' then
          begin
           reset(ObjFile);
           rewrite(SwapFile);
           for j := 1 to TotObj do
            begin
             read(ObjFile, JunkObj);
             if j <> ObjNum then
              begin
               write(SwapFile, JunkObj);
              end;
            end;
           reset(SwapFile);
           rewrite(ObjFile);
           if ObjNum = TotObj then
            ObjNum := ObjNum - 1;
           TotObj := TotObj - 1;
           for j := 1 to TotObj do
            begin
             read(SwapFile, JunkObj);
             write(ObjFile, JunkObj);
            end;
           rewrite(SwapFile);
           close(SwapFile);
           reset(ObjFile);
           for j := 1 to ObjNum do
            read(ObjFile, Obj);
           textcolor(white);
           textbackground(green);
           gotoxy(30,9);
           write(ObjNum:3);
           gotoxy(37,9);
           write(TotObj, '  ');
           gotoxy(26,8);
           write('               ');
           gotoxy(26,8);
           write(Obj.Name);
           gotoxy(33,10);
           write(Obj.x:2);
           gotoxy(38,10);
           write(Obj.y);
           for k := 1 to 5 do
            for j := 1 to 10 do
             begin
              textcolor(Obj.Color[j,k]);
              textbackground(Obj.BColor[j,k]);
              gotoxy(j+7, k+4);
              write(Obj.Char[j,k]);
              textcolor(white);
              textbackground(black);
              gotoxy(j+7, k+14);
              if Obj.Solid[j,k] then write(#219) else write(' ');
             end;
           gotoxy(x+7, y+4);
          end;
        end;
      end;
     'O' :
      begin
       Copy := GetCopy;
       reset(ObjFile);
       for j := 1 to Copy do
        read(ObjFile, JunkObj);
       reset(ObjFile);
       for j := 1 to ObjNum do
        read(ObjFile, Obj);
       Obj.Char := JunkObj.Char;
       Obj.x := JunkObj.x;
       Obj.y := JunkObj.y;
       Obj.Color := JunkObj.Color;
       Obj.BColor := JunkObj.BColor;
       Obj.Solid := JunkObj.Solid;
       textcolor(white);
       textbackground(green);
       gotoxy(26,8);
       write(Obj.Name);
       gotoxy(33,10);
       write(Obj.x:2);
       gotoxy(38,10);
       write(Obj.y);
       for k := 1 to 5 do
        for j := 1 to 10 do
         begin
          textcolor(Obj.Color[j,k]);
          textbackground(Obj.BColor[j,k]);
          gotoxy(j+7, k+4);
          write(Obj.Char[j,k]);
          textcolor(white);
          textbackground(black);
          gotoxy(j+7, k+14);
          if Obj.Solid[j,k] then write(#219) else write(' ');
         end;
      end;
    end; {case}
   if Key in ['+', '-'] then
    begin
     AdjustXY;
     if ObjNum > TotObj then ObjNum := 1;
     if ObjNum < 1 then ObjNum := TotObj;
     if (Key = '+') and (ObjNum <> 1) then
      read(ObjFile, Obj)
     else
      begin
       reset(ObjFile);
       for j := 1 to ObjNum do
        read(ObjFile, Obj);
      end;
     textcolor(white);
     textbackground(green);
     gotoxy(26,8);
     write('               ');
     gotoxy(26,8);
     write(Obj.Name);
     gotoxy(30,9);
     write(ObjNum:3);
     gotoxy(37,9);
     write(TotObj, '  ');
     gotoxy(33,10);
     write(Obj.x:2);
     gotoxy(38,10);
     write(Obj.y);
     for k := 1 to 5 do
      for j := 1 to 10 do
       begin
        textcolor(Obj.Color[j,k]);
        textbackground(Obj.BColor[j,k]);
        gotoxy(j+7, k+4);
        write(Obj.Char[j,k]);
        textcolor(white);
        textbackground(black);
        gotoxy(j+7, k+14);
        if Obj.Solid[j,k] then write(#219) else write(' ');
       end;
     gotoxy(x+7, y+4);
    end;
   if Key in [#13, #32] then
    begin
     x := x + 1;
     if x > 10 then
      begin
       x := 1;
       y := y + 1;
       if y > 5 then
        begin
         x := 1;
         y := 1;
        end;
      end;
    end;
   if Key in [#59, #60] then {DrawMap};
   if x > 10 then x := 1;
   if x < 1 then x := 10;
   if y > 5 then y := 1;
   if y < 1 then y := 5;
   textcolor(white);
   textbackground(green);
   gotoxy(33,11);
   write(x:2);
   gotoxy(37,11);
   write(y:1);
   if DrawMode then gotoxy(x+7, y+4) else gotoxy(x+7, y+14);
  until Quit;
 AdjustXY;
 reset(ObjFile);
 for j := 1 to ObjNum - 1 do
  read(ObjFile, JunkObj);
 write(ObjFile, Obj);
 close(ObjFile);
 DrawWindow(30,10,52,15,3,'Quit');
 gotoxy(33,11);
 write('You are about to');
 gotoxy(33,12);
 write('exit Object Draw.');
 gotoxy(32,14);
 write('All changes saved.');
 textcolor(darkgray);
 textbackground(magenta);
 gotoxy(32,16);
 write(#177, #177, #177, #177, #177, #177);
 textbackground(blue);
 write(#177, #177, #177, #177, #177, #177, #177, #177, #177, #177);
 textbackground(red);
 write(#177, #177, #177, #177, #177, #177, #177);
 for k := 11 to 15 do
  begin
   gotoxy(53,k);
   write(#177, #177);
  end;
 Cursor;
 delay(1000);
 FadeOut;
end.









