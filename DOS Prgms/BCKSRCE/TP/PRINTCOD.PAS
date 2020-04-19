{ Written 9/23/96 by Jon Hyland
  For use in printing source codes. }

program SourceCodePrinter;

uses
 Crt,
 Printer;

var
 PFile     : text;
 Page      : integer;
 PageLine  : integer;
 LineChar  : integer;
 Cha       : char;
 StartPage : integer;

function RealVal(S : string) : real;
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
  if not Neg then RealVal := Num
  else RealVal := -Num;
 end;

begin
 writeln('SourceCode Printer  v1.0 - (c) 1996 by Jon Hyland');
 if paramstr(1) <> '' then
  begin
   assign(PFile, paramstr(1));
   if paramstr(2) <> '' then
    StartPage := trunc(RealVal(paramstr(2)))
   else
    StartPage := 1;
   reset(PFile);
   PageLine := 1;
   LineChar := 0;
   Page := 1;
    repeat
     read(PFile, Cha);
     LineChar := LineChar + 1;
     if LineChar > 80 then
      begin
       LineChar := 1;
       PageLine := PageLine + 1;
       if Page >= StartPage then writeln(Lst);
      end;
     if Page >= StartPage then write(Lst, Cha);
     if Cha = #10 then
      PageLine := PageLine + 1;
     if Cha = #13 then
      LineChar := 1;
     if PageLine >= 59 then
      begin
       PageLine := 1;
       if Page >= StartPage then writeln(Lst);
       if Page >= StartPage then write(Lst, '                           ',
        '                                        Page ', Page);
       if Page >= StartPage then write(Lst, #12);
       Page := Page + 1;
      end;
    until Eof(PFile);
   close(PFile);
  end
 else
  begin
   writeln(' usage : PRINTCOD <FILENAME.EXT> <STARTPAGE>');
  end;
end.
