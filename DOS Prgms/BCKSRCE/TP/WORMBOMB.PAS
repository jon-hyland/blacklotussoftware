program WormBomb;

uses
 Crt, Dos;

{$I WORMSCRN.PIK}
{$I TITLESCR.PIK}

const
 ProgramVersion = '1.3';
 DateCompleted  = '1/18/96';

type
 GridScreenType  = array[1..39,1..20] of boolean;
 WormXYType      = array[1..30] of integer;
 DirType         = (Stop, Up, Down, Left, Right);
 PikArrayType    = array[0..3999] of byte;
 UpDateType      = (Lev, Cns, Lvs, Pts, All);
 HighScoreRecord = record
  Name   : string[20];
  Points : integer;
 end;
 HighScoreArray  = array[1..10] of HighScoreRecord;
 HighScoreFile   = file of HighScoreRecord;

var
 Screen     : PikArrayType absolute $B800:0000;
 Dead,
 Done       : boolean;
 Level      : integer;
 Lives      : integer;
 Coin       : GridScreenType;
 Bomb       : GridScreenType;
 NumCoins   : integer;
 NumBombs   : integer;
 WormLength : integer;
 WormX      : WormXYType;
 WormY      : WormXYType;
 WormColor  : integer;
 Key        : char;
 Dir        : DirType;
 Face       : DirType;
 NewBomb    : boolean;
 NewBombX,
 NewBombY   : integer;
 Count      : integer;
 EndX, EndY : integer;
 LevDelay   : integer;
 Quit       : boolean;
 Points     : integer;
 MoveSound  : integer;
 AskedSnd   : boolean;
 Sounds     : boolean;
 EatSound   : integer;
 ShownHS    : boolean;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  move(TitleScr, Screen, 4000);
  textcolor(yellow);
  gotoxy(39,15);
  write(ProgramVersion);
  textcolor(lightred);
  gotoxy(37,16);
  write(DateCompleted);
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  Cursor;
  readkey;
 end;

function Thing(x, y : integer) : boolean;
 var
  j, k : integer;
 begin
  Thing := false;
  if Coin[x,y] then Thing := true;
  if Bomb[x,y] then Thing := true;
  for j := 1 to WormLength do
   if (WormX[j] = x) and (WormY[j] = y) then
    Thing := true;
 end;

procedure GotoGrid(x, y : integer);
 begin
  gotoxy(x*2,y+1);
 end;

procedure GameInit;
 var
  j, k : integer;
 begin
  randomize;
  Dead := false;
  Quit := false;
  AskedSnd := false;
  Level := 1;
  Lives := 3;
  for k := 1 to 20 do
   for j := 1 to 39 do
    Coin[j,k] := false;
  Points := 0;
  ShownHS := false;
 end;

procedure LevelInit;
 var
  j, k : integer;
  x, y : integer;
 begin
  Done := false;
  WormColor := random(15)+1;
  WormLength := 3 + Level;
  NumCoins := 3 + (Level * 3);
  LevDelay := 135 - (Level * 5);
  y := random(20)+1;
  x := random(35-WormLength)+1;
  for j := 1 to WormLength do
   begin
    WormX[j] := x;
    WormY[j] := y;
    x := x + 1;
   end;
  for k := 1 to 20 do
   for j := 1 to 39 do
    begin
     Bomb[j,k] := false;
     Coin[j,k] := false;
    end;
  NumBombs := 0;
  for j := 1 to NumCoins do
   begin
     repeat
      x := random(39)+1;
      y := random(20)+1;
     until not Thing(x,y);
    Coin[x,y] := true;
   end;
  Dir := Stop;
  Face := Left;
  MoveSound := 0;
  EatSound := 0;
 end;

procedure UpDate(UT : UpDateType);
 begin
  textcolor(white);
  if (UT = Lev) or (UT = All) then
   begin
    gotoxy(14,24);
    write('   ');
    gotoxy(14,24);
    write(Level);
   end;
  if (UT = Cns) or (UT = All) then
   begin
    gotoxy(36,24);
    write('   ');
    gotoxy(36,24);
    write(NumCoins);
   end;
  if (UT = Lvs) or (UT = All) then
   begin
    gotoxy(53,24);
    write('  ');
    gotoxy(53,24);
    write(Lives);
   end;
  if (UT = Pts) or (UT = All) then
   begin
    gotoxy(70,24);
    write('      ');
    gotoxy(70,24);
    write(Points);
   end;
  Cursor;
 end;

function AskSounds : boolean;
 var
  x, y : integer;
  Key : char;
 begin
  for x := 28 to 52 do
   begin
    if (x mod 2) = 0 then textcolor(red) else textcolor(lightred);
    gotoxy(x,8);
    write(chr(223));
    if (x mod 2) = 0 then textcolor(lightred) else textcolor(red);
    gotoxy(x,10);
    write(chr(220));
   end;
  textcolor(lightred);
  textbackground(red);
  for y := 8 to 10 do
   begin
    gotoxy(27,y);
    write(chr(223));
    gotoxy(53, y);
    write(chr(223));
   end;
   textcolor(yellow);
   textbackground(black);
   gotoxy(29,9);
   write('Play with sounds? (Y/N)');
   repeat
    Cursor;
    Key := readkey;
    if Key = 'y' then Key := 'Y';
    if Key = 'n' then Key := 'N';
   until (Key = 'Y') or (Key = 'N');
  textcolor(black);
  for y := 8 to 10 do
   for x := 27 to 53 do
    begin
     gotoxy(x, y);
     write(chr(219));
    end;
  Cursor;
  AskSounds := Key = 'Y';
  AskedSnd := true;
 end;

function HSFileExist : boolean;
 begin
  HSFileExist := FSearch('WORMHISC.DAT', '') <> '';
 end;

procedure ResetHSFile;
 var
  HSFile : HighScoreFile;
  HSRec : HighScoreRecord;
  j : integer;
 begin
  assign(HSFile, 'WORMHISC.DAT');
  rewrite(HSFile);
  HSRec.Name := '< Empty >';
  HSRec.Points := 0;
  for j := 1 to 10 do
   write(HSFile, HSRec);
  close(HSFile);
 end;

procedure ShowHighScore;
 var
  HSArr : HighScoreArray;
  HSFile : HighScoreFile;
  j, k : integer;
  Key : char;
 begin
  if not HSFileExist then
   ResetHSFile;
  textbackground(black);
  for j := 21 to 61 do
   begin
    if (j mod 2) = 1 then textcolor(red) else textcolor(lightred);
    gotoxy(j, 4);
    write(chr(223));
    if (j mod 2) = 1 then textcolor(lightred) else textcolor(red);
    gotoxy(j, 17);
    write(chr(220));
   end;
  textcolor(lightred);
  textbackground(red);
  for j := 4 to 17 do
   begin
    gotoxy(20,j);
    write(chr(223));
    gotoxy(62,j);
    write(chr(223));
   end;
  textbackground(black);
  gotoxy(34,5);
  textcolor(red);
  write('- H');
  textcolor(lightred);
  write('ig');
  textcolor(yellow);
  write('h');
  textcolor(white);
  write(' S');
  textcolor(yellow);
  write('co');
  textcolor(lightred);
  write('re');
  textcolor(red);
  write('s -');
  textcolor(white);
  gotoxy(22,6);
  write('Rank  Name                   Points');
  textcolor(lightred);
  for j := 1 to 10 do
   begin
    gotoxy(23,j+6);
    write(j);
    if j < 10 then write(' ');
    write(':');
   end;
  assign(HSFile, 'WORMHISC.DAT');
  reset(HSFile);
  for j := 1 to 10 do
   read(HSFile, HSArr[j]);
  close(HSFile);
  textcolor(yellow);
  for j := 1 to 10 do
   begin
    gotoxy(27,j+6);
    write(HSArr[j].Name);
    gotoxy(52,j+6);
    write(HSArr[j].Points);
   end;
  ShownHS := true;
  Cursor;
  Key := readkey;
  textcolor(black);
  for k := 4 to 17 do
   for j := 20 to 62 do
    begin
     gotoxy(j,k);
     write(chr(219));
    end;
  if (Key = 'c') or (Key = 'C') then
   begin
    ResetHSFile;
    ShowHighScore;
   end;
  Cursor;
 end;

procedure DrawScreen;
 var
  x, y : integer;
 begin
  clrscr;
  move(WormScrn, Screen, 4000);
  if not ShownHS then ShowHighScore;
  if not AskedSnd then Sounds := AskSounds;
  textbackground(cyan);
  textcolor(yellow);
  GotoGrid(WormX[1], WormY[1]);
  write(': ');
  for x := 2 to WormLength do
   begin
    GotoGrid(WormX[x], WormY[x]);
    write('  ');
   end;
  textbackground(black);
  textcolor(lightblue);
  for y := 1 to 20 do
   for x := 1 to 39 do
    if Coin[x,y] then
     begin
      GotoGrid(x,y);
      write(chr(222), chr(221));
     end;
  UpDate(All);
  Cursor;
 end;

procedure DrawEnd;
 var
  x, y : integer;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  Halt(3);
 end;

procedure WormFry;
 var
  j, k : integer;
 begin
  GotoGrid(EndX, EndY);
  write('  ');
  for j := 1 to 10 do
   begin
    if j mod 2 = 0 then
     begin
      textcolor(darkgray);
      if Sounds then
       sound(random(100) + 500);
     end
    else
     begin
      textcolor(yellow);
      if Sounds then
       sound(random(100) + 300);
     end;
    for k := 1 to WormLength do
     begin
      if ((Face = Right) or (Face = Left)) and (k = 1) then
       begin
        if Face = Left then
         begin
          gotoxy(1, WormY[1] + 1);
          write(chr(219));
         end
        else
         begin
          gotoxy(80, WormY[1] + 1);
          write(chr(219));
         end;
       end
      else
       begin
        GotoGrid(WormX[k], WormY[k]);
        write(chr(219), chr(219));
       end;
     end;
    Cursor;
    delay(25);
   end;
  nosound;
  Dead := true;
 end;

procedure WormExplode;
 var
  x, y : integer;
  j, k : integer;
 begin
  x := (WormX[1] * 2) - 3;
  y := WormY[1] - 1;
  textcolor(white);
  gotoxy(x+3,y+2);
  write(chr(219), chr(219));
  textcolor(yellow);
  gotoxy(x+3,y+1);
  write(chr(219), chr(219));
  gotoxy(x+2,y+2);
  write(chr(219));
  gotoxy(x+5,y+2);
  write(chr(219));
  gotoxy(x+3,y+3);
  write(chr(219), chr(219));
  textcolor(lightred);
  gotoxy(x+2,y+1);
  write(chr(219));
  gotoxy(x+5,y+1);
  write(chr(219));
  gotoxy(x+1,y+2);
  write(chr(219));
  gotoxy(x+6,y+2);
  write(chr(219));
  gotoxy(x+2,y+3);
  write(chr(219));
  gotoxy(x+5,y+3);
  write(chr(219));
  textcolor(red);
  gotoxy(x+3,y+0);
  write(chr(219), chr(219));
  gotoxy(x+1,y+1);
  write(chr(219));
  gotoxy(x+6,y+1);
  write(chr(219));
  gotoxy(x+0,y+2);
  write(chr(219));
  gotoxy(x+7,y+2);
  write(chr(219));
  gotoxy(x+1,y+3);
  write(chr(219));
  gotoxy(x+6,y+3);
  write(chr(219));
  gotoxy(x+3,y+4);
  write(chr(219), chr(219));
  Cursor;
  for j := 1 to 150 do
   begin
    if Sounds then
     sound(random(300)+100);
    delay(1);
   end;
  nosound;
  for k := y to y + 4 do
   for j := x to x + 7 do
    begin
     if random(10) = 0 then textbackground(red) else textbackground(black);
     gotoxy(j,k);
     write(' ');
    end;
  textbackground(black);
  Cursor;
  delay(50);
  Dead := true;
 end;

procedure SaveHighScore;
 type
  StringType = string[20];
 var
  HSFile : HighScoreFile;
  HSArr : HighScoreArray;
  j, k : integer;
  Name : string[20];
  Place : integer;
  Blank : boolean;

 function GetName : StringType;
  var
   Name : string[20];
   x : integer;
   Key : char;
  begin
   for x := 1 to 20 do
    Name[x] := ' ';
   textcolor(white);
   gotoxy(40,9);
   write('[                    ]');
   gotoxy(41,9);
   x := 1;
    repeat
     Key := readkey;
     x := x + 1;
      case Key of
       #8 :
        begin
         x := x - 2;
         if x < 1 then x := 1;
         gotoxy(x+40,9);
         write(' ');
        end;
       #0 :
        begin
         Key := readkey;
         Key := ' ';
         x := x - 1;
         if x < 1 then x := 1;
         gotoxy(x+40,9);
        end;
      end; {case}
     if x > 1 then
      begin
       gotoxy(x+39, 9);
       write(Key);
      end;
     gotoxy(x+40, 9);
     if ((ord(Key) >= 32) and (ord(Key) <= 126)) then
      Name[x-1] := Key;
     if x > 20 then Key := chr(13);
    until ord(Key) = 13;
   Blank := true;
   for x := 1 to 20 do
    if Name[x] <> ' ' then
     Blank := false;
   if Blank then Name := '< No Name >         ';
   GetName := Name;
  end;

 begin
  assign(HSFile, 'WORMHISC.DAT');
  reset(HSFile);
  for j := 1 to 10 do
   read(HSFile, HSArr[j]);
  close(HSFile);
  Place := 0;
  for j := 1 to 10 do
   if Place = 0 then
    if Points > HSArr[j].Points then
     Place := j;
  if Place <> 0 then
   begin
    for k := 6 to 10 do
     for j := 17 to 65 do
      begin
       gotoxy(j,k);
       write(' ');
      end;
    for j := 18 to 64 do
     begin
      gotoxy(j,6);
      if (j mod 2) = 0 then textcolor(red) else textcolor(lightred);
      write(chr(223));
      gotoxy(j,10);
      if (j mod 2) = 0 then textcolor(lightred) else textcolor(red);
      write(chr(220));
     end;
    textcolor(lightred);
    textbackground(red);
    for k := 6 to 10 do
     begin
      gotoxy(17,k);
      write(chr(223));
      gotoxy(65,k);
      write(chr(223));
     end;
    textcolor(yellow);
    textbackground(black);
    gotoxy(23,7);
    write('You made it to the High Score List!');
    gotoxy(20,9);
    write('What is your name :');
    Name := GetName;
    for j := 10 downto Place + 1 do
     HSArr[j] := HSArr[j-1];
    HSArr[Place].Name := Name;
    HSArr[Place].Points := Points;
    reset(HSFile);
    for j := 1 to 10 do
     write(HSFile, HSArr[j]);
    close(HSFile);
   end;
  Cursor;
 end;

procedure DrawWin;
 var
  x : integer;
  c : char;
 begin
  for x := 26 to 55 do
   begin
     case x of
      26, 49 :
       begin
        textcolor(red);
        textbackground(black);
       end;
      34 :
       begin
        textcolor(lightred);
        textbackground(red);
       end;
     end; {case}
     case x of
      26, 34, 46, 54 : c := chr(176);
      28, 36, 44, 52 : c := chr(177);
      30, 38, 42, 50 : c := chr(178);
      32, 40, 48     : c := chr(219);
     end; {case}
    gotoxy(x, 9);
    write(c);
    gotoxy(x, 11);
    write(c);
   end;
  gotoxy(26, 10);
  write(chr(176), chr(176));
  gotoxy(54, 10);
  write(chr(176), chr(176));
  textcolor(yellow);
  gotoxy(28,10);
  write('   You Win! - Game Over   ');
  Cursor;
  for x := 1 to 8 do
   begin
    sound(x*100);
    delay(100);
   end;
  nosound;
  readkey;
 end;

begin
 Title;
 GameInit;
  repeat
   LevelInit;
   DrawScreen;
    repeat
     if KeyPressed then
      begin
       Key := readkey;
        case ord(Key) of 27 : Quit := true end;
        case Key of #0 :
         begin
          Key := readkey;
           case ord(Key) of
            72 : Dir := Up;
            75 : Dir := Left;
            80 : Dir := Down;
            77 : Dir := Right;
           end; {case}
          if ((Dir = Right) and (Face = Left)) or
             ((Dir = Left) and (Face = Right)) or
             ((Dir = Up) and (Face = Down)) or
             ((Dir = Down) and (Face = Up))
           then Dir := Stop;
          if Dir <> Stop then Face := Dir;
         end;
        end; {case}
      end;
     if Dir <> Stop then
      begin
       if random(10)+1 = 1 then NewBomb := true else NewBomb := false;
       if NewBomb then
        begin
         NewBombX := WormX[WormLength];
         NewBombY := WormY[WormLength];
        end;
       EndX := WormX[WormLength];
       EndY := WormY[WormLength];
       for Count := WormLength downto 2 do
        begin
         WormX[Count] := WormX[Count - 1];
         WormY[Count] := WormY[Count - 1];
        end;
        case Dir of
         Up    : WormY[1] := WormY[1] - 1;
         Down  : WormY[1] := WormY[1] + 1;
         Left  : WormX[1] := WormX[1] - 1;
         Right : WormX[1] := WormX[1] + 1;
        end; {case}
       if Coin[WormX[1], WormY[1]] then
        begin
         Coin[WormX[1], WormY[1]] := false;
         NumCoins := NumCoins - 1;
         UpDate(Cns);
         if Sounds then
          EatSound := 2;
         Points := Points + 10;
         UpDate(Pts);
         if NumCoins <= 0 then
          Done := true;
        end;
       if (WormX[1] < 1) or (WormX[1] > 39) or
        (WormY[1] < 1) or (WormY[1] > 20) then WormFry;
       if Bomb[WormX[1], WormY[1]] then WormExplode;
       if not Dead then
        begin
         GotoGrid(EndX, EndY);
         write('  ');
         textcolor(cyan);
         textbackground(black);
         for Count := WormLength downto 2 do
          begin
           GotoGrid(WormX[Count], WormY[Count]);
           write(chr(219), chr(219));
          end;
         textcolor(yellow);
         textbackground(cyan);
         GotoGrid(WormX[1], WormY[1]);
         if Face = Left then   write(': ');
         if Face = Right then  write(' :');
         if (Face = Up) or (Face = Down) then write(chr(250), chr(250));
         textcolor(white);
         textbackground(black);
         Cursor;
         if Sounds then
          begin
           if EatSound = 2 then
            sound(200);
           if EatSound = 1 then
            sound(400);
           if EatSound = 0 then
            if (MoveSound mod 2) = 0 then
             sound(150)
            else
             sound(100);
          end;
         if EatSound <= 0 then delay(15) else delay(30);
         nosound;
         MoveSound := MoveSound + 1;
         if EatSound > 0 then
          EatSound := EatSound - 1;
         if EatSound <= 0 then delay(LevDelay) else Delay(LevDelay - 15);
        end;
       if NewBomb and not Bomb[NewBombX, NewBombY] then
        begin
         Bomb[NewBombX, NewBombY] := true;
         GotoGrid(NewBombX, NewBombY);
         textcolor(magenta);
         write('{}');
         NumBombs := NumBombs + 1;
         Cursor;
        end;
      end;
    until Dead or Done or Quit;                    {Level Over}
   if (not Dead) and (not Quit) {finished level} then
    begin
     if (NumCoins * 2) - NumBombs + (Level * 10)> 0 then
      Points := Points + (NumCoins * 3) - NumBombs + (Level * 10);
     if Level < 26 then
      Level := Level + 1;
     for Count := 1 to 25 do
      begin
       if Sounds then
        sound(Count*10);
       delay(5);
      end;
     nosound;
    end;
   if Dead then
    begin
     Lives := Lives - 1;
     Dead := false;
    end;
   if Quit then
    begin
     for Count := 25 downto 1 do
      begin
       if Sounds then
        sound(Count*10);
       delay(10);
      end;
     nosound;
    end;
  until (Lives <= 0) or (Level > 25) or Quit;      {Game Over}
 if (Level > 25) and (not Dead) then    {Finished Game}
  DrawWin;
 if Dead then
  readkey;
 if not Quit then
  SaveHighScore;
 DrawEnd;
end.