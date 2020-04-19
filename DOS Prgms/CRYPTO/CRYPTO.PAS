program Crypto;

uses
 Crt, Dos;

type
 array1 = array[1..60, 1..4] of char;
 array2 = array[65..90] of char;

var
 Entry : array1;
 Code : array2;
 SaveFile : text;

procedure Title;
 begin
  clrscr;
  gotoxy(33,9);
  write('- CryptoGraph -');
  gotoxy(38,11);
  write('v1.1');
  gotoxy(35,13);
  write('Jon Hyland');
  gotoxy(28,24);
  write('Press any key to continue..');
  readkey;
 end;

procedure GetEntry;
 var
  x, y : integer;
  Key : char;
 begin
  writeln('Enter text to be converted. Letters only. Hit (Esc) when done.');
  for y := 1 to 4 do
   for x := 1 to 60 do Entry[x, y] := ' ';
  gotoxy(1, 3);
  write('[');
  gotoxy(1, 4);
  write('[');
  gotoxy(1, 5);
  write('[');
  gotoxy(1, 6);
  write('[');
  gotoxy(62, 3);
  write(']');
  gotoxy(62, 4);
  write(']');
  gotoxy(62, 5);
  write(']');
  gotoxy(62, 6);
  write(']');
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
        if y > 4 then Key := '';
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
         if y > 4 then Key := '';
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
 begin
  gotoxy(1, 8);
  writeln('Converting text...');
  for x := 65 to 90 do
   Code[x] := chr(x);
  for x := 1 to 250 do
   begin
    r1 := random(26)+65;
    r2 := random(26)+65;
    Key := Code[r1];
    Code[r1] := Code[r2];
    Code[r2] := Key;
   end;
  for y := 1 to 4 do
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
  gotoxy(1,10);
  write('[');
  gotoxy(1,11);
  write('[');
  gotoxy(1,12);
  write('[');
  gotoxy(1,13);
  write('[');
  gotoxy(62,10);
  write(']');
  gotoxy(62,11);
  write(']');
  gotoxy(62,12);
  write(']');
  gotoxy(62,13);
  write(']');
  for y := 1 to 4 do
   for x := 1 to 60 do
    begin
     gotoxy(x+1, y+9);
     write(Entry[x,y]);
    end;
 end;

procedure SaveEntry;
 var
  Key : char;
  x, y : integer;
 begin
   repeat
    gotoxy(1,15);
    write('Save Entry (Y/N):          ');
    gotoxy(19, 15);
    readln(Key);
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  if Key = 'Y' then
   begin
    assign(SaveFile, 'CRYPTO.TXT');
     repeat
      gotoxy(1,16);
      write('Erase old file (Y/N):          ');
      gotoxy(23, 16);
      readln(Key);
      if Key = 'y' then Key := 'Y';
      if Key = 'n' then Key := 'N';
     until (Key = 'Y') or (Key = 'N');
    gotoxy(1,17);
    write('Saving File...');
    if Key = 'Y' then rewrite(SaveFile) else append(SaveFile);
    for y := 1 to 4 do
     begin
      for x := 1 to 60 do write(SaveFile, Entry[x,y]);
      writeln(SaveFile);
      writeln(SaveFile);
     end;
    writeln(SaveFile, '--------------------------------------------------');
    writeln(SaveFile);
    close(SaveFile);
    gotoxy(1,18);
    write('File saved.');
   end;
 end;

function Done : boolean;
 var
  Key : char;
 begin
   repeat
    gotoxy(1,20);
    write('Quit (Y/N):      ');
    gotoxy(13,20);
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
   clrscr;
   GetEntry;
   ConvertEntry;
   DisplayEntry;
   SaveEntry;
  until Done;
end.