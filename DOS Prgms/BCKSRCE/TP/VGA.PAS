program GraphTest;

uses
 Graph, Crt, Std;

var
 GraphDriver : Integer;
 Graphmode   : Integer;
 ErrorCode   : Integer;

procedure GraphInit;
 begin
  GraphDriver := Detect;
  InitGraph(GraphDriver,GraphMode,'C:\BP\BGI');
  ErrorCode := GraphResult;
  if ErrorCode <> GrOK then
   begin
    writeln('Program detected graphics error #: ', GraphErrorMsg(ErrorCode));
    halt(1);
   end;
 end;


procedure ClearWin;
 begin
  SetBkColor(0);
  ClearDevice;
 end;

procedure Test;
 var
  x1, y1, x2, y2 : integer;
  Color : integer;
 begin
  randomize;
   repeat
    Color := random(15)+1;
    x1 := random(600);
    y1 := random(400)+1;
     repeat
      x2 := random(640)+1;
      y2 := random(480)+1;
     until (x2 > x1) and (y2 > y1);
    rectangle(x1, y1, x2, y2);
   until KeyPressed;
 end;



begin
 GraphInit;
 ClearWin;
 Test;
 ClearBuffer;
 readkey;
end.