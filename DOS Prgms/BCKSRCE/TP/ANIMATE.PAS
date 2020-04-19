program Animate;

uses
 Crt, Dos;

type
 FrameRecord = record
   Ch : array[1..25,1..10] of char;
   Color : array[1..25,1..10] of integer;
   Back : array[1..25, 1..10] of integer;
 end;
 AnimateRecord = record
   FrameNum : integer;
   FrameDelay : integer;
   FrameRec : FrameRecord;
 end;
 AnimateFile = file of AnimateRecord;

var
 Frame : FrameRecord;
 AFile : AnimateFile;
 j, k : integer;
 Num, TotNum : integer;
 Draw : boolean;
 Menu, OldMenu : integer;
 Done : boolean;
 Key : char;

procedure Init;
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  Num := 1;
  TotNum := 1;
  for k := 1 to 10 do
   for j := 1 to 25 do
    begin
     Frame.Ch[j,k] := ' ';
     Frame.Color[j,k] := 15;
     Frame.Back[j,k] := 0;
    end;
  Draw := false;
  Done := false;
  Menu := 1;
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure DrawWindow(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  gotoxy(x1, y1);
  write(chr(218));
  gotoxy(x2, y1);
  write(chr(191));
  gotoxy(x1, y2);
  write(chr(192));
  gotoxy(x2, y2);
  write(chr(217));
  for j := x1+1 to x2-1 do
   begin
    gotoxy(j, y1);
    write(chr(196));
    gotoxy(j, y2);
    write(chr(196));
   end;
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1, k);
    write(chr(179));
    gotoxy(x2, k);
    write(chr(179));
   end;
  Cursor;
 end;

procedure DrawShadow(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  textcolor(black);
  textbackground(blue);
  for j := x1+2 to x2+2 do
   begin
    gotoxy(j, y2+1);
    write(chr(177));
   end;
  for k := y1+1 to y2 do
   begin
    gotoxy(x2+1, k);
    write(chr(177), chr(177));
   end;
  Cursor;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(blue);
  DrawWindow(2,2,78,24);
  gotoxy(34,2);
  write(chr(180), ' Animate ', chr(195));
  textcolor(white);
  textbackground(lightgray);
  gotoxy(6, 4);
  write(' ');
  gotoxy(34, 4);
  write(' ');
  gotoxy(6, 15);
  write(' ');
  gotoxy(34, 15);
  write(' ');
  for j := 7 to 33 do
   begin
    gotoxy(j, 4);
    write(chr(220));
    gotoxy(j, 15);
    write(chr(223));
   end;
  for k := 5 to 14 do
   begin
    gotoxy(6, k);
    write(' ', chr(219));
    gotoxy(33, k);
    write(chr(219), ' ');
   end;
  textcolor(white);
  textbackground(black);
  for k := 5 to 14 do
   for j := 8 to 32 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(white);
  textbackground(red);
  DrawWindow(9,18,28,21);
  textcolor(white);
  DrawWindow(46,3,68,17);
  gotoxy(51,3);
  write(chr(180), ' Main Menu ', chr(195));
  textcolor(yellow);
  textbackground(green);
  DrawWindow(43,19,71,22);
  DrawShadow(9,18,28,21);
  DrawShadow(46,3,68,17);
  DrawShadow(43,19,71,22);
  textcolor(yellow);
  textbackground(red);
  gotoxy(15,19);
  write('(00,00)');
  gotoxy(11,20);
  write('Frame = ', Num:2, ' of ', TotNum:2);
  gotoxy(48,4);
  write(chr(254));
  gotoxy(50,4);
  write('L Load Animation');
  gotoxy(50,5);
  write('S Save Animation');
  gotoxy(50,6);
  write('R Run Animation');
  gotoxy(50,8);
  write('A Add Frame');
  gotoxy(50,9);
  write('D Delete Frame');
  gotoxy(50,10);
  write('I Insert Frame');
  gotoxy(50,11);
  write('P Paste Frame');
  gotoxy(50,12);
  write('T Time Delay');
  gotoxy(50,14);
  write('C Colors (F/B)');
  gotoxy(50,16);
  write('Q Quit');
  textcolor(white);
  textbackground(green);
  gotoxy(45,20);
  write(#176, '  ',#177, '  ',#178, '  ',#219, '  ',#223, '  ',#220, '  ');
  write(#221, '  ',#222, '  ',#254);
  gotoxy(45,21);
  write('F1 F2 F3 F4 F5 F6 F7 F8 F9');
  Cursor;
 end;

begin
 Init;
 DrawScreen;
  repeat
   Key := readkey;
   Key := upcase(Key);
   if not Draw then
    begin
     OldMenu := Menu;
      case Key of
       'L' : Menu := 1;
       'S' : Menu := 2;
       'R' : Menu := 3;
       'A' : Menu := 4;
       'D' : Menu := 5;
       'I' : Menu := 6;
       'P' : Menu := 7;
       'T' : Menu := 8;
       'C' : Menu := 9;
       'Q' : Menu := 10;
       #0  :
        begin
         Key := readkey;
          case Key of
           'H', 'K' : Menu := Menu - 1;
           'P', 'M' : Menu := Menu + 1;
          end; {case}
         if Menu < 1 then Menu := 10;
         if Menu > 10 then Menu := 1;
        end;
      end; {case}
     textcolor(yellow);
     textbackground(red);
     if OldMenu <= 3 then gotoxy(48, OldMenu+3)
     else if OldMenu <= 8 then gotoxy(48, OldMenu+4)
     else if OldMenu = 9 then gotoxy(48, OldMenu+5)
     else gotoxy(48, OldMenu+6);
     write(' ');
     if Menu <= 3 then gotoxy(48, Menu+3)
     else if Menu <= 8 then gotoxy(48, Menu+4)
     else if Menu = 9 then gotoxy(48, Menu+5)
     else gotoxy(48, Menu+6);
     write(chr(254));
     Cursor;
    end;



  until Done;
 readkey;
end.


