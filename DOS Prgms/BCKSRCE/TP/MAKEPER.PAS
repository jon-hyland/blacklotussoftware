program MakePaersonFile;

uses
 Crt;

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
 x : integer;

begin
 textcolor(white);
 clrscr;
 assign(PFile, 'PFILE.DAT');
 rewrite(PFile);
 for x := 1 to 3 do
  begin
   write('FN:');
   readln(Person.FirstName);
   write('LN:');
   readln(Person.LastName);
   write('Ph:');
   readln(Person.PhoneNum);
   write('Ad:');
   readln(Person.Address);
   write(PFile, Person);
   writeln('--------------------------------');
  end;
 close(PFile);
end.

