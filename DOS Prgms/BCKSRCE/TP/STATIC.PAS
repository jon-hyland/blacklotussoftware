program Static;

uses
 Crt, Graph;

var
  x : integer;
  y : integer;
  r : integer;
  GraphDriver:                  Integer;
  Graphmode:                    Integer;
  ErrorCode:                    Integer;

procedure graph_ini;
Begin
     GraphDriver := Detect;
     InitGraph(GraphDriver,GraphMode,'C:\BP\BGI');
     ErrorCode := GraphResult;

     if ErrorCode <> GrOK then
     Begin
        Writeln('Graphics error: ', GraphErrorMsg(ErrorCode));
        Writeln('Program Aborted...');
        Halt(1);
     End;
end;

begin
 graph_ini;
 x := 1;
 y := 1;
 repeat
  r := random(3)+1;
  if r = 1 then setcolor(0);
  if r = 2 then setcolor(4);
  if r = 3 then setcolor(12);
  if r = 4 then setcolor(3);
  line(x,y,x,y);
  x := x + 1;
  if x > 640 then
   begin
    x := 1;
    y := y + 1;
   end;
  if y > 480 then
   begin
    x := 1;
    y := 1;
   end;
 until KeyPressed;
end.