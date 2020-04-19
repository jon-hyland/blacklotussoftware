program Arena_1_0;

uses
 Crt;

type
 PersonRecord = record
   Num   : integer;
   Name  : string[10];
   Hand  : integer;
   Range : integer;
   Armor : integer;
   Gold  : longint;
   HP    : integer;
  end;

const
 HandName : array[1..12] of string = ('Hand', 'Knife', 'Lance', 'Rapier',
            'Halberd', 'Short Sword', 'Broad Sword', 'Sgl. Arnis',
            'Dbl. Arnis', 'Katana', 'Dbl. Katana', 'Raptor');
 RangeName : array[0..8] of string = ('None', 'Sling', 'Short Bow',
             'Long Bow', 'Comp. Bow', 'Bow of Suffering', 'Artemis Bow',
             'Great Bow', 'Bow of Death');
 ArmorName : array[0..7] of string = ('None', 'Tin Foil', 'Leather',
             'Studded Leather', 'Steel Mesh', 'Steel Banded', 'Diamond',
             'BlackVoid');

var
 Enemy : array[1..10] of PersonRecord;
 Player1 : PersonRecord;
 Player2 : PersonRecord;
 PlayerFile : file of PersonRecord;
 Quit   : boolean;

procedure InitEnemy;
 begin
  Enemy[1].Name := 'Slave';
  Enemy[1].Hand := 1;
  Enemy[1].Range := 1;
  Enemy[1].Armor := 0;
  Enemy[1].Gold := 10;

  Enemy[2].Name := 'Thief';
  Enemy[2].Hand := 2;
  Enemy[2].Range := 1;
  Enemy[2].Armor := 1;
  Enemy[2].Gold := 25;

  Enemy[3].Name := 'Bandit';
  Enemy[3].Hand := 3;
  Enemy[3].Range := 2;
  Enemy[3].Armor := 1;
  Enemy[3].Gold := 65;

  Enemy[4].Name := 'Imp';
  Enemy[4].Hand := 4;
  Enemy[4].Range := 3;
  Enemy[4].Armor := 2;
  Enemy[4].Gold := 100;

  Enemy[5].Name := 'Gargoyle';
  Enemy[5].Hand := 5;
  Enemy[5].Range := 4;
  Enemy[5].Armor := 3;
  Enemy[5].Gold := 250;

  Enemy[6].Name := 'Demon Knight';
  Enemy[6].Hand := 6;
  Enemy[6].Range := 4;
  Enemy[6].Armor := 3;
  Enemy[6].Gold := 350;

  Enemy[7].Name := 'Shadow';
  Enemy[7].Hand := 7;
  Enemy[7].Range := 5;
  Enemy[7].Armor := 4;
  Enemy[7].Gold := 500;

  Enemy[8].Name := 'Demon Elf';
  Enemy[8].Hand := 8;
  Enemy[8].Range := 5;
  Enemy[8].Armor := 5;
  Enemy[8].Gold := 700;

  Enemy[9].Name := 'Hellhound';
  Enemy[9].Hand := 9;
  Enemy[9].Range := 6;
  Enemy[9].Armor := 5;
  Enemy[9].Gold := 850;

  Enemy[10].Name := 'Omnipotent Being';
  Enemy[10].Hand := 12;
  Enemy[10].Range := 8;
  Enemy[10].Armor := 7;
  Enemy[10].Gold := 1200;
 end;

procedure Clear;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(#219);
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure SetColor(Color : integer);
 var
  FG : integer;
  BG : integer;
 begin
  if Color > 100 then
   begin
    BG := trunc(Color / 100) - 1;
    FG := Color - ((BG + 1) * 100) - 1;
   end
  else
   begin
    BG := trunc(Color / 10) - 1;
    FG := Color - ((BG + 1) * 10) - 1;
   end;
  textcolor(FG);
  textbackground(BG);
 end;

procedure DrawWindow(x1, y1, x2, y2, Color : integer; Name : string);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(Color);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  gotoxy(x1,y1);
  write(#218);
  gotoxy(x1,y2);
  write(#192);
  for j := x1+1 to x2-1 do
   begin
    gotoxy(j,y1);
    write(#196);
    gotoxy(j,y2);
    write(#196);
   end;
  gotoxy(trunc(x1+((x2-x1+1)-length(Name))/2)-2, y1);
  write(#180, ' ', Name, ' ', #195);
  gotoxy(x2,y1);
  write(#191);
  gotoxy(x2,y2);
  write(#217);
  for k := y1+1 to y2-1 do
   begin
    gotoxy(x1,k);
    write(#179);
    gotoxy(x2,k);
    write(#179);
   end;
  Cursor;
 end;

procedure EraseWindow(x1, y1, x2, y2 : integer);
 var
  j, k : integer;
 begin
  textcolor(white);
  textbackground(black);
  for k := y1 to y2 do
   for j := x1 to x2 do
    begin
     gotoxy(j,k);
     write(' ');
    end;
  Cursor;
 end;

procedure Init;
 begin
  randomize;
  InitEnemy;
  assign(PlayerFile, 'ARPLAYER.DAT');
  Quit := false;

 end;

procedure Title;
 begin
  Clear;
  gotoxy(16,10);
  write('Arena  v1.0  (c) 1996 by Eternal Damnnation Software');
  Cursor;
  readkey;
 end;

{$I ARENAPIT.PAS}
procedure DrawArena;
 var
  j, k : integer;
 begin
  Clear;
  for k := 2 to 13 do
   for j := 19 to 62 do
    begin
     SetColor(PicColor[j-18, k-1]);
     gotoxy(j, k);
     write(PicChar[j-18, k-1]);
    end;
 end;

procedure DrawArenaMenu;
 begin
  DrawWindow(16,15,39,23,1,'Player 1');
  textcolor(yellow);
  gotoxy(18,16);
  write('Name ...............');
  gotoxy(18,17);
  write('Hand ...............');
  gotoxy(18,18);
  write('Range ..............');
  gotoxy(18,19);
  write('Armor ..............');
  gotoxy(18,20);
  write('Ammo ...............');
  gotoxy(18,21);
  write('Gold ...............');
  gotoxy(18,22);
  write('HP : 000%');
  DrawWindow(42,15,65,23,1,'Player 2');
  textcolor(yellow);
  gotoxy(44,16);
  write('Name ...............');
  gotoxy(44,17);
  write('Hand ...............');
  gotoxy(44,18);
  write('Range ..............');
  gotoxy(44,19);
  write('Armor ..............');
  gotoxy(44,20);
  write('Ammo ...............');
  gotoxy(44,21);
  write('Gold ...............');
  gotoxy(44,22);
  write('HP : 000%');
  DrawWindow(2,5,16,10,7,'Keys');
  gotoxy(4,6);
  write('Dir : ');
  gotoxy(4,7);
  write('Hand : ');
  gotoxy(4,8);
  write('Range : ');
  gotoxy(4,9);
  write('Mercy : ');
  DrawWindow(65,5,79,10,7,'Keys');
  gotoxy(67,6);
  write('Dir : ');
  gotoxy(67,7);
  write('Hand : ');
  gotoxy(67,8);
  write('Range : ');
  gotoxy(67,9);
  write('Mercy : ');

  Cursor;
 end;

procedure DrawMainMenu;
 begin
 end;

begin
 Init;
 Title;
 DrawArena;
  repeat
   DrawArenaMenu;

   readkey;
  until Quit;
end.












