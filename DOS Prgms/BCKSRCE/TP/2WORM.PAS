program Two_Worms_Eat_Bugs_and_Shit_and_Die; {09/03/97}

uses
 Crt, Std;

const
 TotBugs  = 25;
 TotRocks = 12;

type
 ObjType  : array[1..40, 1..24] of boolean;
 WormType : array[1..2, 1..10] of integer;
 BugType  : array[1..100] of integer;

var
 Rock  : ObjType;
 Shit  : ObjType;
 WormX : WormType;
 WormY : WormType;
 WormC : WormType;
 BugX  : BugType;
 BugY  : BugType;
 BugC  : BugType;

procedure Init;
 var
  i, j, k : integer;
 begin
  randomize;
  for k := 1 to 24 do
   for j := 1 to 40 do
    begin
     Shit[j,k] := false;
     Rock[j,k] := false;
    end;
  for i := 1 to TotRocks do
   begin








