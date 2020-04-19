program EnterPersonRecord;

uses
 Crt;

type
 PersonRecord = record
   First   : string[12];
   Last    : string[15];
   Phone   : string[10];
   Other   : string[10];
   EMAdd   : string[40];
  end;

var
 PFile : file of PersonRecord;
 PRec  : PersonRecord;
 Key   : char;

begin
 assign(PFile, 'PHNDIR.DAT');
 textcolor(white);
 textbackground(black);
 clrscr;
 write('First : ');
 readln(PRec.First);
 write('Last : ');
 readln(PRec.Last);
 write('Phone : ');
 readln(PRec.Phone);
 write('Other : ');
 readln(PRec.Other);
 write('EMAdd : ');
 readln(PRec.EMAdd);
 while KeyPressed do readkey;
 write('[A]dd to Existing    [R]eset');
 Key := readkey;
{ if Key in ['R','r'] then
  rewrite(PFile)}

 reset(PFile);
 write(PFile, PRec);
 close(PFile);
 clrscr;
end.

