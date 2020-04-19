program GraphPaper;

uses
 Crt, Graph;

var
 x, y : integer;

var
 GraphDriver:                  Integer;
 Graphmode:                    Integer;
 ErrorCode:                    Integer;

procedure Init_Graph;
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
 Init_Graph;
 for x := 1 to 81 do
  line(x*7, 1, x*7, 480);
 for y := 1 to 26 do
  line(1, y*16, 640, y*16);
 readkey;
end.