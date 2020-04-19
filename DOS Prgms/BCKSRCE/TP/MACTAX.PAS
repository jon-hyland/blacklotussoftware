program TaxOwed;

const
 Sentinel = 0;

var
 TotTax : real;

procedure DispInst;
 begin
  writeln(' -Instructions -');
  writeln;
  writeln('Blah, blah, blah...');
  writeln('Blah, blah, blah...');
  writeln('Blah, blah, blah...');
  writeln;
  write('Press (Return) to continue..');
  readln;
 end;

function ComputeTax(Market : real; Senior : boolean) : real;
 var
  Tax : real;
  Assessed : real;
 begin
  Assessed := Market * 0.28;
  if Market > 150000 then
   Tax := Assessed * 0.175
  else
   Tax := Assessed * 0.125;
  if Senior then
   Tax := Tax * 0.9;
  ComputeTax := Tax
 end;

procedure ProcessProperty(var TotalTax : real);
 var
  Key : char;
  MarketValue : real;
  SeniorCit : boolean;
  Taxes : real;
 begin
  TotalTax := 0;
   repeat
    write('Market Value $');
    readln(MarketValue);
    if MarketValue > 0 then
     begin
       repeat
        write('Are you old (Y/N): ');
        readln(Key);
        if Key = 'y' then Key := 'Y';
        if Key = 'n' then Key := 'N';
       until (Key = 'Y') or (Key = 'N');
      if Key = 'Y' then SeniorCit := true else SeniorCit := false;
      Taxes := ComputeTax(MarketValue, SeniorCit);
      TotalTax := TotalTax + Taxes;
      writeln('Taxes on this property = $', Taxes:0:2)
     end;
    writeln;
   until MarketValue <= 0;
 end;

procedure DisplayTotal(TT : real);
 begin
  writeln('Total taxes on all property = $', TT:0:2);
  writeln;
  write('Press (Return) to end..');
  readln
 end;

begin
 DispInst;
 ProcessProperty(TotTax {output});
 DisplayTotal(TotTax {input});
end.







