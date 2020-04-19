{Program started 12/9/97.}
program CoolView;

uses
 Crt, Std, Dos;

const
 VerNum         = 'v1.0';
 LineMax        = 126;
 TotMenus       = 5;
 MaxMenuOptions = 6;

type
 LineType       = string[LineMax];
 ScreenData     = array[1..100] of LineType;
 MenuRecordType = array[1..TotMenus] of record
   Name      : string[8];
   TotOption : integer;
   Option    : array[1..MaxMenuOptions] of record
     Name    : string[20];
     Active  : boolean;
     RunCode : integer;
    end; {record}
  end; {record}

var
 Menu  : MenuRecordType;
 TFile : text;
 DFile : file of LineType;
 Line  : ScreenData;
 x, y  : integer;
 FPos  : longint;
 FSize : longint;

procedure Text2Data;
 var
  Long  : string;
  Short : LineType;
  j, k  : integer;
 begin
  reset(TFile);
  rewrite(DFile);
  while not Eof(TFile) do
   begin
    readln(TFile, Long);
    Short := '';
    k := 1;
    for j := 1 to length(Long) do
     begin
      if k > LineMax then
       begin
        write(DFile, Short);
        writeln(Short);
        k := 1;
        Short := '';
       end;
      Short := Short + Long[j];
      k := k + 1;
     end;
    write(DFile, Short);
   end;
  close(TFile);
  close(DFile);
 end;

procedure Init;
 var
  j, k : integer;
 begin
  for k := 1 to 24 do
   for j := 1 to 80 do
    MArea[j,k] := 0;
  MouseOn;
  Show;
  x := MouseX;
  y := MouseY;
  if paramstr(1) <> '' then
   assign(TFile, paramstr(1))
  else
   assign(TFile, 'View.pas');
  assign(DFile, 'VIEW.TMP');
 Menu[1].Name := 'File';
 Menu[1].TotOption := 6;
 Menu[1].Option[1].Name := 'New';
 Menu[1].Option[1].Active := true;
 Menu[1].Option[1].RunCode := 1;


 end;

procedure Title;
 var
  Key  : char;
  ExID : integer;
 begin
  Clear;
  BackGround_I(true);
  DrawWindow(25,9,55,15,1,'Info');
  DrawButton(27,14,32,14,7,'Ok[1]',1);
  DrawButton(48,14,53,14,7,'Exit[2]',2);
  textcolor(red);
  textbackground(blue);
  gotoxy(34,10);
  write('- C');
  textcolor(lightred);
  write('oo');
  textcolor(yellow);
  write('lV');
  textcolor(lightred);
  write('ie');
  textcolor(red);
  write('w -');
  textcolor(yellow);
  gotoxy(38,11);
  write(VerNum);
  Cursor;
  Show;
   repeat
    ExID := MHit;
    Key := StatusKey;
    Key := upcase(Key);
   until (ExID <> 0) or (Key in ['O','X',#13,#27]);
  if (ExID = 2) or (Key in ['X',#27]) then
   begin
    FadeOut;
    Halt(0);
   end;
  ClearBuffer;
  EraseButton(27,14,32,14,1);
  EraseButton(48,14,53,14,1);
  BackGround_I(false);
 end;

procedure DrawScreen;
 begin



begin
 BlackLotusIntro;
 Init;
 Title;
 Text2Data;


end.

