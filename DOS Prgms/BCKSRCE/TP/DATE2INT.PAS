program Test;

uses
 Crt;

var
 Date : string[8];
 DateNum : longint;
 k : char;

function Date2Int(ds : string) : longint;
 var
	dns : string[6];
	dn : longint;
	c : integer;
 begin
	dns := concat((copy(ds, 1, 2)), copy(ds, 4, 2), copy(ds, 7, 2));
	val(dns, dn, c);
	Date2Int := dn;
 end;

begin
 clrscr;
 write('Date (00/00/00):');
 readln(Date);
 DateNum := Date2Int(Date);
 writeln(DateNum);
 write(DateNum + 1);
 k := readkey;
end.





