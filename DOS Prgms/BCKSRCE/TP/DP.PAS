program Test;

uses
 Crt;

var
 j, k : integer;
 Key : char;

begin
 textbackground(black);
 clrscr;
 for k := 1 to 24 do
  begin
    case k of
     1..6, 19..24 :
      begin
       textcolor(red);
       textbackground(black);
      end;
     7..17 :
      begin
       textcolor(lightred);
       textbackground(red);
      end;
    end;
    case k of
     1,2,7,8,17,18,23,24   : Key := chr(176);
     3,9,16,22             : Key := chr(177);
     4,5,10,11,14,15,20,21 : Key := chr(178);
     6,12,13,17,19,23,24   : Key := chr(219);
    end; {case}
   gotoxy(1,k);
   write(Key,Key);
   gotoxy(79,k);
   write(Key,Key);
  end;

 readkey;
end.

