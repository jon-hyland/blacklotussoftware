program Crap;

uses
 Crt;

var
 Str : string;

function ArrangeString(Str : string) : string;
 var
  x : integer;
  New : string[50];
  Low,
  High : char;
 begin
  for x := 1 to 50 do
   New[x] := ' ';
  High := chr(0);
  for x := 1 to length(Str) do
   if ord(Str[x]) > ord(High) then
    High := Str[x];
  Low := High;
  for x := 1 to length(Str) do
   if ord(Str[x]) < ord(Low) then
    Low := Str[x];




