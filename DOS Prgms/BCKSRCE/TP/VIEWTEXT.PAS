program Test;

uses
 Crt, Std;

{$M 32768,0,655360}
procedure ViewText(FileName : string);
 var
  TFile    : text;
  Cha      : array[1..78, 1..250] of char;
  j, k     : integer;
  Key      : char;
  Ch       : char;
  OffSet   : integer;
  LastOS   : integer;
  LastLine : integer;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := OffSet+1 to OffSet+22 do
    for j := 1 to 78 do
     begin
      gotoxy(j+1, k-OffSet+1);
      write(Cha[j,k]);
     end;
   Cursor;
  end;
 begin
  LastOS := 1;
  for k := 1 to 250 do
   for j := 1 to 78 do
    Cha[j,k] := ' ';
  assign(TFile, FileName);
  reset(TFile);
  j := 1;
  k := 1;
  while (not Eof(TFile)) and (k <= 250) do
   begin
    read(TFile, Ch);
     case Ch of
      #32..#126 :
       begin
        Cha[j,k] := Ch;
        j := j + 1;
        if j > 78 then
         begin
          j := 1;
          k := k + 1;
         end;
       end;
      #13 : j := 1;
      #10 : k := k + 1;
     end; {case}
   end;
  LastLine := k;
  close(TFile);
  Clear;
  DrawWindow(1,1,80,24,1,FileName);
  OffSet := 0;
  textcolor(yellow);
   repeat
    if OffSet <> LastOS then DrawPage;
    LastOS := OffSet;
     repeat
      Key := readkey;
     until Key in [#27, 'H', 'P', 'I', 'Q'];
     case Key of
      'H' : OffSet := OffSet - 1;
      'P' : OffSet := OffSet + 1;
      'I' : OffSet := OffSet - 22;
      'Q' : OffSet := OffSet + 22;
     end; {case}
    if OffSet < 0 then OffSet := 0;
    if OffSet > LastLine-22 then OffSet := LastLine - 22;
   until Key = #27;
  EraseWindow(1,1,80,24);
 end;

begin
 ViewText('VIEWTEXT.PAS');
end.