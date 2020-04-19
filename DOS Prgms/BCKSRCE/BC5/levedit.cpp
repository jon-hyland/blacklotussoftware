// --== Quick Editor for Wormbomb 2000  - v1.0 ==--
// Commands :

#include <dos.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include "c:\bc5\jons\bls.h"

struct Area_struct
{
	int	cha[40][24][2];
   int	fcl[40][24][2];
   int	bcl[40][24][2];
   int	dat[40][24];
};

struct Clip_struct
{
	int	totx, toty;
   int	x1, y1, x2, y2;
	int	cha[40][24][2];
   int	fcl[40][24][2];
   int	bcl[40][24][2];
   int	dat[40][24];
};


void 	title_screen(void);
void	init_file(void);
void  load_map(int);
void	save_map(int);
void	add_map(void);
void	init_charset(void);
void	get_charset(void);
void	get_colors(void);
void	clear_clip(void);
void 	clear_area(void);
void	clear_area_ask(void);
void 	draw_area(void);
void 	draw_img_screen(void);
void	update_img_status(void);
void	update_coors(void);
int	img_menu(void);
int	sld_menu(void);
void	ask_save(void);
void	reset_mapfile(void);
int	select_area(int &, int &, int &, int &);
void	cut_to_clip(int);
void	paste_to_area(void);
void	view_clip(void);
void	delete_area(void);
void	flip_area(void);

char	filename[] = "WORMBOMB.LEV";
char	csfname[] = "CHARSET.DAT";
Area_struct area;
Clip_struct	clip;
char	charset[15][10];
int	cs_index = 5;
int	num, tot;
int	x=0, y=0, pos=0;
int	fcl = 15, bcl = 0;
int	changed = 0;
int	menuchoice = 0;
enum	{IMAGE, SOLID} imode = IMAGE;
int	lastmenuchoice = 0;

void main(void)
{
	char	key = '\0';

   black_lotus_intro();
   title_screen();
   draw_img_screen();
	init_file();
   load_map(num);
	init_charset();
   update_img_status();
   draw_area();
	do				// while menuchoice != 13 (quit)
   {
		update_coors();
      gotoxy((x*2+pos)+1, y+1);
   	key = getch();
      switch (key)
      {
      	case 27	:  if (imode == IMAGE)				// user press Esc (Menu)
         				{
   				      	menuchoice = img_menu();
                        switch (menuchoice)
                        {
                        	case 1 	:  if (changed)			// Next Map
														ask_save();
                           				num++;
                           				if (num > tot)
                                    		num = 1;
                                    	load_map(num);
													draw_area();
                                       ungetch(27);
                           				break;
                           case 2 	:  if (changed)   		// Prev Map
                           					ask_save();
                           				num--;
                           				if (num < 1)
                                    		num = tot;
                                    	load_map(num);
                                    	draw_area();
                                       ungetch(27);
                                    	break;
                           case 4	:	cut_to_clip(0);		// Cut Section
                           				break;
                           case 5	:	cut_to_clip(1);		// Copy Section
                           				break;
                           case 6	:	paste_to_area();		// Paste Section
                           				break;
                           case 7	:	delete_area();			// Delete Section
                           				break;
                           case 8	:	flip_area();			// Flip Section
                           				break;
									case 9	:	view_clip();			// View Clipboard
                           				break;
									case 10 	:	clear_area_ask();		// Clear Map
                           				break;
									case 11	:	get_colors();			// Fgr/Bgr Colors
                           				break;
                           case 12	:	get_charset();			// Character Set
                           				break;
                           case 13	:	add_map();				// Add Map
                           				break;
                           case 15	:	save_map(num);			// Save Map
                           				break;
                           case 16	:	if (changed)			// Quit Program
                           					ask_save();
                           				break;
                           case 187 :	reset_mapfile();
                           				break;
                        }
                     }
         				if (imode == SOLID)
                     {
                     	menuchoice = sld_menu();
                     }
                     break;
         case 0	:  key = getch();
         				switch (key)
                     {
                     	case 'H'	:	y--;
                        				if (y < 0)
                              	   	y = 23;
                                		break;
                        case 'K'	:	pos--;
                        				if (pos < 0)
                                 	{
                                 		pos = 1;
	                                    x--;
   	                                 if (x < 0)
      	                              	x = 39;
         	                        }
                        	         break;
                       	case 'P'	:	y++;
                        				if (y > 23)
                                 		y = 0;
                                 	break;
                        case 'M'	:	pos++;
                        				if (pos > 1)
                               	  	{
                                 		pos = 0;
                                  		x++;
                                   		if (x > 39)
                                    		x = 0;
                                    }
                                 	break;
                        case 'G' :	x = 0;
                        				pos = 0;
                                    break;
	                     case 'I' :	y = 0;
                        				break;
                        case 'O'	:	x = 39;
                        				pos = 1;
                                    break;
                        case 'Q' :	y = 23;
                        				break;
                        case	59	: ;
                     }
                     if ((key >= 59) && (key <= 68))	// if function key
                     {
								area.cha[x][y][pos] = charset[cs_index][key-59];
                        area.fcl[x][y][pos] = fcl;
                        area.bcl[x][y][pos] = bcl;
						      gotoxy((x*2+pos)+1, y+1);
					         textcolor(area.fcl[x][y][pos]);
					         textbackground(area.bcl[x][y][pos]);
					         cprintf("%c", area.cha[x][y][pos]);
								if (++pos > 1)		//	inc. pos, then if..
					         {
					         	pos = 0;
					            if (++x > 39)
					            {
					            	x = 0;
					               if (++y > 23)
					               	y = 0;
					            }
					      	}
                        changed = 1;
                     }
							key = 0;
                     break;
      }
      if ((key >= 32) && (key <= 126))			// if printable keyboard char
      {
  			area.cha[x][y][pos] = key;
         area.fcl[x][y][pos] = fcl;
         area.bcl[x][y][pos] = bcl;

	      gotoxy((x*2+pos)+1, y+1);
         textcolor(area.fcl[x][y][pos]);
         textbackground(area.bcl[x][y][pos]);
         cprintf("%c", area.cha[x][y][pos]);
			if (++pos > 1)		//	inc. pos, then if..
         {
         	pos = 0;
            if (++x > 39)
            {
            	x = 0;
               if (++y > 23)
               	y = 0;
            }
      	}
			changed = 1;
      }

   }
   while (menuchoice != 16);
   fadeout();
}


void clear_area(void)
{
	for(int k=0; k<24; k++)
   	for(int j=0; j<40; j++)
      {
      	area.dat[j][k] = 0;
         for(int i=0; i<2; i++)
         {
         	area.cha[j][k][i] = ' ';
            area.fcl[j][k][i] = 15;
            area.bcl[j][k][i] = 0;
         }
      }
	changed = 1;
}


void clear_area_ask(void)
{
   char key;

	draw_window(30,10,50,13,1,"Warning!");
   textcolor(YELLOW);
   gotoxy(33, 11);
   cprintf("Clear this map?");
   gotoxy(37, 12);
   cprintf("( / )");
   textcolor(WHITE);
   gotoxy(38, 12);
   cprintf("Y");
   gotoxy(40, 12);
   cprintf("N");
   cursor();
   do
   {
   	key = getch();
      key = toupper(key);
      if (key == 27)
      	key = 'N';
   }
   while ((key != 'Y') && (key != 'N'));
   if (key == 'Y')
		clear_area();
   draw_area();
}


void clear_clip(void)
{
	clip.totx = 0;
   clip.toty = 0;
   clip.x1 = 0;
   clip.y1 = 0;
   clip.x1 = 0;
   clip.y1 = 0;
   for(int k=0; k<24; k++)
   	for(int j=0; j<40; j++)
      {
      	clip.dat[j][k] = 0;
         for(int d=0; d<2; d++)
         {
         	clip.cha[j][k][d] = ' ';
            clip.fcl[j][k][d] = 15;
            clip.bcl[j][k][d] = 0;
         }
      }
}


int select_area(int &x1, int &y1, int &x2, int &y2)
{
	int	hix, hiy, lowx, lowy;
   int	ox, oy;
   char	key;
   int	temp;

	textbackground(BLACK);
   gotoxy(13, 25);
	cprintf("                                         ");
	gotoxy(19, 25);
   textcolor(YELLOW);
   textbackground(BLUE);
   cprintf(" Select First Corner... ");
	x1 = x;
   y1 = y;
   do
   {
      ox = x1;
      oy = y1;
      gotoxy(x1*2+1, y1+1);
      textcolor(WHITE);
      textbackground(RED);
      cprintf("%c%c", area.cha[x1][y1][0], area.cha[x1][y1][1]);
      cursor();
      key = getch();
      if (!key)
      	key = getch();
      switch (key)
      {
      	case	'H'	:	y1 = y1 - 1;
         					if (y1 < 0)
                        	y1 = 0;
                        break;
         case	'K'	:	x1 = x1 - 1;
         					if (x1 < 0)
                        	x1 = 0;
                        break;
         case	'P'	:	y1 = y1 + 1;
         					if (y1 > 23)
                        	y1 = 23;
                        break;
         case	'M'	:	x1 = x1 + 1;
         					if (x1 > 39)
                        	x1 = 39;
                        break;
      }
      gotoxy(ox*2+1, oy+1);
      textcolor(area.fcl[ox][oy][0]);
      textbackground(area.bcl[ox][oy][0]);
      cprintf("%c", area.cha[ox][oy][0]);
      textcolor(area.fcl[ox][oy][1]);
      textbackground(area.bcl[ox][oy][1]);
      cprintf("%c", area.cha[ox][oy][1]);
      cursor();
   }
   while ((key != 13) && (key != 27));
	textbackground(BLACK);
   gotoxy(13, 25);
	cprintf("                                         ");
	gotoxy(19, 25);
   textcolor(YELLOW);
   textbackground(BLUE);
   cprintf(" Select Second Corner... ");
   if (key != 27)
   {
		x2 = x1;
      y2 = y1;
      do
      {
      	ox = x2;
         oy = y2;
         if (x2 > x1)
         {
         	hix = x2;
            lowx = x1;
         }
         else
         {
            lowx = x2;
         	hix = x1;
         }
         if (y2 > y1)
         {
         	hiy = y2;
            lowy = y1;
         }
         else
         {
         	lowy = y2;
            hiy = y1;
         }
         textcolor(WHITE);
         textbackground(RED);
         for(int k=lowy; k<=hiy; k++)
         	for(int j=lowx; j<=hix; j++)
            {
            	gotoxy(j*2+1, k+1);
               cprintf("%c%c", area.cha[j][k][0], area.cha[j][k][1]);
            }
         cursor();
         key = getch();
         if (!key)
         	key = getch();
         switch (key)
         {
         	case	'H'	:	y2 = y2 - 1;
            					if (y2 < 0)
                           	y2 = 0;
                           break;
            case	'K'	:	x2 = x2 - 1;
            					if (x2 < 0)
                           	x2 = 0;
                           break;
            case	'P'	:	y2 = y2 + 1;
            					if (y2 > 23)
                           	y2 = 23;
                           break;
            case	'M'	:	x2 = x2 + 1;
            					if (y2 > 39)
                           	y2 = 39;
                           break;
         }
         for(int k=lowy; k<=hiy; k++)
         	for(int j=lowx; j<=hix; j++)
            {
            	gotoxy(j*2+1, k+1);
               textcolor(area.fcl[j][k][0]);
               textbackground(area.bcl[j][k][0]);
               cprintf("%c", area.cha[j][k][0]);
               textcolor(area.fcl[j][k][1]);
               textbackground(area.bcl[j][k][1]);
               cprintf("%c", area.cha[j][k][1]);
            }
         cursor();
      }
      while ((key != 13) && (key != 27));
		textbackground(BLACK);
	   gotoxy(13, 25);
		cprintf("                                         ");
   }
   if (x1 > x2)
   {
		temp = x1;
   	x1 = x2;
      x2 = temp;
   }
   if (y1 > y2)
   {
   	temp = y1;
      y1 = y2;
      y2 = temp;
   }
	textcolor(WHITE);
   textbackground(RED);
   gotoxy(13, 25);
	cprintf("1=X 2=X 3=X 4=X 5=X 6=X 7=X 8=X 9=X 10=X ");
	update_img_status();
   if (key == 27)
   	return(0);
   else
   {
    	x = x1;
      y = y1;
   	return(1);
   }
}


void title_screen(void)
{
	clear();
   draw_window(28,8,51,16,4,"Info");
   textcolor(YELLOW);
   gotoxy(32, 9);
   cprintf("-= Quick Edit =-");
	gotoxy(38, 10);
   cprintf("v1.0");
	textcolor(LIGHTCYAN);
	gotoxy(34, 12);
   cprintf("Designed For");
   gotoxy(33, 13);
   cprintf("Worm Bomb 2000");
   textcolor(LIGHTGRAY);
   gotoxy(30, 15);
   cprintf("Black Lotus Software");
   cursor();
   pause();
   erase_window(28,8,51,16);
   cursor();
}


void init_file(void)
{
	FILE	*mapfile;
   Area_struct	junk;

   mapfile = fopen(filename, "rb");
   if (mapfile == NULL)
   {
   	clear_area();
      mapfile = fopen(filename, "wb");
      fwrite(&area, sizeof(area), 1, mapfile);
      fclose(mapfile);
   }
   tot = 0;
   do
   {
   	fread(&junk, sizeof(junk), 1, mapfile);
      if (!feof(mapfile))
      	tot++;
   }
   while (!feof(mapfile));
   if (tot > 0)
   	num = 1;
   else
   	error_quit(str_add("Error! No level entries in ", filename));
}


void	init_charset(void)
{
	FILE	*csfile;

   csfile = fopen(csfname, "rb");
	if (csfile == NULL)
		error_quit(str_add("Error! Cannot open ", filename));
   fread(&charset, sizeof(charset), 1, csfile);
   fclose(csfile);
}


void	get_charset(void)
{
   char	key;
   int	old_index = cs_index;

	draw_window(24,4,46,20,1,"Select Charset");
   textcolor(LIGHTGRAY);
   for(int k=0; k<15; k++)
   {
   	gotoxy(26, k+5);
      for(int j=0; j<10; j++)
      	cprintf("%c ", charset[k][j]);
   }
   do
   {
   	textcolor(YELLOW);
      gotoxy(26, cs_index+5);
      for(int j=0; j<10; j++)
      	cprintf("%c ", charset[cs_index][j]);
		update_img_status();
      key = getch();
      if (!key)
      	key = getch();
      textcolor(LIGHTGRAY);
      textbackground(BLUE);
      gotoxy(26, cs_index+5);
      for(int j=0; j<10; j++)
      	cprintf("%c ", charset[cs_index][j]);
      switch (key)
      {
      	case	'H'	:
         case	'K'	: 	cs_index = cs_index - 1;
         					if (cs_index < 0)
                        	cs_index = 14;
                        break;
         case	'P'	:
         case	'M'	:	cs_index = cs_index + 1;
         					if (cs_index > 14)
                        	cs_index = 0;
                        break;
      }
   }
   while ((key != 13) && (key != 27));
   if (key == 27)
   	cs_index = old_index;
   draw_area();
   update_img_status();
}


void get_colors(void)
{
	char	key;
   int	top = 1;
   int	old_fcl = fcl, old_bcl = bcl;

   draw_window(23,10,58,13,1,"Select Colors");
   for(int i=0; i<16; i++)
   {
   	gotoxy(i*2+25, 11);
		textcolor(i);
      cprintf("%c%c", 219, 219);
      if (i < 8)
      {
      	gotoxy(i*2+25, 12);
         cprintf("%c%c", 219, 219);
      }
   }
   do
   {
		if (top)
      {
	   	gotoxy(fcl*2+25, 11);
   	   textcolor(fcl);
			if (fcl != 0) textbackground(BLACK); else textbackground(WHITE);
      	cprintf("%c%c", 177, 177);
      }
      else
      {
	      gotoxy(bcl*2+25, 12);
   	   textcolor(bcl);
			if (bcl != 0) textbackground(BLACK); else textbackground(WHITE);
      	cprintf("%c%c", 177, 177);
      }
		update_img_status();
      key = getch();
      if (!key)
      	key = getch();
   	gotoxy(fcl*2+25, 11);
      textcolor(fcl);
      cprintf("%c%c", 219, 219);
      gotoxy(bcl*2+25, 12);
      textcolor(bcl);
      cprintf("%c%c", 219, 219);
      cursor();
      switch (key)
      {
      	case 'H' :
         case 'P' :	if (top) top = 0; else top = 1;
         				break;
         case 'K' :	if (top)
         				{
         					if (--fcl < 0) fcl = 15;
                     }
         				else
                     	if (--bcl < 0) bcl = 7;
                     break;
         case 'M'	:	if (top)
         				{
         					if (++fcl > 15) fcl = 0;
                     }
         				else
                     	if (++bcl > 7) bcl = 0;
                     break;
      }
   }
   while ((key != 13) && (key != 27));
   if (key == 27)
   {
   	fcl = old_fcl;
      bcl = old_bcl;
   }
   update_img_status();
   draw_area();
}


void save_map(int num)
{
	FILE	*mapfile;
   FILE	*swapfile;
   Area_struct	temp;

   mapfile = fopen(filename, "rb");
   swapfile = fopen("SWAP.DAT", "wb");
   if (mapfile == NULL)
		error_quit(str_add("Error! Cannot open ", filename));
	for(int i=1; i<=tot; i++)
   {
   	fread(&temp, sizeof(temp), 1, mapfile);
      fwrite(&temp, sizeof(temp), 1, swapfile);
   }
   fclose(mapfile);
   fclose(swapfile);

   mapfile = fopen(filename, "wb");
   swapfile = fopen("SWAP.DAT", "rb");
   if (swapfile == NULL)
		error_quit("Error! Cannot open SWAP.DAT");
   for(int i=1; i<=tot; i++)
   {
		fread(&temp, sizeof(temp), 1, swapfile);
   	if (i != num)
      	fwrite(&temp, sizeof(temp), 1, mapfile);
      else
      	fwrite(&area, sizeof(area), 1, mapfile);
   }
   fclose(mapfile);
   fclose(swapfile);
   changed = 0;
}


void load_map(int num)
{
	FILE	*mapfile;

   mapfile = fopen(filename, "rb");
   if (mapfile == NULL)
		error_quit(str_add("Error! Cannot open ", filename));
   for(int i=0; i<num; i++)
   {
   	if (feof(mapfile))
		error_quit(str_add("Error! Cannot seek beyond EOF in ", filename));
      fread(&area, sizeof(area), 1, mapfile);
   }
   fclose(mapfile);
	textbackground(BLACK);
   gotoxy(66, 25);
   cprintf("              ");
	textcolor(LIGHTGRAY);
   gotoxy(66, 25);
   cprintf("(Map ");
   textcolor(LIGHTBLUE);
   cprintf("%d", num);
   textcolor(LIGHTGRAY);
   cprintf(" of ");
   textcolor(LIGHTBLUE);
   cprintf("%d", tot);
   textcolor(LIGHTGRAY);
   cprintf(")");
   changed = 0;
}


void add_map(void)
{
	FILE	*mapfile, *swapfile;
	Area_struct	temp;
	char	key;
   int	newpos;

   if (changed)
		ask_save();
   draw_window(24,10,56,13,4,"Info");
   textcolor(YELLOW);
   gotoxy(26, 11);
   cprintf("Add a map after current map?");
   gotoxy(38, 12);
   cprintf("(Y/N)");
   textcolor(WHITE);
   gotoxy(39, 12);
   cprintf("Y");
   gotoxy(41, 12);
   cprintf("N");
   cursor();
   do
   {
   	key = getch();
      key = toupper(key);
   }
   while ((key != 'Y') && (key != 'N'));
   if (key == 'Y')
   {
		newpos = num + 1;
   	mapfile = fopen(filename, "rb");
      swapfile = fopen("SWAP.DAT", "wb");
      if (mapfile == NULL)
         error_quit(str_add("Error! Cannot open ", filename));
      for(int i=1; i<=tot; i++)
      {
      	fread(&temp, sizeof(temp), 1, mapfile);
         fwrite(&temp, sizeof(temp), 1, swapfile);
      }
      fclose(mapfile);
      fclose(swapfile);
      swapfile = fopen("SWAP.DAT", "rb");
		if (swapfile == NULL)
      	error_quit("Error! Cannot open SWAP.DAT");
      mapfile = fopen(filename, "wb");
      for(int i=1; i<=tot; i++)
      {
      	if (i == newpos)
         {
				clear_area();
            fwrite(&area, sizeof(area), 1, mapfile);
         }
         fread(&temp, sizeof(temp), 1, swapfile);
         fwrite(&temp, sizeof(temp), 1, mapfile);
      }
   	fclose(mapfile);
      fclose(swapfile);
      tot = tot + 1;
      num = newpos;
      x = 0;
      y = 0;
      pos = 0;
   }
	changed = 0;
   load_map(num);
   draw_area();
}


void draw_area(void)
{
	for(int k=0; k<24; k++)
   	for(int j=0; j<40; j++)
      {
      	gotoxy(j*2+1, k+1);
         textcolor(area.fcl[j][k][0]);
         textbackground(area.bcl[j][k][0]);
         cprintf("%c", area.cha[j][k][0]);
         textcolor(area.fcl[j][k][1]);
         textbackground(area.bcl[j][k][1]);
         cprintf("%c", area.cha[j][k][1]);
      }
   cursor();
}


void update_img_status(void)
{
   textcolor(fcl);
   textbackground(bcl);
   gotoxy(57, 25);
   cprintf("Color");
   textcolor(WHITE);
   textbackground(RED);
   for(int x=0; x<9; x++)
   {
   	gotoxy(x*4+15, 25);
      cprintf("%c", charset[cs_index][x]);
   }
   gotoxy(52, 25);
   cprintf("%c", charset[cs_index][9]);
   cursor();
}


void update_coors(void)
{
   textbackground(BLACK);
	textcolor(BLUE);
   gotoxy(2, 25);
   cprintf("(");
   textcolor(LIGHTBLUE);
   cprintf("%d", x);
   textcolor(BLUE);
   cprintf(",");
   textcolor(LIGHTBLUE);
   cprintf("%d", y);
   textcolor(BLUE);
   cprintf(",");
   textcolor(LIGHTBLUE);
   cprintf("%d", pos);
   textcolor(BLUE);
   cprintf(")");
   if (x < 10)
   	cprintf(" ");
   if (y < 10)
   	cprintf(" ");
   cursor();
}


void draw_img_screen(void)
{
	clear();
   textcolor(BLUE);
   textbackground(BLACK);
   gotoxy(2, 25);
   cprintf("(XX,XX,X)");
	textcolor(WHITE);
   textbackground(RED);
   gotoxy(13, 25);
	cprintf("1=X 2=X 3=X 4=X 5=X 6=X 7=X 8=X 9=X 10=X ");
   textbackground(BLACK);
   gotoxy(57, 25);
   cprintf("Color");
   draw_area();
   update_img_status();
   cursor();
}


int img_menu(void)
{
	const int tot = 16;
   struct
   {
	   char 	*name[tot];
      int	line[tot];
   } item;
   item.name[0]  = "+  Next Map";				item.line[0] = 3;
   item.name[1]  = "-  Prev Map";            item.line[1] = 4;
   item.name[2]  = "T  Toggle Img/Sld";      item.line[2] = 5;
	item.name[3]  = "U  Cut Section";			item.line[3] = 7;
   item.name[4]  = "O  Copy Section";			item.line[4] = 8;
   item.name[5]  = "P  Paste Section";			item.line[5] = 9;
   item.name[6]  = "D  Delete Section";		item.line[6] = 10;
   item.name[7]  = "F  Flip Section";			item.line[7] = 11;
	item.name[8]  = "V  View Clipboard";		item.line[8] = 12;
   item.name[9]  = "X  Clear Map";				item.line[9] = 14;
   item.name[10] = "L  Fgr/Bgr colors";		item.line[10] = 15;
   item.name[11] = "C  Character Set";			item.line[11] = 16;
	item.name[12] = "A  Add Map";					item.line[12] = 18;
   item.name[13] = "R  Remove Map";				item.line[13] = 19;
   item.name[14] = "S  Save Map";				item.line[14] = 20;
   item.name[15] = "Q  Quit Program";			item.line[15] = 21;
	int	num = lastmenuchoice;
   char	key;

	draw_window(25,2,46,22,4,"Image Menu");
	textcolor(LIGHTGRAY);
	for(int i=0; i<tot; i++)
   {
   	gotoxy(27, item.line[i]);
      cprintf("%s", item.name[i]);
   }
   do
   {
   	textcolor(YELLOW);
      gotoxy(27, item.line[num]);
      cprintf("%s", item.name[num]);
      cursor();
      do
      {
      	key = getch();
			key = toupper(key);
			if (key == 'M')			// an extra hidden command to reset map file
         {
				return(187);
         }
         switch (key)
         {
         	case	0 :	textcolor(LIGHTGRAY);
								gotoxy(27, item.line[num]);
					         cprintf("%s", item.name[num]);
				            cursor();
				         	key = getch();
				            switch (key)
				            {
				            	case	'H'   :
				               case 	'K'	:	if (--num < 0)
				               						num = tot-1;
					                 				break;
				               case 	'P'	:
				               case	'M'	:	if (++num >= tot)
            				       					num = 0;
                   								break;
				            }
                        key = 0;
                        break;
         }
         for(int i=0; i<tot; i++)
         	if (key == item.name[i][0])
            {
            	num = i;
               key = 13;
            }
		}
      while ((key != 13) && (key != 27) && (key != 0));
	}
   while ((key != 13) && (key != 27));
	lastmenuchoice = num;
	draw_area();
   if (key == 13)
   	return(num+1);
	else
   	return(0);
}

void ask_save(void)
{
	char	key;

	draw_window(28,10,52,13,4,"Important!");
   textcolor(YELLOW);
   gotoxy(30, 11);
   cprintf("This map has changed!");
   gotoxy(31, 12);
   cprintf("Save changes (Y/N)?");
   textcolor(WHITE);
   gotoxy(45, 12);
   cprintf("Y");
   gotoxy(47, 12);
   cprintf("N");
   cursor();
   do
   {
   	key = getch();
      key = toupper(key);
   }
   while ((key != 'Y') && (key != 'N'));
   if (key == 'Y')
   	save_map(num);
   draw_area();
}


void reset_mapfile(void)
{
	FILE	*mapfile;
	Area_struct	temp;
	const int	newtot = 5;
   char	key;

   draw_area();
	draw_window(26,10,54,13,4,"Warning!");
   textcolor(YELLOW);
   gotoxy(28, 11);
   cprintf("Reset all existing maps?");
   gotoxy(38, 12);
   cprintf("(Y/N)");
   textcolor(WHITE);
   gotoxy(39, 12);
   cprintf("Y");
   gotoxy(41, 12);
   cprintf("N");
   cursor();
   do
   {
   	key = getch();
      key = toupper(key);
   }
   while ((key != 'Y') && (key != 'N'));
   if (key == 'Y')
   {
		mapfile = fopen(filename, "wb");
		for(int i=1; i<=newtot; i++)
      {
      	for(int k=0; k<23; k++)
         	for(int j=0; j<39; j++)
            {
            	temp.dat[j][k] = 0;
               for(int p=0; p<2; p++)
               {
               	temp.cha[j][k][p] = random(3)+176;
                  temp.fcl[j][k][p] = random(16);
                  temp.bcl[j][k][p] = random(8);
               }
            }
			temp.cha[0][0][0] = i + 48;
         fwrite(&temp, sizeof(temp), 1, mapfile);
      }
      fclose(mapfile);
		changed = 0;
		init_file();
		load_map(num);
   }
   draw_area();
}


void cut_to_clip(int leave_sec)
{
	int x1, y1, x2, y2;

   if (select_area(x1, y1, x2, y2))
   {
   	clear_clip();
   	clip.totx = x2 - x1 + 1;
      clip.toty = y2 - y1 + 1;
      clip.x1 = x1;
      clip.y1 = y1;
      clip.x2 = x2;
      clip.y2 = y2;
      for(int k=0; k<clip.toty; k++)
      	for(int j=0; j<clip.totx; j++)
         {
         	clip.cha[j][k][0] = area.cha[j+x1][k+y1][0];
         	clip.fcl[j][k][0] = area.fcl[j+x1][k+y1][0];
         	clip.bcl[j][k][0] = area.bcl[j+x1][k+y1][0];
         	clip.cha[j][k][1] = area.cha[j+x1][k+y1][1];
         	clip.fcl[j][k][1] = area.fcl[j+x1][k+y1][1];
         	clip.bcl[j][k][1] = area.bcl[j+x1][k+y1][1];
            clip.dat[j][k] = area.dat[j+x1][k+y1];
				if (!leave_sec)
				{
	      		area.cha[j+x1][k+y1][0] = ' ';
   	   		area.fcl[j+x1][k+y1][0] = 15;
      			area.bcl[j+x1][k+y1][0] = 0;
      			area.cha[j+x1][k+y1][1] = ' ';
      			area.fcl[j+x1][k+y1][1] = 15;
	      		area.bcl[j+x1][k+y1][1] = 0;
   	         area.dat[j+x1][k+y1] = 0;
               changed = 1;
            }
         }
      draw_area();
   }
}


void paste_to_area(void)
{
	char	key;
   int	x1 = clip.x1, y1 = clip.y1, x2 = clip.x2, y2 = clip.y2;

	textbackground(BLACK);
   gotoxy(13, 25);
	cprintf("                                         ");
	gotoxy(23, 25);
   textcolor(YELLOW);
   textbackground(BLUE);
   cprintf("Position Area...");
   do
   {
   	textcolor(WHITE);
      textbackground(RED);
      for(int k=0; k<clip.toty; k++)
      	for(int j=0; j<clip.totx; j++)
         {
         	gotoxy((j+x1)*2+1, k+y1+1);
            cprintf("%c%c", clip.cha[j][k][0], clip.cha[j][k][1]);
         }
      cursor();
      key = getch();
      if (!key)
      	key = getch();
		for(int k=0; k<clip.toty; k++)
      	for(int j=0; j<clip.totx; j++)
         {
         	gotoxy((j+x1)*2+1, k+y1+1);
            textcolor(area.fcl[j+x1][k+y1][0]);
            textbackground(area.bcl[j+x1][k+y1][0]);
            cprintf("%c", area.cha[j+x1][k+y1][0]);
            textcolor(area.fcl[j+x1][k+y1][1]);
            textbackground(area.bcl[j+x1][k+y1][1]);
            cprintf("%c", area.cha[j+x1][k+y1][1]);
         }
      switch (key)
      {
      	case	'H'	:	y1 = y1 - 1;
         					y2 = y2 - 1;
         					if (y1 < 0)
                        {
                        	y1 = y1 + 1;
                           y2 = y2 + 1;
                        }
                        break;
      	case	'K'	:	x1 = x1 - 1;
         					x2 = x2 - 1;
         					if (x1 < 0)
                        {
                        	x1 = x1 + 1;
                           x2 = x2 + 1;
                        }
                        break;
         case	'P'	:	y1 = y1 + 1;
         					y2 = y2 + 1;
                        if (y2 > 23)
                        {
                        	y1 = y1 - 1;
                           y2 = y2 - 1;
                        }
                        break;
         case	'M'	:	x1 = x1 + 1;
         					x2 = x2 + 1;
                        if (x2 > 39)
                        {
                        	x1 = x1 - 1;
                           x2 = x2 - 1;
                        }
                        break;
      }
   }
   while ((key != 13) && (key != 27));
   if (key == 13)
   {
   	for(int k=0; k<clip.toty; k++)
      	for(int j=0; j<clip.totx; j++)
         {
         	area.cha[j+x1][k+y1][0] = clip.cha[j][k][0];
         	area.fcl[j+x1][k+y1][0] = clip.fcl[j][k][0];
         	area.bcl[j+x1][k+y1][0] = clip.bcl[j][k][0];
         	area.cha[j+x1][k+y1][1] = clip.cha[j][k][1];
         	area.fcl[j+x1][k+y1][1] = clip.fcl[j][k][1];
         	area.bcl[j+x1][k+y1][1] = clip.bcl[j][k][1];
				area.dat[j+x1][k+y1] = clip.dat[j][k];
         }
      changed = 1;
   }
  	textcolor(WHITE);
   textbackground(RED);
   gotoxy(13, 25);
	cprintf("1=X 2=X 3=X 4=X 5=X 6=X 7=X 8=X 9=X 10=X ");
	update_img_status();
   draw_area();
}


void view_clip(void)
{
	textbackground(BLACK);
   gotoxy(13, 25);
	cprintf("                                         ");
	gotoxy(21, 25);
   textcolor(YELLOW);
   textbackground(BLUE);
   cprintf("Viewing Clipboard...");
	for(int k=0; k<24; k++)
   	for(int j=0; j<40; j++)
      {
      	gotoxy(j*2+1, k+1);
        	textcolor(clip.fcl[j][k][0]);
         textbackground(clip.bcl[j][k][0]);
         cprintf("%c", clip.cha[j][k][0]);
        	textcolor(clip.fcl[j][k][1]);
         textbackground(clip.bcl[j][k][1]);
         cprintf("%c", clip.cha[j][k][1]);
      }
   cursor();
	getch();
	while (kbhit())
   	getch();
	textcolor(WHITE);
	textbackground(RED);
	gotoxy(13, 25);
	cprintf("1=X 2=X 3=X 4=X 5=X 6=X 7=X 8=X 9=X 10=X ");
	update_img_status();
   draw_area();
}


void delete_area(void)
{
	int x1, y1, x2, y2;

   if (select_area(x1, y1, x2, y2))
   {
   	for(int k=y1; k<=y2; k++)
      	for(int j=x1; j<=x2; j++)
         {
         	area.dat[j][k] = 0;
            for(int p=0; p<2; p++)
            {
            	area.cha[j][k][p] = ' ';
               area.fcl[j][k][p] = 15;
               area.bcl[j][k][p] = 0;
            }
         }
      changed = 1;
   }
   draw_area();
}


void flip_area(void)
{
	int 	x1, y1, x2, y2;
   char	key;
   Clip_struct	temp;

   if (select_area(x1, y1, x2, y2))
   {
		for(int k=0; k<24; k++)
      	for(int j=0; j<40; j++)
         {
         	temp.dat[j][k] = 0;
            for(int p=0; p<2; p++)
            {
            	temp.cha[j][k][p] = ' ';
               temp.fcl[j][k][p] = 15;
               temp.bcl[j][k][p] = 0;
            }
         }
   	temp.totx = x2 - x1 + 1;
      temp.toty = y2 - y1 + 1;
      temp.x1 = x1;
      temp.y1 = y1;
      temp.x2 = x2;
      temp.y2 = y2;
      for(int k=y1; k<=y2; k++)
      	for(int j=x1; j<=x2; j++)
         {
         	temp.cha[j][k][0] = area.cha[j][k][0];
         	temp.fcl[j][k][0] = area.fcl[j][k][0];
         	temp.bcl[j][k][0] = area.bcl[j][k][0];
         	temp.cha[j][k][1] = area.cha[j][k][1];
         	temp.fcl[j][k][1] = area.fcl[j][k][1];
         	temp.bcl[j][k][1] = area.bcl[j][k][1];
            temp.dat[j][k] = area.dat[j][k];
         }
		textbackground(BLACK);
   	gotoxy(13, 25);
		cprintf("                                         ");
		gotoxy(19, 25);
  	 	textcolor(YELLOW);
  	 	textbackground(BLUE);
      cprintf(" Flip [H]orz. or [V]ert. ");
		textcolor(WHITE);
      gotoxy(26, 25);
      cprintf("H");
      gotoxy(37, 25);
      cprintf("V");
      cursor();
      do
      {
      	key = getch();
         key = toupper(key);
      }
      while ((key != 'H') && (key != 'V'));
      if (key == 'H')
      {
      	for(int k=y1; k<=y2; k++)
         	for(int j=x1; j<=x2; j++)
            {
            	area.dat[j][(temp.toty-(k-y1))-1+y1] = temp.dat[j][k];
               for(int p=0; p<2; p++)
               {
               	area.cha[j][(temp.toty-(k-y1))-1+y1][p] = temp.cha[j][k][p];
               	area.fcl[j][(temp.toty-(k-y1))-1+y1][p] = temp.fcl[j][k][p];
               	area.bcl[j][(temp.toty-(k-y1))-1+y1][p] = temp.bcl[j][k][p];
               }
            }
      }
      else
      {
			for(int k=y1; k<=y2; k++)
         	for(int j=x1; j<=x2; j++)
            {
            	area.dat[(temp.totx-(j-x1))-1+x1][k] = temp.dat[j][k];
            	area.cha[(temp.totx-(j-x1))-1+x1][k][0] = temp.cha[j][k][1];
            	area.cha[(temp.totx-(j-x1))-1+x1][k][1] = temp.cha[j][k][0];
            	area.fcl[(temp.totx-(j-x1))-1+x1][k][0] = temp.fcl[j][k][1];
            	area.fcl[(temp.totx-(j-x1))-1+x1][k][1] = temp.fcl[j][k][0];
            	area.bcl[(temp.totx-(j-x1))-1+x1][k][0] = temp.bcl[j][k][1];
            	area.bcl[(temp.totx-(j-x1))-1+x1][k][1] = temp.bcl[j][k][0];
            }
      }
		textcolor(WHITE);
		textbackground(RED);
		gotoxy(13, 25);
		cprintf("1=X 2=X 3=X 4=X 5=X 6=X 7=X 8=X 9=X 10=X ");
		update_img_status();
   }
   draw_area();
}

int sld_menu(void)
{
}