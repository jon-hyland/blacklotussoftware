program BenkAccount;

uses
 Crt, Dos;

type
 SaveFileType = file of integer;

var
 BankFile : SaveFileType;
 Bal : integer;
 Key : char;
 Money : integer;

begin
 assign(BankFile, 'BANK.DAT');
 if FSearch('BANK.DAT', '') = '' then
  begin
   writeln('Bank file does not exist.');
   write('Enter bank balance : $');
   read(Bal);
   rewrite(BankFile);
   write(BankFile, Bal);
   close(BankFile);
  end
 else
  begin
   reset(BankFile);
   read(BankFile, Bal);
   close(BankFile);
  end;
  repeat
   writeln('-------------------------');
   writeln('Money in bank : $', Bal);
   writeln;
   writeln('1] Deposit');
   writeln('2] Withdraw');
   writeln('3] Quit');
   write('Choice: ');
    repeat
     Key := readkey;
     Key := upcase(Key);
    until Key in ['1'..'3'];
   write(Key);
   writeln;
   if Key = '1' then
    begin
     writeln;
      repeat
       write('Deposit : $');
       readln(Money);
      until Money >= 0;
     Bal := Bal + Money;
    end;
   if Key = '2' then
    begin
     writeln;
      repeat
       write('Withdraw : $');
       readln(Money);
      until Money >= 0;
     Bal := Bal - Money;
     if Bal <= 0 then
      begin
       writeln('No money in account!');
       sound(200);
       delay(200);
       nosound;
      end;
    end;
  until Key = '3';
 reset(BankFile);
 write(BankFile, Bal);
 close(BankFile);
end.

