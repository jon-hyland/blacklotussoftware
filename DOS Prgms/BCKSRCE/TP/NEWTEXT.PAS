program TestEditText;

uses
 Crt, Std, Dos;

procedure EditText(FileName : string);
 const
  MaxLines = 150;
 var
  TFile  : text;
  Text   : array[1..MaxLines, 1..78] of char;
  OffSet : integer;
  OldSet : integer;
  x, y   : integer;
  j, k   : integer;
  Cha    : char;
  Key    : char;
  Found  : PathStr;
  Ins    : boolean;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := OffSet+1 to OffSet+22 do
    begin
     gotoxy(2,k+1);
     for j := 1 to 78 do
      write(Text[j,k]);
    end;
  end;
 begin
  assign(TFile, FileName);
  Found := FSearch(FileName, GetEnv('PATH'));
  if Found = '' then
   begin
    rewrite(TFile);
    write(TFile, ' ');
    close(TFile);
   end;
  for k := 1 to MaxLines do
   for j := 1 to 78 do
    Text[j,k] :=  ' ';
  Clear;
  DrawWindow(1,1,80,24,1,FileName);
  x := 1;
  y := 1;
  reset(TFile);
  while (not Eof(TFile)) and (y <= MaxLines) do
   begin
    read(TFile, Cha);
     case Cha of
      #32..#126 :
       begin
        if x in [1..78] then
         Text[x,y] := Cha;
        x := x + 1;
       end;
      #13 : x := 1;
      #10 : y := y + 1;
     end; {case}
   end;
  close(TFile);
  x := 1;
  y := 1;
  OffSet := 0;
  OldSet := 1;
  Ins := false;
   repeat
    if OffSet <> OldSet then DrawPage;
    OldSet := OffSet;
    gotoxy(x+1, y+1-OffSet);
    Key := readkey;
     case Key of
      #0 :
       begin
        Key := readkey;
         case Key of
          'H' : y := y - 1;
          'K' : x := x - 1;
          'P' : y := y + 1;
          'M' : x := x + 1;
         end; {case}
        if x < 1 then x := 1;
        if x > 78 then x := 78;
        if y < 1 then y := 1;
        if y > MaxLines then y := MaxLines;
        if y < (OffSet+1) then OffSet := OffSet - 1;
        if y > (OffSet+10) then OffSet := OffSet + 1;
       end;
      #32..#126 :
       begin
        Text[x,y] := Key;
        gotoxy(x+1, y+1-OffSet);
        write(Text[x,y]);
        x := x + 1;
        if x > 78 then
         begin
          x := 1;
          y := y + 1;
          if y > MaxLines then
           begin
            y := MaxLines;
            x := 78;
           end;
         end;
       end;
     end; {case}
   until Key in [#27];
  end;

begin
 EditText('C:\TP\BIN\NEWTEXT.PAS');
end.