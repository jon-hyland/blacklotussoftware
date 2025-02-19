/********************************************************************
 *                     --== Space War 2000 ==--                     *
 *                            -= v1.0 =-                            *
 *                                                                  *
 *                   (c) 1999 Black Lotus Software                  *
 *                   All programming by Jon Hyland                  *
 *                                                                  *
 * Source code requires routines from library BLS.H to compile.     *
 * All external functions (c) 1994-1999 Black Lotus Software.       *
 * This program will create and modify SWFILE.DAT for high score    *
 * list.                                                            *
 *                                                                  *
 * Written and compiled using Borland C++ v4.52.                    *
 *                                                                  *
 * Use or possession of this source code is prohibitted unless      *
 * direct permission if granted by the author.                      *
 ********************************************************************/

#include <fstream.h>		// file handling, i/o devices
#include <conio.h>		// cprintf(), getch(), color ANSI
#include <stdlib.h>		// randomize()
#include <time.h>			// delay()
#include <dos.h>			// delay()
#include <ctype.h>		// character manip
#include "bls.h"			// standard functions library


char	prog_name[] 	= "Space War 2000";		// program name
char	ver_num[] 		= "v1.0";             	// version number
const int star_count	= 100;
const int enemy_max	= 15;

struct Space_struct
{
	int	obj[31][40][2];
	int	fcl[31][40][2];
	int	bcl[31][40][2];
};

struct Ship_struct
{
	char	chr[3][3][2];
	int	fcl[3][3][2];
	int	bcl[3][3][2];
	int	hitpts;
	int	xwait, xleft, xdir, xpos;
	int	ywait, yleft, ydir, ypos;
};

struct Star_struct
{
	int 	xpos;
	int 	ypos;
	int	ppos;
	int	wait;
	int	left;
};

struct
{
	char	name[17];
	long int	points;
} hs_list[10];


Space_struct	space;
Ship_struct		proto[2];
Star_struct		star[star_count];
Ship_struct		enemy[enemy_max];

void 	init_game(void);
void 	build_ship_prototypes(void);
void 	init_level(int);
void 	draw_screen(void);
void  init_stars(void);
void 	draw_ship(int, int, int);
void 	erase_ship(int, int);
void	move_stars(void);
void	create_enemy(int);
void	copy_ship(Ship_struct &, Ship_struct &);


int			level;
int			tot_enemy;


void main(void)
{
	black_lotus_intro();
	init_game();



	create_enemy(tot_enemy+1);
	getch();
	while (!kbhit())
	{
		move_stars();

		delay(5);
	}












	pause();
}


void init_game(void)
{
	randomize();

	draw_screen();
	level = 1;
	init_level(level);
	build_ship_prototypes();
}


void init_level(int level)
{
	int	j, k, p;

	for(k=0; k<40; k++)
		for(j=0; j<31; j++)
			for(p=0; p<2; p++)
			{
				space.obj[j][k][p] = 0;
				space.fcl[j][k][p] = 0;
				space.bcl[j][k][p] = 0;
			}
	init_stars();

	tot_enemy = 0;			// change
}


void draw_screen(void)
{
	clear();
	draw_window(1,1,16,23,1,"Status");
	textcolor(DARKGRAY);
	textbackground(BLACK);
	gotoxy(47, 25);
	cprintf("(c)1999 Black Lotus Software");
	cursor();
}


void init_stars(void)
{
	int i;

	textcolor(WHITE);
	textbackground(BLACK);
	for(i=0; i<star_count; i++)
	{
		star[i].xpos = random(31);
		star[i].ypos = random(24);
		star[i].ppos = random(2);
		star[i].wait = random(10)+1;
		star[i].left = star[i].wait;
		gotoxy(star[i].xpos*2+19+star[i].ppos, star[i].ypos+1);
		cprintf("%c", 250);
	}
	cursor();
}






void build_ship_prototypes(void)
{
	int	j, k, p;

	proto[0].hitpts = 99;				// player ship
	for(k=0; k<3; k++)
		for(j=0; j<3; j++)
			for(p=0; p<2; p++)
			{
				proto[0].fcl[j][k][p] = 15;
				proto[0].bcl[j][k][p] = 0;
			}
	proto[0].chr[0][0][0] = 32;	proto[0].chr[0][0][1] = 32;
	proto[0].chr[1][0][0] = 219;	proto[0].chr[1][0][1] = 219;
	proto[0].chr[2][0][0] = 32;	proto[0].chr[2][0][1] = 32;
	proto[0].chr[0][1][0] = 222;	proto[0].chr[0][1][1] = 221;
	proto[0].chr[1][1][0] = 222;	proto[0].chr[1][1][1] = 221;
	proto[0].chr[2][1][0] = 222;	proto[0].chr[2][1][1] = 221;
	proto[0].chr[0][2][0] = 222;	proto[0].chr[0][2][1] = 221;
	proto[0].chr[1][2][0] = 223;	proto[0].chr[1][2][1] = 223;
	proto[0].chr[2][2][0] = 222;	proto[0].chr[2][2][1] = 221;


	proto[1].hitpts = 3;					// enemy ship
	for(k=0; k<3; k++)
		for(j=0; j<3; j++)
			for(p=0; p<2; p++)
			{
				proto[1].fcl[j][k][p] = 15;
				proto[1].bcl[j][k][p] = 0;
			}
	proto[1].chr[0][0][0] = 32;	proto[1].chr[0][0][1] = 222;
	proto[1].chr[1][0][0] = 219;	proto[1].chr[1][0][1] = 219;
	proto[1].chr[2][0][0] = 221;	proto[1].chr[2][0][1] = 32;
	proto[1].chr[0][1][0] = 220;	proto[1].chr[0][1][1] = 220;
	proto[1].chr[1][1][0] = 222;	proto[1].chr[1][1][1] = 221;
	proto[1].chr[2][1][0] = 220;	proto[1].chr[2][1][1] = 220;
	proto[1].chr[0][2][0] = 222;	proto[1].chr[0][2][1] = 32;
	proto[1].chr[1][2][0] = 222;	proto[1].chr[1][2][1] = 221;
	proto[1].chr[2][2][0] = 32;	proto[1].chr[2][2][1] = 221;
}


void draw_ship(Ship_struct ship)
{
	int j, k, p;

	for(k=0; k<3; k++)
		for(j=0; j<3; j++)
			for(p=0; p<2; p++)
			{
//				space.chr[

				gotoxy(j*2+19+(ship.xpos)+p, (ship.ypos)-5+k);
				textcolor(ship.fcl[j][k][p]);
				textbackground(ship.bcl[j][k][p]);
				cprintf("%c", ship.chr[j][k][p]);
			}
	cursor();
}


void erase_ship(int x, int y)
{
	int j, k, p;

	for(k=0; k<3; k++)
		for(j=0; j<3; j++)
			for(p=0; p<2; p++)
			{

				gotoxy(j*2+19+x+p, y-5+k);
				textcolor(BLACK);
				textbackground(BLACK);
				cprintf("%c", 219);
				// draw background
			}
	cursor();
}


void move_stars(void)
{
	int	i;

	for(i=0; i<star_count; i++)
	{
		textbackground(BLACK);
		if (!star[i].left)
		{
			// if no object
			textcolor(BLACK);
			gotoxy(star[i].xpos*2+19+star[i].ppos, star[i].ypos+1);
			cprintf(" ");
			star[i].ypos++;
			if (star[i].ypos > 23)
			{
				star[i].ypos = 0;
				star[i].xpos = random(31);
				star[i].wait = random(10)+1;
				star[i].left = star[i].wait;
			}
			// if no object
			if (star[i].wait <= 5)
				textcolor(WHITE);
			else
				textcolor(LIGHTGRAY);
			gotoxy(star[i].xpos*2+19+star[i].ppos, star[i].ypos+1);
			cprintf("%c", 250);
			star[i].left = star[i].wait;
		}
		else
			star[i].left--;
	}
	cursor();
}

void copy_ship(Ship_struct &source, Ship_struct &dest)
{
	int	j, k, p;

	for(k=0; k<3; k++)
		for(j=0; j<3; j++)
			for(p=0; p<2; p++)
			{
				dest.chr[j][k][p] = source.chr[j][k][p];
				dest.fcl[j][k][p] = source.fcl[j][k][p];
				dest.bcl[j][k][p] = source.bcl[j][k][p];
			}
	dest.hitpts = source.hitpts;
	dest.xwait = source.xwait;
	dest.xleft = source.xleft;
	dest.xdir = source.xdir;
	dest.ywait = source.ywait;
	dest.yleft = source.yleft;
	dest.ydir = source.ydir;
}


void create_enemy(int num)
{
	if (tot_enemy < enemy_max)
	{
		tot_enemy++;
		copy_ship(proto[1], enemy[num]);
		enemy[num].xwait = random(10+1);
		enemy[num].xleft = enemy[num].xwait;
		enemy[num].xdir = random(3)-1;
		enemy[num].ywait = random(10+1);
		enemy[num].yleft = enemy[num].ywait;
		enemy[num].ydir = random(2);
		enemy[num].xpos = 10;
		enemy[num].ypos = 6;
		draw_ship(enemy[num]);



	}
}

