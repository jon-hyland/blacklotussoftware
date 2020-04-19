program FixObj;

uses
 Crt;

type
 OldObjType = record
   Name   : string[15];
   X, Y   : integer;
   Char   : array[1..10, 1..5] of char;
   Color  : array[1..10, 1..5] of integer;
   BColor : array[1..10, 1..5] of integer;
   Solid  : array[1..10, 1..5] of boolean;
  end;
 NewObjType = record
   Name      : string[15];
   X, Y      : integer;
   Char      : array[1..10, 1..5] of char;
   AllColor  : array[1..10, 1..5] of integer;
   Solid     : array[1..10, 1..5] of integer;
  end;

var
 OldObj : OldObjType;
 NewObj : NewObjType;
 OldFile : file of OldObjType;
 NewFile : file of NewObjType;
 j, k : integer;

procedure MixColor(var Color : integer; FColor, BColor : integer);
 begin
  if FColor > 8 then
   Color := ((BColor+1) * 100)
  else
   Color := ((BColor+1) * 10);
  Color := Color + FColor + 1;
 end;

begin
 assign(NewFile, 'C:\GAME\NEWOBJ.DAT');
 assign(OldFile, 'C:\GAME\MAKEOBJ.DAT');
 reset(OldFile);
 rewrite(NewFile);
  repeat
   read(OldFile, OldObj);
   NewObj.Name := OldObj.Name;
   NewObj.X := OldObj.X;
   NewObj.Y := OldObj.Y;
   for k := 1 to 5 do
    for j := 1 to 10 do
     begin
      NewObj.Char[j,k] := OldObj.Char[j,k];
      MixColor(NewObj.AllColor[j,k], OldObj.Color[j,k], OldObj.BColor[j,k]);
      if OldObj.Solid[j,k] then
       NewObj.Solid[j,k] := 1
      else
       NewObj.Solid[j,k] := 0;
     end;
   write(NewFile, NewObj);
  until Eof(OldFile);
 close(OldFile);
 close(NewFile);
end.