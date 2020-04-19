program AlarmClock;

uses
 Dos, Std;

type
 TimeRec = record
   Hour   : word;
   Minute : word;
   Sec    : word;
   Sec100 : word;
  end;

var
 WFile  : file of TimeRec;
 Wake   : TimeRec;
 Time   : TimeRec;
 x, y   : integer;
 Alarm  : boolean;
 Key    : char;
 Dir    : integer;
 Rand   : longint;
 Lst100 : integer;
 nx, ny : integer;
 Color  : integer;

procedure Init;
 var
  Pth  : PathStr;
  Jnk  : TimeRec;
 begin
  randomize;
  assign(WFile, 'CLOCK.DAT');
  Pth := fsearch('CLOCK.DAT',GetEnv('PATH'));
  if Pth = '' then
   begin
    rewrite(WFile);
    Jnk.Hour := 0;
    Jnk.Minute := 0;
    Jnk.Sec := 0;
    Jnk.Sec100 := 0;
    write(WFile, Jnk);
    close(WFile);
   end;
  reset(WFile);
  read(WFile, Wake);
  close(WFile);
  gettime(Time.Hour, Time.Minute, Time.Second, Time.Sec100);
  x := 1;
  y := 1;
  Dir := 5;
  Ring := false;
  Color := 4;
 end;

procedure ShowTime;
 begin
  if Time.Hour < 12 then
   write('`')
  else
   write(' ');
   case Time.Hour of
    0      : write('12');
    1..12  : write(Time.Hour);
    13..23 : write(Time.Hour - 12);
   end; {case}
  write(':', Time.Minute, ':', Time.Sec, '.', Time.Sec100);
  if Alarm then write('.');
  Cursor;
 end;

begin
 BlackLotusIntro;
  repeat
   gettime(Time.Hour, Time.Minute, Time.Second, Time.Sec100);
   if (Time.Hour = Wake.Hour) and (Time.Minute = Wake.Minute)
    then Ring := true;
   if Time.Sec100 <> Lst100 then
    begin
     Lst100 := Time.Sec100;
     textcolor(Color);
     ShowTime;
     Rand := random(1000);
     if Rand = 0 then textcolor(random(15)+1);
     Rand := random(1000);
      case Rand of
       0 :      {new location}
        begin
         textcolor(black);
         gotoxy(x,y);
         write('    ');
         ShowTime;
         x := random(65)+1;
         y := random(24)+1;
        end;
       1..500 :  {move in Dir direction}
        begin
          case Dir of
           1 :
            begin
             ny := y + 1;
             nx := x - 1;
            end;
           2 : ny := y + 1;
           3 :
            begin
             nx := x + 1;
             ny := y + 1;
            end;
           4 : x := x - 1;
           5 :
            begin
             nx := x;
             ny : = y;
            end;
           6 : x := x + 1;
           7 :
            begin
             nx := x - 1;
             ny := y - 1;
            end;
           8 : ny := y - 1;
           9 :
            begin
             nx := x + 1;
             ny := y - 1;
            end;
          end; {case}
         textcolor(black);
         textbackground(black);
         gotoxy(x,y);
         write('    ');
         ShowTime;
        end;
      end; {case}
     if not(nx in [1..65]) or not(ny in [1..24]) then
      Dir := random(8)+1
     else
      begin
       x := nx;
       y := ny;
      end;
     Rand := random(300);
     if Rand = 0 then Dir := random(9)+1;
    end;
   if KeyPressed then
    begin
     Key := readkey;
      case Key of
