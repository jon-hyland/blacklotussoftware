#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <dos.h>



void main(void)
{
 	void draw_window(int, int, int, int, int, char[]);
	void erase_window(int, int, int, int);

	getch();
   textcolor(WHITE);
   textbackground(BLACK);
   clrscr;
   draw_window(20, 4, 60, 16, 1, "Window");
   getch();
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
	for(int i=1; i<=times-1; i++)
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
	for(int k=y1; k<=y2; k++)
		for(int j=x1; j<=x2; j++)
		{
			gotoxy(j, k);
			cprintf(" ");
		}
}





