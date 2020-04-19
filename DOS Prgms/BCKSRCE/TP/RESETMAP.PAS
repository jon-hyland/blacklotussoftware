program ResetMapFile;

uses
 Crt;

type
 MapType = record
   Name   : string[25];
   Char   : array[1..78, 1..18] of char;
   Color  : array[1..78, 1..18] of integer;
   BColor : array[1..78, 1..18] of integer;
   Solid  : array[1..78, 1..18] of boolean;
  end;

var
 Map : MapType;
 MapFile : file of MapType;
 j, k : integer;
 Name : string[15];
 Key : char;

begin
 clrscr;
 write('Are you sure you want to erase EDITMAP.DAT?  (Y/N) : ');
  repeat
   Key := readkey;
   Key := upcase(Key);
  until Key in ['Y', 'N'];
 if Key = 'N' then
  begin
   clrscr;
   Halt;
  end;
 writeln;
 writeln;
 write('Name first map : ');
 read(Name);
 assign(MapFile, 'EDITMAP.DAT');
 rewrite(MapFile);
 Map.Name := Name;
 for k := 1 to 18 do
  for j := 1 to 78 do
   begin
    Map.Color[j,k] := 15;
    Map.BColor[j,k] := 0;
    Map.Char[j,k] := ' ';
    Map.Solid[j,k] := false;
   end;
 write(MapFile, Map);
 close(MapFile);
end.