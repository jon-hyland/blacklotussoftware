{This is the newest version.}

program TestEditText;

uses
 Crt, Dos, Std;

var
 FileName : string;

{$M 32768,0,655360}
procedure EditText(FileName: string);
 var
  Cha     : array[1..78, 1..250] of char;
  TFile   : text;
  OffSet  : integer;
  x, y    : integer;
  j, k    : integer;
  Key     : char;
  Path    : PathStr;
  Ins     : boolean;
  Found   : boolean;
  EofLine : boolean;
  BSpace  : integer;
 procedure DrawPage;
  var
   j, k : integer;
  begin
   for k := (OffSet+1) to (OffSet+22) do
    for j := 1 to 78 do
     begin
      gotoxy(j+1, k+1-OffSet);
      write(Cha[j,k]);
     end;
   Cursor;
  end; {sub procedure}
 begin
  DrawWindow(1,1,80,24,1,FileName);
  for k := 1 to 250 do
   for j := 1 to 78 do
    Cha[j,k] := ' ';
  assign(TFile, FileName);
  Path := fsearch(FileName, GetEnv('PATH'));
  if Path = '' then
   begin
    rewrite(TFile);
    write(TFile, ' ');
    close(TFile);
   end;
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
      if j in [1..78] then Cha[j,k] := Key;
     end; {case}
    j := j + 1;
   end;
  close(TFile);
  Ins := true;
  x := 1;
  y := 1;
  OffSet := 0;
  DrawPage;
   repeat
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
          'R' : if Ins then Ins := false else Ins := true;
          'S' :
           begin
            EofLine := true;
            for j := x to 78 do
             if Cha[j,y] <> ' ' then
              EofLine := false;

           end;













            {
            Found := false;
            for j := x to 78 do
             if Cha[j,y] <> ' ' then
              Found := true;
            WStart := 1;
            while (Cha[WStart, y+1] = ' ') and (WStart <= 78) do
             WStart := WStart + 1;
            WEnd := 78;
            while (Cha[WEnd, y+1] = ' ') and (WEnd >= 1) do
             WEnd := WEnd - 1;
            if Ins and (not Found) and ((78-x) > (WEnd-WStart+1)) then
             begin
              for j := WStart to WEnd do
               Cha[x+(j-WStart), y] := Cha[j, y+1];
              for j := x to (x+(WEnd-WStart+1)) do
               Cha[j,y] := Cha[(j-(WEnd-WStart+1))+WStart, y+1];

              for k := y+1 to 249 do
               for j := 1 to 78 do
                Cha[j,k] := Cha[j,k+1];
              for j := 1 to 78 do
               Cha[j,250] := ' ';
              DrawPage;
             end
            else
             begin
              for j := x to 77 do
               Cha[j,y] := Cha[j+1,y];
              Cha[78,y] := ' ';
              gotoxy(x+1,y+1-OffSet);
              for j := x to 78 do
               write(Cha[j,y]);
             end;

           end;}
         end; {case}
        if x < 1 then x := 1;
        if x > 78 then x := 78;
        if y < 1 then y := 1;
        if y > 250 then y := 250;
        if y < (Offset+1) then
         begin
          OffSet := OffSet - 1;
          DrawPage;
         end;
        if y > (OffSet+22) then
         begin
          OffSet := OffSet + 1;
          DrawPage;
         end;
       end;
      #8 :
       if x > 1 then
        begin
         for j := x-1 to 77 do
          Cha[j,y] := Cha[j+1,y];
         Cha[78,y] :=  ' ';
         x := x - 1;
         gotoxy(x+1, y+1-OffSet);
         for j := x to 78 do
          write(Cha[j,y]);
        end;
      #13 :
       if y < 250 then
        begin
         Found := false;
         for j := 1 to 78 do
          if Cha[j,250] <> ' ' then
           Found := true;
         if Ins and (not Found) then
          begin
           for k := 250 downto y+2 do
            for j := 1 to 78 do
             Cha[j,k] := Cha[j,k-1];
           for j := 1 to 78 do
            Cha[j,y+1] := ' ';
           for j := x to 78 do
            begin
             Cha[j-(x-1), y+1] := Cha[j,y];
             Cha[j,y] :=  ' ';
            end;
           x := 1;
           y := y + 1;
           if y > (OffSet+22) then
            OffSet := OffSet + 1;
           DrawPage;
          end
         else
          begin
           x := 1;
           y := y + 1;
           if y > (OffSet+22) then
            begin
             OffSet := OffSet + 1;
             DrawPage;
            end;
          end;
        end;
      #32..#126 :
       begin
        if Ins then
         begin
          for j := 78 downto x+1 do
           Cha[j,y] := Cha[j-1,y];
          Cha[x,y] := Key;
          for j := x to 78 do
           write(Cha[j,y]);
         end
        else
         begin
          Cha[x,y] := Key;
          write(Cha[x,y]);
         end;
        if y < 250 then
         begin
          x := x + 1;
          if x > 78 then
            begin
            x := 1;
            y := y + 1;
           end;
         end;
       end;
     end; {case}
   until Key = #27;

 end;

begin
 FileName := 'C:\TP\BIN\EDITTEXT.PAS';
 EditText(FileName);
end.


