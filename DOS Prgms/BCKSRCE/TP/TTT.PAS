program TicTacToe;

uses
 Crt;

type
 GridType = array[1..3, 1..3] of integer;

var
 Grid : GridType;
 Quit : boolean;
 Done : boolean;
 Turn : integer;
 Spot : integer;

procedure ProgInit;
 begin
  randomize;
  Quit := false;
 end;

procedure GameInit;
 var
  x, y : integer;
 begin
  Done := false;
  for y := 1 to 3 do
   for x := 1 to 3 do
    Grid[x,y] := 0;
  Turn := random(2)+1;
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

procedure Title;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  gotoxy(30,10);
  write('- Tic Tac Toe  v1.0 -');
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  Cursor;
  textcolor(white);
  readkey;
 end;

procedure DrawScreen;
 var
  x, y : integer;
 begin
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  for x := 28 to 50 do
   begin
    gotoxy(x, 9);
    write(chr(223));
    gotoxy(x, 13);
    write(chr(223));
   end;
  for y := 6 to 16 do
   begin
    gotoxy(35, y);
    write(chr(219));
    gotoxy(43, y);
    write(chr(219));
   end;
  Cursor;
 end;

function PlayerMove : integer;
 var
  Key : char;
 begin
   repeat
    Key := readkey;
   until (Key in ['1'..'9']);
  PlayerMove := ord(Key) - 48;
 end;

function PlayerTotal : integer;
 var
  x, y : integer;
  Highest : integer;
 begin
  Highest := 0;
  for y := 1 to 3 do
   for x := 1 to 3 do
    begin

    end;


function CompMove : integer;
 begin


 end;

begin
 ProgInit;
 Title;
  repeat
   GameInit;
   DrawScreen;
    repeat
      case Turn of
       1 : Spot := PlayerMove;
       2 : Spot := CompMove;
      end; {case}


    until Done;


  until Quit;
 clrscr;
end.




