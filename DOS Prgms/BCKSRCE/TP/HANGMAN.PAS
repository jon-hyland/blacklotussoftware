program HangMan;

uses
 Crt;

var
 WordFile : text;
 HWord : string;
 Used : array[1..26] of boolean;
 Tries : integer;
 Wrong : integer;
 Right : integer;
 Done : boolean;
 Quit : boolean;
 Key : char;
 j : integer;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(31,10);
  write('- HangMan  v1.0 -');
  gotoxy(24,12);
  write('(c) 1996 BlackWolf Productions');
  Cursor;
  readkey;
 end;

procedure Init;
 begin
  randomize;
  Done := false;
 end;

function TotWords : integer;
 var
  Words : integer;
 begin
  Words := 0;
  assign(WordFile, 'HANGMAN.DAT');
  reset(WordFile);
   repeat
    readln(WordFile);
    Words := Words + 1;
   until Eof(WordFile);
  close(WordFile);
  TotWords := Words;
 end;

procedure LevelInit;
 var
  Rand : integer;
  j : integer;
 begin
  for j := 1 to 26 do
   Used[j] := false;
  Done := false;
  Rand := random(TotWords) + 1;
  assign(WordFile, 'HANGMAN.DAT');
  reset(WordFile);
  for j := 1 to Rand-1 do
   readln(WordFile);
  readln(WordFile, HWord);
  close(WordFile);
  Tries := 0;
  Wrong := 0;
  Right := 0;
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(37,6);
  write(#218, #196, #196, #191);
  for j := 7 to 9 do
   begin
    gotoxy(37,j);
    write(chr(179));
   end;
  gotoxy(36, 10);
  write(#196, #193, #196, #196, #196, #196, #196);
  gotoxy(27,14);
  write('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  gotoxy(39 - trunc(length(HWord) / 2), 12);
  for j := 1 to length(HWord) do
   write('*');
  gotoxy(35,16);
  write('Wrong : 0');
  Cursor;
 end;

function GetKey : char;
 var
  Key : char;
 begin
   repeat
    Key := readkey;
    if Key in ['a'..'z'] then
     Key := upcase(Key);
   until ((Key in ['A'..'Z']) and (Used[ord(Key) - 64] = false))
         or (Key = #27);
  if Key = #27 then Quit := true else
   begin
    gotoxy(ord(Key) - 38, 14);
    write(' ');
    Used[ord(Key) - 64] := true;
   end;
  GetKey := Key;
  Cursor;
 end;

function GoodLett : boolean;
 var
  j : integer;
  Good : boolean;
 begin
  Good := false;
  for j := 1 to length(HWord) do
   if HWord[j] = Key then
    Good := true;
  GoodLett := Good;
 end;

procedure UpdateWord;
 var
  j : integer;
 begin
  for j := 1 to length(HWord) do
   if HWord[j] = Key then
    begin
     Right := Right + 1;
     gotoxy(38 - trunc(length(HWord) / 2) + j, 12);
     write(Key);
    end;
  Cursor;
 end;

procedure DrawMan;
 begin
   case Wrong of
    1 :
     begin
      gotoxy(40,7);
      write('O');
     end;
    2 :
     begin
      gotoxy(40,8);
      write(#179);
     end;
    3 :
     begin
      gotoxy(39,8);
      write(#196);
     end;
    4 :
     begin
      gotoxy(41,8);
      write(#196);
     end;
    5 :
     begin
      gotoxy(38, 8);
      write('o');
     end;
    6 :
     begin
      gotoxy(42,8);
      write('o');
     end;
    7 :
     begin
      gotoxy(39,9);
      write('/');
     end;
    8 :
     begin
      gotoxy(41,9);
      write('\');
     end;
    9 :
     begin
      gotoxy(38,9);
      write('o');
     end;
    10 :
     begin
      gotoxy(42,9);
      write('o');
     end;
   end; {case}
  Cursor;
 end;

procedure GoodSound;
 begin
  sound(200);
  delay(50);
  sound(300);
  delay(50);
  nosound;
 end;

procedure BadSound;
 begin
  sound(100);
  delay(200);
  nosound;
 end;

begin
 Title;
 Init;
 repeat
  LevelInit;
   repeat
    Key := GetKey;
    if GoodLett then
     begin
      UpdateWord;
      GoodSound;
     end
    else
     begin
      Wrong := Wrong + 1;
      gotoxy(43,16);
      write(Wrong);
      Cursor;
      DrawMan;
      if not Quit then BadSound;
     end;
    if Right >= length(HWord) then
     begin
      for j := 2 to 5 do
       begin
        sound(j*100);
        delay(10);
       end;
      for j := 4 downto 2 do
       begin
        sound(j*100);
        delay(10);
       end;
      nosound;
      readkey;
      Done := true;
     end;
    if Wrong >= 10 then
     begin
      for j := 1 to 20 do
       begin
        sound(random(500)+1);
        delay(10+random(20));
       end;
      nosound;
      Done := true;
      readkey;
     end;
   until Done or Quit;
 until Quit;
end.