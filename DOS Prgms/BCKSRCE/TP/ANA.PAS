program GetAnarchyNames;

uses
 Crt;

var
 NamesFile : text;
 Name : string;
 Num : integer;
 AnaFile : text;

procedure Init;
 begin
  assign(NamesFile, 'NAMES.TXT');
  Num := 1;
 end;


function GetName : string;
 var
  AnaFileName : string[12];
 begin
  if Num > 99 then
   AnaFileName := str(3,Num);

