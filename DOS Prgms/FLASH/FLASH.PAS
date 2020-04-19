program Flash;

uses
 Crt;

{$I FLSHPLAY.PIK}

type
 array1 = array[1..25] of integer;
 array2 = array [1..3999] of byte;

var
 OrigMode : word;
 Blink : array1;
 Screen : array2 absolute $B800:0000;
 cx, cy : integer;
 j, k, x, y : integer;
 Key : char;
 Level : integer;
 Times : integer;
 Tms : integer;
 Lose : boolean;
 QuitGame : boolean;
 Ky : char;

procedure Init;
 begin
  randomize;
  OrigMode := LastMode;
  textcolor(white);
  textbackground(black);
 end;

procedure Clear;
 begin
  textbackground(black);
  clrscr;
  textcolor(black);
  write(' ');
  gotoxy(1,1);
  textcolor(white);
 end;

procedure Cursor;
 begin
  cx := wherex;
  cy := wherey;
  gotoxy(1,1);
 end;

procedure CursorBack;
 begin
  gotoxy(cx, cy);
 end;

procedure Title;
 begin
  Clear;
  gotoxy(36,8);
  write('- Flash -');
  gotoxy(39,10);
  write('v1.0');
  gotoxy(36, 12);
  write('Jon Hyland');
  readkey;
 end;

procedure DrawPlayScreen;
 begin
  Clear;
  Move(FlshPlay, Screen, 4000);
  Cursor;
 end;

procedure UpdateScreen;
 begin
  textcolor(yellow);
  gotoxy(61,19);
  if Level < 10 then write('0');
  write(Level);
  gotoxy(61,22);
  if Times < 10 then write('0');
  if Times < 100 then write('0');
  write(Times);
  Cursor;
 end;

procedure Show(Num : integer);
 var
  Hz : integer;
  Color : integer;
  sj, sk, sx, sy : integer;
 begin
  if Num = 1 then
   begin
    Color := 4;
    Hz := 400;
    sx := 33;
    sy := 5;
   end;
  if Num = 2 then
   begin
    Color := 1;
    Hz := 300;
    sx := 21;
    sy := 10;
   end;
  if Num = 3 then
   begin
    Color := 2;
    Hz := 100;
    sx := 33;
    sy := 15;
   end;
  if Num = 4 then
   begin
    Color := 5;
    Hz := 200;
    sx := 45;
    sy := 10;
   end;
  textcolor(Color+8);
  for sk := 0 to 3 do
   begin
    for sj := 0 to 9 do
     begin
      gotoxy(sx+sj, sy+sk);
      write(chr(219));
     end;
   end;
  Cursor;
  sound(Hz);
  delay(300);
  nosound;
  textcolor(Color);
  for sk := 0 to 3 do
   begin
    for sj := 0 to 9 do
     begin
      gotoxy(sx+sj, sy+sk);
      write(chr(219));
     end;
   end;
  Cursor;
 end;

procedure ShowLose;
 begin
  Times := Times - 1;
  UpdateScreen;
  textcolor(4+8);
  for k := 0 to 3 do
   begin
    gotoxy(33, k+5);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(1+8);
  for k := 0 to 3 do
   begin
    gotoxy(21, k+10);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(2+8);
  for k := 0 to 3 do
   begin
    gotoxy(33, k+15);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(5+8);
  for k := 0 to 3 do
   begin
    gotoxy(45, k+10);
    for j := 1 to 10 do write(chr(219));
   end;
  Cursor;
  for j := 1 to 5 do
   begin
    sound(750);
    delay(100);
    sound(500);
    delay(100);
   end;
  nosound;
  textcolor(4);
  for k := 0 to 3 do
   begin
    gotoxy(33, k+5);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(1);
  for k := 0 to 3 do
   begin
    gotoxy(21, k+10);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(2);
  for k := 0 to 3 do
   begin
    gotoxy(33, k+15);
    for j := 1 to 10 do write(chr(219));
   end;
  textcolor(5);
  for k := 0 to 3 do
   begin
    gotoxy(45, k+10);
    for j := 1 to 10 do write(chr(219));
   end;
  Cursor;
 end;

procedure ShowWin;
 begin
 end;

procedure DoEnd;
 begin
  TextMode(OrigMode);
  clrscr;
  writeln('Play again soon.');
  writeln;
  halt(3);
 end;

begin
 Init;
 Title;
 DrawPlayScreen;
  repeat
   Level := 1;
   Times := 0;
   Tms := 0;
   Lose := false;
   QuitGame := false;
   UpdateScreen;
   textcolor(yellow);
   gotoxy(25,23);
   write('Remember Pattern');
   Cursor;
   delay(1000);
    repeat
     textcolor(yellow);
     gotoxy(25,23);
     write('Remember Pattern');
     Cursor;
     for j := 1 to 25 do Blink[j] := 0;         {clears mem}
     for j := 1 to Level do Blink[j] := random(4)+1;   {rand blinks}
     for j := 1 to Level do
      begin
       Show(Blink[j]);
       delay(150);
      end;
     textcolor(yellow);
     gotoxy(25,23);
     write(' Repeat Pattern ');
     Cursor;
     j := 1;
      repeat
       k := 0;
        repeat
         Key := readkey;
	 if ord(Key) = 27 then QuitGame := true;
         case Key of
          #0:
           begin
            Key := readkey;
             case Key of
              #72: k := 1;
              #75: k := 2;
              #80: k := 3;
              #77: k := 4;
             end;
           end;
         end;
        until ((k <> 0) or (QuitGame));   {until hit arrow or esc}
       if not QuitGame then
				begin
				 Show(k);
				 if k <> Blink[j] then Lose := true;
				 j := j + 1;
				end;
			until ((j > Level) or (Lose) or (QuitGame));
		 if not QuitGame then
			begin
			 Times := Times + 1;
			 Tms := Tms + 1;
			 if Tms > 3 then
				begin
				 Tms := 1;
				 Level := Level + 1;
				end;
			 UpdateScreen;
			 if ((not Lose) and (not QuitGame)) then delay(750);
			end;
		 if not Lose then
			begin
			 gotoxy(26,23);
			 write('              ');
			 Cursor;
			end;
		until ((Lose) or (Level > 25) or (QuitGame));
	 if Lose then ShowLose;
	 if not Lose and not QuitGame then ShowWin;
	 if not QuitGame then
		begin
		 gotoxy(22,23);
		 textcolor(yellow);
		 write('Hit (Enter) to Continue');
		 Cursor;
			repeat
			 Key := readkey;
			until (ord(Key) = 13) or (ord(Key) = 27);
		 if ord(key) = 27 then QuitGame := true;
		 gotoxy(22,23);
		 write('                       ');
		end;
	until QuitGame;
 DoEnd;
end.