program TextEditTester;

uses
 Crt, Std, Dos;

{$M 32768,0,655360}
procedure EditText(FileName : string);
 var
  TFile   : text;
  Text   : array[1..78, 1..350] of char;
  x, y   : integer;
  j, k   : integer;
  Key    : char;
  Cha    : char;
  Offset : integer;
  OldOff : integer;
  Found  : PathStr;
  Ins    : boolean;
 procedure DrawPage(Offset : integer);
  var
   j, k : integer;
  begin
   textcolor(white);
   textbackground(blue);
   for k := Offset + 1 to Offset + 22 do
    for j := 1 to 78 do
     begin
      gotoxy(j+1,k+1);
      write(Text[j,k]);
     end;
  end;
 begin
  Clear;
  DrawWindow(1,1,80,24,1,FileName);
  assign(TFile, FileName);
  for k := 1 to 350 do
   for j := 1 to 78 do
    Text[j,k] :=  ' ';
  Found := fsearch(FileName,GetEnv('PATH'));
  if Found = '' then
   begin
    rewrite(TFile);
    write(TFile, ' ');
    close(TFile);
   end;
  x := 1;
  y := 1;
  reset(TFile);
  while (not Eof(TFile)) and (y <= 350) do
   begin
    read(TFile, Cha);
     case Cha of
      #32..#126 :
       begin
        Text[x,y] := Cha;
        x := x + 1;
        if x > 78 then
         begin
          x := 1;
          y := y + 1;
         end;
       end;
      #13 :
       x := 1;
      #10 :
       y := y + 1;
     end; {case}
   end;
  close(TFile);
  OffSet := 0;
  OldOff := 23432;
  x := 1;
  y := 1;
  Ins := false;
   repeat
    if OffSet <> OldOff then
     DrawPage(OffSet);
    OldOff := OffSet;
    gotoxy(x+1, y+1-Offset);
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
        if x > 80 then x := 80;
        if x < 1 then x := 1;
        if y < 1 then y := 1;
        if y > 350 then y := 350;
        if y < (OffSet+1) then OffSet := OffSet - 1;
        if y > (Offset+22) then OffSet := OffSet + 1;
       end;
      #8 :
       begin
        if not Ins then
         begin
          if x > 1 then
           begin
            x := x - 1;
            for j := x to 77 do
             Text[j,y] := Text[j+1,y];
            Text[78,y] := ' ';
            gotoxy(x+1, y+1-Offset);
            for j := x to 78 do
             write(Text[j,y]);
           end
          else
           begin
            if y > 1 then
             begin
              y := y - 1;
              x := 78;
              while (Text[x-1,y] = ' ') and (x > 1) do
               x := x - 1;
             end;
           end;
         end;
       end;
     end; {case}

   until Key = #27;
 end;

begin
 EditText('C:\TP\BIN\LOGIN.PAS');
end.