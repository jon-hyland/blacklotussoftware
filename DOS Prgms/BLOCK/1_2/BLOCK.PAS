{   --==Block Cruncher==--
 (c) 1997 Black Lotus Software
 This version completed 4/20/97.
 All programming by Jon Hyland.

 Source code requires routines from library STD.PAS to compile.
 All external functions (c) 1994-1997 Black Lotus Software.
 This program will create BLOCK.HS for high score list.
 Written and compiled using Borland Turbo Pascal v7.0.

 Use or possession of this source code is prohibitted unless
 direct permission is granted by author. }

program BlockCruncher;

uses
 Crt, Std, Dos;

const
 VerNum = '1.2';

type
 AreaType = record
   Obj   : array[1..10, 1..20] of boolean;
   Color : array[1..10, 1..20] of integer;
  end;
 BlockType = record
   Obj   : array[1..4, 1..4] of boolean;
   Color : array[1..4, 1..4] of integer;
   XMax, YMax : integer;
  end;
 HSType = array[1..10] of record
   Name   : string[17];
   Points : integer;
  end;

var
 HSFile   : file of HSType;
 BlockRec : array[1..7] of BlockType;
 Area     : AreaType;
 Block    : BlockType;
 Next     : BlockType;
 BX, BY   : integer;
 Loose    : boolean;
 Key      : char;
 Points   : integer;
 Speed    : integer;
 Dead     : boolean;
 Del      : integer;
 DelTot   : integer;
 j, k     : integer;
 SpeedS   : string;
 Step     : boolean;
 NB       : boolean;
 First    : boolean;
 Ch       : char;
 NewHS    : integer;
 SndOn    : boolean;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  Clear;
  textcolor(darkgray);
  textbackground(black);
  gotoxy(40,25);
  write('(c) 1997 Black Lotus Software');
  DrawWindow(10,2,70,23,1,'Block Cruncher');
  textcolor(darkgray);
  textbackground(blue);
  for k := 3 to 22 do
   begin
    gotoxy(28,k);
    write(#177, #178);
    gotoxy(50,k);
    write(#178, #177);
   end;
  textcolor(white);
  textbackground(black);
  for k := 4 to 7 do
   for j := 15 to 22 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(white);
  textbackground(blue);
  gotoxy(14,8);
  write('Next Piece');
  gotoxy(55,4);
  write('Right - Hmm..');
  gotoxy(55,5);
  write('Left - Uhh..');
  gotoxy(55,6);
  write('Up - Rotate');
  gotoxy(55,7);
  write('Down - Drop');
  gotoxy(55,9);
  write('P - Pause');
  gotoxy(55,10);
  write('N - New Game');
  gotoxy(55,11);
  write('S - Speed');
  gotoxy(55,12);
  write('D - Step/Drop');
  gotoxy(55,13);
  write('T - Next Piece');
  gotoxy(55,14);
  write('L - High Score');
  gotoxy(61,15);
  write('List');
  gotoxy(55,16);
  write('R - Reset High');
  gotoxy(60,17);
  write('Scores');
  gotoxy(55,18);
  write('E - Sound Eff.');
  gotoxy(55,19);
  write('H - Help/Docs');
  gotoxy(55,21);
  write('Esc - Quit');
  gotoxy(12,19);
  write('Speed : ');
  gotoxy(12,21);
  write('Points : ');
  textcolor(black);
  for k := 3 to 22 do
   for j := 30 to 49 do
    begin
     gotoxy(j,k);
     write(#219);
    end;
  Cursor;
 end;

procedure ResetHighScore;
 var
  x    : integer;
  Temp : HSType;
 begin
  rewrite(HSFile);
  for x := 1 to 10 do
   begin
    Temp[x].Name := '[EMPTY]';
    Temp[x].Points := 11-x;
   end;
  write(HSFile, Temp);
  close(HSFile);
 end;

procedure DrawTitle;
 begin
  DrawWindow(30,8,47,15,4,'Info');
  textcolor(yellow);
  gotoxy(32,9);
  write('Block Cruncher');
  gotoxy(37,10);
  write('v', VerNum);
  gotoxy(32,12);
  write('All coding and');
  gotoxy(33,13);
  write('graphics  by');
  gotoxy(34,14);
  write('Jon Hyland');
  Cursor;
  ClearBuffer;
  readkey;
  EraseWindow(30,9,47,4);
 end;

procedure MakeBlocks;
 var
  i, j, k  : integer;
  Color    : integer;
 begin
  for i := 1 to 7 do
   for k := 1 to 4 do
    for j := 1 to 4 do
     begin
      BlockRec[i].Color[j,k] := 0;
      BlockRec[i].Obj[j,k] := false;
     end;
  BlockRec[1].XMax := 4;
  BlockRec[1].YMax := 1;
  for j := 1 to 4 do
   BlockRec[1].Obj[j,1] := true;
  BlockRec[2].XMax := 2;
  BlockRec[2].YMax := 2;
  for k := 1 to 2 do
   for j := 1 to 2 do
    BlockRec[2].Obj[j,k] := true;
  BlockRec[3].XMax := 3;
  BlockRec[3].YMax := 2;
  BlockRec[3].Obj[2,1] := true;
  for j := 1 to 3 do
   BlockRec[3].Obj[j,2] := true;
  BlockRec[4].XMax := 3;
  BlockRec[4].YMax := 2;
  for j := 1 to 3 do
   BlockRec[4].Obj[j,1] := true;
  BlockRec[4].Obj[3,2] := true;
  BlockRec[5].XMax := 3;
  BlockRec[5].YMax := 2;
  for j := 1 to 3 do
   BlockRec[5].Obj[j,1] := true;
  BlockRec[5].Obj[1,2] := true;
  BlockRec[6].XMax := 3;
  BlockRec[6].YMax := 2;
  for j := 1 to 2 do
   begin
    BlockRec[6].Obj[j,1] := true;
    BlockRec[6].Obj[j+1,2] := true;
   end;
  BlockRec[7].XMax := 3;
  BlockRec[7].YMax := 2;
  for j := 1 to 2 do
   begin
    BlockRec[7].Obj[j+1,1] := true;
    BlockRec[7].Obj[j,2] := true;
   end;
  for i := 1 to 7 do
   begin
     case i of
      1 : Color := 12;
      2 : Color := 11;
      3 : Color := 7;
      4 : Color := 13;
      5 : Color := 14;
      6 : Color := 10;
      7 : Color := 9;
     end; {case}
    for k := 1 to BlockRec[i].YMax do
     for j := 1 to BlockRec[i].XMax do
      if BlockRec[i].Obj[j,k] then
       BlockRec[i].Color[j,k] := Color;
   end;
 end;

procedure Init;
 var
  Path : DirStr;
 begin
  randomize;
  assign(HSFile, 'BLOCK.HS');
  Path := fsearch('BLOCK.HS',GetEnv('PATH'));
  NB := false;
  Step := false;
  SndOn := true;
  if Path = '' then ResetHighScore;
  MakeBlocks;
  DrawScreen;
  DrawTitle;
 end;

procedure GameReset;
 var
  j, k : integer;
 begin
  Points := 0;
  Speed := 1;
  Dead := false;
  Loose := false;
  First := true;
  for k := 1 to 20 do
   for j := 1 to 10 do
    begin
     Area.Obj[j,k] := false;
     Area.Color[j,k] := 0;
    end;
  textcolor(white);
  textbackground(black);
  for k := 3 to 22 do
   for j := 30 to 49 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  textcolor(yellow);
  textbackground(blue);
  gotoxy(18,14);
  write('    ');
  gotoxy(18,20);
  write('   ');
  gotoxy(21,21);
  write(Points);
  gotoxy(20,19);
  write(Speed);
  Cursor;
 end;

procedure FlipBlock;
 var
  New   : BlockType;
  j, k  : integer;
 begin
  for k := 1 to 4 do
   for j := 1 to 4 do
    begin
     New.Obj[j,k] := false;
     New.Color[j,k] := 0;
    end;
  New.XMax := Block.YMax;
  New.YMax := Block.XMax;
  for k := 1 to New.YMax do
   for j := 1 to New.XMax do
    begin
     New.Obj[j,k] := Block.Obj[New.YMax-k+1, j];
     New.Color[j,k] := Block.Color[New.YMax-k+1, j];
    end;
  Block := New;
 end;

procedure DrawBlock;
 var
  j, k : integer;
 begin
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     begin
      gotoxy(((BX+(j-1))*2)+28, BY+(k-1)+2);
      textcolor(Block.Color[j,k]);
      write(#219, #219);
     end;
  Cursor;
 end;

procedure EraseBlock;
 var
  j, k : integer;
 begin
  textcolor(black);
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     begin
      gotoxy(((BX+(j-1))*2)+28, BY+(k-1)+2);
      write(#219, #219);
     end;
  Cursor;
 end;

procedure DrawArea;
 var
  j, k : integer;
 begin
  for k := 1 to 20 do
   begin
    gotoxy(30,k+2);
    for j := 1 to 10 do
     begin
      textcolor(Area.Color[j,k]);
      write(#219, #219);
     end;
    Cursor;
   end;
 end;

procedure DrawNext;
 var
  j, k : integer;
 begin
  for k := 1 to 4 do
   for j := 1 to 4 do
    begin
     textcolor(Next.Color[j,k]);
     gotoxy(13+(j*2), k+3);
     write(#219, #219);
    end;
  Cursor;
 end;

procedure NewBlock;
 var
  Num  : integer;
  j, k : integer;
 begin
  if First then
   begin
    Next := BlockRec[random(7)+1];
    First := false;
   end;
  Block := Next;
  Num := random(7)+1;
  Next := BlockRec[Num];
  BX := 5 - trunc(Block.XMax/2);
  BY := 1;
  DrawBlock;
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     if Area.Obj[BX+(j-1), BY+(k-1)] then Dead := true;
  if NB then DrawNext;
 end;

procedure WaitTimeKey;
 begin
   case Speed of
    1  : DelTot := 75;
    2  : DelTot := 55;
    3  : DelTot := 40;
    4  : DelTot := 32;
    5  : DelTot := 23;
    6  : DelTot := 18;
    7  : DelTot := 13;
    8  : DelTot := 9;
    9  : DelTot := 7;
    10 : DelTot := 5;
   end; {case}
  while (Del > 0) and (not KeyPressed) do
   begin
    delay(10);
    Del := Del - 1;
   end;
  if Del <= 0 then Del := DelTot;
 end;

function IsLoose : boolean;
 var
  L    : boolean;
  j, k : integer;
 begin
  L := true;
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     if Area.Obj[BX+(j-1), BY+(k-1)+1] then
      L := false;
  if BY >= (20-(Block.YMax-1)) then L := false;
  IsLoose := L;
  if SndOn then
   if not L then
    begin
     sound(100);
     delay(1);
     nosound;
    end;
 end;

function BadMove : boolean;
 var
  B    : boolean;
  j, k : integer;
 begin
  B := false;
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     if Area.Obj[BX+(j-1), BY+(k-1)] then
      B := true;
  if BY > (20-(Block.YMax-1)) then B := true;
  if BX > (10-(Block.XMax-1)) then B := true;
  BadMove := B;
 end;

procedure Block2Area;
 var
  j, k : integer;
 begin
  for k := 1 to Block.YMax do
   for j := 1 to Block.XMax do
    if Block.Obj[j,k] then
     begin
      Area.Obj[BX+(j-1), BY+(k-1)] := Block.Obj[j,k];
      Area.Color[BX+(j-1), BY+(k-1)] := Block.Color[j,k];
     end;
 end;

procedure LineCheck;
 var
  i, j, k  : integer;
  Solid    : boolean;
  Times    : integer;
  NewSp    : integer;
 begin
  Times := 0;
  for k := 1 to 20 do
   begin
    Solid := true;
    for j := 1 to 10 do
     if not Area.Obj[j,k] then
      Solid := false;
    if Solid then
     begin
      Times := Times + 1;
      for i := k downto 2 do
       for j := 1 to 10 do
        begin
         Area.Obj[j,i] := Area.Obj[j,i-1];
         Area.Color[j,i] := Area.Color[j,i-1];
        end;
      for j := 1 to 10 do
       begin
        Area.Color[j,1] := 0;
        Area.Obj[j,1] := false;
       end;
     end;
   end;
  if NB then
   Points := Points + trunc((Times*(Speed/3)*10)/2)
  else
   Points := Points + trunc(Times*(Speed/3)*10);
   case Points of
    0..50      : NewSp := 1;
    51..100     : NewSp := 2;
    101..250    : NewSp := 3;
    251..500   : NewSp := 4;
    501..750   : NewSp := 5;
    750..1200   : NewSp := 6;
    1201..2000  : NewSp := 7;
    2001..3500 : NewSp := 8;
    3501..5000 : NewSp := 9;
   else
    NewSp := 10;
   end; {case}
  textcolor(yellow);
  textbackground(blue);
  if NewSp > Speed then
   begin
    Speed := NewSp;
    gotoxy(20,19);
    write('   ');
    gotoxy(20,19);
    write(Speed);
   end;
  gotoxy(21,21);
  write('     ');
  gotoxy(21,21);
  write(Points);
  Cursor;
  if (Times > 0) then
   begin
    for j := 1 to Times*5 do
     begin
      if SndOn then sound(random(250));
      delay(5);
     end;
    nosound;
    DrawArea;
   end;
 end;

procedure CheckHighScore;
 var
  HS   : HSType;
  x, y : integer;
  Name : string;
  New  : boolean;
 begin
  reset(HSFile);
  read(HSFile, HS);
  close(HSFile);
  New := false;
  x := 0;
  while (x < 10) and (not New) do
   begin
    x := x + 1;
    if Points >= HS[x].Points then New := true;
   end;
  NewHS := 0;
  if New then
   begin
    DrawWindow(27,10,50,13,2,'New High Score!');
    gotoxy(29,11);
    write('Enter your name:');
    Name := GetString(29,12,17,locked,visable,reg);
    for y := 10 downto x+1 do
     HS[y] := HS[y-1];
    HS[x].Name := Name;
    HS[x].Points := Points;
    rewrite(HSFile);
    write(HSFile, HS);
    close(HSFile);
    NewHS := x;
   end;
  EraseWindow(29,10,50,13);
  textcolor(darkgray);
  textbackground(blue);
  for k := 10 to 14 do
   begin
    gotoxy(27,k);
    write(' ', #177, #178);
    gotoxy(50,k);
    write(#178, #177, ' ');
   end;
  DrawArea;
  DrawBlock;
 end;

procedure ShowHighScore;
 var
  HS   : HSType;
  x, y : integer;
 begin
  reset(HSFile);
  read(HSFile, HS);
  close(HSFile);
  DrawWindow(26,7,53,18,4,'High Score List');
  for x := 1 to 10 do
   begin
    if NewHS = x then
     begin
      textcolor(white);
      textbackground(magenta);
     end
    else
     begin
      textcolor(yellow);
      textbackground(red);
     end;
    gotoxy(28,x+7);
    write(HS[x].Name);
    for y := 1 to (20 - length(HS[x].Name)) do
     write('.');
    write(HS[x].Points);
   end;
  Cursor;
  readkey;
 end;

begin
 BlackLotusIntro;
 Init;
  repeat
   GameReset;
    repeat
     while (not Loose) and (not Dead) do
      begin
       LineCheck;
       NewBlock;
       Loose := IsLoose;
       if not Loose then Block2Area;
      end;
     if not Dead then
      begin
       WaitTimeKey;
       if KeyPressed then
        begin
         Key := readkey;
         Key := upcase(Key);
          case Key of
           #0 :
            begin
             Key := readkey;
              case Key of
               'H' :
                begin
                 EraseBlock;
                 FlipBlock;
                 if BadMove then
                  for j := 1 to 3 do
                   FlipBlock;
                 DrawBlock;
                end;
               'K' :
                begin
                 if BX > 1 then BX := BX - 1;
                 if not BadMove then
                  begin
                   BX := BX + 1;
                   EraseBlock;
                   BX := BX - 1;
                   DrawBlock;
                  end
                 else
                  BX := BX + 1;
                end;
               'M' :
                begin
                 if BX+(Block.XMax-1) < 10 then BX := BX + 1;
                 if not BadMove then
                  begin
                   BX := BX - 1;
                   EraseBlock;
                   BX := BX + 1;
                   DrawBlock;
                  end
                 else
                  BX := BX - 1;
                end;
               'P' :
                begin
                 if Step then
                  begin
                   BY := BY + 1;
                   if not BadMove then
                    begin
                     BY := BY - 1;
                     EraseBlock;
                     BY := BY + 1;
                     DrawBlock;
                     Del := DelTot;
                    end
                   else
                    BY := BY - 1;
                  end
                 else
                  begin
                   EraseBlock;
                    repeat
                     BY := BY + 1;
                    until BadMove;
                   BY := BY - 1;
                   DrawBlock;
                   Del := 0;
                  end;
                end;
              end; {case}
            end;
           'P' :
            begin
             DrawWindow(30,10,47,13,2,'Info');
             textcolor(yellow);
             gotoxy(33,11);
             write('Game Paused');
             gotoxy(32,12);
             write('Press any key..');
             Cursor;
             Key := readkey;
             ClearBuffer;
             EraseWindow(30,10,47,13);
             DrawArea;
             DrawBlock;
            end;
           'N' :
            begin
             GameReset;
            end;
           'S' :
            begin
             DrawWindow(30,10,47,13,3,'Input');
             textcolor(yellow);
             gotoxy(32,11);
             write('Enter Speed');
             gotoxy(32,12);
             write('(1-10) : ');
              repeat
               SpeedS := GetString(41,12,2,locked,visable,reg);
               Speed := trunc(Str2Real(SpeedS));
              until Speed in [1..10];
             textcolor(yellow);
             textbackground(blue);
             gotoxy(20,19);
             write('   ');
             gotoxy(20,19);
             write(Speed);
             EraseWindow(30,10,47,13);
             DrawArea;
             DrawBlock;
            end;
           'D' : if Step then Step := false else Step := true;
           'T' :
            begin
             if NB then NB := false else NB := true;
             if NB then
              DrawNext
             else
              begin
               textcolor(black);
               for k := 1 to 4 do
                for j := 1 to 4 do
                 begin
                  gotoxy(13+(j*2), k+3);
                  write(#219, #219);
                 end;
               Cursor;
              end;
            end;
           'L' :
            begin
             ShowHighScore;
             textbackground(blue);
                for k := 7 to 19 do
              begin
               textcolor(darkgray);
               gotoxy(26,k);
               write('  ', #177, #178);
               gotoxy(50,k);
               write(#178, #177, '   ');
               textcolor(white);
                case k of
                 7  : write('D');
                 9  : write('P');
                 10 : write('N');
                 11 : write('S');
                 12 : write('D');
                 13 : write('T');
                 14 : write('L');
                 16 : write('R');
                 18 : write('E');
                else
                 write(' ');
                end; {case}
               DrawArea;
               DrawBlock;
              end;
            end;
           'R' :
            begin
             DrawWindow(30,10,47,13,2,'Info');
             textcolor(yellow);
             gotoxy(32,11);
             write('Reset High');
             gotoxy(32,12);
             write('Scores? (Y/N)');
             Cursor;
              repeat
               Ch := readkey;
               Ch := upcase(Ch);
              until Ch in ['Y', 'N'];
             if Ch = 'Y' then ResetHighScore;
             EraseWindow(30,10,47,13);
             DrawArea;
             DrawBlock;
            end;
           'E' : if SndOn then SndOn := false else SndOn := true;
           'H' :
            begin
             ViewText('BLOCK.TXT');
             DrawScreen;
             DrawArea;
             DrawBlock;
             if NB then DrawNext;
             textcolor(yellow);
             textbackground(blue);
             gotoxy(20,19);
             write(Speed);
             gotoxy(21,21);
             write(Points);
            end;
          end; {case}
        end
       else
        begin
         Loose := IsLoose;
         if not Loose then Block2Area;
         if Loose then
          begin
           textcolor(black);
           for k := 1 to Block.YMax do
            for j := 1 to Block.XMax do
             if Block.Obj[j,k] then
              begin
               gotoxy(((BX+(j-1))*2)+28, BY+(k-1)+2);
               write(#219, #219);
              end;
           BY := BY + 1;
           for k := 1 to Block.YMax do
            for j := 1 to Block.XMax do
             if Block.Obj[j,k] then
              begin
               gotoxy(((BX+(j-1))*2)+28, BY+(k-1)+2);
               textcolor(Block.Color[j,k]);
               write(#219, #219);
              end;
           Cursor;
          end;
        end;
      end;
    until Dead or (Key = #27);
   if Dead then
    begin
     DrawWindow(30,10,47,13,5,'Info');
     textcolor(yellow);
     gotoxy(34,11);
     write('Game Over');
     gotoxy(32,12);
     write('Press any key..');
     Cursor;
     Key := readkey;
     ClearBuffer;
     EraseWindow(30,10,47,13);
     DrawArea;
     DrawBlock;
    end;
   CheckHighScore;
  until Key = #27;
 ShowHighScore;
 Fadeout;
end.