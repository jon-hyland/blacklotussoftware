program Test;

uses
 Crt;

var
 PassStr : string[8];
 PassNum : longint;


begin
 clrscr;
 PassNum := GetPassword;
 writeln(PassNum);
 readkey;
end.
