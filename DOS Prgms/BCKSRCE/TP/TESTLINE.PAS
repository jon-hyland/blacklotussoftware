program Test;

uses
 Crt, Graph;

var
 GraphDriver : Integer;
 GraphMode : Integer;
 ErrorCode : Integer;
 x, y, r, d, m, xm, ym, mr : integer;

procedure graph_ini;
 begin
  GraphDriver := Detect;
  InitGraph(GraphDriver,GraphMode,'');
  ErrorCode := GraphResult;
  if ErrorCode <> GrOK then
   begin
    writeln('Graphics Error: ', GraphErrorMsg(ErrorCode));
    writeln('Program Aborted...');
    halt(1);
   end;
 end;

procedure Start;
 begin
  randomize;
  graph_ini;
  x := random(640)+1;
  y := random(460)+1;
  r := random(75)+1;
  d := random(2)+1;
  m := random(250)+1;
  xm := random(3);
  ym := random(3);
  mr := random(150)+1;
 end;

procedure DrawCircle;
 begin
  setcolor(random(16));
  circle(x,y,r);
 end;

procedure ChangeSize;
 begin
  if d = 1 then r := r - 1;
  if d = 2 then r := r + 1;
  if r <= 1 then
   begin
    d := 2;
    mr := random(150);
   end;
  if r >= mr then d := 1;
 end;

procedure MovePos;
 begin
  m := m - 1;
  if m <= 1 then
   begin
    m := random(300)+1;
    xm := random(3);
    ym := random(3);
   end;
  if xm = 1 then x := x - 1;
  if xm = 2 then x := x + 1;
  if ym = 1 then y := y - 1;
  if ym = 2 then y := y + 1;
  if x > 640 then x := 640;
  if x < 1 then x := 1;
  if y > 460 then y := 460;
  if y < 1 then y := 1;
  if x >= 640 then m := 0;
  if x <= 1 then m := 0;
  if y >= 460 then m := 0;
  if y <= 1 then m := 0;
 end;

begin
 Start;
  while KeyPressed = False do
   begin
    DrawCircle;
    ChangeSize;
    MovePos;
   end;
  textmode(3);
end.