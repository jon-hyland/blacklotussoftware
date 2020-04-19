{$M $4000,0,0 }

program Config;

uses
 Crt, Dos, Std;

type
 ConfigType = record
   ScreenName : string[20];
   FileName   : string[8];
  end;

var
 InfoFile     : file of ConfigType;
 Info         : ConfigType;
 TotCnfg      : integer;
 MenuChoice   : char;
 ConfigChoice : integer;
 j            : integer;
 Bat          : boolean;
 FileName     : string[12];

procedure Init;
 var
  Junk : ConfigType;
 begin
  Clear;
  assign(InfoFile, 'CNFGINFO.DAT');
  TotCnfg := 0;
  reset(InfoFile);
  while not Eof(InfoFile) do
   begin
    read(InfoFile, Junk);
    TotCnfg := TotCnfg + 1;
   end;
  close(InfoFile);
 end;

procedure LoadInfoAt(X : integer);
 var
  j : integer;
 begin
  reset(InfoFile);
  for j := 1 to X do
   read(InfoFile, Info);
  close(InfoFile);
 end;

function MainMenu : char;
 const
  MenuChoice : array[1..5] of string =
  ('Select New Config Setup',
   'Edit Existing Setup',
   'Add Setup',
   'Delete Setup',
   'Quit Config');
 var
  Key  : char;
  Loc  : integer;
  j, k : integer;
 begin
  DrawWindow(25,7,55,13,3,'Config');
  textcolor(yellow);
  for j := 1 to 5 do
   begin
    gotoxy(27, j+7);
    write(MenuChoice[j]);
   end;
  Loc := 1;
   repeat
    textcolor(white);
    textbackground(blue);
    gotoxy(27, Loc+7);
    write(MenuChoice[Loc]);
    Cursor;
     repeat
      Key := readkey;
      Key := upcase(Key);
     until Key in ['H','P',#13];
    if Key <> #13 then
     begin
      textcolor(yellow);
      textbackground(cyan);
      gotoxy(27, Loc+7);
      write(MenuChoice[Loc]);
      Cursor;
     end;
     case Key of
      'H' : Loc := Loc - 1;
      'P' : Loc := Loc + 1;
     end; {case}
    if Loc > 5 then Loc := 1;
    if Loc < 1 then Loc := 5;
   until Key = #13;
  MainMenu := MenuChoice[Loc][1];
  textcolor(white);
  textbackground(black);
  for k := 7 to 14 do
   for j := 25 to 59 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
 end;

function GetConfig : integer;
 var
  j, k : integer;
  Junk : ConfigType;
  Choice : integer;
  Key : char;
 begin
  Choice := 1;
  DrawWindow(25,4,55,5+TotCnfg,1,'Choose Configuration');
  reset(InfoFile);
  for j := 1 to TotCnfg do
   begin
    read(InfoFile, Junk);
    gotoxy(29,j+4);
    write(Junk.ScreenName);
   end;
  close(InfoFile);
   repeat
    gotoxy(27,Choice+4);
    write('*');
    Cursor;
     repeat
      Key := readkey;
     until Key in [#13,#27,'H','P'];
    if Key in ['H','P'] then
     begin
      gotoxy(27,Choice+4);
      write(' ');
      Cursor;
     end;
     case Key of
      'H' : Choice := Choice - 1;
      'P' : Choice := Choice + 1;
     end; {case}
    if Choice > TotCnfg then Choice := 1;
    if Choice < 1 then Choice := TotCnfg;
   until Key in [#13, #27];
  if Key = #27 then Choice := 0;
  GetConfig := Choice;
  textcolor(white);
  textbackground(black);
  for k := 4 to (6 + TotCnfg) do
   for j := 25 to 57 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
 end;

procedure ErrorMessage;
 begin
  DrawWindow(30,5,50,7,4,'ERROR');
  textcolor(yellow);
  gotoxy(32,6);
  write('An error has occured.');
  Cursor;
  readkey;
  textcolor(white);
  textbackground(black);
  clrscr;
  halt(1);
 end;

function IsBat : boolean;
 var
  Key : char;
 begin
  DrawWindow(30,10,50,13,1,'Input');
  gotoxy(32,11);
  write('File type : [B]at');
  gotoxy(44,12);
  write('[S]ys');
  Cursor;
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['B', 'S'];
  IsBat := Key = 'B';
 end;

procedure EditFile(FileName : string);
 var
  x, y   : integer;
  CFile  : text;
  PS     : PathStr;
  Screen : array[1..78, 1..100] of char;
  j, k   : integer;
  Cha    : char;
  Offset : integer;
  Key    : char;
  Line   : string;
  TotX   : integer;
  TotY   : integer;
  Found  : boolean;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := (OffSet + 1) to (OffSet + 22) do
    for j := 1 to 78 do
     begin
      gotoxy(j+1, k+1-Offset);
      write(Screen[j,k]);
     end;
  end;
 begin
  for k := 1 to 100 do
   for j := 1 to 78 do
    Screen[j,k] :=  ' ';
  assign(CFile, FileName);
  PS := FSearch(FileName, GetEnv('PATH'));
  if PS <> '' then reset(CFile) else rewrite(CFile);
  x := 1;
  y := 1;
  while not Eof(CFile) do
   begin
    read(CFile, Cha);
     case Cha of
      #13 : y := y + 1;
      #10 : x := 1;
      #32..#126 :
       begin
        if (x in [1..78]) and (y in [1..100]) then Screen[x,y] := Cha;
        x := x + 1;
       end;
     end; {case}
   end;
  close(CFile);
  DrawWindow(1,1,80,24,1,FileName);
  textcolor(yellow);
  x := 1;
  y := 1;
  Offset := 0;
  DrawPage;
   repeat
     repeat
      gotoxy(x+1,y+1-Offset);
      Key := readkey;
      if Key = #0 then
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x < 1 then x := 1;
        if x > 78 then x := 78;
        if y < 1 then y := 1;
        if y > 100 then y := 100;
        if y <= OffSet then
         begin
          OffSet := OffSet - 1;
          DrawPage;
         end;
        if y > OffSet + 22 then
         begin
          OffSet := OffSet + 1;
          DrawPage;
         end;
        Key := #0;
       end;
     until Key in [#32..#126, #13, #8, #27];
     case Key of
      #13 :
       begin
        x := 1;
        y := y + 1;
        if y > 100 then y := 100;
        if y > OffSet + 22 then
         begin
          OffSet := OffSet + 1;
          DrawPage;
         end;
       end;
      #32..#126 :
       begin
        Screen[x,y] := Key;
        gotoxy(x+1,y+1-Offset);
        write(Screen[x,y]);
        x := x + 1;
        if x > 78 then y := y + 1;
        if y > 100 then y := 100;
        if y > OffSet + 22 then
         begin
          OffSet := OffSet + 1;
          DrawPage;
         end;
       end;
      #8 :
       begin
        Screen[x,y] := ' ';
        gotoxy(x+1,y+1-Offset);
        write(Screen[x,y]);
        x := x - 1;
        if x < 1 then x := 1;
        Screen[x,y] := ' ';
        gotoxy(x+1,y+1-Offset);
        write(Screen[x,y]);
       end;
     end; {case}
   until Key = #27;
  DrawWindow(24,6,56,9,5,'Input');
  gotoxy(26,7);
  write('Save changes to ', FileName, '?');
  gotoxy(38,8);
  write('(Y/N)');
  Cursor;
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['Y','N'];
  if Key = 'Y' then
   begin
    Found := false;
    TotY := 1;
    k := 100;
    j := 78;
    for k := 100 downto 1 do
     for j := 78 downto 1 do
      if not Found then
       if Screen[j,k] <> ' ' then
        begin
         Found := true;
         TotY := k;
        end;
    rewrite(CFile);
    for k := 1 to TotY do
     begin
      TotX := 1;
      Found := false;
      for j := 78 downto 1 do
       if not Found then
        if Screen[j,k] <> ' ' then
         begin
          Found := true;
          TotX := j;
         end;
      Line := '';
      for j := 1 to TotX do
       Line := concat(Line, Screen[j,k]);
      writeln(CFile, Line);
     end;
    close(CFile);
   end;
  Clear;
 end;

procedure GetInfo;
 begin
  DrawWindow(20,8,60,12,5,'Input');
  gotoxy(22,9);
  write('Screen Name : ');
  gotoxy(22,11);
  write('File Name   : ');
  textbackground(black);
  Info.ScreenName := GetString(36,9,20,locked,visable,reg);
  Info.FileName := GetString(36,11,8,locked,visable,upper);
  EraseWindow(20,8,60,12);
 end;

procedure RecordNewInfo;
 var
  Junk : ConfigType;
  BFile,
  SFile : text;
 begin
  reset(InfoFile);
  while not Eof(InfoFile) do
   read(InfoFile, Junk);
  write(InfoFile, Info);
  close(InfoFile);
  TotCnfg := TotCnfg + 1;
  assign(BFile, Info.FileName + '.BAT');
  assign(SFile, Info.FileName + '.SYS');
  rewrite(BFile);
  rewrite(SFile);
  write(BFile, ' ');
  write(SFile, ' ');
  close(BFile);
  close(SFile);
 end;

procedure DeleteInfo(Choice : integer);
 var
  Swap : file of ConfigType;
  Junk : ConfigType;
  x    : integer;
 begin
  assign(Swap, 'SWAP.DAT');
  rewrite(Swap);
  reset(InfoFile);
  x := 1;
  while not Eof(InfoFile) do
   begin
    read(InfoFile, Junk);
    if x <> Choice then
     write(Swap, Junk);
    x := x + 1;
   end;
  close(Swap);
  close(InfoFile);
  rewrite(InfoFile);
  reset(Swap);
  while not Eof(Swap) do
   begin
    read(Swap, Junk);
    write(InfoFile, Junk);
   end;
  close(Swap);
  close(InfoFile);
  TotCnfg := TotCnfg - 1;
 end;

begin
 Init;
  repeat
   MenuChoice := MainMenu;
   if MenuChoice = 'S' then
    begin
     ConfigChoice := GetConfig;
     if ConfigChoice <> 0 then
      begin
       LoadInfoAt(ConfigChoice);
       CopyText((Info.FileName + '.BAT'), 'C:\AUTOEXEC.BAT');
       CopyText((Info.FileName + '.SYS'), 'C:\CONFIG.SYS');
      end;
    end;
   if MenuChoice = 'E' then
    begin
     ConfigChoice := GetConfig;
     if ConfigChoice <> 0 then
      begin
       LoadInfoAt(ConfigChoice);
       Bat := IsBat;
       if Bat then FileName := Info.FileName + '.BAT' else
        FileName := Info.FileName + '.SYS';
       EditFile(FileName);
      end;
    end;
   if MenuChoice = 'A' then
    begin
     GetInfo;
     RecordNewInfo;
    end;
   if MEnuChoice = 'D' then
    begin
     ConfigChoice := GetConfig;
     if ConfigChoice <> 0 then DeleteInfo(ConfigChoice);
    end;
  until MenuChoice = 'Q';

end.



