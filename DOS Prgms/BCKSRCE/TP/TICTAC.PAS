program TicTackToe;

uses
 Crt;

label
 BeginTicTacToe, AskPlayers, BeginGame, AskPlr1, AskPlr2, Plr1Win, Plr2Win,
	Cat, Computer, EndGame, AskPlayAgain, GameOver;

var
 j, jj, k, xx, yy, s11, s12, s13, s21, s22, s23, s31, s32, s33 : integer;
 players, game, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10 : integer;
 r, c, SpaceEmpty, t1, t2 : integer;
 kp : char;

procedure DrawX(r : integer; c : integer);
 begin
	if c = 1 then xx := 14;
	if c = 2 then xx := 25;
	if c = 3 then xx := 36;
	if r = 1 then yy := 5;
	if r = 2 then yy := 10;
	if r = 3 then yy := 15;
	textcolor(yellow);
	gotoxy(xx,yy);
	write(chr(220), '     ', chr(220));
	gotoxy(xx+1,yy+1);
	write(chr(223), chr(220), ' ', chr(220), chr(223));
	gotoxy(xx+1,yy+2);
	write(chr(220), chr(223), ' ', chr(223), chr(220));
	gotoxy(xx,yy+3);
	write(chr(223), '     ', chr(223));
 end;

procedure DrawO(r : integer; c : integer);
 begin
	if c = 1 then xx := 14;
	if c = 2 then xx := 25;
	if c = 3 then xx := 36;
	if r = 1 then yy := 5;
	if r = 2 then yy := 10;
	if r = 3 then yy := 15;
	textcolor(yellow);
	gotoxy(xx+2,yy);
	write(chr(220), chr(220), chr(220));
	gotoxy(xx,yy+1);
	write(chr(220), chr(223), '   ', chr(223), chr(220));
	gotoxy(xx,yy+2);
	write(chr(223), chr(220), '   ', chr(220), chr(223));
	gotoxy(xx+2,yy+3);
	write(chr(223), chr(223), chr(223));
 end;

procedure ClearWindow;
 begin
	textcolor(white);
	textbackground(black);
	gotoxy(54,19);
	write('                      ');
	gotoxy(54,20);
	write('                      ');
 end;

procedure CheckSpace(r : integer; c : integer);
 begin
	SpaceEmpty := 1;
	if r = 1 then if c = 1 then if s11 <> 0 then SpaceEmpty := 0;
	if r = 1 then if c = 2 then if s12 <> 0 then SpaceEmpty := 0;
	if r = 1 then if c = 3 then if s13 <> 0 then SpaceEmpty := 0;
	if r = 2 then if c = 1 then if s21 <> 0 then SpaceEmpty := 0;
	if r = 2 then if c = 2 then if s22 <> 0 then SpaceEmpty := 0;
	if r = 2 then if c = 3 then if s23 <> 0 then SpaceEmpty := 0;
	if r = 3 then if c = 1 then if s31 <> 0 then SpaceEmpty := 0;
	if r = 3 then if c = 2 then if s32 <> 0 then SpaceEmpty := 0;
	if r = 3 then if c = 3 then if s33 <> 0 then SpaceEmpty := 0;
 end;

procedure EndSound;
 var
	s : integer;
 begin
	for s := 1 to 3 do
	 begin
		sound(100);
		delay(100);
		sound(150);
		delay(100);
	 end;
	sound(100);
	delay(100);
	nosound;
 end;

procedure Start;
 begin
	s11 := 0;
	s12 := 0;
	s13 := 0;
	s21 := 0;
	s22 := 0;
	s23 := 0;
	s31 := 0;
	s32 := 0;
	s33 := 0;
	g1 := 0;
	g2 := 0;
	g3 := 0;
	g4 := 0;
	g5 := 0;
	g6 := 0;
	g7 := 0;
	g8 := 0;
	g9 := 0;
	g10 := 0;
	game := 1;
	clrscr;
	textcolor(red);
	j := 4;
	jj := 1;
	while j <= 76 do
	 begin
		gotoxy(j,3);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(j,21);
    if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		jj := jj + 1;
		if jj > 6 then jj := 1;
		j := j + 2;
	 end;
	jj := 2;
	j := 4;
	while j <= 21 do
	 begin
		gotoxy(4,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(52,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(76,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		jj := jj + 1;
		if jj > 6 then jj := 1;
		j := j + 1;
	 end;
	gotoxy(54,18);
	write(chr(178), chr(178), chr(177), chr(177), chr(176), chr(176), chr(177), chr(177),
	 chr(178), chr(178), chr(219), chr(219), chr(178), chr(178), chr(177), chr(177), chr(176), chr(176),
	 chr(177), chr(177), chr(178), chr(178));
	textcolor(red);
	gotoxy(57,5);
	write(chr(220), chr(220), chr(220), chr(220), chr(220), ' ', chr(220), chr(220), chr(220), ' ',
	 chr(220), chr(220), chr(220), chr(220));
	textcolor(lightred);
	gotoxy(59,6);
	write(chr(219), '    ', chr(219), '  ', chr(219));
	textcolor(yellow);
	textbackground(lightgray);
	gotoxy(59,7);
	write(chr(223));
	gotoxy(64,7);
	write(chr(223));
	gotoxy(67,7);
	write(chr(223));
	textcolor(black);
	gotoxy(63,7);
	write(chr(223));
	gotoxy(65,7);
	write(chr(223));
	gotoxy(68,7);
	write(chr(223), chr(223), chr(223));
	textcolor(red);
	textbackground(black);
	gotoxy(57,8);
	write(chr(220), chr(220), chr(220), chr(220), chr(220), ' ', chr(220), chr(220), chr(220), chr(220), ' ',
	 chr(220), chr(220), chr(220), chr(220));
	textcolor(lightred);
	gotoxy(59,9);
	write(chr(219), '   ', chr(219), chr(220), chr(220), chr(219), ' ', chr(219));
	textcolor(yellow);
	textbackground(lightgray);
	gotoxy(59,10);
	write(chr(223));
	gotoxy(63,10);
	write(chr(223));
	gotoxy(66,10);
	write(chr(223));
	gotoxy(68,10);
	write(chr(223));
	textcolor(black);
	write(chr(223), chr(223), chr(223));
	textcolor(red);
	textbackground(black);
	gotoxy(57,11);
	write(chr(220), chr(220), chr(220), chr(220), chr(220), ' ', chr(220), chr(220), chr(220), chr(220), ' ',
	 chr(220), chr(220), chr(220), chr(220));
	textcolor(lightred);
	gotoxy(59,12);
	write(chr(219), '   ', chr(219), '  ', chr(219), ' ', chr(219), chr(220), chr(220));
	textcolor(yellow);
	textbackground(lightgray);
	gotoxy(59,13);
	write(chr(223));
	gotoxy(63,13);
	write(chr(223));
	textcolor(black);
	write(chr(223), chr(223));
	textcolor(yellow);
	write(chr(223));
	gotoxy(68,13);
	write(chr(223));
	textcolor(black);
	write(chr(223), chr(223), chr(223));
	textbackground(black);
	gotoxy(57,15);
	textcolor(darkgray);
	write(chr(157), ' ');
	textcolor(red);
	write('D', chr(228));
	textcolor(lightred);
	write(chr(224), chr(197));
	textcolor(yellow);
	write('h S');
	textcolor(lightred);
	write(chr(179), chr(224), 'y');
	textcolor(red);
	write(chr(228), chr(226), ' ');
	textcolor(darkgray);
	write(chr(157));
	textcolor(lightgray);
	j := 5;
	while j <= 18 do
	 begin
		gotoxy(22,j);
		write(chr(219), chr(219));
		j := j + 1;
	 end;
	textcolor(darkgray);
	j := 5;
	while j <= 18 do
	 begin
		gotoxy(33,j);
		write(chr(219), chr(219));
		j := j + 1;
	 end;
	textcolor(lightblue);
	j := 13;
	while j <= 43 do
	 begin
		gotoxy(j,9);
		write(chr(219));
		j := j + 1;
	 end;
	textcolor(blue);
	j := 13;
	while j <= 43 do
	 begin
		gotoxy(j,14);
		write(chr(219));
		j := j + 1;
	 end;
	drawx(2,2);
	drawo(1,2);
	drawx(3,3);
	drawo(3,2);
	drawx(1,1);
	textcolor(white);
	gotoxy(57,19);
	write('Press Any Key to');
	gotoxy(60,20);
	write('Continue..');
	readkey;
	ClearWindow;
 end;

procedure DrawScreen;
 begin
	clrscr;
	textcolor(red);
	j := 4;
	jj := 1;
	while j <= 76 do
	 begin
		gotoxy(j,3);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(j,21);
    if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		jj := jj + 1;
		if jj > 6 then jj := 1;
		j := j + 2;
	 end;
	jj := 2;
	j := 4;
	while j <= 21 do
	 begin
		gotoxy(4,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(52,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		gotoxy(76,j);
		if jj = 1 then write(chr(219), chr(219));
		if jj = 2 then write(chr(178), chr(178));
		if jj = 3 then write(chr(177), chr(177));
		if jj = 4 then write(chr(176), chr(176));
		if jj = 5 then write(chr(177), chr(177));
		if jj = 6 then write(chr(178), chr(178));
		jj := jj + 1;
		if jj > 6 then jj := 1;
		j := j + 1;
	 end;
	gotoxy(54,18);
	write(chr(178), chr(178), chr(177), chr(177), chr(176), chr(176), chr(177), chr(177),
	 chr(178), chr(178), chr(219), chr(219), chr(178), chr(178), chr(177), chr(177), chr(176), chr(176),
	 chr(177), chr(177), chr(178), chr(178));
	textcolor(lightgray);
	j := 5;
	while j <= 18 do
	 begin
		gotoxy(22,j);
		write(chr(219), chr(219));
		j := j + 1;
	 end;
	textcolor(darkgray);
	j := 5;
	while j <= 18 do
	 begin
		gotoxy(33,j);
		write(chr(219), chr(219));
		j := j + 1;
	 end;
	textcolor(lightblue);
	j := 13;
	while j <= 43 do
	 begin
		gotoxy(j,9);
		write(chr(219));
		j := j + 1;
	 end;
	textcolor(blue);
	j := 13;
	while j <= 43 do
	 begin
		gotoxy(j,14);
		write(chr(219));
		j := j + 1;
	 end;
	for j := 1 to 10 do
	 begin
		gotoxy(56,j+5);
		textcolor(blue);
		write('G');
		textcolor(lightblue);
		write('a');
		textcolor(lightgray);
		write('m');
		textcolor(lightblue);
		write('e ');
		textcolor(blue);
		if j < 10 then write(j, ' :') else write(j, ':');
	 end;
	for j := 1 to 10 do
	 begin
		gotoxy(65,j+5);
		textcolor(red);
		write('P');
		textcolor(lightred);
		write('la');
		textcolor(yellow);
		write('y');
		textcolor(lightred);
		write('er ');
		textcolor(red);
		if j = 1 then if g1 = 0 then write('?');
		if j = 2 then if g2 = 0 then write('?');
		if j = 3 then if g3 = 0 then write('?');
		if j = 4 then if g4 = 0 then write('?');
		if j = 5 then if g5 = 0 then write('?');
		if j = 6 then if g6 = 0 then write('?');
		if j = 7 then if g7 = 0 then write('?');
		if j = 8 then if g8 = 0 then write('?');
		if j = 9 then if g9 = 0 then write('?');
		if j = 10 then if g10 = 0 then write('?');
		if j = 1 then if g1 = 1 then write('1');
		if j = 2 then if g2 = 1 then write('1');
		if j = 3 then if g3 = 1 then write('1');
		if j = 4 then if g4 = 1 then write('1');
		if j = 5 then if g5 = 1 then write('1');
		if j = 6 then if g6 = 1 then write('1');
		if j = 7 then if g7 = 1 then write('1');
		if j = 8 then if g8 = 1 then write('1');
		if j = 9 then if g9 = 1 then write('1');
		if j = 10 then if g10 = 1 then write('1');
		if j = 1 then if g1 = 2 then write('2');
		if j = 2 then if g2 = 2 then write('2');
		if j = 3 then if g3 = 2 then write('2');
		if j = 4 then if g4 = 2 then write('2');
		if j = 5 then if g5 = 2 then write('2');
		if j = 6 then if g6 = 2 then write('2');
		if j = 7 then if g7 = 2 then write('2');
		if j = 8 then if g8 = 2 then write('2');
		if j = 9 then if g9 = 2 then write('2');
		if j = 10 then if g10 = 2 then write('2');
	 end;
	if s11 = 1 then drawx(1,1);
	if s12 = 1 then drawx(1,2);
	if s13 = 1 then drawx(1,3);
	if s21 = 1 then drawx(2,1);
	if s22 = 1 then drawx(2,2);
	if s23 = 1 then drawx(2,3);
	if s31 = 1 then drawx(3,1);
	if s32 = 1 then drawx(3,2);
	if s33 = 1 then drawx(3,3);
	if s11 = 2 then drawo(1,1);
	if s12 = 2 then drawo(1,2);
	if s13 = 2 then drawo(1,3);
	if s21 = 2 then drawo(2,1);
	if s22 = 2 then drawo(2,2);
	if s23 = 2 then drawo(2,3);
	if s31 = 2 then drawo(3,1);
	if s32 = 2 then drawo(3,2);
	if s33 = 2 then drawo(3,3);
  gotoxy(62,4);
	textcolor(blue);
	write('G');
	textcolor(lightblue);
	write('a');
	textcolor(lightgray);
	write('m');
	textcolor(lightblue);
	write('e ');
	textcolor(blue);
	write(game);
 end;

begin
BeginTicTacToe:
 Start;
AskPlayers:
 DrawScreen;
 textcolor(white);
 gotoxy(56,19);
 write('Number of Players');
 gotoxy(57,20);
 write('(1-2): ');
 kp := readkey;
 players := ord(kp) - 48;
 write(players);
 if players <> 1 then if players <> 2 then goto AskPlayers;
BeginGame:
 s11 := 0;
 s12 := 0;
 s13 := 0;
 s21 := 0;
 s22 := 0;
 s23 := 0;
 s31 := 0;
 s32 := 0;
 s33 := 0;
 DrawScreen;
 if game/2 = int(game/2) then goto AskPlr2 else goto AskPlr1;
AskPlr1:
 DrawScreen;
 gotoxy(61,17);
 textcolor(red);
 write('P');
 textcolor(lightred);
 write('la');
 textcolor(yellow);
 write('y');
 textcolor(lightred);
 write('er ');
 textcolor(red);
 write('1');
 textcolor(white);
 gotoxy(55,19);
 write('Enter Row (1-3): ');
 kp := readkey;
 r := ord(kp) - 48;
 write(r);
 if kp = 'q' then goto AskPlayAgain;
 if kp = 'Q' then goto AskPlayAgain;
 gotoxy(55,20);
 write('Enter Column (1-3): ');
 kp := readkey;
 c := ord(kp) - 48;
 write(c);
 delay(100);
 if kp = 'q' then goto AskPlayAgain;
 if kp = 'Q' then goto AskPlayAgain;
 ClearWindow;
 if r <> 1 then if r <> 2 then if r <> 3 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr1;
	end;
 if c <> 1 then if c <> 2 then if c <> 3 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr1;
	end;
 CheckSpace(r,c);
 if SpaceEmpty = 0 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr1;
	end;
 DrawX(r, c);
 if r = 1 then if c = 1 then s11 := 1;
 if r = 1 then if c = 2 then s12 := 1;
 if r = 1 then if c = 3 then s13 := 1;
 if r = 2 then if c = 1 then s21 := 1;
 if r = 2 then if c = 2 then s22 := 1;
 if r = 2 then if c = 3 then s23 := 1;
 if r = 3 then if c = 1 then s31 := 1;
 if r = 3 then if c = 2 then s32 := 1;
 if r = 3 then if c = 3 then s33 := 1;
 if r = 1 then if c = 1 then
	begin
	 if s12 = 1 then if s13 = 1 then goto Plr1Win;
	 if s22 = 1 then if s33 = 1 then goto Plr1Win;
	 if s21 = 1 then if s31 = 1 then goto Plr1Win;
	end;
 if r = 1 then if c = 2 then
	begin
	 if s11 = 1 then if s13 = 1 then goto Plr1Win;
	 if s22 = 1 then if s32 = 1 then goto Plr1Win;
	end;
 if r = 1 then if c = 3 then
	begin
	 if s12 = 1 then if s11 = 1 then goto Plr1Win;
	 if s23 = 1 then if s33 = 1 then goto Plr1Win;
	 if s22 = 1 then if s31 = 1 then goto Plr1Win;
	end;
 if r = 2 then if c = 1 then
	begin
	 if s11 = 1 then if s31 = 1 then goto Plr1Win;
	 if s22 = 1 then if s23 = 1 then goto Plr1Win;
	end;
 if r = 2 then if c = 2 then
	begin
	 if s11 = 1 then if s33 = 1 then goto Plr1Win;
	 if s13 = 1 then if s31 = 1 then goto Plr1Win;
	 if s21 = 1 then if s23 = 1 then goto Plr1Win;
	 if s12 = 1 then if s32 = 1 then goto Plr1Win;
	end;
 if r = 2 then if c = 3 then
	begin
	 if s13 = 1 then if s33 = 1 then goto Plr1Win;
	 if s22 = 1 then if s21 = 1 then goto Plr1Win;
	end;
 if r = 3 then if c = 1 then
	begin
	 if s21 = 1 then if s11 = 1 then goto Plr1Win;
	 if s32 = 1 then if s33 = 1 then goto Plr1Win;
	 if s22 = 1 then if s13 = 1 then goto Plr1Win;
	end;
 if r = 3 then if c = 2 then
	begin
	 if s31 = 1 then if s33 = 1 then goto Plr1Win;
	 if s22 = 1 then if s12 = 1 then goto Plr1Win;
	end;
 if r = 3 then if c = 3 then
	begin
	 if s31 = 1 then if s32 = 1 then goto Plr1Win;
	 if s11 = 1 then if s22 = 1 then goto Plr1Win;
	 if s13 = 1 then if s23 = 1 then goto Plr1Win;
	end;
 if s11 <> 0 then if s12 <> 0 then if s13 <> 0 then if s21 <> 0 then if s22 <> 0
	then if s23 <> 0 then if s31 <> 0 then if s32 <> 0 then if s33 <> 0
	then goto Cat;
AskPlr2:
 DrawScreen;
 gotoxy(61,17);
 textcolor(red);
 write('P');
 textcolor(lightred);
 write('la');
 textcolor(yellow);
 write('y');
 textcolor(lightred);
 write('er ');
 textcolor(red);
 write('2');
 if players = 1 then goto Computer;
 textcolor(white);
 gotoxy(55,19);
 write('Enter Row (1-3): ');
 kp := readkey;
 r := ord(kp) - 48;
 write(r);
 if kp = 'q' then goto AskPlayAgain;
 if kp = 'Q' then goto AskPlayAgain;
 gotoxy(55,20);
 write('Enter Column (1-3): ');
 kp := readkey;
 c := ord(kp) - 48;
 write(c);
 delay(100);
 ClearWindow;
 if r <> 1 then if r <> 2 then if r <> 3 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr2;
	end;
 if c <> 1 then if c <> 2 then if c <> 3 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr2;
	end;
 CheckSpace(r,c);
 if SpaceEmpty = 0 then
	begin
	 sound(150);
	 delay(500);
	 nosound;
	 goto AskPlr2;
	end;
 DrawO(r, c);
 if r = 1 then if c = 1 then s11 := 2;
 if r = 1 then if c = 2 then s12 := 2;
 if r = 1 then if c = 3 then s13 := 2;
 if r = 2 then if c = 1 then s21 := 2;
 if r = 2 then if c = 2 then s22 := 2;
 if r = 2 then if c = 3 then s23 := 2;
 if r = 3 then if c = 1 then s31 := 2;
 if r = 3 then if c = 2 then s32 := 2;
 if r = 3 then if c = 3 then s33 := 2;
 if r = 1 then if c = 1 then
	begin
	 if s12 = 2 then if s13 = 2 then goto Plr2Win;
	 if s22 = 2 then if s33 = 2 then goto Plr2Win;
	 if s21 = 2 then if s31 = 2 then goto Plr2Win;
	end;
 if r = 1 then if c = 2 then
	begin
	 if s11 = 2 then if s13 = 2 then goto Plr2Win;
	 if s22 = 2 then if s32 = 2 then goto Plr2Win;
	end;
 if r = 1 then if c = 3 then
	begin
	 if s12 = 2 then if s11 = 2 then goto Plr2Win;
	 if s23 = 2 then if s33 = 2 then goto Plr2Win;
	 if s22 = 2 then if s31 = 2 then goto Plr2Win;
	end;
 if r = 2 then if c = 1 then
	begin
	 if s11 = 2 then if s31 = 2 then goto Plr2Win;
	 if s22 = 2 then if s23 = 2 then goto Plr2Win;
	end;
 if r = 2 then if c = 2 then
	begin
	 if s11 = 2 then if s33 = 2 then goto Plr2Win;
	 if s13 = 2 then if s31 = 2 then goto Plr2Win;
	 if s21 = 2 then if s23 = 2 then goto Plr2Win;
	 if s12 = 2 then if s32 = 2 then goto Plr2Win;
	end;
 if r = 2 then if c = 3 then
	begin
	 if s13 = 2 then if s33 = 2 then goto Plr2Win;
	 if s22 = 2 then if s21 = 2 then goto Plr2Win;
	end;
 if r = 3 then if c = 1 then
	begin
	 if s21 = 2 then if s11 = 2 then goto Plr2Win;
	 if s32 = 2 then if s33 = 2 then goto Plr2Win;
	 if s22 = 2 then if s13 = 2 then goto Plr2Win;
	end;
 if r = 3 then if c = 2 then
	begin
	 if s31 = 2 then if s33 = 2 then goto Plr2Win;
	 if s22 = 2 then if s12 = 2 then goto Plr2Win;
	end;
 if r = 3 then if c = 3 then
	begin
	 if s31 = 2 then if s32 = 2 then goto Plr2Win;
	 if s11 = 2 then if s22 = 2 then goto Plr2Win;
	 if s13 = 2 then if s23 = 2 then goto Plr2Win;
	end;
 if s11 <> 0 then if s12 <> 0 then if s13 <> 0 then if s21 <> 0 then if s22 <> 0
	then if s23 <> 0 then if s31 <> 0 then if s32 <> 0 then if s33 <> 0
	then goto Cat;
 goto AskPlr1;
Computer:
Plr1Win:
 ClearWindow;
 textcolor(white);
 gotoxy(58,19);
 write('Player 1 Wins!');
 EndSound;
 readkey;
 ClearWindow;
 if game = 1 then g1 := 1;
 if game = 2 then g2 := 1;
 if game = 3 then g3 := 1;
 if game = 4 then g4 := 1;
 if game = 5 then g5 := 1;
 if game = 6 then g6 := 1;
 if game = 7 then g7 := 1;
 if game = 8 then g8 := 1;
 if game = 9 then g9 := 1;
 if game = 10 then g10 := 1;
 game := game + 1;
 if game > 10 then goto EndGame;
 goto BeginGame;
Plr2Win:
 ClearWindow;
 textcolor(white);
 gotoxy(58,19);
 write('Player 2 Wins!');
 EndSound;
 readkey;
 ClearWindow;
 if game = 1 then g1 := 2;
 if game = 2 then g2 := 2;
 if game = 3 then g3 := 2;
 if game = 4 then g4 := 2;
 if game = 5 then g5 := 2;
 if game = 6 then g6 := 2;
 if game = 7 then g7 := 2;
 if game = 8 then g8 := 2;
 if game = 9 then g9 := 2;
 if game = 10 then g10 := 2;
 game := game + 1;
 if game > 10 then goto EndGame;
 goto BeginGame;
Cat:
 ClearWindow;
 textcolor(white);
 gotoxy(59,19);
 write('No one wins.');
 EndSound;
 readkey;
 readkey;
 ClearWindow;
 game := game + 1;
 if game > 10 then goto EndGame;
 goto BeginGame;
EndGame:
 game := 10;
 DrawScreen;
 t1 := 0;
 t2 := 0;
 if g1 = 1 then t1 := t1 + 1;
 if g1 = 2 then t2 := t2 + 1;
 if g2 = 1 then t1 := t1 + 1;
 if g2 = 2 then t2 := t2 + 1;
 if g3 = 1 then t1 := t1 + 1;
 if g3 = 2 then t2 := t2 + 1;
 if g4 = 1 then t1 := t1 + 1;
 if g4 = 2 then t2 := t2 + 1;
 if g5 = 1 then t1 := t1 + 1;
 if g5 = 2 then t2 := t2 + 1;
 if g6 = 1 then t1 := t1 + 1;
 if g6 = 2 then t2 := t2 + 1;
 if g7 = 1 then t1 := t1 + 1;
 if g7 = 2 then t2 := t2 + 1;
 if g8 = 1 then t1 := t1 + 1;
 if g8 = 2 then t2 := t2 + 1;
 if g9 = 1 then t1 := t1 + 1;
 if g9 = 2 then t2 := t2 + 1;
 if g10 = 1 then t1 := t1 + 1;
 if g10 = 2 then t2 := t2 + 1;
 if t1 > t2 then
	begin
   textcolor(white);
	 gotoxy(60,19);
	 write('Player One');
	 gotoxy(58,20);
	 write('Wins Over All!');
	end;
 if t2 > t1 then
	begin
	 textcolor(white);
	 gotoxy(60,19);
	 write('Player Two');
	 gotoxy(58,20);
	 write('Wins Over All!');
	end;
 if t1 = t2 then
	begin
	 textcolor(white);
	 gotoxy(58,19);
	 write('Both Players');
	 gotoxy(58,20);
	 write('Tie Over All.');
	end;
 readkey;
AskPlayAgain:
 ClearWindow;
 gotoxy(55,19);
 write('Play Again (Y/N)?:');
 kp := readkey;
 if kp = 'y' then goto BeginTicTacToe;
 if kp = 'Y' then goto BeginTicTacToe;
 if kp = 'n' then goto GameOver;
 if kp = 'N' then goto GameOver;
 goto AskPlayAgain;
GameOver:
 textcolor(lightgray);
 textbackground(black);
 clrscr;
 halt;
end.