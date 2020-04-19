program TestMouse;

uses
 Crt, Std;

var
 x, y  : integer;
 Click : integer;
 Key   : char;

begin
 BlackLotusIntro;
 MouseOn;
 Clear;
 DrawWindow(30,10,50,14,4,'Mouse Test');
 gotoxy(32,11);
 write('x = ');
 gotoxy(32,12);
 write('y = ');
 gotoxy(32,13);
 write('Button = NONE');
 Show;
 Cursor;
  repeat
   if (x <> MouseX) or (y <> MouseY) then
    begin
     x := MouseX;
     y := MouseY;
     gotoxy(36,11);
     write('  ');
     gotoxy(36,12);
     write('  ');
     gotoxy(36,11);
     write(x);
     gotoxy(36,12);
     write(y);
     Cursor;
    end;
   if Click <> GetClick then
    begin
     Click := GetClick;
     gotoxy(41,13);
     write('     ');
     gotoxy(41,13);
      case Click of
       0 : write('NONE');
       1 : write('LEFT');
       2 : write('RIGHT');
      end; {case}
     Cursor;
    end;
   if KeyPressed then Key := readkey;
  until Key = #27;
 MouseOff;
 FadeOut;
end.
