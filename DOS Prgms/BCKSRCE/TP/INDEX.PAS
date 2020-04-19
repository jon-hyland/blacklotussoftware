program WriteToSourceFile_DateTimeIndex;

uses
 Crt, Std, Dos;

var
 SFile  : text;
 Hour,
 Min,
 Sec,
 Sec100 : word;
 Year,
 Month,
 Day,
 DOW    : word;
 FText  : string;
 Ext    : boolean;
 x      : integer;

begin
 textcolor(white);
 textbackground(black);
 clrscr;
 write('Enter source code filename : ');
 readln(FText);
 if FText = '' then Halt(0);
 Ext := false;
 for x := 1 to length(FText) do
  if FText[x] = '.' then Ext := true;
 if not Ext then FText := FText + '.PAS';
 assign(SFile, FText);
 if fsearch(FText, GetEnv('PATH')) = '' then
  begin
   rewrite(SFile);
   write(SFile, ' ');
   close(SFile);
  end;
 getdate(Year, Month, Day, DOW);
 gettime(Hour, Min, Sec, Sec100);
 append(SFile);
 write(SFile, '{----------- ');
  case DOW of
   1 : write('Sun ');
   2 : write('Mon ');
   3 : write('Tue ');
   4 : write('Wed ');
   5 : write('Thu ');
   6 : write('Fri ');
   7 : write('Sat ');
  end; {case}
 write(SFile, Month, '/', Day, '/', Year, ' at ');
  case Hour of
   0      : write(SFile, '12:');
   1..12  : write(SFile, Hour, ':');
   13..23 : write(SFile, Hour-12, ':');
  end; {case}
 write(SFile, Min, ' ');
  case Hour of
   0..12  : write(SFile, 'AM');
   13..23 : write(SFile, 'PM');
  end; {case}
 writeln(SFile, ' -------------}');
 close(SFile);
end.







{----------- 7/28/1997 at 11:13  -------------}
{----------- 7/28/1997 at 11:16 PM -------------}
