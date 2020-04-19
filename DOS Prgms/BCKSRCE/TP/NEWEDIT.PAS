program NewEditText;

uses
 Crt, Dos, Std;

procedure EditTest(FileName : string);
 var
  Cha    : aray[1..78, 1..250] of char;
  TFile  : text;
  x, y   : integer;
  OffSet : integer;
  j, k   : integer;
  Key    : char;
  Path   : PathStr;
  Ins    : boolean;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := (OffSet+1) to (OffSet+22) do
    for j := 1 to 78 do
     begin
      gotoxy(j+1, k+1);
      write(Cha[j,k]);
     end;
   Cursor;
  end; {sub procedure}
 begin
  DrawWindow(1,1,80,24,1,FileName);
  assign(TFile, FileName);
  fsearch(FileName, GetEnv('PATH'));
  if Path = '' then
   begin
    rewrite(TFile);
    write(TFile, ' ');
    close(TFile);
   end;
  for k := 1 to 250 do
   for j := 1 to 78 do
    Cha[j,k] := ' ';
  reset(TFile);
  j := 1;
  k := 1;
  while (not Eof(TFile)) and (k <= 250) do
   begin
    read(TFile, Key);
     case Key of
      #13 : j := 1;
      #10 : k := k + 1;
     else
       begin
        if (j in [1..78]) and (k in [1..250]) then
        Cha[j,k] := Key;
        j := j + 1;
       end;
     end; {case}
   end;
  close(TFile);
  OffSet := 0;
  DrawPage;
  Ins := true;
  x := 1;
  y := 1;
   repeat
    gotoxy(x+1, y+1);
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
        if x > 78 then x := 78;
        if x < 1 then x := 1;
        if y < 1 then y := 1;
        if y > 250 then y := 250;
        if y <= OffSet then
         begin
          OffSet := OffSet - 1;
          DrawPage;
         end;
        if y > OffSet + 23 then
         begin
          OffSet := OffSet + 1;
          DrawPage;
         end;
       end;
      #8 :
       if Ins then
        begin
         if x > 1 then
          begin
           x := x - 1;
           for j := x to 77 do
            Cha[j, y] := Cha[j+1, y];
           Cha[78, y] := ' ';
           gotoxy(x+1, y+1);
           for j := x to 78 do
            write(Cha[j,y]);
          end;
        end
       else
        begin
         if x > 1 then
          begin
           Cha[x,y] := ' ';
           write(Cha[x,y]);
           x := x - 1;
           Cha[x,y] := ' ';
           gotoxy(x+1, y+1);
           write(Cha[x,y]);
          end;
        end;

      #32..#126 :
       begin



   until Key = #27;

 end;




