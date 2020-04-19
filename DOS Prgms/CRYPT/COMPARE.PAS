{This version completed 1/24/96.
 All coding by Jon Hyland.

 Tot Lines : 72
 File Size : 1420}

program CompareText;

uses
 Crt, Dos;

var
 File1 : text;
 File2 : text;
 Ch1, Ch2 : char;
 Same : boolean;
 Twirl, X, Y : integer;

procedure Help;
 begin
  writeln('TextCompare v1.0 - Jon Hyland 1/24/96');
  writeln(' usage : COMPARE <filenam1.ext> <filenam2.ext>');
  Halt(0);
 end;

function FileExist(FileName : string) : boolean;
 begin
  FileExist := FSearch(FileName, '') <> '';
 end;

procedure NoFile;
 begin
  writeln('Error! - File does not exist.');
  Halt(0);
 end;

begin
 if (paramstr(1) = '') or (paramstr(2) = '') then Help;
 if not FileExist(paramstr(1)) then NoFile;
 if not FileExist(paramstr(2)) then NoFile;
 writeln;
 write('Comparing files ... ');
 X := WhereX;
 Y := WhereY;
 Same := true;
 assign(File1, paramstr(1));
 assign(File2, paramstr(2));
 reset(File1);
 reset(File2);
 Twirl := 0;
  repeat
   Twirl := Twirl + 1;
   if Twirl > 8 then
    Twirl := 1;
   read(File1, Ch1);
   read(File2, Ch2);
   if Ch1 <> Ch2 then Same := false;
   gotoxy(X,Y);
   case Twirl of
    1, 5 : write('|');
    2, 6 : write('/');
    3, 7 : write('-');
    4, 8 : write('\');
   end; {case}
  until Eof(File1) or Eof(File2);
 writeln;
 if Same then
  writeln('These files are the same.')
 else
  writeln('These files are different.');
end.