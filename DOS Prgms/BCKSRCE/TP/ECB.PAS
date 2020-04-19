program ElectricCheckbook;

uses
 Crt;

type
 EntryRecord = record
  EntryNum : integer;
  CheckNum : integer;
  Date : real;
  Desc : string[50];
  Trans : real;
  Balance : real;
 EntryFile = file of EntryRecord;

var
 CBFile : EntryFile;
 Entry : EntryRecord;
 Total : integer;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(25,10);
  write('- Electric Checkbook  v1.0 -');
  gotoxy(24,12);
  write('(c) 1996 BlackWolf Productions');
  Cursor;
  readkey;
 end;

procedure Init;
 begin
  assign(CBFile, 'ECB.DAT');
  reset(CBFile);
  Total := 0;
   repeat
    readln(CBFile, Entry);
    Total := Total + 1;
   until Eof(CBFile);


