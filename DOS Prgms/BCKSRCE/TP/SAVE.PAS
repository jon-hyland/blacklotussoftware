program Test;

uses
 Crt, Dos;

type
 array1 = array[1..60, 1..15] of Char;

var
 Entry : array1;
 x, y : integer;
 j, k : integer;
 AskDate : string[8];
 DatFile : text;
 Date : string[8];

procedure ClearEntry;
 begin
  for j := 1 to 15 do
   begin
    for k := 1 to 60 do Entry[k,j] := ' ';
   end;
 end;

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

procedure SaveNewEntry(EntName : string);
 var
  LineChars : integer;
 begin
  assign(DatFile, 'JRNLX.DAT');
  append(DatFile);
  writeln(DatFile, ConCat('JRNL ', EntName));
  for k := 1 to 15 do
   begin
    LineChars := EofLineNum(k);
    for j := 1 to 60 do
     begin
      if j <= LineChars then write(DatFile, Entry[j, k]);
      if j <= LineChars then write(Entry[j, k]);
     end;
    writeln(DatFile);
    writeln;
   end;
  close(DatFile);
 end;

procedure SaveEntry(EntName : string);
 var
  EntryExist : boolean;
  FoundHead : boolean;
  Head : string[5];
  dte : string[8];
 begin
  assign(DatFile, 'JRNL.DAT');
  append(DatFile);
  EntryExist := false;
   repeat
     repeat
      FoundHead := false;
      read(DatFile, Head);
      if Head <> 'JRNL ' then readln(DatFile);
     until ((Eof(DatFile) = true) or (FoundHead = true));
    if FoundHead = true then
     begin
      readln(DatFile, dte);
      if dte = EntName then EntryExist := true;
     end;
   until ((EntryExist = true) or (Eof(DatFile) = true));
  if EntryExist = true then
   begin
    for k := 1 to 15 do
     begin
      for j := 1 to 60 do
       begin
        if j <= EofLineNum(k) then write(DatFile, Entry[j,k]);
       end;
      readln(DatFile);
     end;
   end else
   begin
    writeln(DatFile);
    writeln(DatFile, ConCat('JRNL ', SaveDate));
    for k := 1 to 15 do
     begin
      for j := 1 to 60 do
       begin
        if j <= EofLineNum(k) then write(DatFile, Entry[j,k]);
       end;
      readln(DatFile);
     end;
   end;
  Close(DatFile);
 end;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 ClearEntry;
 write('Date: ');
 readln(AskDate);
 LoadEntry(AskDate);
 SaveNewEntry('01/01/01');
end.
