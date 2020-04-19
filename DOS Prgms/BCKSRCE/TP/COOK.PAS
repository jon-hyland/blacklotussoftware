program TextMaster;

uses
 Crt, Std, Dos;

const
 VerNum = '1.0';

type
 TextArrayType = record
   Name : string[50];
   Cha  : array[1..60, 1..100] of char;
  end;

var
 Rec     : TextArrayType;
 RFile   : file of TextArrayType;
 Num     : integer;
 Tot     : integer;
 Key     : char;

procedure LoadEntry(Num : integer);
 var
  x : integer;
 begin
  reset(RFile);
  for x := 1 to Num do
   if not Eof(RFile) then
    read(RFile, Rec);
  close(RFile);
 end;

procedure Init;
 var
  Pth  : PathStr;
  Jnk  : TextArrayType;
  j, k : integer;
  Msg  : string;
 begin
  assign(RFile, 'TXTREC.DAT');
  Pth := fsearch('TXTREC.DAT',GetEnv('PATH'));
  if Pth = '' then
   begin
    rewrite(RFile);
    Jnk.Name := 'THIS IS A TEST';
    for k := 1 to 100 do
     for j := 1 to 60 do
      Jnk.Cha[j,k] := ' ';
    Msg := 'Please delete this entry.';
    for j := 1 to length(Msg) do
     Jnk.Cha[j,1] := Msg[j];
    write(RFile, Jnk);
    close(RFile);
   end;
  reset(RFile);
  Tot := 0;
  while not eof(RFile) do
   begin
    read(RFile, Jnk);
    Tot := Tot + 1;
   end;
  Num := 1;
  LoadEntry(Num);
 end;

procedure DrawScreen;
 begin
  Clear;
  DrawWindow(1,1,78,23,1,'Text Master');
  DrawWindow(30,7,50,13,4,'Info');
  textcolor(yellow);
  gotoxy(33,8);
  write('- Text Master -');
  gotoxy(38,9);
  write('v', VerNum);
  textcolor(lightgray);
  gotoxy(36,11);
  write('(c) 1997');
  gotoxy(35,12);
  write('Jon Hyland');
  Cursor;
  readkey;
  DrawWindow(10,3,70,20,0,Rec.Name);


  readkey;
 end;

begin
 Init;
{ BlackLotusIntro;}
 DrawScreen;
end.

