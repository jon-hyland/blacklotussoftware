program PassWordPrgm;

uses
 Crt;

var
 password : string[20];

begin
 password := 'go_away';
  while password <> 'JLH286343.975' do
   begin
    write('What''s the password: ');
    readln(password);
    if password <> 'JLH286343.975' then writeln('Wrong!');
   end;
 writeln;
end.

