 procedure CoptSection; {SubProc}
  var
   Copy : MapType;
   j, k : integer;
   x1, y1, x2, y2 : integer;
   xn, yn : integer;
   Key : char;
  begin

   x1 := x;
   y1 := y;
    repeat
     gotoxy(x1+1, y1+1);
      repeat
       Key := readkey;
      until Key in ['H', 'K', 'P', 'M', #13];


    until Key = #13;
