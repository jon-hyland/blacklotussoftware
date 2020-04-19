program HorseRace;

uses
 Crt;

type
 array1 = array[1..10] of integer;

var
 Horse : array1;
 Money : integer;
 HorseBet : integer;
 Move : integer;
 WPS : integer;

procedure Title;
 begin
  ClrScr;
  writeln('- HorseRace -');
  writeln;
  writeln('fdsgmdfg dfg..');
  writeln;
  write('Press [Return] to continue..');
  readln;
 end;

procedure DrawScreen;
 var
  j, k : integer;
 begin
  ClrScr;
  gotoxy(1,1);
  for j := 1 to 80 do
   write('-');
  for k := 2 to 20 do
   begin
    gotoxy(1, k);
    write('|');
    gotoxy(80, k);
    write('|');
   end;
  gotoxy(1, 21);
  for j := 1 to 80 do
   write('-');
  for j := 1 to 10 do
   begin
    gotoxy(2, (j*2)+1);
    write('---');
    gotoxy(5, j*2);
    write('|');
    gotoxy(3, j*2);
    write('@');
   end;
  readkey;
 end;

begin
 Title;
 DrawScreen;
end.





