uses Crt;

var
 C: Char;

procedure cool;
 begin
  Writeln('Please press a key');
  C := Readkey;
  Writeln(' You pressed ', C, ', whose ASCII value is ', Ord(C), '.');
   repeat
    textcolor(white);
   until keypressed;
  cool;
end;

begin
 cool;
end.