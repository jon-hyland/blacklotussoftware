program CopyText_v1_0;

var
 File1, File2 : string;

procedure CopyText(FileName1, FileName2 : string);
 var
  File1 : text;
  File2 : text;
  Str : string;
 begin
  assign(File1, FileName1);
  assign(File2, FileName2);
  rewrite(File2);
  reset(File1);
  while not Eof(File1) do
   begin
    readln(File1, Str);
    writeln(File2, Str);
   end;
  close(File1);
  close(File2);
 end;

begin
 writeln;
 if paramstr(1) <> '' then
  File1 := paramstr(1)
 else
  begin
   write('FileName1 : ');
   readln(File1);
  end;
 if paramstr(2) <> '' then
  File2 := paramstr(2)
 else
  begin
   write('FileName2 : ');
   readln(File2);
  end;
 CopyText(File1, File2);
end.

