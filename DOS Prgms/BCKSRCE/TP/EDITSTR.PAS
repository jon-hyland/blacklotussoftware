program Test;

uses
 Crt, Std;

var
 Str : string;



begin
 textcolor(yellow);
 textbackground(blue);
 clrscr;
 write('EditString test :');
 Str := 'TEsT';
 Str := EditString(10,10,8,Str,true,false,0);
 textcolor(lightred);
 textbackground(magenta);
 gotoxy(10,12);
 write(Str);
 readkey;
end.










