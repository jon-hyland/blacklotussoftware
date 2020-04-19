program Journal;

uses
 Crt, Dos;

type
 array1 = array[1..60, 1..15] of Char;
 array2 = array[1..8] of Char;

var
 OrigMode : Word;
 Entry : array1;
 x, y : integer;
 j, k : integer;
 CursorX, CursorY : integer;
 CursorClr : byte;
 MMChoice : integer;
 Key : char;
 Date : string[8];
 DatFile : text;
 SwapFile : text;
 EntryExist : boolean;
 MMPoint : integer;

function SaveDate : string;
 var
  sdy, sdm, sdd, sddw : word;
  sy, sm, sd : string[2];
 begin
  GetDate(sdy, sdm, sdd, sddw);
  if sdy < 2000 then sdy := sdy - 1900 else sdy := sdy - 2000;
  str(sdy, sy);
  str(sdm, sm);
  str(sdd, sd);
  if sdy < 10 then sy := concat('0', sy);
  if sdm < 10 then sm := concat('0', sm);
  if sdd < 10 then sd := concat('0', sd);
  SaveDate := concat(sm, '/', sd, '/', sy);
 end;

procedure Init;
 begin
  OrigMode := LastMode;
  randomize;
  textcolor(white);
  textbackground(black);
  Date := SaveDate;
  assign(DatFile, 'JRNL.DAT');
  assign(SwapFile, 'JRNL.SWP');
 end;

procedure Beep;
 begin
  sound(200);
  delay(100);
  nosound;
 end;


procedure Clear;
 begin
  clrscr;
  textcolor(black);
  textbackground(black);
  gotoxy(1,1);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  CursorX := WhereX;
  CursorY := WhereY;
  gotoxy(1,1);
 end;

procedure CursorBack;
 begin
  gotoxy(CursorX, CursorY);
 end;

procedure Box(x1, y1, x2, y2 : integer);
 var
  bx, by : integer;
 begin
  for by := y1 to y2 do
   begin
    gotoxy(x1,by);
    for bx := x1 to x2 do write(' ');
   end;
  Cursor;
 end;

procedure TitleBox(TitleStr : string; x1, y1, x2, y2, NumChar : integer;
 BckColor : integer);
 var
  bx, by : integer;
  r : real;
 begin
  for by := y1 to y2 do
   begin
    gotoxy(x1,by);
    for bx := x1 to x2 do write(' ');
   end;
  textcolor(white);
  r := ((x2 - x1 + 1) - (NumChar + 4)) / 2;
  gotoxy(x1, y1);
  write(chr(218));
  for bx := (x1 + 1) to (x1 + trunc(r) - 3) do write(chr(196));
  write(chr(180), ' ', TitleStr, ' ', chr(195));
  for bx := (x1 + trunc(r) + 2 + NumChar) to (x2 - 1) do write(chr(196));
  write(chr(191));
  for by := (y1 + 1) to (y2 - 1) do
   begin
    gotoxy(x1, by);
    write(chr(179));
    gotoxy(x2, by);
    write(chr(179));
   end;
  gotoxy(x1, y2);
  write(chr(192));
  for bx := (x1 + 1) to (x2 - 1) do write(chr(196));
  write(chr(217));
  textcolor(black);
  textbackground(BckColor);
  gotoxy(x1+2, y2+1);
  for bx := (x1 + 2) to (x2 + 2) do write(chr(177));
  for by := (y1 + 1) to (y2) do
   begin
    gotoxy(x2+1, by);
    write(chr(177), chr(177));
   end;
  Cursor;
 end;

procedure MainScreen;
 var
  y1, y2 : integer;
  x1, x2 : real;
 begin
  Clear;
  textcolor(blue);
  textbackground(blue);
  x1 := 38;
  x2 := 38;
  y1 := 11;
  y2 := 11;
  for j := 1 to 10 do
   begin
    box(round(x1), y1, round(x2), y2);
    x1 := x1 - 3.3;
    x2 := x2 + 3.3;
    y1 := y1 - 1;
    y2 := y2 + 1;
    Cursor;
    delay(10);
   end;
  Box(3,2,78,24);
  textcolor(white);
  gotoxy(3,2);
  write(chr(218));
  for j := 4 to 31 do write(chr(196));
  write(chr(180), ' Journal v1.0 ', chr(195));
  for j := 48 to 77 do write(chr(196));
  write(chr(191));
  for j := 3 to 23 do
   begin
    gotoxy(3,j);
    write(chr(179));
    gotoxy(78,j);
    write(chr(179));
   end;
  gotoxy(3,24);
  write(chr(192));
  for j := 4 to 77 do write(chr(196));
  write(chr(217));
  textcolor(lightblue);
  gotoxy(59,23);
  write('Jon Hyland 7/10/95');
  Date := SaveDate;
  gotoxy(5, 23);
  write('Date: ', Date);
  Cursor;
 end;

function MainMenu : integer;
 var
  OldPoint : integer;
  Chosen : boolean;
  Move : boolean;
 begin
  textbackground(red);
  Box(28,7,50,19);
  textcolor(white);
  gotoxy(28,7);
  write(chr(218));
  for j := 29 to 32 do write(chr(196));
  write(chr(180), ' Main Menu ', chr(195));
  for j := 46 to 49 do write(chr(196));
  write(chr(191));
  for j := 8 to 18 do
   begin
    gotoxy(28,j);
    write(chr(179));
    gotoxy(50,j);
    write(chr(179));
   end;
  gotoxy(28,19);
  write(chr(192));
  for j := 29 to 49 do write(chr(196));
  write(chr(217));
  textcolor(black);
  textbackground(blue);
  gotoxy(30,20);
  for j := 30 to 52 do write(chr(177));
  for j := 8 to 20 do
   begin
    gotoxy(51,j);
    write(chr(177), chr(177));
   end;
  textcolor(yellow);
  textbackground(red);
  gotoxy(32,8);
  write('1 Create Entry');
  gotoxy(32,10);
  write('2 Read Entry');
  gotoxy(32,12);
  write('3 Edit Entry');
  gotoxy(32,14);
  write('4 Delete Entry');
  gotoxy(32,16);
  write('5 List Dates');
  gotoxy(32,18);
  write('6 Exit to DOS');
  gotoxy(30, MMPoint * 2 + 6);
  write(chr(254));
  Cursor;
  Chosen := false;
  while not Chosen do
   begin
    Move := true;
    Key := readkey;
    OldPoint := MMPoint;
     case Key of
      #72: MMPoint := MMPoint - 1;
      #80: MMPoint := MMPoint + 1;
      ' ': MMPoint := MMPoint + 1;
      '1': MMPoint := 1;
      '2': MMPoint := 2;
      '3': MMPoint := 3;
      '4': MMPoint := 4;
      '5': MMPoint := 5;
      '6': MMPoint := 6;
     else
      Move := false;
     end;
    if MMPoint = 0 then MMPoint := 6;
    if MMPoint = 7 then MMPoint := 1;
    if Move then
     begin
      gotoxy(30, OldPoint * 2 + 6);
      write(' ');
      gotoxy(30, MMPoint * 2 + 6);
      write(chr(254));
      Cursor;
     end;
     case ord(Key) of
      13: Chosen := true;
      49..54: Chosen := true;
     end;
   end;
  MainMenu := MMPoint;
  if ord(Key) <> 13 then delay(50);
  textcolor(blue);
  textbackground(blue);
  Box(28,7,52,20);
 end;

procedure ClearEntry;
 begin
  for j := 1 to 15 do
   begin
    for k := 1 to 60 do Entry[k,j] := ' ';
   end;
 end;

function FindEntryExist(Date : string) : boolean;
 var
  Lbl : string[5];
  Dte : string[8];
 begin
  EntryExist := false;
  reset(DatFile);
   repeat
     repeat
      read(DatFile, Lbl);
      if Lbl <> 'JRNL ' then readln(DatFile);
     until ((Lbl = 'JRNL ') or (Eof(DatFile)));
    readln(DatFile, Dte);
    if Dte = Date then EntryExist := true;
   until ((EntryExist) or (Eof(DatFile)));
  close(DatFile);
  FindEntryExist := EntryExist;
 end;

function EofLineNum(YLine : integer) : integer;
 var
  Num : integer;
  FoundChar : boolean;
 begin
  Num := 60;
  j := 60;
  FoundChar := false;
  while ((j > 1) and (FoundChar = false)) do
   begin
    if Entry[j, YLine] = ' ' then Num := Num - 1 else FoundChar := true;
    j := j - 1;
   end;
  if Num < 1 then Num := 1;
  EofLineNum := Num;
 end;

function EofEntryNum : integer;
 var
  Num : integer;
  FoundChar : boolean;
 begin
  Num := 1;
  for k := 1 to 15 do
   begin
    FoundChar := false;
    for j := 1 to 60 do if Entry[j, k] <> ' ' then FoundChar := true;
    if FoundChar then Num := k;
   end;
  EofEntryNum := Num;
 end;

procedure SaveNewEntry(EntName : string);
 var
  LineChars : integer;
 begin
  append(DatFile);
  writeln(DatFile, ConCat('JRNL ', EntName));
  for k := 1 to 15 do
   begin
    LineChars := EofLineNum(k);
    for j := 1 to 60 do
     begin
      if j <= LineChars then write(DatFile, Entry[j, k]);
     end;
    writeln(DatFile);
   end;
  close(DatFile);
 end;

procedure CreateEntry(EntryDate : string);
 var
  DoneTyping : boolean;
  Action : integer;
  SaveAnswer : boolean;
  SaveIt : boolean;
  LastBlank : boolean;
  AllBlank : boolean;
  AfterChars : boolean;
  DragChars : integer;
 begin
  ClearEntry;
  DoneTyping := false;
  textcolor(yellow);
  textbackground(magenta);
  TitleBox(Concat('Entry ', EntryDate), 9,5,72,21,14,1);
  textcolor(yellow);
  textbackground(magenta);
  Box(11,6,7,12);
  x := 1;
  y := 1;
  textcolor(yellow);
  textbackground(5);
  gotoxy(x+10,y+5);
   repeat
    Key := readkey;
    Action := 0;
    if Key = #27 then DoneTyping := true;
     case Key of
      #13: Action := 1;
      #8:  Action := 2;
      #9 : Action := 9;
      #0:
       begin
        Key := readkey;
         case Key of
          #83: Action := 3;
          #82: Action := 4;
          #72: Action := 5;
          #80: Action := 6;
          #77: Action := 7;
          #75: Action := 8;
          #71: Action := 10;
          #79: Action := 11;
          #59: Action := 20;
         end;
       end;
     else
     begin
      if Key <> #27 then
       begin
        Entry[x,y] := Key;
        write(Key);
        x := x + 1;
        if x > 60 then
         begin
          x := 1;
          y := y + 1;
          if y > 15 then
           begin
            x := 60;
            y := 15;
            Beep;
           end;
         end;
        gotoxy(x+10,Y+5);
       end;
     end;
     end;
    if Action = 1 then
     begin
      if EofEntryNum < 15 then LastBlank := true else LastBlank := false;
      if EofEntryNum <= y then AllBlank := true else AllBlank := false;
      if EofLineNum(y) >= x then AfterChars := true else AfterChars := false;
      if ((LastBlank = true) and
       ((AllBlank = false) or (AfterChars = true))) then
       begin
        k := 15;
         repeat
          if k > y + 1 then
           begin
            for j := 1 to 60 do
             begin
              Entry[j, k] := Entry[j, k-1];
              gotoxy(j+10, k+5);
              write(Entry[j,k]);
             end;
           end else
           begin
            if k > y then
             begin
              for j := x to 60 do
               begin
                Entry[j - (x-1), k] := Entry[j, y];
                gotoxy((j - (x-1)) + 10, k + 5);
                write(Entry[j - (x-1), k]);
               end;
             end;
            if k = y then
             begin
              for j := x to 60 do
               begin
                Entry[j, k] := ' ';
                gotoxy(j+10, k+5);
                write(Entry[j,k]);
               end;
             end;
           end;
          k := k - 1;
         until k < y;
        x := 1;
        y := y + 1;
        gotoxy(x+10, y+5);
       end else
       begin
        x := 1;
        y := y + 1;
        if y > 15 then
         begin
          y := 15;
          Beep;
         end;
        gotoxy(x+10,y+5);
       end;
     end;


    if Action = 2 then
     begin

      if x > 1 then
       begin
        if EofLineNum(y) + 1 <= x then
         begin
          x := x - 1;
          if x < 1 then
           begin
            y := y - 1;
            if y < 1 then
             begin
              y := 1;
              x := 1;
              Beep;
             end else
             begin
              x := EofLineNum(y) + 1;
              if x > 60 then x := 60;
             end;
           end;
          if ((y = 15) and (x + 1 = 60)) then
           begin
            gotoxy(x+11, y+5);
            write(' ');
            Entry[x+1,y] := ' ';
           end;
          gotoxy(x+10,y+5);
          write(' ');
          gotoxy(x+10,y+5);
          Entry[x,y] := ' ';
         end else
         begin
          x := x - 1;
          for j := x to EofLineNum(y) - 1 do
           begin
            Entry[j, y] := Entry[j+1, y];
            gotoxy(j+10, y+5);
            write(Entry[j, y]);
           end;
          gotoxy(EofLineNum(y) + 10, y + 5);
          write(' ');
          gotoxy(x+10, y+5);
          Entry[EofLineNum(y), y] := ' ';
         end;
       end else
       begin
        if y > 1 then
         begin
          DragChars := (EofLineNum(y) - x) + 1;
          AfterChars := false;
          for k := y to 15 do
           begin
            for j := 1 to 60 do
             begin
              if Entry[j, k] <> ' ' then AfterChars := true;
             end;
           end;
          if ((AfterChars = false) or (DragChars > (60 - EofLineNum(y-1))))
           then begin
            y := y - 1;
            if y < 1 then
             begin
              y := 1;
              x := 1;
              Beep;
              gotoxy(x+10, y+5);
             end else
             begin
              x := EofLineNum(y);
              if x > 60 then x := 60;
              gotoxy(x+10, y + 5);
              write(' ');
              gotoxy(x+10, y+5);
              Entry[x, y] := ' ';
             end;
           end else
           begin                      {Pulls bottom lines up}
            k := 1;              {Drags Chars after cursor to above line}
            for j := EofLineNum(y-1) + 1 to 60 do
             begin
              Entry[j, y-1] := Entry[k, y];
              gotoxy(j+10, (y-1)+5);
              write(Entry[j, y-1]);
              k := k + 1;
             end;
            for k := y to 14 do
             begin
              for j := 1 to 60 do
               begin
                Entry[j, k] := Entry[j, k+1];
                gotoxy(j+10, k+5);
                write(Entry[j, k]);
               end;
             end;
            for j := 1 to 60 do
             begin
              Entry[j, 15] := ' ';
              gotoxy(j+10, 15+5);
              write(' ');
             end;
            y := y - 1;
            x := (EofLineNum(y) + 1) - DragChars;
            gotoxy(x+10, y+5);
           end;
         end else
         begin
          y := y - 1;
          if y < 1 then
           begin
            y := 1;
            x := 1;
            Beep;
           end else
           begin
            x := EofLineNum(y);
            if x > 60 then x := 60;
            gotoxy(x+10, y + 5);
            write(' ');
            gotoxy(x+10, y+5);
            Entry[x, y] := ' ';
           end;
         end;
       end;
     end;

    if Action = 3 then
     begin
      for j := x to 59 do
       begin
        Entry[j, y] := Entry[j+1, y];
       end;
      Entry[60, y] := ' ';
      for j := x to 60 do
       begin
        write(Entry[j, y]);
       end;
      gotoxy(x+10,y+5);
     end;
    if Action = 4 then
     begin
      j := 60;
      while j > x do
       begin
        Entry[j,y] := Entry[j-1,y];
        j := j - 1;
       end;
      Entry[x,y] := ' ';
      for j := x to 60 do write(Entry[j,y]);
      gotoxy(x+10,y+5);
     end;
    if Action = 5 then
     begin
      y := y - 1;
      if y < 1 then y := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 6 then
     begin
      y := y + 1;
      if y > 15 then y := 15;
      gotoxy(x+10,y+5);
     end;
    if Action = 7 then
     begin
      x := x + 1;
      if x > 60 then x := 60;
      gotoxy(x+10,y+5);
     end;
    if Action = 8 then
     begin
      x := x - 1;
      if x < 1 then x := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 9 then
     begin
      for j := x to x+3 do
       begin
        Entry[x,y] := ' ';
        gotoxy(x+10,y+5);
        write(' ');
        x := x + 1;
        if x > 60 then x := 60;
       end;
     end;
    if Action = 10 then
     begin
      x := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 11 then
     begin
      x := EofLineNum(y) + 1;
      if x > 60 then x := 60;
      gotoxy(x+10,y+5);
     end;
    if Action = 20 then
     begin
      for k := 1 to 15 do
       begin
        for j := 1 to 60 do
         begin
          gotoxy(j+10,k+5);
          write(Entry[j,k]);
         end;
       end;
      gotoxy(x+10,y+5);
     end;
   until DoneTyping;
  textcolor(cyan);
  textbackground(cyan);
  TitleBox('Input', 29,12,51,14,5,5);
  textcolor(yellow);
  textbackground(cyan);
  gotoxy(32,13);
  write('Save Entry? (Y/N)');
  Cursor;
  SaveAnswer := false;
   repeat
    Key := readkey;
    if ((Key = 'Y') or (Key = 'N') or (Key = 'y') or (Key = 'n')) then
     SaveAnswer := true;
   until SaveAnswer = true;
  SaveIt := false;
  if ((Key = 'Y') or (Key = 'y')) then SaveIt := true;
  if SaveIt then SaveNewEntry(EntryDate);
  textcolor(blue);
  textbackground(blue);
  Box(9,5,74,22);
 end;

function AskDate : string;
 var
  Dte : array2;
  Pl : integer;
  Dte2 : string;
 begin
  for j := 1 to 8 do Dte[j] := ' ';
  Pl := 1;
  textcolor(cyan);
  textbackground(cyan);
  TitleBox('Input', 29,11,53,14,5,1);
  textcolor(yellow);
  textbackground(cyan);
  Box(35,13,45,13);
  gotoxy(31,12);
  write('Entry Date (MM/DD/YY)');
  gotoxy(39,13);
  write('/  /');
  gotoxy(37,13);
  x := 37;
   repeat
    Key := readkey;
    if ord(Key) = 8 then
     begin
      Pl := Pl - 1;
      x := x - 1;
      if x < 37 then x := 37;
      if ((x = 39) or (x = 42)) then
       begin
        Dte[Pl] := '/';
        x := x - 1;
        Pl := Pl - 1;
       end;
      gotoxy(x, 13);
      write(' ');
      gotoxy(x, 13);
      Dte[Pl] := ' ';
     end;
    if ((ord(Key) >= 48) and (ord(Key) <= 57)) then
     begin
      write(Key);
      Dte[Pl] := Key;
      x := x + 1;
      Pl := Pl + 1;
      if ((x = 39) or (x = 42)) then
       begin
        x := x + 1;
        Dte[Pl] := '/';
        Pl := Pl + 1;
       end;
      gotoxy(x, 13);
     end;
   until ((Pl > 8) or (ord(Key) = 27));
  Dte2 := '';
  for j := 1 to 8 do Dte2 := ConCat(Dte2, Dte[j]);
  AskDate := Dte2;
  if ord(Key) = 27 then AskDate := 'PressEsc' else delay(175);
  textcolor(blue);
  textbackground(blue);
  Box(29,11,55,15);
  Cursor;
 end;

procedure LoadEntry(EntName : string);
 var
  RightEntry : boolean;
  Lab : string[5];
  Dte : string[8];
 begin
  ClearEntry;
  reset(DatFile);
  RightEntry := false;
   repeat
     repeat
      read(DatFile, Lab);
      if Lab <> 'JRNL ' then readln(DatFile);
     until ((Lab = 'JRNL ') or (Eof(DatFile) = true));
    readln(DatFile, Dte);
    if Dte = EntName then RightEntry := true;
   until ((RightEntry = true) or (Eof(DatFile) = true));
  if RightEntry = true then
   begin
    Date := Dte;
    for k := 1 to 15 do
     begin
      for j := 1 to 60 do
       begin
        if Eoln(DatFile) = false then
         begin
          read(DatFile, Entry[j,k]);
         end else
         begin
          Entry[j,k] := ' ';
         end;
       end;
      readln(DatFile);
     end;
   end;
  close(DatFile);
 end;

procedure ReadEntry(EntryName : String);
 begin
  textcolor(green);
  textbackground(green);
  TitleBox(Concat('Entry ', EntryName), 9,5,72,21,14,1);
  textcolor(yellow);
  textbackground(green);
  for y := 1 to 15 do
   begin
    for x := 1 to 60 do
     begin
      gotoxy(x+10,y+5);
      write(Entry[x,y]);
     end;
   end;
  Cursor;
  readkey;
  textcolor(blue);
  textbackground(blue);
  Box(9,5,74,22);
 end;

procedure SaveOldEntry(EntName : string);
 var
  FoundAnEntry : boolean;
  Head : string[5];
  Dte : string[8];
  Ky : char;
  Lns : integer;
 begin
  rewrite(SwapFile);
  reset(DatFile);
  Head := '';
   repeat
     repeat
      Head := '';
      read(DatFile, Head);
      if Head <> 'JRNL ' then readln(DatFile);
     until ((Eof(DatFile)) or (Head = 'JRNL '));
    if Head = 'JRNL ' then readln(DatFile, Dte);
    if ((Dte <> EntName) and (Head = 'JRNL ')) then
     begin
      writeln(SwapFile, Head, Dte);
      for k := 1 to 15 do
       begin
        for j := 1 to 60 do
         begin
          if Eoln(DatFile) = false then
           begin
            read(DatFile, Ky);
            write(SwapFile, Ky);
           end;
         end;
        writeln(SwapFile);
        readln(DatFile);
       end;
     end;
   until Eof(DatFile);
  writeln(SwapFile, 'JRNL ', EntName);
  for k := 1 to 15 do
   begin
    Lns := EofLineNum(k);
    for j := 1 to Lns do
     begin
      write(SwapFile, Entry[j, k]);
     end;
    writeln(SwapFile);
   end;
  close(SwapFile);
  close(DatFile);
  rewrite(DatFile);
  reset(SwapFile);
   repeat
     repeat
      read(SwapFile, Ky);
      write(DatFile, Ky);
     until Eoln(SwapFile);
    readln(SwapFile);
    writeln(DatFile);
   until Eof(SwapFile);
  close(DatFile);
  close(SwapFile);
  rewrite(SwapFile);
  close(SwapFile);
 end;

procedure EditEntry(EntryDate : string);
 var
  DoneTyping : boolean;
  Action : integer;
  SaveAnswer : boolean;
  SaveIt : boolean;
 begin
  DoneTyping := false;
  textcolor(yellow);
  textbackground(brown);
  TitleBox(Concat('Entry ', EntryDate), 9,5,72,21,14,1);
  textcolor(yellow);
  textbackground(brown);
  Box(11,6,7,12);
   for k := 1 to 15 do
    begin
     for j := 1 to 60 do
      begin
       gotoxy(j+10, k+5);
       write(Entry[j, k]);
      end;
    end;
  y := EofEntryNum;
  x := EofLineNum(y) + 1;
  if x > 60 then x := 60;
  textcolor(yellow);
  textbackground(brown);
  gotoxy(x+10,y+5);
   repeat
    Key := readkey;
    Action := 0;
    if Key = #27 then DoneTyping := true;
     case Key of
      #13: Action := 1;
      #8:  Action := 2;
      #9 : Action := 9;
      #0:
       begin
        Key := readkey;
         case Key of
          #83: Action := 3;
          #82: Action := 4;
          #72: Action := 5;
          #80: Action := 6;
          #77: Action := 7;
          #75: Action := 8;
          #71: Action := 10;
          #79: Action := 11;
          #59: Action := 20;
         end;
       end;
     else
     begin
      if Key <> #27 then
       begin
        Entry[x,y] := Key;
        write(Key);
        x := x + 1;
        if x > 60 then
         begin
          x := 1;
          y := y + 1;
          if y > 15 then
           begin
            x := 60;
            y := 15;
            Beep;
           end;
         end;
        gotoxy(x+10,Y+5);
       end;
     end;
     end;
    if Action = 1 then
     begin
      x := 1;
      y := y + 1;
      if y > 15 then
       begin
        y := 15;
        Beep;
       end;
      gotoxy(x+10,y+5);
     end;
    if Action = 2 then
     begin
      x := x - 1;
      if x < 1 then
       begin
        y := y - 1;
        if y < 1 then
         begin
          y := 1;
          x := 1;
          Beep;
         end else
         begin
          x := EofLineNum(y) + 1;
          if x > 60 then x := 60;
         end;
       end;
      if ((y = 15) and (x + 1 = 60)) then
       begin
        gotoxy(x+11, y+5);
        write(' ');
        Entry[x+1,y] := ' ';
       end;
      gotoxy(x+10,y+5);
      write(' ');
      gotoxy(x+10,y+5);
      Entry[x,y] := ' ';
     end;
    if Action = 3 then
     begin
      for j := x to 59 do
       begin
        Entry[j, y] := Entry[j+1, y];
       end;
      Entry[60, y] := ' ';
      for j := x to 60 do
       begin
        write(Entry[j, y]);
       end;
      gotoxy(x+10,y+5);
     end;
    if Action = 4 then
     begin
      j := 60;
      while j > x do
       begin
        Entry[j,y] := Entry[j-1,y];
        j := j - 1;
       end;
      Entry[x,y] := ' ';
      for j := x to 60 do write(Entry[j,y]);
      gotoxy(x+10,y+5);
     end;
    if Action = 5 then
     begin
      y := y - 1;
      if y < 1 then y := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 6 then
     begin
      y := y + 1;
      if y > 15 then y := 15;
      gotoxy(x+10,y+5);
     end;
    if Action = 7 then
     begin
      x := x + 1;
      if x > 60 then x := 60;
      gotoxy(x+10,y+5);
     end;
    if Action = 8 then
     begin
      x := x - 1;
      if x < 1 then x := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 9 then
     begin
      for j := x to x+3 do
       begin
        Entry[x,y] := ' ';
        gotoxy(x+10,y+5);
        write(' ');
        x := x + 1;
        if x > 60 then x := 60;
       end;
     end;
    if Action = 10 then
     begin
      x := 1;
      gotoxy(x+10,y+5);
     end;
    if Action = 11 then
     begin
      x := EofLineNum(y) + 1;
      if x > 60 then x := 60;
      gotoxy(x+10,y+5);
     end;
    if Action = 20 then
     begin
      for k := 1 to 15 do
       begin
        for j := 1 to 60 do
         begin
          gotoxy(j+10,k+5);
          write(Entry[j,k]);
         end;
       end;
      gotoxy(x+10,y+5);
     end;
   until DoneTyping;
  textcolor(cyan);
  textbackground(cyan);
  TitleBox('Input', 29,12,51,14,5,6);
  textcolor(yellow);
  textbackground(cyan);
  gotoxy(32,13);
  write('Save Entry? (Y/N)');
  Cursor;
  SaveAnswer := false;
   repeat
    Key := readkey;
    if ((Key = 'Y') or (Key = 'N') or (Key = 'y') or (Key = 'n')) then
     SaveAnswer := true;
   until SaveAnswer = true;
  SaveIt := false;
  if ((Key = 'Y') or (Key = 'y')) then SaveIt := true;
  if SaveIt then
   begin
    SaveOldEntry(EntryDate);
   end;
  textcolor(blue);
  textbackground(blue);
  Box(9,5,74,22);
 end;

procedure DelEntry(EntName : string);
 var
  FoundAnEntry : boolean;
  Head : string[5];
  Dte : string[8];
  Ky : char;
  Lns : integer;
 begin
  rewrite(SwapFile);
  reset(DatFile);
  Head := '';
   repeat
     repeat
      Head := '';
      read(DatFile, Head);
      if Head <> 'JRNL ' then readln(DatFile);
     until ((Eof(DatFile)) or (Head = 'JRNL '));
    if Head = 'JRNL ' then readln(DatFile, Dte);
    if ((Dte <> EntName) and (Head = 'JRNL ')) then
     begin
      writeln(SwapFile, Head, Dte);
      for k := 1 to 15 do
       begin
        for j := 1 to 60 do
         begin
          if Eoln(DatFile) = false then
           begin
            read(DatFile, Ky);
            write(SwapFile, Ky);
           end;
         end;
        writeln(SwapFile);
        readln(DatFile);
       end;
     end;
   until Eof(DatFile);
  close(SwapFile);
  close(DatFile);
  rewrite(DatFile);
  reset(SwapFile);
   repeat
     repeat
      read(SwapFile, Ky);
      write(DatFile, Ky);
     until Eoln(SwapFile);
    readln(SwapFile);
    writeln(DatFile);
   until Eof(SwapFile);
  close(DatFile);
  close(SwapFile);
  rewrite(SwapFile);
  close(SwapFile);
 end;

procedure ShowDates;
 var
  Hed : string[5];
  Dte : string[8];
 begin
  textcolor(lightgray);
  textbackground(lightgray);
  TitleBox('Entry Dates', 10,4,71,20,11,1);
  textbackground(lightgray);
  reset(DatFile);
   repeat
    textcolor(lightgray);
    textbackground(lightgray);
    Box(12,5,70,19);
    textcolor(yellow);
    x := 12;
    y := 5;
    j := 1;
     repeat
       repeat
        Hed := '';
        read(DatFile, Hed);
        if Hed <> 'JRNL ' then readln(DatFile);
       until ((Hed = 'JRNL ') or (Eof(DatFile)));
      if Hed = 'JRNL ' then
       begin
        readln(DatFile, Dte);
        gotoxy(x,y);
        write(Dte);
        x := x + 10;
        if x > 62 then
         begin
          x := 12;
          y := y + 2;
         end;
        Cursor;
        j := j + 1;
       end;
     until ((j > 48) or (Eof(DatFile)));
    readkey;
   until Eof(DatFile);
  close(DatFile);
  textcolor(blue);
  textbackground(blue);
  Box(10,4,73,21);
  Cursor;
 end;

procedure NotDone;
 begin
  textcolor(lightgray);
  textbackground(lightgray);
  TitleBox('Error!', 30,11,50,13,6,1);
  textcolor(yellow);
  textbackground(lightgray);
  gotoxy(32,12);
  write('Not yet finished!');
  Cursor;
  Beep;
  readkey;
  textcolor(blue);
  textbackground(blue);
  Box(30,11,52,14);
 end;

procedure ShowEntExist;
 begin
  textcolor(cyan);
  textbackground(cyan);
  TitleBox('Error!', 24,11,56,14,6,1);
  textcolor(yellow);
  textbackground(cyan);
  gotoxy(26,12);
  write('Today''s entry already exists!');
  gotoxy(27,13);
  write('Use ''Edit Entry'' to change.');
  Cursor;
  Beep;
  readkey;
  textcolor(white);
  textbackground(blue);
  Box(24,11,58,15);
 end;

procedure ShowEntNoExist;
 begin
  textcolor(cyan);
  textbackground(cyan);
  TitleBox('Error!', 28,11,52,13,6,1);
  textcolor(yellow);
  textbackground(cyan);
  gotoxy(30,12);
  write('Entry does not exist!');
  Cursor;
  Beep;
  readkey;
  textcolor(white);
  textbackground(blue);
  Box(28,11,54,14);
 end;


procedure DrawEnd;
 var
  y1, y2 : integer;
  x1, x2 : real;
 begin
  textcolor(black);
  textbackground(black);
  x1 := 40;
  x2 := 40;
  y1 := 13;
  y2 := 13;
  for j := 1 to 11 do
   begin
    box(round(x1), y1, round(x2+1), y2);
    x1 := x1 - 3.6;
    x2 := x2 + 3.6;
    y1 := y1 - 1;
    y2 := y2 + 1;
    Cursor;
    delay(10);
   end;
  TextMode(OrigMode);
  clrscr;
  Halt(3);
 end;

begin
 Init;
 MainScreen;
 MMPoint := 1;
  repeat
   MMChoice := MainMenu;
   if MMChoice = 1 then
    begin
     Date := SaveDate;
     EntryExist := FindEntryExist(Date);
     if EntryExist = false then
      begin
       CreateEntry(Date);
      end else
      begin
       ShowEntExist;
      end;
    end;
   if MMChoice = 2 then
    begin
     Date := AskDate;
     if Date <> 'PressEsc' then
      begin
       EntryExist := FindEntryExist(Date);
       if EntryExist then
        begin
         LoadEntry(Date);
         ReadEntry(Date);
        end else
        begin
         ShowEntNoExist;
        end;
      end;
    end;
   if MMChoice = 3 then
    begin
     Date := AskDate;
     if Date <> 'PressEsc' then
      begin
       EntryExist := FindEntryExist(Date);
       if EntryExist then
        begin
         LoadEntry(Date);
         EditEntry(Date);
        end else
        begin
         ShowEntNoExist;
        end;
      end;
    end;
   if MMChoice = 4 then
    begin
     Date := AskDate;
     if Date <> 'PressEsc' then
      begin
       EntryExist := FindEntryExist(Date);
       if EntryExist then
        begin
         DelEntry(Date);
        end else
        begin
         ShowEntNoExist;
        end;
      end;
    end;
   if MMChoice = 5 then
    begin
     ShowDates;
    end;
  until MMChoice = 6;
 DrawEnd;
end.