program BeerCo;

uses
 Crt;

var
 MenuChoice : char;
 Done : boolean;
 Piels, Coors, Bud, IronCity : integer;

procedure DrawMain;
 var
  x, y : integer;
 begin
  for y := 2 to 14 do
   for x := 16 to 51 do
    begin
     gotoxy(x,y);
     write(' ')
    end;
  gotoxy(16,2);
  for x := 16 to 51 do write('-');
  gotoxy(16+3, 2);
  write('( Main Menu )');
  for y := 2+1 to 14-1 do
   begin
    gotoxy(16, y);
    write('|');
    gotoxy(51, y);
    write('|')
   end;
  gotoxy(16, 14);
  for x := 16 to 51 do write('-');
  gotoxy(16+2, 2+1);
  x := 18;
  y := 3;
  gotoxy(18,2);
  write('( Main Menu )');
  gotoxy(x, y);
  write('(E)nter Inventory');
  gotoxy(x, y+2);
  write('(P)urchase Beer');
  gotoxy(x, y+4);
  write('(S)ell Beer');
  gotoxy(x, y+6);
  write('(D)isplay Inventory');
  gotoxy(x, y+8);
  write('(Q)uit Program');
  gotoxy(x, y+10);
  write('           ');
  gotoxy(x, y+10);
  write('Chioce: ')
 end;

procedure DrawOther;
 var
  x, y : integer;
 begin
  for y := 4 to 18 do
   for x := 37 to 65 do
    begin
     gotoxy(x,y);
     write(' ')
    end;
  gotoxy(37,4);
  for x := 37 to 65 do write('-');
  for y := 4+1 to 18-1 do
   begin
    gotoxy(37, y);
    write('|');
    gotoxy(65, y);
    write('|')
   end;
  gotoxy(37, 18);
  for x := 37 to 65 do write('-');
  x := 39;
  y := 5;
  gotoxy(x, y);
  write('(P)iels');
  gotoxy(x, y+2);
  write('(C)oors');
  gotoxy(x, y+4);
  write('(B)ud');
  gotoxy(x, y+6);
  write('(I)ron City');
  gotoxy(x, y+8);
  write('(Q)uit to Main Menu');
  gotoxy(x, y+10);
  write('Choice:')
 end;

procedure EraseWindow;
 var
  y : integer;
 begin
  for y := 4 to 18 do
   begin
    gotoxy(37,y);
    write('                             ');
    if y <= 13 then
     begin
      gotoxy(51, y);
      write('|')
     end
   end;
  gotoxy(37, 14);
  write('---------------')
 end;

function BeerId : char;
 var
  Key : char;
  Done : boolean;
 begin
  Done := false;
   repeat
    gotoxy(47,15);
    write('   ');
    gotoxy(47,15);
    read(Key);
     case Key of
      'p', 'P' : Done := true;
      'c', 'C' : Done := true;
      'b', 'B' : Done := true;
      'i', 'I' : Done := true;
      'q', 'Q' : Done := true
     end; {case}
   until Done;
  BeerId := Key
 end;

function BeerCases : integer;
 var
  S : string;
  V : real;
  C : integer;
 begin
   repeat
    gotoxy(39, 17);
    write('Number of Cases: ');
    readln(S);
    val(S, V, C);
    gotoxy(39, 17);
    write('                          ');
   until (C = 0) and (V >= 0);
  BeerCases := trunc(V)
 end;

procedure Inventory;
 var
  Cases : integer;
 begin
  DrawOther;
  gotoxy(39,4);
  write('( Inventory )');
   repeat
    MenuChoice := BeerId;
    if (MenuChoice <> 'q') and (MenuChoice <> 'Q') then
     begin
      Cases := BeerCases;
       case MenuChoice of
        'p', 'P': Piels := Cases;
        'c', 'C': Coors := Cases;
        'b', 'B': Bud := Cases;
        'i', 'I': IronCity := Cases
       end {case}
     end;
   until (MenuChoice = 'q') or (MenuChoice = 'Q');
  EraseWindow
 end;

procedure Purchase;
 var
  Cases : integer;
 begin
  DrawOther;
  gotoxy(39,4);
  write('( Purchase )');
   repeat
    MenuChoice := BeerId;
    if (MenuChoice <> 'q') and (MenuChoice <> 'Q') then
     begin
      Cases := BeerCases;
       case MenuChoice of
        'p', 'P': Piels := Piels + Cases;
        'c', 'C': Coors := Coors + Cases;
        'b', 'B': Bud := Bud + Cases;
        'i', 'I': IronCity := IronCity + Cases
       end {case}
     end;
   until (MenuChoice = 'q') or (MenuChoice = 'Q');
  EraseWindow
 end;

procedure Sell;
 var
  Cases : integer;
 begin
  DrawOther;
  gotoxy(39,4);
  write('( Sell )');
   repeat
    MenuChoice := BeerId;
    if (MenuChoice <> 'q') and (MenuChoice <> 'Q') then
     begin
      Cases := BeerCases;
       case MenuChoice of
        'p', 'P': Piels := Piels - Cases;
        'c', 'C': Coors := Coors - Cases;
        'b', 'B': Bud := Bud - Cases;
        'i', 'I': IronCity := IronCity - Cases
       end {case}
     end;
   until (MenuChoice = 'q') or (MenuChoice = 'Q');
  EraseWindow
 end;

procedure Display;
 var
  x, y : integer;
 begin
  for y := 4 to 18 do
   for x := 37 to 65 do
    begin
     gotoxy(x,y);
     write(' ')
    end;
  gotoxy(37,4);
  for x := 37 to 65 do write('-');
  for y := 4+1 to 18-1 do
   begin
    gotoxy(37, y);
    write('|');
    gotoxy(65, y);
    write('|')
   end;
  gotoxy(37, 18);
  for x := 37 to 65 do write('-');
  x := 39;
  y := 5;
  gotoxy(39,4);
  write('( Display )');
  gotoxy(x, y+1);
  write('Cases of');
  gotoxy(x, y+3);
  write(' Piels: ', Piels);
  gotoxy(x, y+5);
  write(' Coors: ', Coors);
  gotoxy(x, y+7);
  write(' Bud: ', Bud);
  gotoxy(x, y+9);
  write(' IronCity: ', IronCity);
  gotoxy(x, y+11);
  write('(Enter) to continue..');
  readln;
  readln;
  EraseWindow
 end;

begin
 Done := false;
 Piels := 0;
 Coors := 0;
 Bud := 0;
 IronCity := 0;
 ClrScr;
 DrawMain;
  repeat
   gotoxy(26,13);
   read(MenuChoice);
   gotoxy(26,13);
   write('       ');
    case MenuChoice of
     'E', 'e' : Inventory;
     'P', 'p' : Purchase;
     'S', 's' : Sell;
     'D', 'd' : Display;
     'Q', 'q' : Done := true
    end; {case}
  until Done
end.


