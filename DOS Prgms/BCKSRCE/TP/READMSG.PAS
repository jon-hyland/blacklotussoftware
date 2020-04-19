{$M $4000,0,0 }   { 16K stack, no heap }
program ReadMessage;

uses
 Crt, Std, Dos;

const
 VerNum = '1.0';

type
 TextType = array[1..70, 1..20] of char;

var
 Cha      : TextType;
 TFile    : text;
 x, y     : integer;
 Key      : char;
 FileName : string;
 Code     : string[3];
 Path     : PathStr;

procedure Title;
 begin
  Clear;
  DrawWindow(28,9,53,15,1,'Info');
  textcolor(yellow);
  gotoxy(31,10);
  write('- Messager Reader -');
  gotoxy(39,11);
  write('v', VerNum);
  gotoxy(36,13);
  write('(c) 1997');
  gotoxy(30,14);
  write('Black Lotus Software');
  Cursor;
  readkey;
 end;

begin
 FileName := 'C:\MSG\MSG' + paramstr(1) + '.TXT';
 assign(TFile, FileName);
 Path := FSearch(FileName, GetEnv('PATH'));
 if Path = '' then
  begin
   rewrite(TFile);
   writeln(TFile, '#0#');
   close(TFile);
  end;
 reset(TFile);
 readln(TFile, Code);
 close(TFile);
 if Code = '#0#' then
  begin
   Clear;
   DrawWindow(30,10,50,14,4,'Guess What?');
   textcolor(yellow);
   gotoxy(32,12);
   write('You have no mail.');
   Cursor;
   delay(1000);
   Clear;
   halt(0);
  end;
 BlackLotusIntro;
 Clear;
 Title;
 for y := 1 to 20 do
  for x := 1 to 70 do
   Cha[x,y] := ' ';
 reset(TFile);
 readln(TFile, Code);
 x := 1;
 y := 1;
 while not Eof(TFile) do
  begin
   read(TFile, Key);
    case Key of
     #32..#126 :
      begin
       if (x in [1..70]) and (y in [1..20]) then
        Cha[x,y] := Key;
       x := x + 1;
      end;
     #13 : y := y + 1;
     #10 : x := 1;
    end; {case}
  end;
 close(TFile);
 DrawWindow(4,2,75,23,7,'You have a message :');
 textcolor(black);
 for y := 1 to 20 do
  begin
   gotoxy(5,y+2);
   for x := 1 to 70 do
    write(Cha[x,y]);
   Cursor;
  end;
 ClearBuffer;
 readkey;
 DrawWindow(30,10,51,12,1,'Message');
 textcolor(yellow);
 gotoxy(32,11);
 write('[S]ave or [D]elete');
 Cursor;
  repeat
   Key := readkey;
   Key := upcase(Key);
  until Key in ['S', 'D'];
 if Key = 'D' then
  begin
   rewrite(TFile);
   writeln(TFile, '#0#');
   close(TFile);
   FadeOut2;
  end
 else
  FadeOut;
end.