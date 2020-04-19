program DrawProgram;

uses
 Crt, Dos;

type
 ScreenType = array[1..80, 1..24] of char;
 ScreenFile = file of ScreenType;
 ChoiceType = (DRAW, LOAD, QUIT, NOTHING);

var
 Pic : ScreenType;
 x, y : integer;
 j, k : integer;
 Key : char;
 Ch : char;
 GoodKey : boolean;
 PicFile : ScreenFile;
 BoxX1, BoxY1, BoxX2, BoxY2 : integer;
 Choice : ChoiceType;

procedure DispXY;
 begin
  gotoxy(6,25);
  write('  ');
  gotoxy(14,25);
  write('  ');
  gotoxy(6,25);
  write(x);
  gotoxy(14,25);
  write(y);
 end;

procedure Cursor;
 begin
  gotoxy(79,25);
 end;

procedure Init;
 var
  j, k : integer;
 begin
  for k := 1 to 24 do
   for j := 1 to 80 do
    Pic[j,k] :=  ' ';
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(79,25);
  write(chr(219));
  textcolor(white);
  x := 1;
  y := 1;
  gotoxy(2,25);
  write('x =     y =       F1:', #176, '   F2:', #177, '   F3:',
  #178, '   F4:', #219, '   F5:', #223, '   F6:', #220,
  '   F7:', #221, '   F8:', #222);
  Choice := draw;
 end;

procedure DrawBox(x1, y1, x2, y2 : integer; Name : string);
 var
  x, y : integer;
 begin
  BoxX1 := x1;
  BoxY1 := y1;
  BoxX2 := x2;
  BoxY2 := y2;
  for x := x1+1 to x2-1 do
   begin
    gotoxy(x, y1);
    write(chr(223));
    gotoxy(x, y2);
    write(chr(220));
   end;
  for y := y1 to y2 do
   begin
    gotoxy(x1, y);
    write(chr(219));
    gotoxy(x2, y);
    write(chr(219));
   end;
  gotoxy(x1+2, y1);
  write(' ', Name, ' ');
  for y := y1+1 to y2-1 do
   for x := x1+1 to x2-1 do
    begin
     gotoxy(x,y);
     write(' ');
    end;
 end;

procedure EraseBox;
 var
  j, k : integer;
 begin
  for k := BoxY1 to BoxY2 do
   for j := BoxX1 to BoxX2 do
    begin
     gotoxy(j,k);
     write(Pic[j,k]);
    end;
  gotoxy(x,y);
 end;

procedure GetChoice;
 var
  Key : char;
 begin
  DrawBox(30,7,50,13,'Input');
  gotoxy(33,8);
  write('1] Draw Picture');
  gotoxy(33,10);
  write('2] Load Picture');
  gotoxy(33,12);
  write('3] Quit');
  Cursor;
   repeat
    Key := readkey;
   until Key in ['1'..'3'];
  EraseBox;
  if Key = '1' then Choice := DRAW;
  if Key = '2' then Choice := LOAD;
  if Key = '3' then Choice := QUIT;
 end;

function WantSave : boolean;
 var
  Key : char;
  x, y : integer;
 begin
  DrawBox(25, 8, 55, 12, 'Input');
  gotoxy(28, 10);
  write('Save this picture? (Y/N)');
  Cursor;
   repeat
    Key := readkey;
    Key := upcase(Key);
   until (Key = 'Y') or (Key = 'N');
  WantSave := Key = 'Y';
  EraseBox;
 end;

procedure SavePic;
 var
  FileName : string;
 begin
  DrawBox(22, 8, 58, 12, 'Input');
  gotoxy(25, 10);
  write('Enter file name: ');
  read(FileName);
  if FileName <> '' then
   begin
    assign(PicFile, FileName);
    rewrite(PicFile);
    write(PicFile, Pic);
    close(PicFile);
   end;
  EraseBox;
 end;

procedure DrawPic;
 function PicExist : boolean;
  var
   j, k : integer;
   Dot : boolean;
  begin
   Dot := false;
   for k := 1 to 24 do
    for j := 1 to 80 do
     if Pic[j,k] <> ' ' then
      Dot := true;
   PicExist := Dot;
  end;
 begin {DrawPic}
   repeat
    DispXY;
    gotoxy(x,y);
     repeat
      GoodKey := false;
      Key := readkey;
       case Key of
        #27 : GoodKey := true;
        ' ' : GoodKey := true;
        #8  : GoodKey := true;
        #13 : GoodKey := true;
        #0  :
         begin
          Key := readkey;
           case Key of
            ';'..'C' : GoodKey := true;
            'H', 'K', 'P', 'M' : GoodKey := true;
            'G', 'O', 'I', 'Q' : GoodKey := true;
           end; {case}
         end;
       end; {case}
     until GoodKey;
     case Key of
      'H' : y := y - 1;
      'K' : x := x - 1;
      'P' : y := y + 1;
      'M' : x := x + 1;
      'G' : x := 1;
      'O' : x := 80;
      'I' : y := 1;
      'Q' : y := 24;
      #13 :
       begin
        x := 1;
        y := y + 1;
       end;
      #8 :
       begin
        x := x - 1;
        if x < 1 then
         if y > 1 then
          begin
           x := 80;
           y := y - 1;
          end
         else
          begin
           x := 1;
           y := 1;
          end;
        gotoxy(x,y);
        write(' ');
        Pic[x,y] := ' ';
       end;
     end; {case}
    if x > 80 then x := 80;
    if x < 1 then x := 1;
    if y > 24 then y := 24;
    if y < 1 then y := 1;
    if Key = 'C' then
     for k := 1 to 24 do
      for j := 1 to 80 do
       begin
        gotoxy(j,k);
        write(Pic[j,k]);
       end;
    if Key in [';'..'B', ' '] then
     begin
      Ch := 'E';
       case Key of
        ' ' : Ch := ' ';
        ';' : Ch := #176;
        '<' : Ch := #177;
        '=' : Ch := #178;
        '>' : Ch := #219;
        '?' : Ch := #223;
        '@' : Ch := #220;
        'A' : Ch := #221;
        'B' : Ch := #222;
       end; {case}
      write(Ch);
      Pic[x,y] := Ch;
      x := x + 1;
      if x > 80 then
       if y < 24 then
        begin
         x := 1;
         y := y + 1;
        end
       else
        x := 80;
     end;
   until ord(Key) = 27;
  if PicExist then
   if WantSave then
    SavePic;
  Choice := NOTHING;
 end;

procedure LoadPic;
 var
  FileName : string;
  j, k : integer;
 begin
  DrawBox(22, 8, 58, 12, 'Input');
  gotoxy(25, 10);
  write('Enter file name: ');
  read(FileName);
  if FileName <> '' then
   begin
    if FSearch(FileName, '') = '' then
     begin
      EraseBox;
      DrawBox(28,8,52,12,'Output');
      gotoxy(30,10);
      write('File does not exist!');
      Cursor;
      readkey;
      EraseBox;
     end
    else
     begin
      assign(PicFile, FileName);
      reset(PicFile);
      read(PicFile, Pic);
      close(PicFile);
      for k := 1 to 24 do
       for j := 1 to 80 do
        begin
         gotoxy(j,k);
         write(Pic[j,k]);
        end;
      gotoxy(x,y);
     end;
   end;
  Choice := DRAW;
 end;

begin
 Init;
  repeat
   if Choice = DRAW then DrawPic;
   if Choice = LOAD then LoadPic;
   if Choice = NOTHING then GetChoice;
  until Choice = QUIT;
end.