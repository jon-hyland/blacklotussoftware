#include <conio.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include "c:\bc5\jons\bls.h"

const char progname[] = "WormBomb 2000";
const char vernum[] = "v1.0";
const char hsfilename[] = "WORMBOMB.HS";

struct Area_struct
{
	int	cha[40][24][2];
   int	fcl[40][24][2];
   int	bcl[40][24][2];
   int	dat[40][24];
};

struct Worm_struct
{
	int	length;
	int	x[100];
   int   y[100];
   int	cha[2][100];
   int	fcl[100];
   int	bcl[100];
};

struct HS_rec_struct
{
	char 	name[15];
   int	points;
}

struct HS_list_struct
{
	int				lastscore;
   HS_rec_struct	entry[10];
}

Area_struct		area;
Worm_struct		worm;
HS_list_struct	hslist;


void draw_area(void);
void draw_screen(void);
void write_high_score_file(void);
void reset_high_score_file(void);
void read_high_score_file(void);

void main(void)
{
	black_lotus_intro();
   draw_screen();
   draw_title();

}


void draw_area(void)
{
	for(int k=0; k<=23; k++)
   	for(int j=0; j<=39; j++)
      {
      	gotoxy(j*2+1, k+1);
         textcolor(area.fcl[0][j][k]);
         textbackground(area.bcl[0][j][k]);
         cprintf("%c", area.cha[0][j][k]);
         textcolor(area.fcl[1][j][k]);
         textbackground(area.bcl[1][j][k]);
         cprintf("%c", area.cha[1][j][k]);
      }
   cursor();
}


void draw_screen(void)
{
	clear();
   textcolor(BLUE);
   textbackground(BLACK);
   gotoxy(18, 25);
   cprintf("%c%c%c", 176, 177, 178);
   textcolor(LIGHTGRAY);
   textbackground(BLUE);
   cprintf("  Coins ");
   textcolor(WHITE);
   cprintf(":");
   textcolor(LIGHTGRAY);
   cprintf("    of          Points ");
   textcolor(WHITE);
   cprintf(":       ");
   textcolor(BLUE);
   textbackground(BLACK);
   cprintf("%c%c%c", 178, 177, 176);
   draw_area();
}


void write_high_score_file(void)
{
	FILE *hsfile = fopen(hsfilename, "wb");
   fwrite(&hslist, sizeof(hslist), 1, hsfile);
   fclose(hsfile);
}

void reset_high_score_file(void)
{
   for(int i=0; i<=9; i++)
   {
		strcpy(hslist.entry[i].name, "[NO RECORD]");
      hslist.entry[i].points = 10-i;
   }
   hslist.lastscore = 0;
 	write_high_score_file();
   draw_window(33,13,48,16,4,"Info");
   textcolor(YELLOW);
   gotoxy(35, 14);
   cprintf("High Score");
   gotoxy(35, 15);
   cprintf("File Reset");
   cursor();
   delay(250);
   erase_window(33,13,48,16);
   draw_area();
}


void read_high_score_file(void)
{
	FILE *hsfile = fopen(hsfilename, "rb");
   if (hsfile == NULL)
   {
   	reset_high_score_file();
      hsfile = fopen(hsfilename, "rb");
   }
   if (hsfile == NULL)
   {
   	draw_window(33,13,48,16,1,"Error");
      textcolor(YELLOW);
      gotoxy(36, 14);
      cprintf("Cannot");
      gotoxy(35, 15);
      cprintf("Open File");
      cursor();
      pause();
      clear();
      exit(1);
   }
   fread(&hslist, sizeof(hslist), 1, hsfile);
   close(hsfile);
}

