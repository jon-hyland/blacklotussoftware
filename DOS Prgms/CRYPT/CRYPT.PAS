{This version completed 1/24/96.
 All coding by Jon Hyland.

 Tot Lines : 188
 File Size : 3834}

program TextCrypt;

uses
 Crt, Dos;

var
 OrigFile : text;
 CodeFile : text;
 Seed : longint;
 Rand : integer;
 Ch : char;
 Num : integer;
 NewLine : integer;
 Twirl, X, Y : integer;
 Protect : boolean;
 Password : longint;
 Key : char;

procedure Help;
 begin
  writeln('TextCrypt v1.0 - Jon Hyland 1/24/96');
  writeln(' usage : CRYPT <origfile.ext> <codefile.ext>');
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

function GetPassword : longint;
 var
  Str : string[8];
  Key : char;
  X, Y : integer;
  GoodCh : boolean;
  j : integer;
 function Pass2Int(Str : string) : longint;
  var
   Num : longint;
   j : integer;
   Ch : char;
   Add : integer;
  begin
   Num := 0;
   for j := 1 to 8 do
    begin
     Ch := Str[1];
      case Ch of
       '0'..'9' : Add := ord(Ch) - 48;
       'A'..'B',
       'U'..'V' : Add := 3;
       'C'..'D',
       'W'..'X' : Add := 8;
       'E'..'F',
       'Y'..'Z' : Add := 4;
       'G'..'H' : Add := 0;
       'I'..'J' : Add := 5;
       'K'..'L' : Add := 6;
       'M'..'N' : Add := 9;
       'O'..'P' : Add := 1;
       'Q'..'R' : Add := 7;
       'S'..'T' : Add := 2;
      end; {case}
     Num := Num * 10 + Add;
     delete(Str,1,1);
    end;
    Pass2Int := Num;
  end;
{begin GetPassWord}
 begin
  writeln;
  write('Enter password : [        ]');
  Y := WhereY;
  X := 1;
  for j := 1 to 8 do
   Str[j] := ' ';
   repeat
    gotoxy(X+18,Y);
    Key := readkey;
    GoodCh := true;
     case Key of
      'A'..'Z' : Str[X] := Key;
      'a'..'z' : Str[X] := chr(ord(Key) - 32);
      '0'..'9' : Str[X] := Key;
     else
      GoodCh := false;
     end; {case}
    if (ord(Key) = 8) and (X > 1) then
     begin
      X := X - 1;
      Str[X] := ' ';
      gotoxy(X+18,Y);
      write(' ');
     end;
    if GoodCh then
     begin
      write(Str[X]);
      X := X + 1;
     end;
   until (ord(Key) = 13) or (X > 8);
  writeln;
  GetPassword := Pass2Int(Str);
 end;

begin
 if (paramstr(1) = '') or (paramstr(2) = '') then Help;
 if not FileExist(paramstr(1)) then NoFile;
 writeln;
 write('Password protect this file (Y/N)?');
  repeat
   Key := readkey;
   Key := upcase(Key);
  until (Key = 'Y') or (Key = 'N');
 Protect := Key = 'Y';
 if Protect then
  Password := GetPassword
 else
  begin
   Password := 0;
   writeln;
  end;
 randomize;
 write('Encrypting data now ... ');
 X := WhereX;
 Y := WhereY;
 Seed := RandSeed;
 RandSeed := Seed;
 assign(OrigFile, paramstr(1));
 assign(CodeFile, paramstr(2));
 rewrite(CodeFile);
 reset(OrigFile);
 if Protect then
  writeln(CodeFile, random(500)+502)
 else
  writeln(CodeFile, random(500)+1);
 writeln(CodeFile, Seed+Password);
 NewLine := 0;
 Twirl := 0;
  repeat
   NewLine := NewLine + 1;
   Twirl := Twirl + 1;
   if Twirl > 8 then
    Twirl := 1;
   read(OrigFile, Ch);
   Rand := random(124)+1;
   Num := ord(Ch);
    case Num of
      9 : Num := 252;
     10 : Num := 253;
     13 : Num := 254;
    else
     Num := Num + Rand
    end; {case}
   Ch := chr(Num);
   if Num < 32 then
    writeln('Error!  NonText chr# ', Num);
   write(CodeFile, Ch);
   if NewLine >= 75 then
    begin
     writeln(CodeFile);
     NewLine := 0;
    end;
  until Eof(OrigFile);
 close(OrigFile);
 close(CodeFile);
 writeln;
 writeln('Finished.');
end.