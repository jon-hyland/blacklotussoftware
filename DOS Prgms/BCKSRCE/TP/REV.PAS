program RevUUE;

uses
 Crt;

var
 Str     : string;
 DatFile : text;
 RevFile : text;
 Line    : longint;
 Lines   : longint;
 x       : integer;

function TotLines : integer;
 var
  x : integer;
 begin
  x := 0;
  reset(DatFile);
   repeat
    readln(DatFile);
    x := x + 1;
   until Eof(DatFile);
  TotLines := x;
 end;

procedure Init;
 var
  s : string;
 begin
  assign(DatFile, 'REV.DAT');
  assign(RevFile, 'VER.DAT');
  rewrite(RevFile);
  reset(DatFile);
  Lines := TotLines;
  readln(DatFile, s);
  writeln(RevFile, s);
  Line := 1;
 end;

procedure RevLine(var s : string);
 var
  x : integer;
  t : string[51];
 begin
  t := s;
  for x := 2 to 51 do
   if t[x] <> ' ' then s[x] := t[52-x];
 end;

begin
 Init;
  repeat
   reset(DatFile);
   for x := 1 to Lines + 1 - Line do
    readln(DatFile);
   for x := 1 to 51 do
    Str[x] := ' ';
   readln(DatFile, Str);
   RevLine(Str);
   writeln(RevFile, Str);
   writeln(Line, ' of ', Lines);
   Line := Line + 1;
  until Line > Lines;
 close(DatFile);
 close(RevFile);
end.

