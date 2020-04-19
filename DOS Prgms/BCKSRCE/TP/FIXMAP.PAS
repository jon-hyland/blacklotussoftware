program FixMap;

uses
 Crt;

type
 OldMapType = record
   Name    : string[25];
   Char    : array[1..78, 1..18] of char;
   Color   : array[1..78, 1..18] of shortint;
   BColor  : array[1..78, 1..18] of shortint;
   Solid   : array[1..78, 1..18] of boolean;
   Trigger : array[1..78, 1..18] of record
     Num : shortint;
     Dir : array[1..4] of boolean;
    end;
  end;
 NewMapType = record
   Name    : string[25];
   Char    : array[1..78, 1..18] of char;
   Color   : array[1..78, 1..18] of integer;
   BColor  : array[1..78, 1..18] of integer;
   Solid   : array[1..78, 1..18] of integer;
   Trigger : array[1..78, 1..18] of record
     Num : shortint;
     Dir : array[1..4] of boolean;
    end;
  end;

var
 OldMap : OldMapType;
 NewMap : NewMapType;
 OldFile : file of OldMapType;
 NewFile : file of NewMapType;
 i, j, k   : integer;
 Count : integer;

begin
 assign(OldFile, 'C:\GAME\QUEST.DAT');
 assign(NewFile, 'C:\GAME\NEW.DAT');
 reset(OldFile);
 rewrite(NewFile);
 Count := 0;
  repeat
   read(OldFile, OldMap);
   Count := Count + 1;
   NewMap.Name := OldMap.Name;
   clrscr;
   textcolor(white);
   textbackground(black);
   write(OldMap.Name);
   for k := 1 to 18 do
    for j := 1 to 78 do
     begin
      gotoxy(j,k+1);
      textcolor(OldMap.Color[j,k]);
      textbackground(OldMap.BColor[j,k]);
      write(OldMap.Char[j,k]);
      NewMap.Color[j,k] := OldMap.Color[j,k];
      NewMap.BColor[j,k] := OldMap.BColor[j,k];
      NewMap.Char[j,k] := OldMap.Char[j,k];
      NewMap.Trigger[j,k].Num := OldMap.Trigger[j,k].Num;
      for i := 1 to 4 do
       NewMap.Trigger[j,k].Dir[i] := OldMap.Trigger[j,k].Dir[i];
      if OldMap.Solid[j,k] then
       NewMap.Solid[j,k] := 1
      else
       NewMap.Solid[j,k] := 0;
     end;
   write(NewFile, NewMap);
   readkey;
  until Eof(OldFile);
 close(NewFile);
 close(OldFile);
end.

