program Test;

uses
 Crt, Std;

var
 F1, F2 : string;

procedure ReverseText(Filename1, Filename2 : string);
 var
  File1,
  File2  : text;
  Lines  : integer;
  x      : integer;
  Cha    : char;
  Str1,
  Str2   : string;
  j, k   : integer;
 begin
  assign(File1, Filename1);
  assign(File2, Filename2);
  rewrite(File2);
  Lines := 0;
  reset(File1);
  while not Eof(File1) do
   begin
    readln(File1, Str1);
    Lines := Lines + 1;
   end;
  close(File1);
  for x := 1 to Lines do
   begin
    reset(File1);
    for k := 1 to (Lines-x+1) do
     readln(File1, Str1);
    close(File1);
    Str2 := '';
    for j := 1 to length(Str1) do
     Str2 := Str2 + Str1[length(Str1)-j+1];
    writeln(File2, Str2);
   end;
  close(File2);
 end;

begin
 Clear;
 write('Enter oriniginal filename : ');
 readln(F1);
 write('Enter new filename : ');
 readln(F2);
 ReverseText(F1, F2);
end.