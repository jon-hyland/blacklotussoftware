program Test;

uses
 Crt, Dos;

type
 array1 = array[1..60, 1..15] of Char;

var
 Entry : array1;
 x,y : integer;
 j,k : integer;
 DatFile : text;
 Date : string[8];
 AskDate : string[8];

procedure ClearEntry;
 begin
  for j := 1 to 15 do
   begin
    for k := 1 to 60 do Entry[k,j] := ' ';
   end;
 end;

procedure LoadEntry(EntName : string);
 var
  RightEntry : boolean;
  Lab : string[5];
  Dte : string[8];
 begin
  assign(DatFile, 'JRNL.DAT');
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
   end else
   begin
    sound(200);
    delay(100);
    nosound;
   end;
  Close(DatFile);
 end;

procedure ShowEntry;
 begin
  clrscr;
  for y := 1 to 15 do
   begin
    for x := 1 to 60 do
     begin
      gotoxy(x,y);
      write(Entry[x,y]);
     end;
   end;
  sound(200);
  delay(100);
  nosound;
  readkey;
 end;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 ClearEntry;
 write('Date: ');
 readln(AskDate);
 LoadEntry(AskDate);
 ShowEntry;
end.
