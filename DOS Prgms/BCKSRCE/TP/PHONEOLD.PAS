program PersonRecord;

uses
 Crt, Std;

const
 VersionNum = '1.0';

type
 PersonFileType = record
   FirstName : string[10];
   LastName  : string[12];
   PhoneNum  : string[12];
   Address   : string[25];
  end;

var
 Person : PersonFileType;
 PFile  : file of PersonFileType;
 Swap   : file of PersonFileType;
 PNum   : integer;
 PMax   : integer;
 Key    : char;

procedure LoadPerson(Num : integer);
 var
  x : integer;
 begin
  reset(PFile);
  for x := 1 to Num do
   if not Eof(PFile) then
    read(PFile, Person);
  close(PFile);
 end;

procedure Output;
 begin
  textcolor(white);
  textbackground(black);
  gotoxy(54,8);
  write('  ');
  gotoxy(35,8);
  write('          ');
  gotoxy(35,10);
  write('            ');
  gotoxy(35,12);
  write('            ');
  gotoxy(32,14);
  write('                         ');
  gotoxy(54,8);
  write(PNum);
  gotoxy(35,8);
  write(Person.FirstName);
  gotoxy(35,10);
  write(Person.LastName);
  gotoxy(35,12);
  write(Person.PhoneNum);
  gotoxy(32,14);
  write(Person.Address);
  Cursor;
 end;

procedure Title;
 begin
  Clear;
  textcolor(darkgray);
  textbackground(black);
  gotoxy(45,25);
  write('(c) 1997 Black Lotus Software');
  DrawWindow(25,9,55,12,4,'Info');
  textcolor(yellow);
  gotoxy(32,10);
  write('- Person Record -');
  gotoxy(38,11);
  write('v', VersionNum);
  Cursor;
  readkey;
  EraseWindow(25,9,55,12);
 end;

procedure Init;
 var
  Junk : PersonFileType;
 begin
  assign(PFile, 'PFILE.DAT');
  assign(Swap, 'SWAP.DAT');
  PMax := 0;
  reset(PFile);
  while not Eof(PFile) do
   begin
    read(PFile, Junk);
    PMax := PMax + 1;
   end;
  close(PFile);
  Title;
  DrawWindow(20,7,58,17,1,'Person File');
  textcolor(lightgray);
  gotoxy(49,8);
  write('No.: ');
  gotoxy(22,8);
  write('First Name : ');
  gotoxy(22,10);
  write('Last Name  : ');
  gotoxy(22,12);
  write('Phone Num  : ');
  gotoxy(22,14);
  write('Address : ');
  textcolor(yellow);
  gotoxy(22,16);
  write('[Esc] Quit       [N]ew       [D]el');
  gotoxy(50,9);
  write(#27, '  ', #26);
  PNum := 1;
  Cursor;
 end;

procedure NewPerson;
 var
  Junk : PersonFileType;
 begin
  PNum := PMax + 1;
  PMax := PMax + 1;
  gotoxy(54,8);
  write('  ');
  gotoxy(35,8);
  write('          ');
  gotoxy(35,10);
  write('            ');
  gotoxy(35,12);
  write('            ');
  gotoxy(32,14);
  write('                         ');
  gotoxy(54,8);
  write(PNum);
  Person.FirstName := GetString(35,8,10,locked,visable,reg);
  Person.LastName  := GetString(35,10,12,locked,visable,reg);
  Person.PhoneNum  := GetString(35,12,12,locked,visable,reg);
  Person.Address   := GetString(32,14,25,locked,visable,reg);
  reset(PFile);
  while not Eof(PFile) do
   read(PFile, Junk);
  write(PFile, Person);
  close(PFile);
 end;

function MakeSure : boolean;
 var
  Key : char;
 begin
  DrawWindow(25,19,55,21,3,'Input');
  gotoxy(28,20);
  write('Delete this person (Y/N)?');
  Cursor;
   repeat
    Key := readkey;
    Key := upcase(Key);
   until Key in ['Y','N'];
  MakeSure := Key = 'Y';
  EraseWindow(25,19,55,21);
 end;

procedure DeletePerson;
 var
  Junk : PersonFileType;
  Count : integer;
 begin
  rewrite(Swap);
  reset(PFile);
  Count := 1;
  while not Eof(PFile) do
   begin
    read(PFile, Junk);
    if Count <> PNum then
      write(Swap, Junk);
    Count := Count + 1;
   end;
  close(PFile);
  close(Swap);
  reset(Swap);
  rewrite(PFile);
  while not Eof(Swap) do
   begin
    read(Swap, Junk);
    write(PFile, Junk);
   end;
  close(PFile);
  close(Swap);
  PMax := PMax - 1;
  if PNum > PMax then PNum := PMax;
 end;

begin
 Init;
  repeat
   LoadPerson(PNum);
   Output;
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in ['H','K','P','M',#27,'N','D','+','-'];
    case Key of
     '-','H','K' :
      begin
       PNum := PNum - 1;
       if PNum < 1 then PNum := PMax;
      end;
     '+','P','M' :
      begin
       PNum := PNum + 1;
       if PNum > PMax then PNum := 1;
      end;
     'N' :
      begin
       NewPerson;
      end;
     'D' :
      begin
       if PMax > 1 then
        if MakeSure then
         DeletePerson;
      end;
    end; {case}
  until Key = #27;
 Fadeout;
end.



