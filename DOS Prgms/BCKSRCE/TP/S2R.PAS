program Test;

var
 SNum : string;
 RNum : real;

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
 write('String: ');
 readln(SNum);
 RNum := RealVal(SNum);
 write('Real  : ', RNum:0:3);
 readln;
end.