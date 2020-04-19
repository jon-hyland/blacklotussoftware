program FakeDos;

uses
 Crt;

type
 Matrix = array[1..80,1..25] of integer;

var
 Screen : matrix;
 xpos : integer;
 ypos : integer;
 key : char;

procedure Start;
 begin
  randomize;
  textcolor(lightgray);
  clrscr;



