program RandomObjects;

uses
 Crt;

type
 GraphType = record
   Name   : string[15];
   X, Y   : integer;
   Char   : array[1..10, 1..5] of char;
   Color  : array[1..10, 1..5] of integer;
   BColor : array[1..10, 1..5] of integer;
   Solid  : array[1..10, 1..5] of boolean;
  end;

var
 Obj      : GraphType;
 ObjFile  : file of GraphType;
 i, j, k  : integer;
 s : string[15];

begin
 randomize;
 assign(ObjFile, 'MAKEOBJ.DAT');
 rewrite(ObjFile);
 for i := 1 to 10 do
  begin
   str(i,s);
   Obj.Name := '#' + s;
   Obj.x := 10;
   Obj.y := 5;
   for k := 1 to 5 do
    for j := 1 to 10 do
     begin
      Obj.Char[j,k] := chr(random(3)+176);
      Obj.Color[j,k] := random(16);
      Obj.BColor[j,k] := random(8);
      Obj.Solid[j,k] := false;
     end;
   write(ObjFile, Obj);
  end;
 close(ObjFile);
end.

   Obj.Char[