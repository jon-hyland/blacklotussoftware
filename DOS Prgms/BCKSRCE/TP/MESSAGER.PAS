program AutoMessager;

uses
 Crt, Std;

const
 VerNum = '1.0';

type
 TextType = array[1..70, 1..20] of char;
 UserFileType = record
   Name     : string[16];
   Password : string[16];
   Security : integer;
  end;

var
 Cha    : TextType;
 TFile  : text;
 UFile  : file of UserFileType;
 x, y   : integer;
 Name   : string[16];
 Num    : integer;
 NumS   : string;
 Key    : char;
 ox, oy : integer;
 j, k   : integer;
 Line   : string;

procedure Title;
 begin
  Clear;
  DrawWindow(29,9,52,15,1,'Info');
  textcolor(yellow);
  gotoxy(32,10);
  write('- Auto Messager -');
  gotoxy(39,11);
  write('v', VerNum);
  gotoxy(36,13);
  write('(c) 1997');
  gotoxy(31,14);
  write('Black Lotus Software');
  Cursor;
  readkey;
 end;

procedure Init;
 var
  j, k : integer;
 begin
  Clear;
  assign(UFile, 'C:\DOS\USER.DAT');
  for k := 1 to 20 do
   for j := 1 to 70 do
    Cha[j,k] := ' ';
 end;

function GoodUserName : boolean;
 var
  User : UserFileType;
  x    : integer;
 begin
  DelayTime := 100;
  DrawWindow(28,10,52,13,4,'Send Message');
  textcolor(yellow);
  gotoxy(30,11);
  write('Enter user name :');
  Name := GetString(32,12,16,unlock,visable,upper);
  Num := 0;
  reset(UFile);
  while not Eof(UFile) do
   begin
    read(UFile, User);
    if DeScramble(User.Name) = Name then
     Num := User.Security;
   end;
  GoodUserName := Num <> 0;
  if Name = '#ESC#' then GoodUserName := true;
 end;

function SaveMessage_Ask : boolean;
 var
  Key : char;
 begin
  DrawWindow(30,10,51,13,4,'Save');
  textcolor(yellow);
  gotoxy(32,11);
  write('Send this message?');
  gotoxy(38,12);
  write('(Y/N)');
  Cursor;
  textcolor(white);
  textbackground(red);
   repeat
    Key := readkey;
    Key := upcase(Key);
    if Key = 'Y' then
     begin
      gotoxy(39,12);
      write('Y');
     end;
    if Key = 'N' then
     begin
      gotoxy(41,12);
      write('N');
     end;
    Cursor;
   until Key in ['Y', 'N'];
  SaveMessage_Ask := Key = 'Y';
  delay(150);
 end;

function LengthLine(y : integer) : integer;
 var
  j : integer;
 begin
  j := 70;
  while (j >= 1) and (Cha[j,y] = ' ') do
   j := j - 1;
  LengthLine := j;
 end;

function TotalLines : integer;
 var
  k : integer;
 begin
  k := 20;
  while (k > 1) and (LengthLine(k) = 0) do
   k := k - 1;
  TotalLines := k;
 end;

begin
 BlackLotusIntro;
 Title;
 Init;
  repeat
  until GoodUserName;
 if Name <> '#ESC#' then
  begin
   str(Num, NumS);
   assign(TFile, concat('C:\MSG\MSG', NumS, '.TXT'));
   DelayTime := 20;
   DrawWindow(4,2,75,23,7,'Send Message');
   textcolor(black);
   x := 1;
   y := 1;
    repeat
     ox := x;
     oy := y;
     gotoxy(x+4,y+2);
     Key := readkey;
      case Key of
       #0 :
        begin
         Key := readkey;
          case Key of
           'H' : y := y - 1;
           'K' : x := x - 1;
           'P' : y := y + 1;
           'M' : x := x + 1;
           'G' : x := 1;
           'O' :
            begin
             x := 69;
             while (x > 1) and (Cha[x,y] = ' ') do
              x := x - 1;
             if Cha[x,y] <> ' ' then x := x + 1;
            end;
           'S' :
            begin
             for j := x to 69 do
              Cha[j,y] := Cha[j+1,y];
             Cha[70,y] := ' ';
             gotoxy(x+4, y+2);
             for j := x to 70 do
              write(Cha[j,y]);
            end;
          end; {case}
         if x < 1 then x := 70;
         if x > 70 then x := 1;
         if y < 1 then y := 20;
         if y > 20 then y := 1;
        end;
       #32..#126 :
        begin
         for j := 70 downto x+1 do
          Cha[j,y] := Cha[j-1,y];
         Cha[x,y] := Key;
         for j := x to 70 do
          write(Cha[j,y]);
         x := x + 1;
         if x > 70 then
          begin
           x := 1;
           y := y + 1;
           if y > 20 then y := 20;
          end;
        end;
       #13 :
        begin
         y := y + 1;
         if y > 20 then y := 20;
         x := 69;
         while (x > 1) and (Cha[x,y] = ' ') do
          x := x - 1;
         if Cha[x,y] <> ' ' then x := x + 1;
        end;
       #8 :
        begin
         Cha[x,y] := ' ';
         write(Cha[x,y]);
         x := x - 1;
         if x < 1 then
          begin
           y := y - 1;
           if y < 1 then
            begin
             x := 1;
             y := 1;
            end
           else
            begin
             x := 69;
             while (x > 1) and (Cha[x,y] = ' ') do
              x := x - 1;
             if Cha[x,y] <> ' ' then x := x + 1;
            end;
          end;
         Cha[x,y] := ' ';
         gotoxy(x+4,y+2);
         write(Cha[x,y]);
        end;
      end; {case}
    until Key = #27;
   if SaveMessage_Ask then
    begin
     rewrite(TFile);
     writeln(TFile, '#1#');
     for y := 1 to TotalLines do
      begin
       Line := '';
       for x := 1 to LengthLine(y) do
         Line := Line + Cha[x,y];
       writeln(TFile, Line);
      end;
     close(TFile);
     FadeOut;
    end
   else
    FadeOut2;
  end;
 DelayTime := 20;
 FadeOut2;
end.



