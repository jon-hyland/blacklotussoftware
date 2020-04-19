program PhoneMaster;

uses
 Crt, Std, Dos;

const
 VerNum = 'v1.0';

type
 PersonRecord = record
   First    : string[12];
   Last     : string[12];
   Phone    : string[12];
   Address1 : string[25];
   Address2 : string[25];
   EMail    : string[25];
  end;

var
 PFile    : file of PersonRecord;
 Person   : PersonRecord;
 Num, Tot : integer;
 Key      : char;
 x, y     : integer;


procedure Init;
 var
  Pth : PathStr;
  Jnk : PersonRecord;
 begin
  assign(PFile, 'C:\PHONE\PHONE.DAT');
  Pth := fsearch('C:\PHONE\PHONE.DAT',GetEnv('PATH'));
  if Pth = '' then
   begin
    Jnk.First    := 'DELETE';
    Jnk.Last     := 'ME';
    Jnk.Phone    := '';
    Jnk.Address1 := '';
    Jnk.Address2 := '';
    Jnk.EMail    := '';
    rewrite(PFile);
    write(PFile, Jnk);
    close(PFile);
   end;
  reset(PFile);
  Tot := 0;
  while not eof(PFile) do
   begin
    read(PFile, Jnk);
    Tot := Tot + 1;
   end;
  Num := 1;
  MouseOn;
 end;

procedure Title;
 begin
  Background_I(true);
  DrawWindow(29,7,51,17,4,'Info');
  textcolor(yellow);
  gotoxy(31,8);
  write('-= Phone  Master =-');
  gotoxy(38,9);
  write(VerNum);
  textcolor(lightgray);
  gotoxy(31,11);
  write('Coded by Jon Hyland');
  gotoxy(36,13);
  write('(c) 1998');
  gotoxy(31,14);
  write('Black Lotus Software');
  Cursor;
  ClearBuffer;
  readkey;
 end;


begin
 BlackLotusIntro;
 Init;
 Title;
end.



