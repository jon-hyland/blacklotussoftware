#include <conio.h>
#include <string.h>
#include <dos.h>
#include <time.h>
#include <stdlib.h>


void clear(void);
void cursor(void);
void draw_window(int, int, int, int, int, char[]);
void erase_window(int, int, int, int);
void black_lotus_intro(void);
void pause(void);
void ansi_color_table(void);

void main(void)
{
	ansi_color_table();
}

void clear(void)
{
	textcolor(WHITE);
   textbackground(BLACK);
   clrscr();
   textcolor(BLACK);
   gotoxy(1,25);
   cprintf("%c", 219);
   textcolor(WHITE);
   gotoxy(1,1);
}


void cursor(void)
{
	gotoxy(1, 25);
}


void draw_window(int x1, int y1, int x2, int y2, int bcl, char name[])
{
	const int delay_time = 20;
	int ya, yb;
	float xa, xb;
	int times, xinc;

	times = (y2-y1+1) - int((y2-y1+1)/2);
	xinc = ((x2-x1+1)/2) / times;
	ya = int((y2-y1+1)/2+y1);
	yb = ya;
	xa = int((x2-x1+1)/2+x1-xinc);
	xb = xa;
	for(int j=1; j<=times-1; j++)
	{
		textcolor(bcl);
		textbackground(bcl);
		for(int k=ya; k<=yb; k++)
		{
			gotoxy(xa, k);
			for(int j=xa; j<=xb; j++)
				cprintf("%c", 219);
		}
   	delay(delay_time);
		xa -= xinc;
		xb += xinc;
		ya--;
		yb++;
	}
	textcolor(WHITE);
	for(int k=y1; k<=y2; k++)
		for(int j=x1; j<=x2; j++)
		{
			gotoxy(j,k);
			cprintf(" ");
		}
	if ((x2 <= 78) && (y2 <= 23))
	{
		textcolor(DARKGRAY);
		textbackground(BLACK);
		for(int k=y1+1; k<=y2; k++)
		{
			gotoxy(x2+1, k);
			cprintf("%c%c", 176, 176);
		}
		for(int j=x1+2; j<=x2+2; j++)
		{
			gotoxy(j, y2+1);
			cprintf("%c", 176);
		}
	}
	textcolor(WHITE);
	textbackground(bcl);
	gotoxy(x1, y1);
	cprintf("%c", 218);
	gotoxy(x1, y2);
	cprintf("%c", 192);
	for(int j=x1+1; j<=x2-1; j++)
	{
		gotoxy(j, y1);
		cprintf("%c", 196);
		gotoxy(j, y2);
		cprintf("%c", 196);
	}
	gotoxy(int(x1+((x2-x1+1)-strlen(name))/2)-2, y1);
	cprintf("%c %s %c", 180, name, 195);
	gotoxy(x2, y1);
	cprintf("%c", 191);
	gotoxy(x2, y2);
	cprintf("%c", 217);
	for(int k=y1+1; k<=y2-1; k++)
	{
		gotoxy(x1, k);
		cprintf("%c", 179);
		gotoxy(x2, k);
		cprintf("%c", 179);
	}
}


void erase_window(int x1, int y1, int x2, int y2)
{
	textcolor(WHITE);
	textbackground(BLACK);
	for(int k=y1; k<=y2+1; k++)
		for(int j=x1; j<=x2+2; j++)
		{
			gotoxy(j, k);
			cprintf(" ");
		}
}


void black_lotus_intro(void)
{
  char str[] = "Black Lotus Productions";
  int chd[24], chc[24], chx[24], chy[24];
  int i, j, c, d, left;

  randomize();
  textbackground(BLACK);
  clear();
  for(i=1; i<=4; i++)
  {
	 c = 0;
	 for(j=29; j<=51; j++)
	 {
		d = c;
		if (i == 1)
		  switch(d)
		  {
			 case 5:
			 case 6:
			 case 7:
			 case 8:
			 case 9:
			 case 10:
			 case 11:
			 case 12:
			 case 13:
			 case 14:
			 case 15:
			 case 16:
			 case 17:
			 case 18:
			 case 19:	d = 4;
		  }
		if (i == 2)
		  switch(d)
		  {
			 case 8:
			 case 9:
			 case 10:
			 case 11:
			 case 12:
			 case 13:
			 case 14:
			 case 15:
			 case 16:	d = 7;
		  }
		if (i == 3)
		  switch(d)
		  {
			 case 11:
			 case 12:
			 case 13:	d = 10;
		  }
		switch(d)
		{
		  case 1:
		  case 2:
		  case 3:
		  case 4:
		  case 20:
		  case 21:
		  case 22:
		  case 23:		textcolor(RED);
							break;
		  case 5:
		  case 6:
		  case 7:
		  case 17:
		  case 18:
		  case 19:		textcolor(LIGHTRED);
							break;
		  case 8:
		  case 9:
		  case 10:
		  case 14:
		  case 15:
		  case 16:		textcolor(YELLOW);
							break;
		  case 11:
		  case 12:
		  case 13:		textcolor(LIGHTGRAY);
		}
		gotoxy(j,10);
		cprintf("%c", str[c]);
      c++;
		cursor();
	 }
	 delay(78);
  }
  for(j=1; j<=23; j++)
  {
	 chx[j] = j+28;
	 chy[j] = 10;
	 chd[j] = random(8)+1;
	 switch(j)
	 {
		case 1:
		case 2:
		case 3:
		case 4:
		case 20:
		case 21:
		case 22:
		case 23:		   chc[j] = 4;
							break;
		case 5:
		case 6:
		case 7:
		case 17:
		case 18:
		case 19:			chc[j] = 12;
							break;
		case 8:
		case 9:
		case 10:
		case 14:
		case 15:
		case 16:			chc[j] = 14;
							break;
		case 11:
		case 12:
		case 13:			chc[j] = 7;
	 }
  }
  delay(78*3);
  left = 23;
  while (left > 0)
  {
	 do
	 {
		j = random(23)+1;
	 }
	 while ((chx[j] > 80) || (chx[j] < 1) ||
			  (chy[j] > 24) || (chy[j] < 1));
	 textcolor(WHITE);
	 gotoxy(chx[j], chy[j]);
	 cprintf(" ");
	 cursor();
	 switch(chd[j])
	 {
		case 1:		chx[j] = chx[j] - 1;
						chy[j] = chy[j] - 1;
						break;
		case 2:		chy[j] = chy[j] - 1;
						break;
		case 3:		chx[j] = chx[j] + 1;
						chy[j] = chy[j] - 1;
						break;
		case 4:		chx[j] = chx[j] + 1;
						break;
		case 5:		chx[j] = chx[j] + 1;
						chy[j] = chy[j] + 1;
						break;
		case 6:		chy[j] = chy[j] + 1;
						break;
		case 7:		chx[j] = chx[j] - 1;
						chy[j] = chy[j] + 1;
						break;
		case 8:		chx[j] = chx[j] - 1;
	 }
	 if ((chx[j] > 80) || (chx[j] < 1) ||
		  (chy[j] > 24) || (chy[j] < 1))
		left--;
	 else
	 {
		textcolor(chc[j]);
		gotoxy(chx[j], chy[j]);
		cprintf("%c", str[j]);
		cursor();
	 }
	 delay(2);
  }
}


void pause(void)
{
 	//clearbuffer??
	getch();
}


void ansi_color_table(void)
{
	textcolor(WHITE);
   textbackground(BLACK);
   clrscr();
	gotoxy(35, 8);
   cprintf("ANSI Color Chart");
   for(int i=0; i<=15; i++)
   {
   	gotoxy(i*3+20, 10);
      textcolor(i);
      cprintf("%c%c", 219, 219);
      textcolor(WHITE);
      gotoxy(i*3+20, 12);
      cprintf("%d", i);
   }
 	pause();
}
