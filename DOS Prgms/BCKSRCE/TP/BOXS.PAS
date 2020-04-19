program Test;

uses
 Crt, Graph;

var
 GraphDriver : Integer;
 GraphMode : Integer;
 ErrorCode : Integer;

Procedure graph_ini;
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

begin
 randomize;
 graph_ini;
  while keypressed = false do
   begin
    setfillstyle(1, random(16));
    bar(random(640), random(480), random(640), random(480));
    delay(100);
   end;
end.


