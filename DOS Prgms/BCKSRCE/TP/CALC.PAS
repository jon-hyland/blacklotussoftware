program Calc;

uses
 Crt;

var
 Num1, Num2 : real;
 Dec : boolean;
 Decs : integer;
 Nums : Integer;
 Key : char;
 Button : integer;
 Quit : boolean;
 Com : integer;
 Mode : boolean;

procedure Clear;
 begin
  textcolor(white);

  textbackground(black);
  clrscr;
  textcolor(black);
  gotoxy(1,25);
  write(chr(219));
  textcolor(white);
  gotoxy(1,1);
 end;

procedure Cursor;
 begin
  gotoxy(1,25);
 end;

function ButY(B : integer) : integer;
 begin
   case B of
    1..3, 17 : ButY := 6;
    4..6     : ButY := 8;
    16       : ButY := 9;
    7..9     : ButY := 10;
    10..12   : ButY := 12;
    15       : ButY := 13;
    13, 14   : ButY := 14;
   end; {case}
 end;

function ButX(B : integer) : integer;
 begin
   case B of
    1,4,7,10    : ButX := 1;
    13          : ButX := 3;
    2,5,8,11    : ButX := 5;
    3,6,9,12,14 : ButX := 9;
    17,16,15    : ButX := 13;
   end; {case}
 end;

function ButtonChar(B : integer) : char;
 var
  c : char;
 begin
   case B of
    1  : c := 'C';
    2  : c := '/';
    3  : c := '*';
    4  : c := '7';
    5  : c := '8';
    6  : c := '9';
    7  : c := '4';
    8  : c := '5';
    9  : c := '6';
    10 : c := '1';
    11 : c := '2';
    12 : c := '3';
    13 : c := '0';
    14 : c := '.';
    15 : c := '=';
    16 : c := '+';
    17 : c := '-';
   end; {case}
  ButtonChar := c;
 end;

procedure BrightButton;
 begin
  gotoxy(ButX(Button), ButY(Button));
  textcolor(yellow);
  write(ButtonChar(Button));
  Cursor;
 end;

procedure DarkButton;
 begin
  textcolor(white);
  gotoxy(ButX(Button), ButY(Button));
  write(ButtonChar(Button));
  Cursor;
 end;

procedure DispAns(x : real);
 begin
  gotoxy(2,4);
  write('               ');
  textcolor(lightgreen);
  gotoxy(2,4);
  write(x:0:3);

  gotoxy(1,20);
  writeln('Num1 : ', Num1:0:1);
  writeln('Num2 : ', Num2:0:1);
  writeln('Com  : ', Com);
  if Mode then write('Mode : 1') else write('Mode : 0');

  Cursor;
 end;

function ButtonNum : integer;
 begin
   case Key of
    '1' : Button := 10;
    '2' : Button := 11;
    '3' : Button := 12;
    '4' : Button := 7;
    '5' : Button := 8;
    '6' : Button := 9;
    '7' : Button := 4;
    '8' : Button := 5;
    '9' : Button := 6;
    '0' : Button := 13;
    '.' : Button := 14;
    #13 : Button := 15;
    '+' : Button := 16;
    '-' : Button := 17;
    '*' : Button := 3;
    '/' : Button := 2;
    #8  : Button := 1;
    #27 : Button := 18;
   end; {case}
 end;

function GetKey : char;
 var
  Key : char;
  GotKey : boolean;
 begin
  GotKey := false;
   repeat
    Key := readkey;
    if Key in ['0'..'9', '.', '+', '-', '*', '/', #13, #8, #27] then
     GotKey := true;
   until GotKey;
  GetKey := Key;
 end;

procedure Init;
 begin
  randomize;
  Quit := false;
  Clear;
  gotoxy(1,1);
  write('- TurboCalc 2000  v1.0 -');
  gotoxy(1,2);
  write('(c) 1996  BlackWolf Productions');
  gotoxy(1,6);
  write('C   /   *   -');
  gotoxy(1,8);
  write('7   8   9');
  gotoxy(1,9);
  write('            +');
  gotoxy(1,10);
  write('4   5   6');
  gotoxy(1,12);
  write('1   2   3');
  gotoxy(1,13);
  write('            =');
  gotoxy(1,14);
  write('  0     .');
  Button := 15;
  BrightButton;
  DarkButton;
  Dec := false;
  Num1 := 0;
  Num2 := 0;
  Decs := 0;
  Nums := 0;
  Com := 0;
  DispAns(Num2);
  Mode := true;
 end;

function Pow(x, y : integer) : longint;
 var
  j : integer;
  p : longint;
 begin
  p := 1;
  for j := 1 to y do
   p := p * x;
  Pow := p;
 end;

procedure GetNum;
 begin
  if not Dec then
   begin
    Num1 := Num1 * 10 + (ord(Key) - 48);
    Nums := Nums + 1;
   end
  else
   begin
    Decs := Decs + 1;
    Nums := Nums + 1;
    Num1 := Num1 + ((ord(Key) - 48) / Pow(10,Decs));
   end;
  DispAns(Num1);
 end;

function CalcAns : real;
 var
  x : real;
 begin
   Dec := false;
   Nums := 0;
   Decs := 0;
   case Com of
    0 : x := Num1;
    1 : x := Num2 + Num1;
    2 : x := Num2 - Num1;
    3 : x := Num2 * Num1;
    4 : x := Num2 / Num1;
   end; {case}
  CalcAns := x;
 end;

begin
 Init;
  repeat
   Key := GetKey;
   if (Mode = false) and (Key in ['0'..'9', '.']) then
    Num1 := 0;
   if Key in ['0'..'9', '.'] then
    Mode := true
   else
    Mode := false;
    case Key of
     #27     : Quit := true;
     #8      :
      begin
       Num1 := 0;
       Num2 := 0;
       DispAns(Num2);
      end;
     '.'      : Dec := true;
     '0'..'9' : GetNum;
     '+' :
      begin
       Num2 := CalcAns;
       Com := 1;
       DispAns(Num2);
      end;
     '-' :
      begin
       Num2 := CalcAns;
       Com := 2;
       DispAns(Num2);
      end;
     '*' :
      begin
       Num2 := CalcAns;
       Com := 3;
       DispAns(Num2);
      end;
     '/' :
      begin
       Num2 := CalcAns;
       Com := 4;
       DispAns(Num2);
      end;
     #13 :
      begin
       Num2 := CalcAns;
       Com := 0;
       DispAns(Num2);
      end;
    end; {case}





  until Quit;
end.


