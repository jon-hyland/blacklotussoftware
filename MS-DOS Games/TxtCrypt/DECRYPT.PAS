{This version completed 1/24/96.
 All coding by Jon Hyland.

 Tot Lines : 203
 File Size : 4157}

program TextDecrypt;

uses
 Crt, Dos;

var
 CodeFile : text;
 DcodFile : text;
 Seed : longint;
 Rand : integer;
 Str : string;
 Ch : char;
 Num : integer;
 Twirl, X, Y : integer;
 Protected : boolean;
 Password : longint;
 Junk : integer;

procedure Help;
 begin
  writeln('TextDecrypt v1.0 - Jon Hyland 1/24/96');
  writeln(' usage : DECRYPT <codefile.ext> <decdfile.ext>');
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

function Str2Int(S : string) : longint;
 var
  Ch : char;
  Num : real;
  Dec : boolean;
  Dv : real;
  Neg : boolean;
 begin
  Num := 0;
  Dec := false;
  Dv := 1;
  Neg := false;
  while S <> '' do
   begin
    Ch := S[1];
    if Ch in ['0'..'9'] then
     if not Dec then
      Num := Num * 10 + ord(Ch) - 48
     else
      begin
       Dv := Dv * 10;
       Num := Num + (ord(Ch) - 48) / Dv;
      end;
    if Ch = '.' then Dec := true;
    if Ch = '-' then Neg := true;
    delete(S,1,1);
   end;
  if not Neg then Str2Int := trunc(Num)
  else Str2Int := trunc(-Num);
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
  writeln('This file is protected.');
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
 assign(CodeFile, paramstr(1));
 assign(DcodFile, paramstr(2));
 reset(CodeFile);
 readln(CodeFile, Str);
 Protected := Str2Int(Str) > 500;
 if Protected then
  Password := GetPassword
 else
  begin
   Password := 0;
   writeln;
  end;
 readln(CodeFile, Str);
 Seed := Str2Int(Str) - Password;
 RandSeed := Seed;
 Junk := random(500)+1;
 rewrite(DcodFile);
 Twirl := 0;
 write('Decrypting data now ... ');
 X := WhereX;
 Y := WhereY;
  repeat
   Twirl := Twirl + 1;
   if Twirl > 8 then Twirl := 1;
    repeat
     read(CodeFile, Ch);
    until ((ord(Ch) <> 13) and (ord(Ch) <> 10));
   Rand := random(124)+1;
   Num := ord(Ch);
    case Num of
     252 : Num := 9;
     253 : Num := 10;
     254 : Num := 13;
    else
     Num := Num - Rand
    end; {case}
   Ch := chr(Num);
   write(DcodFile, Ch);
  until Eof(CodeFile);
 close(CodeFile);
 close(DcodFile);
 writeln;
 writeln('Finished.');
end.
