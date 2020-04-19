program Raises;

var
 OldPay : real;
 NewPay : real;


procedure DispInst;
 begin
  write('Instructions');
  readln;
 end;

function RaisePercent(Salary : real) : real;
 begin
  if Salary < 30000 then
   RaisePercent := 0.07
  else
   if Salary > 40000 then
    RaisePercent := 0.04
   else
    RaisePercent := 0.055
 end;

function Raise(Salary : real) : real;
 begin
  Raise := Salary * RaisePercent(Salary);
 end;

procedure ComputeRaises(var OldPayroll, NewPayroll : real);
 var
  Sal : real;
 begin
  OldPayroll := 0;
  NewPayroll := 0;
   repeat
    writeln;
    write('Salary : $');
    readln(Sal);
    if Sal > 0 then
     begin
      writeln('Raise percent %', (RaisePercent(Sal)*100):0:1);
      writeln('Raise : $', Raise(Sal):0:0);
      writeln('New salary : $', (Sal + Raise(Sal)):0:0);
      OldPayroll := OldPayroll + Sal;
      NewPayroll := NewPayroll + Sal + Raise(Sal);
     end;
   until Sal <= 0;
 end;

procedure DispPay(OldPayroll, NewPayroll : real);
 begin
  writeln;
  writeln('Old Payroll : ', OldPayroll:0:0);
  writeln('New Payroll : ', NewPayroll:0:0);
  writeln;
  write('Press [Return] to end..');
  readln;
 end;




begin
 DispInst;
 ComputeRaises(OldPay, NewPay);
 DispPay(OldPay, NewPay);
end.
