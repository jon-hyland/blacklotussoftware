program TestProcFunc;

uses
 Crt;

var
 j, k : integer;

procedure MakeWindow(Name : string; x1, y1,
 x2, y2 : integer; Color : byte);
 var
  x, y : integer;
  WinLength : integer;
  NameLength : integer;
  NameSpace : integer;
  Center : integer;
  HalfName : integer;
  Start : integer;
 begin
  WinLength := x2 - x1 + 1;
  NameLength := length(Name);
  NameSpace := WinLength - 8;
  if NameLength < NameSpace then
   delete(Name, NameSpace + 1, length(Name) - NameSpace);
  Center := WinLength div 2;
  HalfName := (NameLength div 2) - 1;
  Start := (Center - HalfName) + (x1 - 1);
  textbackground(Color);
  for y := y1 to y2 do
   begin
    for x := x1 to x2 do
     begin
      gotoxy(x,y);
      write(' ');
     end;
   end;
  gotoxy(x1, y1);
  write(chr(218));
  for x := x1 + 1 to Start - 3 do write(chr(196));
  write(chr(180), ' ', Name, ' ', chr(195));
  for x := Start + NameLength + 1 to x2 - 2 do write(chr(196));
  write(chr(191));
  for y := y1+1 to y2 - 1 do
   begin
    gotoxy(x1, y);
    write(chr(179));
    gotoxy(x2, y);
    write(chr(179));
   end;
  gotoxy(x1, y2);
  write(chr(192));
  for x := x1 + 1 to x2 - 1 do write(chr(196));
  write(chr(217));
 end;

var
 Name : string;
 x1, y1, x2, y2 : integer;
 Color : integer;

begin
 textbackground(black);
 clrscr;
  repeat
   if random(2)+1 = 1 then Name := '12345' else Name := '123456';
   x1 := random(35)+1;
   x2 := random(40)+39;
   y1 := random(10)+1;
   y2 := random(10)+12;
   Color := random(7);
   MakeWindow(Name, x1, y1, x2, y2, Color);
  until 1 = 2;
end.