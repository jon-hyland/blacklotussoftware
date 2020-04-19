program CreateArenaFile;

uses
 Crt, Std;

type
 PlayerStats = record
   Name  : string[12];
   Sex   : boolean;
   TotHP : integer;
   HitPt : real;
   Hand  : integer;
   Range : integer;
   Armor : integer;
   Gold  : longint;
   Kills : integer;
  end;

var
 P     : PlayerStats;
 PFile : file of PlayerStats;
 Name  : string[12];
 Sex   : boolean;
 Key   : char;
 x     : integer;

begin
 randomize;
 BlackLotusIntro;
 DrawWindow(23,10,58,13,4,'!Warning!');
 textcolor(yellow);
 gotoxy(25,11);
 write('This will erase all player data!');
 textcolor(white);
 gotoxy(32,12);
 write('Continue? (Y/N)');
 Cursor;
  repeat
   Key := readkey;
   Key := upcase(Key);
  until Key in ['Y', 'N'];
 if Key = 'Y' then
  begin
   assign(PFile, 'KILL.DAT');
   rewrite(PFile);
   Clear;
   DrawWindow(25,7,55,19,1,'Create Players');
   gotoxy(27,8);
   write('Name                   Sex');
   for x := 1 to 10 do
    begin
     gotoxy(26,x+8);
     if x < 10 then write(' ', x, '. ') else write(x, '. ');
    end;
   for x := 1 to 10 do
    begin
     Name := GetString(29,x+8,12,locked,visable,reg);
     if Name[1] = ' ' then Name := '{EMPTY}';
     textcolor(yellow);
     textbackground(blue);
     PutString(29,x+8,12,Name);
     if Name <> '{EMPTY}' then
      begin
       textcolor(white);
       textbackground(black);
       gotoxy(51,x+8);
       write(' ');
       gotoxy(51,x+8);
        repeat
         Key := readkey;
         Key := upcase(Key);
        until Key in ['M', 'F'];
       textcolor(yellow);
       textbackground(blue);
       write(Key);
       Sex := Key = 'M';
      end;
     P.Name := Name;
     P.Sex := Sex;
     if Sex then P.TotHP := 10 else P.TotHP := 8;
     P.HitPt := P.TotHP;
     P.Hand := 0;
     P.Range := 0;
     P.Armor := 0;
     P.Gold := 10 + random(10)+1;
     P.Kills := 0;
     write(PFile, P);
    end;
   close(PFile);
  end;
 FadeOut;
end.


