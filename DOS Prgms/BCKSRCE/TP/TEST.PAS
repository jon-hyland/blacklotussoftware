program Test;

uses
 Crt, Std, Dos;

const
 LineMax = 126;

type
 LineType = string[LineMax];

var
 TFile : text;
 DFile : file of LineType;

procedure Init;
 begin
  assign(TFile, 'TEST.PAS');
  assign(DFile, 'VIEW.DAT');
 end;

procedure Text2Data;
 var
  Long  : string;
  Short : LineType;
  j, k  : integer;
 begin
  reset(TFile);
  rewrite(DFile);
  while not Eof(TFile) do
   begin
    readln(TFile, Long);
    Short := '';
    k := 1;
    for j := 1 to length(Long) do
     begin
      if k > LineMax then
       begin
        write(DFile, Short);
        writeln(Short);
        k := 1;
        Short := '';
       end;
      Short := Short + Long[j];
      k := k + 1;
     end;
    write(DFile, Short);
   end;
  close(TFile);
  close(DFile);
 end;

procedure SplashOnScreen;
 var
  Count : integer;
  Str   : LineType;
 begin
  textcolor(white);
  textbackground(black);
  clrscr;
  textbackground(blue);
  reset(DFile);
  Count := 0;
  while not Eof(DFile) do
   begin
    read(DFile, Str);
    writeln(Str);
    Count := Count + 1;
    if Count >= 23 then
     begin
      Count := 0;
      readkey;
     end;
   end;
  close(DFile);
  readkey;
 end;


begin
 Init;
 Text2Data;
 SplashOnScreen;
end.

