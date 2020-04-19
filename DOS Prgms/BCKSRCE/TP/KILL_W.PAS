uses
 Crt, Std;

var
 TFile : text;
 Name : string[25];
 Power : real;
 Price : integer;
 Num : integer;
 s : string;

begin
 assign(TFile, 'KILL.INC');
 append(TFile);
 Num := 1;
  repeat
   write('Hand Name #', Num, ' : ');
   readln(Name);
   if Name = '' then
    begin
     Break;
    end;
   writeln(TFile, '  HandInfo[', Num, '] := ', Name, ';');
   write('Hand Power #', Num, ' : ');
   readln(Power);
   writeln(TFile, '  HandInfo.Power[', Num, '] := ', Power, ';');
   write('Hand Price #', Num, ' : ');
   readln(Price);
   writeln(TFile, '  HandInfo.Price[', Num, '] := ', Price, ';');
   writeln(TFile, ' ');
   Num := Num + 1;
  until Name = '';

 writeln('----------------------------------------');
 Num := 1;
  repeat
   write('Range Name #', Num, ' : ');
   readln(Name);
   if Name = '' then Break;
   writeln(TFile, '  RangeInfo.Name[', Num, '] := ', Name, ';');
   write('Range Power #', Num, ' : ');
   readln(Power);
   writeln(TFile, '  RangeInfo.Power[', Num, '] := ', Power, ';');
   write('Range Price #', Num, ' : ');
   readln(Price);
   writeln(TFile, '  RangeInfo.Price[', Num, '] := ', Price, ';');
   writeln(TFile, ' ');
   Num := Num + 1;
  until Name = '';

 writeln('----------------------------------------');
 Num := 1;
  repeat
   write('Armor Name #', Num, ' : ');
   readln(Name);
   if Name = '' then Break;
   writeln(TFile, '  ArmorInfo.Name[', Num, '] := ', Name, ';');
   write('Armor Power #', Num, ' : ');
   readln(Power);
   writeln(TFile, '  ArmorInfo.Power[', Num, '] := ', Power, ';');
   write('Armor Price #', Num, ' : ');
   readln(Price);
   writeln(TFile, '  ArmorInfo.Price[', Num, '] := ', Price, ';');
   writeln(TFile, ' ');
   Num := Num + 1;
  until Name = '';

 close(TFile);
end.





