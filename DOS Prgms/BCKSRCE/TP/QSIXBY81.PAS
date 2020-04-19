program qsix;

uses Crt,Graph;


type
  matrix = array[1..8,1..8] of integer;

var
  GraphDriver:                  Integer;
  Graphmode:                    Integer;
  ErrorCode:                    Integer;
  a,b,f,e,h:                    matrix;
  i,j,r,c,p,d,k,l,g,m,n,u:      integer;
  chips:                        integer;
  point,tot_point:              integer;
  row,column:                   integer;
  player:                       integer;
  player1_score,player2_score:  integer;
  pos_value:                    integer;
  tot_value:                    integer;
  bigb,bigf,bige:               integer;
  foundb,founde,foundf:         integer;
  xb,xe,xf,yb,ye,yf:            integer;
  first:                        string[3];
  name,name1,name2,s:           string[15];
  namea,nameb:                  string[15];
  f1,f2,score1,score2:          integer;
  num_players:                  integer;
  play_more:                    string[3];
  play_again:                   integer;
  fontnum1:                     pointer;


procedure logo;
begin
setlinestyle(0,0,3);
setviewport(450,10,600,300,clipoff);
setfillstyle(1,7);
bar(-20,30,150,150);
setcolor(1);
rectangle(-20,30,150,150);
settextstyle(1,0,10);
setcolor(1);
outtext('Q');
setcolor(4);
outtext('8');
end;

procedure score;
begin
setviewport(430,180,600,340,clipoff);
setfillstyle(1,7);
bar(0,0,170,160);
setlinestyle(0,0,3);
setcolor(1);
rectangle(0,0,170,160);
setcolor(4);
settextstyle(1,0,3);
setlinestyle(0,0,3);
line(10,27,160,27);
setcolor(0);
outtextxy(55,0,'Score');
settextstyle(1,0,1);
setcolor(4);
moveto(10,45);
outtext(name1);
outtext(':');
moveto(105,35);
settextstyle(1,0,4);
str(player1_score,s);
outtext(s);
setcolor(1);
moveto(10,95);
settextstyle(1,0,1);
outtext(name2);
outtext(':');
moveto(105,85);
settextstyle(1,0,4);
str(player2_score,s);
outtext(s);
end;


procedure graph_ini;
Begin
     GraphDriver := Detect;
     InitGraph(GraphDriver,GraphMode,'C:\BP\BGI');
     ErrorCode := GraphResult;

     if ErrorCode <> GrOK then
     Begin
        Writeln('Graphics error: ', GraphErrorMsg(ErrorCode));
        Writeln('Program Aborted...');
        Halt(1);
     End;
end;

procedure message(x:string);
begin
setviewport(430,360,600,450,clipoff);
setfillstyle(1,7);
setcolor(15);
bar(0,0,170,90);
setcolor(1);
rectangle(0,0,170,90);
settextstyle(1,0,3);
setcolor(4);
settextjustify(1,1);
outtextxy(85,40,x);
settextjustify(0,2);
end;

procedure display;
begin
      setviewport(40,40,400,400,clipon);

     setlinestyle(0,0,1);
     for i := 1 to 8 do begin
         for j := 1 to 8 do begin
             setcolor(7);
             settextstyle(7,0,1);
             outtextxy(j*45-36,i*45-33,chr(i+48));
             outtextxy(j*45-20,i*45-33,chr(j+48));
             if (a[i,j] = f1) then begin
             setfillstyle(1,4);
             fillellipse(j*45-22,i*45-22,16,16);
             setcolor(0);
             circle(j*45-22,i*45-22,16);
             end;
             if (a[i,j] = f2) then begin
             setfillstyle(1,1);
             fillellipse(j*45-22,i*45-22,16,16);
             setcolor(0);
             circle(j*45-22,i*45-22,16);
             end;

     end;
    end;
end;

procedure ask;
begin
setfillstyle(1,7);
     setviewport(40,410,400,450,clipon);
     bar(0,0,360,40);
     setcolor(1);
     setlinestyle(0,0,3);
     rectangle(0,0,360,40);
     setcolor(0);
     setTextStyle(1,0,2);
     outtextxy(5,6,'Enter next move ');
     moveto(190,6);
     end;

procedure comment;
begin
 case tot_point of
 4:  message('Not bad.');
 5:  message('Good move.');
 6:  message('Yowza!');
 7,8,9,10:  message('&%$@##*&!!');
 end;
 delay(700);
end;


procedure logo_old;
begin
textbackground(0);
clrscr;
textcolor(1);
writeln;
write('  ',chr(201),chr(205),chr(205),chr(205),chr(205),chr(187));
textcolor(4);
writeln('   ',chr(201),chr(205),chr(205),chr(205),chr(205),chr(187));
textcolor(1);
write('  ',chr(186),'    ',chr(186));
textcolor(4);
writeln('   ',chr(186),'    ',chr(189));
textcolor(1);
write('  ',chr(186),'    ',chr(186));
textcolor(4);
writeln('   ',chr(186));
textcolor(1);
write('  ',chr(186),'    ',chr(186));
textcolor(4);
writeln('   ',chr(204),chr(205),chr(205),chr(205),chr(205),chr(187));
textcolor(1);
write('  ',chr(186),'    ',chr(186));
textcolor(2);
write(chr(223),chr(223),chr(223));
textcolor(4);
writeln(chr(186),'    ',chr(186));
textcolor(1);
write('  ',chr(186),'    ',chr(186));
textcolor(4);
writeln('   ',chr(186),'    ',chr(186));
textcolor(1);
write('  ',chr(186),'  ',chr(196),chr(183),chr(186));
textcolor(4);
writeln('   ',chr(186),'    ',chr(186));
textcolor(1);
write('  ',chr(200),chr(205),char(205),chr(205),chr(206),char(188));
textcolor(4);
writeln('   ',chr(200),chr(205),chr(205),chr(205),chr(205),chr(188));
textcolor(1);
writeln('      ',chr(211),chr(196));
textcolor(7);
end;


procedure switch_player;
begin
  if (player=1) then begin
    player:= 2;
    end
    else begin
    player:=1;
    end;
end;

procedure line_point;
begin
  point:=p;
  if (point > 2) then begin
  if (player = f1) then begin
  player1_score:=player1_score+point;
  tot_point := tot_point+point;
  end
  else begin
  player2_score:=player2_score+point;
  tot_point := tot_point+point;
  end;
  end;
end;

procedure west_test;
begin
  p:=1;
  r:=row;
  c:=column-1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      c:=0
    end;
    c:=c-1;
  end;
end;

procedure east_test;
begin
  r:=row;
  c:=column+1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      c:=9
    end;
    c:=c+1;
  end;
end;

procedure northwest_test;
begin
  p:=1;
  r:=row-1;
  c:=column-1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=0
    end;
    r:=r-1;
    c:=c-1;
  end;
end;

procedure southeast_test;
begin
  r:=row+1;
  c:=column+1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=9
    end;
    c:=c+1;
    r:=r+1;
  end;
end;

procedure northeast_test;
begin
  p:=1;
  r:=row-1;
  c:=column+1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=0
    end;
    r:=r-1;
    c:=c+1;
  end;
end;

procedure southwest_test;
begin
  r:=row+1;
  c:=column-1;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=9
    end;
    c:=c-1;
    r:=r+1;
  end;
  end;

procedure north_test;
begin
  p:=1;
  r:=row-1;
  c:=column;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=0
    end;
    r:=r-1;
  end;
end;

procedure south_test;
begin
  r:=row+1;
  c:=column;
  while (((r<9) and (r>0)) and ((c<9) and (c>0))) do
  begin
    if (a[r,c] = player) then
    begin
      p:=p+1;
    end else
    begin
      r:=9
    end;
    r:=r+1;
  end;
end;

procedure createa;           {makes an initial zero array}
begin
  for i:=1 to 8 do begin
  for j:=1 to 8 do begin
  a[i,j]:=0;
  end;
  end;
end;



procedure resetbfe;
begin
 for i:=1 to 8 do begin
  for j:=1 to 8 do begin
   b[i,j]:=0;
   f[i,j]:=0;
   e[i,j]:=0;
  end;
 end;
end;

procedure test_pos;
begin
  if (p>2) then begin
   pos_value:=pos_value+p;
  end;
end;

procedure findbigb;
begin
 bigb:=0;
 for i:=1 to 8 do begin
  for j:=1 TO 8 DO BEGIN
   if (b[i,j]>bigb) then begin
    bigb:=b[i,j];
   end;
  end;
 end;
end;

procedure findbigf;
begin
 bigf:=0;
 for i:=1 to 8 do begin
  for j:=1 TO 8 DO BEGIN
   if (f[i,j]>bigf) then begin
    bigf:=f[i,j];
   end;
  end;
 end;
end;

procedure findbige;
begin
 bige:=0;
 for i:=1 to 8 do begin
  for j:=1 TO 8 DO BEGIN
   if (e[i,j]>bige) then begin
    bige:=e[i,j];
   end;
  end;
 end;
end;

procedure big_locb;
begin
  foundb:=0;

  if (((b[4,4]=bigb)and(foundb=0))and(a[4,4]=0))then begin
  xb:=4;
  yb:=4;
  foundb:=1;
  end;
  if (((b[5,4]=bigb)and(foundb=0))and(a[5,4]=0))then begin
  xb:=5;
  yb:=4;
  foundb:=1;
  end;
  if (((b[5,5]=bigb)and(foundb=0))and(a[5,5]=0))then begin
  xb:=5;
  yb:=5;
  foundb:=1;
  end;
  if (((b[4,5]=bigb)and(foundb=0))and(a[4,5]=0))then begin
  xb:=4;
  yb:=5;
  foundb:=1;
  end;
  if (((b[3,5]=bigb)and(foundb=0))and(a[3,5]=0))then begin
  xb:=3;
  yb:=5;
  foundb:=1;
  end;
  if (((b[3,4]=bigb)and(foundb=0))and(a[3,4]=0))then begin
  xb:=3;
  yb:=4;
  foundb:=1;
  end;
  if (((b[3,3]=bigb)and(foundb=0))and(a[3,3]=0))then begin
  xb:=3;
  yb:=3;
  foundb:=1;
  end;
  if (((b[4,3]=bigb)and(foundb=0))and(a[4,3]=0))then begin
  xb:=4;
  yb:=3;
  foundb:=1;
  end;
  if (((b[5,3]=bigb)and(foundb=0))and(a[5,3]=0))then begin
  xb:=5;
  yb:=3;
  foundb:=1;
  end;
  if (((b[6,3]=bigb)and(foundb=0))and(a[6,3]=0))then begin
  xb:=6;
  yb:=3;
  foundb:=1;
  end;
  if (((b[6,4]=bigb)and(foundb=0))and(a[6,4]=0))then begin
  xb:=6;
  yb:=4;
  foundb:=1;
  end;
  if (((b[6,5]=bigb)and(foundb=0))and(a[6,5]=0))then begin
  xb:=6;
  yb:=5;
  foundb:=1;
  end;
  if (((b[6,6]=bigb)and(foundb=0))and(a[6,6]=0))then begin
  xb:=6;
  yb:=6;
  foundb:=1;
  end;
  if (((b[5,6]=bigb)and(foundb=0))and(a[5,6]=0))then begin
  xb:=5;
  yb:=6;
  foundb:=1;
  end;
  if (((b[4,6]=bigb)and(foundb=0))and(a[4,6]=0))then begin
  xb:=4;
  yb:=6;
  foundb:=1;
  end;
  if (((b[3,6]=bigb)and(foundb=0))and(a[3,6]=0))then begin
  xb:=3;
  yb:=6;
  foundb:=1;
  end;
  if (((b[2,6]=bigb)and(foundb=0))and(a[2,6]=0))then begin
  xb:=2;
  yb:=6;
  foundb:=1;
  end;
  if (((b[2,5]=bigb)and(foundb=0))and(a[2,5]=0))then begin
  xb:=2;
  yb:=5;
  foundb:=1;
  end;
  if (((b[2,4]=bigb)and(foundb=0))and(a[2,4]=0))then begin
  xb:=2;
  yb:=4;
  foundb:=1;
  end;
  if (((b[2,3]=bigb)and(foundb=0))and(a[2,3]=0))then begin
  xb:=2;
  yb:=3;
  foundb:=1;
  end;
  if (((b[2,2]=bigb)and(foundb=0))and(a[2,2]=0))then begin
  xb:=2;
  yb:=2;
  foundb:=1;
  end;
  if (((b[3,2]=bigb)and(foundb=0))and(a[3,2]=0))then begin
  xb:=3;
  yb:=2;
  foundb:=1;
  end;
  if (((b[4,2]=bigb)and(foundb=0))and(a[4,2]=0))then begin
  xb:=4;
  yb:=2;
  foundb:=1;
  end;
  if (((b[5,2]=bigb)and(foundb=0))and(a[5,2]=0))then begin
  xb:=5;
  yb:=2;
  foundb:=1;
  end;
  if (((b[6,2]=bigb)and(foundb=0))and(a[6,2]=0))then begin
  xb:=6;
  yb:=2;
  foundb:=1;
  end;
  if (((b[7,2]=bigb)and(foundb=0))and(a[7,2]=0))then begin
  xb:=7;
  yb:=2;
  foundb:=1;
  end;
  if (((b[7,3]=bigb)and(foundb=0))and(a[7,3]=0))then begin
  xb:=7;
  yb:=3;
  foundb:=1;
  end;
  if (((b[7,4]=bigb)and(foundb=0))and(a[7,4]=0))then begin
  xb:=7;
  yb:=4;
  foundb:=1;
  end;
  if (((b[7,5]=bigb)and(foundb=0))and(a[7,5]=0))then begin
  xb:=7;
  yb:=5;
  foundb:=1;
  end;
  if (((b[7,6]=bigb)and(foundb=0))and(a[7,6]=0))then begin
  xb:=7;
  yb:=6;
  foundb:=1;
  end;
  if (((b[7,7]=bigb)and(foundb=0))and(a[7,7]=0))then begin
  xb:=7;
  yb:=7;
  foundb:=1;
  end;
  if (((b[6,7]=bigb)and(foundb=0))and(a[6,7]=0))then begin
  xb:=6;
  yb:=7;
  foundb:=1;
  end;
  if (((b[5,7]=bigb)and(foundb=0))and(a[5,7]=0))then begin
  xb:=5;
  yb:=7;
  foundb:=1;
  end;
  if (((b[4,7]=bigb)and(foundb=0))and(a[4,7]=0))then begin
  xb:=4;
  yb:=7;
  foundb:=1;
  end;
  if (((b[3,7]=bigb)and(foundb=0))and(a[3,7]=0))then begin
  xb:=3;
  yb:=7;
  foundb:=1;
  end;
  if (((b[2,7]=bigb)and(foundb=0))and(a[2,7]=0))then begin
  xb:=2;
  yb:=7;
  foundb:=1;
  end;
  if (((b[1,7]=bigb)and(foundb=0))and(a[1,7]=0))then begin
  xb:=1;
  yb:=7;
  foundb:=1;
  end;
  if (((b[1,6]=bigb)and(foundb=0))and(a[1,6]=0))then begin
  xb:=1;
  yb:=6;
  foundb:=1;
  end;
  if (((b[1,5]=bigb)and(foundb=0))and(a[1,5]=0))then begin
  xb:=1;
  yb:=5;
  foundb:=1;
  end;
  if (((b[1,4]=bigb)and(foundb=0))and(a[1,4]=0))then begin
  xb:=1;
  yb:=4;
  foundb:=1;
  end;
  if (((b[1,3]=bigb)and(foundb=0))and(a[1,3]=0))then begin
  xb:=1;
  yb:=3;
  foundb:=1;
  end;
  if (((b[1,2]=bigb)and(foundb=0))and(a[1,2]=0))then begin
  xb:=1;
  yb:=2;
  foundb:=1;
  end;
  if (((b[1,1]=bigb)and(foundb=0))and(a[1,1]=0))then begin
  xb:=1;
  yb:=1;
  foundb:=1;
  end;
    if (((b[2,1]=bigb)and(foundb=0))and(a[2,1]=0))then begin
  xb:=2;
  yb:=1;
  foundb:=1;
  end;
  if (((b[3,1]=bigb)and(foundb=0))and(a[3,1]=0))then begin
  xb:=3;
  yb:=1;
  foundb:=1;
  end;
  if (((b[4,1]=bigb)and(foundb=0))and(a[4,1]=0))then begin
  xb:=4;
  yb:=1;
  foundb:=1;
  end;
  if (((b[5,1]=bigb)and(foundb=0))and(a[5,1]=0))then begin
  xb:=5;
  yb:=1;
  foundb:=1;
  end;
  if (((b[6,1]=bigb)and(foundb=0))and(a[6,1]=0))then begin
  xb:=6;
  yb:=1;
  foundb:=1;
  end;
  if (((b[7,1]=bigb)and(foundb=0))and(a[7,1]=0))then begin
  xb:=7;
  yb:=1;
  foundb:=1;
  end;
  if (((b[8,1]=bigb)and(foundb=0))and(a[8,1]=0))then begin
  xb:=8;
  yb:=1;
  foundb:=1;
  end;
    if (((b[8,2]=bigb)and(foundb=0))and(a[8,2]=0))then begin
  xb:=8;
  yb:=2;
  foundb:=1;
  end;
  if (((b[8,3]=bigb)and(foundb=0))and(a[8,3]=0))then begin
  xb:=8;
  yb:=3;
  foundb:=1;
  end;
  if (((b[8,4]=bigb)and(foundb=0))and(a[8,4]=0))then begin
  xb:=8;
  yb:=4;
  foundb:=1;
  end;
  if (((b[8,5]=bigb)and(foundb=0))and(a[8,5]=0))then begin
  xb:=8;
  yb:=5;
  foundb:=1;
  end;
  if (((b[8,6]=bigb)and(foundb=0))and(a[8,6]=0))then begin
  xb:=8;
  yb:=6;
  foundb:=1;
  end;
  if (((b[8,7]=bigb)and(foundb=0))and(a[7,7]=0))then begin
  xb:=8;
  yb:=7;
  foundb:=1;
  end;
  if (((b[8,8]=bigb)and(foundb=0))and(a[8,8]=0))then begin
  xb:=8;
  yb:=8;
  foundb:=1;
  end;
    if (((b[7,8]=bigb)and(foundb=0))and(a[7,8]=0))then begin
  xb:=7;
  yb:=8;
  foundb:=1;
  end;
  if (((b[6,8]=bigb)and(foundb=0))and(a[6,8]=0))then begin
  xb:=6;
  yb:=8;
  foundb:=1;
  end;
  if (((b[5,8]=bigb)and(foundb=0))and(a[5,8]=0))then begin
  xb:=5;
  yb:=8;
  foundb:=1;
  end;
  if (((b[4,8]=bigb)and(foundb=0))and(a[4,8]=0))then begin
  xb:=4;
  yb:=8;
  foundb:=1;
  end;
  if (((b[3,8]=bigb)and(foundb=0))and(a[3,8]=0))then begin
  xb:=3;
  yb:=8;
  foundb:=1;
  end;
  if (((b[2,8]=bigb)and(foundb=0))and(a[2,8]=0))then begin
  xb:=2;
  yb:=8;
  foundb:=1;
  end;
  if (((b[1,8]=bigb)and(foundb=0))and(a[1,8]=0))then begin
  xb:=1;
  yb:=8;
  foundb:=1;
  end;
end;

procedure big_loce;
begin
  founde:=0;
  if (((e[4,4]=bige)and(founde=0))and(a[4,4]=0))then begin
  xe:=4;
  ye:=4;
  founde:=1;
  end;
  if (((e[5,4]=bige)and(founde=0))and(a[5,4]=0))then begin
  xe:=5;
  ye:=4;
  founde:=1;
  end;
  if (((e[5,5]=bige)and(founde=0))and(a[5,5]=0))then begin
  xe:=5;
  ye:=5;
  founde:=1;
  end;
  if (((e[4,5]=bige)and(founde=0))and(a[4,5]=0))then begin
  xe:=4;
  ye:=5;
  founde:=1;
  end;
  if (((e[3,5]=bige)and(founde=0))and(a[3,5]=0))then begin
  xe:=3;
  ye:=5;
  founde:=1;
  end;
  if (((e[3,4]=bige)and(founde=0))and(a[3,4]=0))then begin
  xe:=3;
  ye:=4;
  founde:=1;
  end;
  if (((e[3,3]=bige)and(founde=0))and(a[3,3]=0))then begin
  xe:=3;
  ye:=3;
  founde:=1;
  end;
  if (((e[4,3]=bige)and(founde=0))and(a[4,3]=0))then begin
  xe:=4;
  ye:=3;
  founde:=1;
  end;
  if (((e[5,3]=bige)and(founde=0))and(a[5,3]=0))then begin
  xe:=5;
  ye:=3;
  founde:=1;
  end;
  if (((e[6,3]=bige)and(founde=0))and(a[6,3]=0))then begin
  xe:=6;
  ye:=3;
  founde:=1;
  end;
  if (((e[6,4]=bige)and(founde=0))and(a[6,4]=0))then begin
  xe:=6;
  ye:=4;
  founde:=1;
  end;
  if (((e[6,5]=bige)and(founde=0))and(a[6,5]=0))then begin
  xe:=6;
  ye:=5;
  founde:=1;
  end;
  if (((e[6,6]=bige)and(founde=0))and(a[6,6]=0))then begin
  xe:=6;
  ye:=6;
  founde:=1;
  end;
  if (((e[5,6]=bige)and(foundb=0))and(a[5,6]=0))then begin
  xe:=5;
  ye:=6;
  founde:=1;
  end;
  if (((e[4,6]=bige)and(founde=0))and(a[4,6]=0))then begin
  xe:=4;
  ye:=6;
  founde:=1;
  end;
  if (((e[3,6]=bige)and(founde=0))and(a[3,6]=0))then begin
  xe:=3;
  ye:=6;
  founde:=1;
  end;
  if (((e[2,6]=bige)and(founde=0))and(a[2,6]=0))then begin
  xe:=2;
  ye:=6;
  founde:=1;
  end;
  if (((e[2,5]=bige)and(founde=0))and(a[2,5]=0))then begin
  xe:=2;
  ye:=5;
  founde:=1;
  end;
  if (((e[2,4]=bige)and(founde=0))and(a[2,4]=0))then begin
  xe:=2;
  ye:=4;
  founde:=1;
  end;
  if (((e[2,3]=bige)and(founde=0))and(a[2,3]=0))then begin
  xe:=2;
  ye:=3;
  founde:=1;
  end;
  if (((e[2,2]=bige)and(founde=0))and(a[2,2]=0))then begin
  xe:=2;
  ye:=2;
  founde:=1;
  end;
  if (((e[3,2]=bige)and(founde=0))and(a[3,2]=0))then begin
  xe:=3;
  ye:=2;
  founde:=1;
  end;
  if (((e[4,2]=bige)and(founde=0))and(a[4,2]=0))then begin
  xe:=4;
  ye:=2;
  founde:=1;
  end;
  if (((e[5,2]=bige)and(founde=0))and(a[5,2]=0))then begin
  xe:=5;
  ye:=2;
  founde:=1;
  end;
  if (((e[6,2]=bige)and(founde=0))and(a[6,2]=0))then begin
  xe:=6;
  ye:=2;
  founde:=1;
  end;
  if (((e[7,2]=bige)and(founde=0))and(a[7,2]=0))then begin
  xe:=7;
  ye:=2;
  founde:=1;
  end;
  if (((e[7,3]=bige)and(founde=0))and(a[7,3]=0))then begin
  xe:=7;
  ye:=3;
  founde:=1;
  end;
  if (((e[7,4]=bige)and(founde=0))and(a[7,4]=0))then begin
  xe:=7;
  ye:=4;
  founde:=1;
  end;
  if (((e[7,5]=bige)and(founde=0))and(a[7,5]=0))then begin
  xe:=7;
  ye:=5;
  founde:=1;
  end;
  if (((e[7,6]=bige)and(founde=0))and(a[7,6]=0))then begin
  xe:=7;
  ye:=6;
  founde:=1;
  end;
  if (((e[7,7]=bige)and(founde=0))and(a[7,7]=0))then begin
  xe:=7;
  ye:=7;
  founde:=1;
  end;
  if (((e[6,7]=bige)and(founde=0))and(a[6,7]=0))then begin
  xe:=6;
  ye:=7;
  founde:=1;
  end;
  if (((e[5,7]=bige)and(founde=0))and(a[5,7]=0))then begin
  xe:=5;
  ye:=7;
  founde:=1;
  end;
  if (((e[4,7]=bige)and(founde=0))and(a[4,7]=0))then begin
  xe:=4;
  ye:=7;
  founde:=1;
  end;
  if (((e[3,7]=bige)and(founde=0))and(a[3,7]=0))then begin
  xe:=3;
  ye:=7;
  founde:=1;
  end;
  if (((e[2,7]=bige)and(founde=0))and(a[2,7]=0))then begin
  xe:=2;
  ye:=7;
  founde:=1;
  end;
  if (((e[1,7]=bige)and(founde=0))and(a[1,7]=0))then begin
  xe:=1;
  ye:=7;
  founde:=1;
  end;
  if (((e[1,6]=bige)and(founde=0))and(a[1,6]=0))then begin
  xe:=1;
  ye:=6;
  founde:=1;
  end;
  if (((e[1,5]=bige)and(founde=0))and(a[1,5]=0))then begin
  xe:=1;
  ye:=5;
  founde:=1;
  end;
  if (((e[1,4]=bige)and(founde=0))and(a[1,4]=0))then begin
  xe:=1;
  ye:=4;
  founde:=1;
  end;
  if (((e[1,3]=bige)and(founde=0))and(a[1,3]=0))then begin
  xe:=1;
  ye:=3;
  founde:=1;
  end;
  if (((e[1,2]=bige)and(founde=0))and(a[1,2]=0))then begin
  xe:=1;
  ye:=2;
  founde:=1;
  end;
  if (((e[1,1]=bige)and(founde=0))and(a[1,1]=0))then begin
  xe:=1;
  ye:=1;
  founde:=1;
  end;
    if (((e[2,1]=bige)and(founde=0))and(a[2,1]=0))then begin
  xe:=2;
  ye:=1;
  founde:=1;
  end;
  if (((e[3,1]=bige)and(founde=0))and(a[3,1]=0))then begin
  xe:=3;
  ye:=1;
  founde:=1;
  end;
  if (((e[4,1]=bige)and(founde=0))and(a[4,1]=0))then begin
  xe:=4;
  ye:=1;
  founde:=1;
  end;
  if (((e[5,1]=bige)and(founde=0))and(a[5,1]=0))then begin
  xe:=5;
  ye:=1;
  founde:=1;
  end;
  if (((e[6,1]=bige)and(founde=0))and(a[6,1]=0))then begin
  xe:=6;
  ye:=1;
  founde:=1;
  end;
  if (((e[7,1]=bige)and(founde=0))and(a[7,1]=0))then begin
  xe:=7;
  ye:=1;
  founde:=1;
  end;
  if (((e[8,1]=bige)and(founde=0))and(a[8,1]=0))then begin
  xe:=8;
  ye:=1;
  founde:=1;
  end;
    if (((e[8,2]=bige)and(founde=0))and(a[8,2]=0))then begin
  xe:=8;
  ye:=2;
  founde:=1;
  end;
  if (((e[8,3]=bige)and(founde=0))and(a[8,3]=0))then begin
  xe:=8;
  ye:=3;
  founde:=1;
  end;
  if (((e[8,4]=bige)and(founde=0))and(a[8,4]=0))then begin
  xe:=8;
  ye:=4;
  founde:=1;
  end;
  if (((e[8,5]=bige)and(founde=0))and(a[8,5]=0))then begin
  xe:=8;
  ye:=5;
  founde:=1;
  end;
  if (((e[8,6]=bige)and(founde=0))and(a[8,6]=0))then begin
  xe:=8;
  ye:=6;
  founde:=1;
  end;
  if (((e[8,7]=bige)and(founde=0))and(a[7,7]=0))then begin
  xe:=8;
  ye:=7;
  founde:=1;
  end;
  if (((e[8,8]=bige)and(founde=0))and(a[8,8]=0))then begin
  xe:=8;
  ye:=8;
  founde:=1;
  end;
    if (((e[7,8]=bige)and(founde=0))and(a[7,8]=0))then begin
  xe:=7;
  ye:=8;
  founde:=1;
  end;
  if (((e[6,8]=bige)and(founde=0))and(a[6,8]=0))then begin
  xe:=6;
  ye:=8;
  founde:=1;
  end;
  if (((e[5,8]=bige)and(founde=0))and(a[5,8]=0))then begin
  xe:=5;
  ye:=8;
  founde:=1;
  end;
  if (((e[4,8]=bige)and(founde=0))and(a[4,8]=0))then begin
  xe:=4;
  ye:=8;
  founde:=1;
  end;
  if (((e[3,8]=bige)and(founde=0))and(a[3,8]=0))then begin
  xe:=3;
  ye:=8;
  founde:=1;
  end;
  if (((e[2,8]=bige)and(founde=0))and(a[2,8]=0))then begin
  xe:=2;
  ye:=8;
  founde:=1;
  end;
  if (((e[1,8]=bige)and(founde=0))and(a[1,8]=0))then begin
  xe:=1;
  ye:=8;
  founde:=1;
  end;
end;

procedure big_locf;
begin
  foundf:=0;
  if (((f[4,4]=bigf)and(foundf=0))and(a[4,4]=0))then begin
  xf:=4;
  yf:=4;
  foundf:=1;
  end;
  if (((f[5,4]=bigf)and(foundf=0))and(a[5,4]=0))then begin
  xf:=5;
  yf:=4;
  foundf:=1;
  end;
  if (((f[5,5]=bigf)and(foundf=0))and(a[5,5]=0))then begin
  xf:=5;
  yf:=5;
  foundf:=1;
  end;
  if (((f[4,5]=bigf)and(foundf=0))and(a[4,5]=0))then begin
  xf:=4;
  yf:=5;
  foundf:=1;
  end;
  if (((f[3,5]=bigf)and(foundf=0))and(a[3,5]=0))then begin
  xf:=3;
  yf:=5;
  foundf:=1;
  end;
  if (((f[3,4]=bigf)and(foundf=0))and(a[3,4]=0))then begin
  xf:=3;
  yf:=4;
  foundf:=1;
  end;
  if (((f[3,3]=bigf)and(foundf=0))and(a[3,3]=0))then begin
  xf:=3;
  yf:=3;
  foundf:=1;
  end;
  if (((f[4,3]=bigf)and(foundf=0))and(a[4,3]=0))then begin
  xf:=4;
  yf:=3;
  foundf:=1;
  end;
  if (((f[5,3]=bigf)and(foundf=0))and(a[5,3]=0))then begin
  xf:=5;
  yf:=3;
  foundf:=1;
  end;
  if (((f[6,3]=bigf)and(foundf=0))and(a[6,3]=0))then begin
  xf:=6;
  yf:=3;
  foundf:=1;
  end;
  if (((f[6,4]=bigf)and(foundf=0))and(a[6,4]=0))then begin
  xf:=6;
  yf:=4;
  foundf:=1;
  end;
  if (((f[6,5]=bigf)and(foundf=0))and(a[6,5]=0))then begin
  xf:=6;
  yf:=5;
  foundf:=1;
  end;
  if (((f[6,6]=bigf)and(foundf=0))and(a[6,6]=0))then begin
  xf:=6;
  yf:=6;
  foundf:=1;
  end;
  if (((f[5,6]=bigf)and(foundf=0))and(a[5,6]=0))then begin
  xf:=5;
  yf:=6;
  foundf:=1;
  end;
  if (((f[4,6]=bigf)and(foundf=0))and(a[4,6]=0))then begin
  xf:=4;
  yf:=6;
  foundf:=1;
  end;
  if (((f[3,6]=bigf)and(foundf=0))and(a[3,6]=0))then begin
  xf:=3;
  yf:=6;
  foundf:=1;
  end;
  if (((f[2,6]=bigf)and(foundf=0))and(a[2,6]=0))then begin
  xf:=2;
  yf:=6;
  foundf:=1;
  end;
  if (((f[2,5]=bigf)and(foundf=0))and(a[2,5]=0))then begin
  xf:=2;
  yf:=5;
  foundf:=1;
  end;
  if (((f[2,4]=bigf)and(foundf=0))and(a[2,4]=0))then begin
  xf:=2;
  yf:=4;
  foundf:=1;
  end;
  if (((f[2,3]=bigf)and(foundf=0))and(a[2,3]=0))then begin
  xf:=2;
  yf:=3;
  foundf:=1;
  end;
  if (((f[2,2]=bigf)and(foundf=0))and(a[2,2]=0))then begin
  xf:=2;
  yf:=2;
  foundf:=1;
  end;
  if (((f[3,2]=bigf)and(foundf=0))and(a[3,2]=0))then begin
  xf:=3;
  yf:=2;
  foundf:=1;
  end;
  if (((f[4,2]=bigf)and(foundf=0))and(a[4,2]=0))then begin
  xf:=4;
  yf:=2;
  foundf:=1;
  end;
  if (((f[5,2]=bigf)and(foundf=0))and(a[5,2]=0))then begin
  xf:=5;
  yf:=2;
  foundf:=1;
  end;
  if (((f[6,2]=bigf)and(foundf=0))and(a[6,2]=0))then begin
  xf:=6;
  yf:=2;
  foundf:=1;
  end;
  if (((f[7,2]=bigf)and(foundf=0))and(a[7,2]=0))then begin
  xf:=7;
  yf:=2;
  foundf:=1;
  end;
  if (((f[7,3]=bigf)and(foundf=0))and(a[7,3]=0))then begin
  xf:=7;
  yf:=3;
  foundf:=1;
  end;
  if (((f[7,4]=bigf)and(foundf=0))and(a[7,4]=0))then begin
  xf:=7;
  yf:=4;
  foundf:=1;
  end;
  if (((f[7,5]=bigf)and(foundf=0))and(a[7,5]=0))then begin
  xf:=7;
  yf:=5;
  foundf:=1;
  end;
  if (((f[7,6]=bigf)and(foundf=0))and(a[7,6]=0))then begin
  xf:=7;
  yf:=6;
  foundf:=1;
  end;
  if (((f[7,7]=bigf)and(foundf=0))and(a[7,7]=0))then begin
  xf:=7;
  yf:=7;
  foundf:=1;
  end;
  if (((f[6,7]=bigf)and(foundf=0))and(a[6,7]=0))then begin
  xf:=6;
  yf:=7;
  foundf:=1;
  end;
  if (((f[5,7]=bigf)and(foundf=0))and(a[5,7]=0))then begin
  xf:=5;
  yf:=7;
  foundf:=1;
  end;
  if (((f[4,7]=bigf)and(foundf=0))and(a[4,7]=0))then begin
  xf:=4;
  yf:=7;
  foundf:=1;
  end;
  if (((f[3,7]=bigf)and(foundf=0))and(a[3,7]=0))then begin
  xf:=3;
  yf:=7;
  foundf:=1;
  end;
  if (((f[2,7]=bigf)and(foundf=0))and(a[2,7]=0))then begin
  xf:=2;
  yf:=7;
  foundf:=1;
  end;
  if (((f[1,7]=bigf)and(foundf=0))and(a[1,7]=0))then begin
  xf:=1;
  yf:=7;
  foundf:=1;
  end;
  if (((f[1,6]=bigf)and(foundf=0))and(a[1,6]=0))then begin
  xf:=1;
  yf:=6;
  foundf:=1;
  end;
  if (((f[1,5]=bigf)and(foundf=0))and(a[1,5]=0))then begin
  xf:=1;
  yf:=5;
  foundf:=1;
  end;
  if (((f[1,4]=bigf)and(foundf=0))and(a[1,4]=0))then begin
  xf:=1;
  yf:=4;
  foundf:=1;
  end;
  if (((f[1,3]=bigf)and(foundf=0))and(a[1,3]=0))then begin
  xf:=1;
  yf:=3;
  foundf:=1;
  end;
  if (((f[1,2]=bigf)and(foundf=0))and(a[1,2]=0))then begin
  xf:=1;
  yf:=2;
  foundf:=1;
  end;
  if (((f[1,1]=bigf)and(foundf=0))and(a[1,1]=0))then begin
  xf:=1;
  yf:=1;
  foundf:=1;
  end;
    if (((f[2,1]=bigf)and(foundf=0))and(a[2,1]=0))then begin
  xf:=2;
  yf:=1;
  foundf:=1;
  end;
  if (((f[3,1]=bigf)and(foundf=0))and(a[3,1]=0))then begin
  xf:=3;
  yf:=1;
  foundf:=1;
  end;
  if (((f[4,1]=bigf)and(foundf=0))and(a[4,1]=0))then begin
  xf:=4;
  yf:=1;
  foundf:=1;
  end;
  if (((f[5,1]=bigf)and(foundf=0))and(a[5,1]=0))then begin
  xf:=5;
  yf:=1;
  foundf:=1;
  end;
  if (((f[6,1]=bigf)and(foundf=0))and(a[6,1]=0))then begin
  xf:=6;
  yf:=1;
  foundf:=1;
  end;
  if (((f[7,1]=bigf)and(foundf=0))and(a[7,1]=0))then begin
  xf:=7;
  yf:=1;
  foundf:=1;
  end;
  if (((f[8,1]=bigf)and(foundf=0))and(a[8,1]=0))then begin
  xf:=8;
  yf:=1;
  foundf:=1;
  end;
    if (((f[8,2]=bigf)and(foundf=0))and(a[8,2]=0))then begin
  xf:=8;
  yf:=2;
  foundf:=1;
  end;
  if (((f[8,3]=bigf)and(foundf=0))and(a[8,3]=0))then begin
  xf:=8;
  yf:=3;
  foundf:=1;
  end;
  if (((f[8,4]=bigf)and(foundf=0))and(a[8,4]=0))then begin
  xf:=8;
  yf:=4;
  foundf:=1;
  end;
  if (((f[8,5]=bigf)and(foundf=0))and(a[8,5]=0))then begin
  xf:=8;
  yf:=5;
  foundf:=1;
  end;
  if (((f[8,6]=bigf)and(foundf=0))and(a[8,6]=0))then begin
  xf:=8;
  yf:=6;
  foundf:=1;
  end;
  if (((f[8,7]=bigf)and(foundf=0))and(a[7,7]=0))then begin
  xf:=8;
  yf:=7;
  foundf:=1;
  end;
  if (((f[8,8]=bigf)and(foundf=0))and(a[8,8]=0))then begin
  xf:=8;
  yf:=8;
  foundf:=1;
  end;
    if (((f[7,8]=bigf)and(foundf=0))and(a[7,8]=0))then begin
  xf:=7;
  yf:=8;
  foundf:=1;
  end;
  if (((f[6,8]=bigf)and(foundf=0))and(a[6,8]=0))then begin
  xf:=6;
  yf:=8;
  foundf:=1;
  end;
  if (((f[5,8]=bigf)and(foundf=0))and(a[5,8]=0))then begin
  xf:=5;
  yf:=8;
  foundf:=1;
  end;
  if (((f[4,8]=bigf)and(foundf=0))and(a[4,8]=0))then begin
  xf:=4;
  yf:=8;
  foundf:=1;
  end;
  if (((f[3,8]=bigf)and(foundf=0))and(a[3,8]=0))then begin
  xf:=3;
  yf:=8;
  foundf:=1;
  end;
  if (((f[2,8]=bigf)and(foundf=0))and(a[2,8]=0))then begin
  xf:=2;
  yf:=8;
  foundf:=1;
  end;
  if (((f[1,8]=bigf)and(foundf=0))and(a[1,8]=0))then begin
  xf:=1;
  yf:=8;
  foundf:=1;
  end;
end;

begin                                   {main program}
 play_again:=121;
 while (play_again = 121) do begin
  textmode(3);
  chips:=0;
  player1_score:=0;
  player2_score:=0;
  textbackground(1);
  clrscr;
  textbackground(0);
  window(4,14,23,24);
  logo_old;
  window(58,14,77,24);
  logo_old;
  window(28,23,53,24);
  clrscr;
  writeln('        Written by');
  write('      Chuck  Stevens');
  window(19,6,63,10);
  clrscr;
  writeln;
  write('   How many players  (1 or 2)?  ');
  readln(num_players);
  if (num_players = 1) then begin
   clrscr;
   writeln;
   write('   What is your name?  ');
   readln(name);
   writeln;
   write('   Do you want to go first (yes/NO)?  ');
   readln(first);
   if((first = 'yes') or (first = 'y')or
   (first = 'YES')or(first = 'Y')) then begin
    name1:=name;
    name2:='HAL';
    f1:=2;
    f2:=1;
   end
   else begin
    name1:='HAL';
    name2:=name;
    f1:=1;
    f2:=2;
   end;
  end else begin
   clrscr;
   writeln;
   write('   Name of player #1:  ');
   readln(namea);
   writeln;
   write('   Name of player #2:  ');
   readln(nameb);
  end;

  {Main program for two players}

  if (num_players = 2) then begin
   graph_ini;
   f1:=1;
   f2:=2;
   name1:=namea;
   name2:=nameb;
   chips:=0;
   player1_score:=0;
   player2_score:=0;
   player:=1;
   createa;
   row:=1;
   setbkcolor(0);
   setlinestyle(0,0,3);
   setcolor(4);
   rectangle(0,0,getmaxx,getmaxy);
   rectangle(6,6,getmaxx-6,getmaxy-6);
   setviewport(40,40,400,400,clipon);
   setfillstyle(1,8);
   bar(0,0,360,360);
   setlinestyle(0,1,3);
   setcolor(2);
   rectangle(0,0,360,360);
   setcolor(2);
   setlinestyle(0,0,1);
   for j := 1 to 7 do begin
    line(j*45,0,j*45,360);
    line(0,j*45,360,j*45);
   end;
   while (chips <= 63) do begin
    display;
    chips:=chips+1;
    logo;
    score;
    message(' ');
    row := 0;
    column := 0;
    while not ((a[row,column] = 0)or (chips = 70)) do begin
     ask;
     if (player=f1) then begin
      setcolor(4);
      outtext(name1);
      outtext(': ');
     end
     else begin
      setcolor(1);
      outtext(name2);
      outtext(': ');
     end;
     repeat row := ord(readkey)-48;
     until ((row < 9)and(row >0)) or (row = 65);
      if (row = 65) then begin
       chips := 70;
      end
      else begin
       outtext(chr(row+48));
       outtext(',');
       repeat column := ord(readkey)-48;
       until ((column < 9) and (column >0));
        outtext(chr(column+48));
        if not (a[row,column] = 0)then
         message('Oops!');
        end;
       end;
       a[row,column] := player;
       west_test;
       east_test;
       line_point;
       north_test;
       south_test;
       line_point;
       northwest_test;
       southeast_test;
       line_point;
       northeast_test;
       southwest_test;
       line_point;
       switch_player;
      end;
     end
     else begin
      chips:=70;
     end;

  {Put one player game here.}

 if (num_players = 1) then begin
  graph_ini;
  randomize;
  chips:=0;
  player1_score:=0;
  player2_score:=0;
  player := f1;
  createa;
  row := 1;
  setbkcolor(0);
  setlinestyle(0,0,3);
  setcolor(4);
  rectangle(0,0,getmaxx,getmaxy);
  rectangle(6,6,getmaxx-6,getmaxy-6);
  setviewport(40,40,400,400,clipon);
  setfillstyle(1,8);
  bar(0,0,360,360);
  setlinestyle(0,1,3);
  setcolor(2);
  rectangle(0,0,360,360);
  setcolor(2);
  setlinestyle(0,0,1);
  for j := 1 to 7 do begin
   line(j*45,0,j*45,360);
   line(0,j*45,360,j*45);
  end;
  While (chips <= 63 ) do begin
   chips := chips + 1;
   logo;
   score;
   display;
   ask;
   message(' ');
   row := 0;
   column := 0;
   resetbfe;
   g:=player;
   player:=f1;
   for k:=1 to 8 do begin            {making matrix e for player 1 options}
    row:=k;
    for l:=1 to 8 do begin
     pos_value:=0;
     column:=l;
     if( a[k,l]=0) then begin
      west_test;
      east_test;
      test_pos;
      north_test;
      south_test;
      test_pos;
      northwest_test;
      southeast_test;
      test_pos;
      northeast_test;
      southwest_test;
      test_pos;
      e[k,l]:=pos_value;
     end
     else begin
      e[k,l]:=0;
    end;
    end;
   end;
   findbige;
   big_loce;
   player:=f2;
   for k:=1 to 8 do begin              {making matix f for player 2 options}
    row:=k;
    for l:=1 to 8 do begin
     pos_value:=0;
     column:=l;
     if( a[k,l]=0) then begin
       west_test;
       east_test;
       test_pos;
       north_test;
       south_test;
       test_pos;
       northwest_test;
       southeast_test;
       test_pos;
       northeast_test;
       southwest_test;
       test_pos;
       f[k,l]:=pos_value;
      end
      else begin
       f[k,l]:=0;
      end;
     end;
    end;
    player:=f1;
    for m:=1 to 8 do begin        {making b matrix for total points per move}
     for n:=1 to 8 do begin
      tot_value:=0;
      u:=a[m,n];
      if (a[m,n]=0) then begin
       a[m,n]:=f1;
      end;
      for k:=1 to 8 do begin
       row:=k;
       for l:=1 to 8 do begin
        pos_value:=0;
        column:=l;
        if (a[k,l]=0) then begin
         west_test;
         east_test;
         test_pos;
         north_test;
         south_test;
         test_pos;
         northwest_test;
         southeast_test;
         test_pos;
         northeast_test;
         southwest_test;
         test_pos;
         tot_value:=tot_value+pos_value;
        end
        else begin
         b[k,l]:=0;
        end;
       end;
      end;
      b[m,n]:=tot_value+e[m,n]+f[m,n];
      a[m,n]:=u;
     end;
    end;
    findbigb;
    big_locb;
    findbigf;                               {Matrix e is computer}
    big_locf;                               {Matrix f is human}
    player:=g;

     if (player = 1) then begin
     row:=xb;
     column:=yb;
     if (chips < 3) then begin                {Move rondom if chips are less}
      row:=random(4)+3;                       {than 3}
      column:=random(4)+3;
      while (a[row,column] > 0) do begin
       row:=random(3)+2;
       column:=random(3)+2;
      end;
     end;
     if (f1=1) then begin                     {If computer starts}
      if (bige >=5) then begin                 {Take 5}
       row := xe;
       column := ye;
      end;
      if ((chips >55) and (bige >= 4)) then begin
      row := xe;
      column := ye;
      end;
      if (bigf >=5) then begin                 {Stop 5}
       row := xf;
       column := yf;
      end;
      if (chips > 55 ) and (bige >= 3) and (bigf <= 4) then begin
      row := xe;
      column := ye;
      end;
     end
     else begin                               {If opponent starts}
     if (bige >=6) then begin                 {take 4}
      row := xe;
      column := ye;
     end;
     if (bigf >=5) then begin                 {Stop 5}
      row :=xf;
      column :=yf;
     end;
     if ((chips < 12) and (bigf <= 3)) then begin
      row := xb;
      column := yb;
     end;
     if ((chips > 58) and (bige >= 3)) then begin
     row := xe;
     column := ye;
     end;
    end;
    ask;
    if (f1 = 2) then begin
     setcolor(1);
    end
    else begin
     setcolor(4);
    end;
    outtext('HAL');
    outtext(': ');
    outtext(chr(row+48));
    outtext(',');
    outtext(chr(column+48));
    delay(1100);
   end;

     if (player=2) then begin
      repeat
      if (player = 2) then begin
       ask;
       if (f1 = 2) then begin
        setcolor(4);
       end
       else begin
        setcolor(1);
       end;
       outtext(name);
       outtext(': ');
      end
      else begin
       ask;
       if (f1 = 1) then begin
        setcolor(1);
       end
       else begin
        setcolor(4);
       end;
       outtext(name);
       outtext(': ');
      end;
      if (player = 2) then begin
       repeat row := ord(readkey)-48;
       until ((row < 9)and(row >0)) or (row = 65);
       if (row = 65) then begin
       chips := 70;
       message('Play again?');
    end
    else begin
     outtext(chr(row+48));
     outtext(',');
     repeat column := ord(readkey)-48;
     until ((column < 9) and (column >0));
      outtext(chr(column+48));
      if not (a[row,column] = 0)then
       message('Oops!');
      end;
      end;
      until (a[row,column] = 0) or (row = 65);
      end;
     tot_point := 0;
     a[row,column] := player;
     west_test;
     east_test;
     line_point;
     north_test;
     south_test;
     line_point;
     northwest_test;
     southeast_test;
     line_point;
     northeast_test;
     southwest_test;
     line_point;

     if (player = 2) then begin              {Comments from Hal}
      comment;
     end;

     switch_player;
    end;
   end
   else begin
    chips:=70;
   end;

{End one player game here}


if  not (row = 65 ) then begin
display;
score;
if  (player1_score = player2_score) then begin
message('Draw.');
readln;
end
else begin
message('Winner!');
readln;
end;
end;
message('Play again?');
play_again := ord(readkey);
end;
textmode(3);
clrscr;
writeln('Thanks for playing Queue-6');
writeln
end.