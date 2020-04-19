program Crypto;

{ This program was inputs fivef, sixty character lines and scrambles
  all letters (A..Z). It displays the result and will save it in
  CRYPTO.TXT if the user chooses. This program will also ask if
  CRYPTO.TXT will be erased. Program loops until user quits.

  Programmed by: Jon Hyland            Date: 11/2/95 }

uses
 Crt, Dos;

type
 array1 = array[1..60, 1..5] of char;
 array2 = array[65..90] of char;

var
 Entry : array1;
 Code : array2;
 SaveFile : text;
 Saved : boolean;

procedure Title;
 begin
  clrscr;
  gotoxy(33,9);
  textcolor(blue);
  write('- CryptoGraph -');
  gotoxy(38,11);
  textcolor(yellow);
  write('v1.2');
  gotoxy(35,13);
  textcolor(red);
  write('Jon Hyland');
  gotoxy(28,24);
  textcolor(lightgray);
  write('Press any key to continue..');
  readkey;
 end;

procedure GetEntry;
 var
  x, y : integer;
  Key : char;
 begin
  clrscr;
  write('Enter text to be converted.');
  writeln(' Hit (Esc) when done.');
  for y := 1 to 5 do
   for x := 1 to 60 do Entry[x, y] := ' ';
  for y := 3 to 7 do
   begin
    gotoxy(1, y);
    write('[');
   end;
  for y := 3 to 7 do
   begin
    gotoxy(62, y);
    write(']');
   end;
  x := 1;
  y := 1;
   repeat
    gotoxy(x+1, y+2);
    Key := readkey;
     case Key of
      #13 :
       begin
        x := 1;
        y := y + 1;
        if y > 5 then Key := '';
       end;
      #8  :
       begin
        x := x - 1;
        if x < 1 then
         begin
          x := 60;
          y := y - 1;
          if y < 1 then
           begin
            y := 1;
            x := 1;
           end;
         end;
        Entry[x,y] := ' ';
        gotoxy(x+1, y+2);
        write(' ');
        gotoxy(x+1, y+2);
       end;
      #27 :
     else
      begin
        case Key of
          'a'..'z' : Key := chr(ord(Key)-32);
        end; {case}
       Entry[x,y] := Key;
       gotoxy(x+1, y+2);
       write(Key);
       x := x + 1;
       if x > 60 then
        begin
         x := 1;
         y := y + 1;
         if y > 5 then Key := '';
        end;
      end;
     end;
   until ord(Key) = 27;
 end;

procedure ConvertEntry;
 var
  Key : char;
  x, y : integer;
  r1, r2 : integer;
  Alpha : array2;
 begin
  for x := 65 to 90 do Alpha[x] := chr(x);
  gotoxy(1, 9);
  writeln('Converting text...');
  for x := 65 to 90 do Code[x] := chr(x);
  for x := 1 to 250 do
   begin
    r1 := random(26)+65;
    r2 := random(26)+65;
    if (Code[r1] <> Alpha[r2]) and (Code[r2] <> Alpha[r1]) then
     begin
      Key := Code[r1];
      Code[r1] := Code[r2];
      Code[r2] := Key;
     end;
   end;
  for y := 1 to 5 do
   begin
    for x := 1 to 60 do
     begin
      if (65 <= ord(Entry[x,y])) and (ord(Entry[x,y]) <= 90) then
       Entry[x,y] := Code[ord(Entry[x,y])];
     end;
   end;
 end;

procedure DisplayEntry;
 var
  x, y : integer;
 begin
  for y := 11 to 15 do
   begin
    gotoxy(1, y);
    write('[');
   end;
  for y := 11 to 15 do
   begin
    gotoxy(62, y);
    write(']');
   end;
  for y := 1 to 5 do
   for x := 1 to 60 do
    begin
     gotoxy(x+1, y+10);
     write(Entry[x,y]);
    end;
 end;

procedure SaveEntry;
 var
  Key : char;
  x, y : integer;
  NoLett : boolean;
  NewFile : boolean;
 begin
   repeat
    gotoxy(1,17);
    write('Save Entry (Y/N):          ');
    gotoxy(19, 17);
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then Saved := true else Saved := false;
  if Key = 'Y' then
   begin
    assign(SaveFile, 'CRYPTO.TXT');
     repeat
      gotoxy(1,18);
      write('Erase old file (Y/N):          ');
      gotoxy(23, 18);
      readln(Key);
      if Key = 'y' then Key := 'Y';
      if Key = 'n' then Key := 'N';
     until (Key = 'Y') or (Key = 'N');
    if Key = 'Y' then NewFile := true else NewFile := false;
    gotoxy(1,19);
    write('Saving File...');
    if Key = 'Y' then rewrite(SaveFile) else append(SaveFile);
    if not NewFile then
     writeln(SaveFile, '--------------------------------------------------');
    for y := 1 to 5 do
     begin
      NoLett := true;
      for x := 1 to 60 do if Entry[x,y] <> ' ' then NoLett := false;
      if not NoLett then
       begin
        for x := 1 to 60 do write(SaveFile, Entry[x,y]);
        writeln(SaveFile);
        writeln(SaveFile);
       end;
     end;
    close(SaveFile);
    gotoxy(1,20);
    write('File saved.');
   end;
 end;

function Done : boolean;
 var
  Key : char;
 begin
   repeat
    if Saved then
     begin
      gotoxy(1,22);
      write('Quit (Y/N):      ');
      gotoxy(13,22);
     end
    else
     begin
      gotoxy(1,19);
      write('Quit (Y/N):      ');
      gotoxy(13,19);
     end;
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then Done := true else Done := false;
 end;

begin
 randomize;
 Title;
  repeat
   GetEntry;
   ConvertEntry;
   DisplayEntry;
   SaveEntry;
  until Done;
 clrscr;
end.
