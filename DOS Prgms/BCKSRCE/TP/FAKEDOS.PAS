program FakeDos2_2;

uses
 Crt, Dos;

type
 array1 = array[0..126] of string[1];

var
 InputChr : array1;
 InputStr : string[127];
 LogFile : text;
 ThinkFile : text;
 j, k : integer;
 y : integer;
 Key : char;
 ToDo : integer;
 Inputs : integer;

procedure Help;                   {Displays help}
 begin
	writeln('FakeDos 2.2 - 8/21/95 by Jon Hyland');
  writeln('Usage: fakedos [/?] [filename]');
  writeln(' [/?] - Shows this message');
  writeln(' [filename.ext] - Name of textfile to save inputs');
  writeln;
  halt(3);
 end;

procedure Init;                   {Does things that need to be done}
 var                              {before program starts}
  tj, tk : integer;
 begin
  if paramstr(1) = '' then assign(LogFile, 'C:\DOS\FAKELOG.TXT') else
   assign(LogFile, paramstr(1));
  assign(ThinkFile, 'C:\DOS\THNK.FIL');
  rewrite(ThinkFile);
  for tj := 1 to 100 do
   begin
    for tk := 1 to 80 do write(ThinkFile, 'X');
    writeln(ThinkFile);
   end;
  close(ThinkFile);
 end;

procedure MakeThinkSound;         {Makes it seem the computer is reading}
 var                              {hard drive}
  c : char;
  j, k : integer;
 begin
  for k := 1 to 3 do
   begin
    rewrite(ThinkFile);
    for j := 1 to 80 do
     begin
      c := chr(random(26)+65);
      write(ThinkFile, c);
     end;
    close(ThinkFile);
   end;
 end;

function DateStr : string;        {returns date in a string format}
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
  DateStr := concat(sm, '/', sd, '/', sy);
 end;

procedure LogTime_Date;           {Labels entry with date}
 begin
  append(LogFile);
  writeln(LogFile, '--- ', DateStr, ' ---');
  close(LogFile);
 end;

procedure LogInput;               {Saves input to entry}
 begin
  append(LogFile);
  writeln(LogFile, InputStr);
  close(LogFile);
 end;

procedure BadCommand;             {Displays DOS's bad command message}
 begin
  MakeThinkSound;
  writeln('Bad command or file name');
  writeln;
 end;

procedure Dir;                    {Displays a fake empty drive}
 begin
  MakeThinkSound;
  writeln;
  writeln(' Volume in drive C is MS-DOS_6');
  writeln(' Volume Serial Number is 1EFF-0A18');
  writeln(' Directory of C:\');
  writeln;
  MakeThinkSound;
  writeln('File not found');
  writeln;
 end;

procedure Cd;                     {Displays DOS's bad directory message}
 begin
  MakeThinkSound;
  writeln('Invalid directory');
  writeln;
 end;

procedure Drive;                  {Displays DOS's bad drive message}
 begin
  MakeThinkSound;
  writeln('Invalid drive specification');
  writeln;
 end;

procedure Did;                    {Displays a blank line}
 begin
  MakeThinkSound;
  writeln;
 end;

procedure Cls;                    {Acts like DOS's cls command}
 begin
  clrscr;
  writeln;
 end;

procedure Quit;                   {Erases password and quits to real DOS}
 begin
	gotoxy(5, y);
	writeln('           ');
	halt(3);
 end;

procedure Input;                  {Get Input and saves it as a}
 var                              {string and an array of chars}
  tc : string[1];
 begin
	y := WhereY;
	write('C:\>');
  readln(InputStr);
  for j := 1 to 126 do
   begin
    tc := copy(InputStr, j, 1);
    InputChr[j] := tc;
   end;
 end;

function WhatTyped : integer;     {Figures out what to do after user}
 var                              {inputs something}
  Tt : integer;
 begin
	Tt := 0;
  if (((InputChr[1] = 'D') or (InputChr[1] = 'd')) and
   ((InputChr[2] = 'I') or (InputChr[2] = 'i')) and
   ((InputChr[3] = 'R') or (InputChr[3] = 'r'))) then Tt := 1;
  if (((InputChr[1] = 'C') or (InputChr[1] = 'c')) and
   ((InputChr[2] = 'D') or (InputChr[2] = 'd'))) then Tt := 2;
  if InputChr[2] = ':' then Tt := 3;
	if Tt = 2 then if ((InputChr[3] <> '\') and (InputChr[3] <> '.')
	 and (InputChr[3] <> ' ')) then Tt := 0;
	if Tt = 2 then
   begin
    if ((InputChr[3] = '.') and (InputChr[4] <> '.')) then Tt := 4;
    if ((InputChr[3] = '\') and ((InputChr[4] = ' ') or (InputChr[4] = '')))
     then Tt := 4;
   end;
	if (((InputChr[1] = 'C') or (InputChr[1] = 'c')) and
   ((InputChr[2] = 'L') or (InputChr[2] = 'l')) and
   ((InputChr[3] = 'S') or (InputChr[3] = 's'))) then Tt := 5;
	if (((InputChr[1] = '') or (InputChr[1] = ' ')) and
			((InputChr[2] = '') or (InputChr[2] = ' '))) then Tt := 6;
	if InputStr = '286343.975' then Tt := -1;
	WhatTyped := Tt;
 end;

begin                             {Main program}
 if paramstr(1) = '/?' then Help;
 Init;
 Inputs := 0;
 writeln;
  repeat
   Input;
   Inputs := Inputs + 1;
   if Inputs = 1 then LogTime_Date;
   LogInput;
   ToDo := WhatTyped;
   if ToDo = 0 then BadCommand;
   if ToDo = 1 then Dir;
   if ToDo = 2 then Cd;
   if ToDo = 3 then Drive;
   if ToDo = 4 then Did;
   if ToDo = 5 then Cls;
	 if ToDo = -1 then Quit;
	until 1 = 2;
end.