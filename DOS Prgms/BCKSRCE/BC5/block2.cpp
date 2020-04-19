





#include <iostream.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <time.h>
#include <dos.h>
#include <ctype.h>
#include <c:\bc5\jons\bls.h>

char prog_name[] = "Block Cruncher";
char ver_num[] = "v2.0";

struct {
  int obj[10][20];
  int clr[10][20];
} scr;

struct Piece_struct
{
  int id;
  int totx, toty;
  int obj[4][4];
  int clr;
};

Piece_struct piece, next, proto[7];
int points;
int speed;
int next_piece = 1;
int sound_on = 1;
int step = 0;
int dead;
int first;
int loose;
int bx, by;
int deltot;
int del;

void main(void)
{
	void black_lotus_intro(void);
	void init_pieces(void);
	void draw_screen(void);
   void draw_title(void);
   void game_reset(void);
	void draw_block(void);
	void erase_block(void);
   void flip_block(void);
	void draw_next(void);
   void wait_time_key(void);
   void line_check(void);
   void new_block(void);
   int  is_loose(void);
   void block_to_area(void);
   int  bad_move(void);
   void draw_area(void);
   char key;
   char speed_str[2];
   int j;

	black_lotus_intro();
	init_pieces();
   draw_screen();
   draw_title();
   do
   {
   	game_reset();
      do
      {
      	while((!loose) && (!dead))
         {
         	line_check();
            new_block();
            loose = is_loose();
            if (!loose)
            	block_to_area();
         }
         if (!dead)
         {
         	wait_time_key();
            if (kbhit())
            {
            	key = getch();
               key = toupper(key);
               switch (key)
               {
               	case '\0' : key = getch(); // extended character set
                  				switch (key)
                              {
                              	case 'H' : 	erase_block();
                                 			  	flip_block();
                                            	if (bad_move())
                                             	for(j=1; j<=3; j++)
                                                	flip_block();
                                             draw_block();
                                             break;
                                 case 'K' :	if (bx > 0)
                                 					bx--;
                                 				if (!bad_move)
                                             {
                                             	bx++;
                                                erase_block();
                                                bx--;
                                                draw_block();
                                             }
                                             else
                                             	bx++;
                                             break;
                                 case 'M' :	if (bx+(piece.totx-1) < 9)
                                 					bx--;
                                 				if (!bad_move)
                                             {
                                             	bx--;
                                                erase_block();
                                                bx++;
                                                draw_block();
                                             }
                                             else
                                             	bx--;
                                             break;
                                 case 'P' :	if (step)  	// drop 1 notch
                                 				{
                                             	by++;
                                                if (!bad_move)
                                                {
                                                	by--;
                                                   erase_block();
                                                   by++;
                                                   draw_block();
                                                   del = deltot;
                                                }
                                                else
                                                	by--;
                                             }
                                             else			// drop all notches
                                             {
                                             	erase_block();
                                                do
                                                {
                                                	by++;
                                                }
                                                while (!bad_move);
                                                by--;
                                                draw_block();
                                                del = 0;
                                             }
                                             break;
                              break;
                              } // end of extended char set

                  case 'P' : 	draw_window(30,10,47,13,2,"Info");
                  				textcolor(YELLOW);
                              gotoxy(33, 11);
                              cprintf("Game Paused");
                              gotoxy(32, 12);
                              cprintf("Press any key..");
                              cursor();
										clear_buffer();
                              getch();
                              clear_buffer();
                              erase_window(30,10,47,13);
                              draw_area();
                              draw_block();
                              break;
                  case 'N' :	game_reset();
                  				break;
                  case 'S' :	draw_window(30,10,47,13,3,"Input");
                  				textcolor(YELLOW);
                              gotoxy(32, 11);
                              cprintf("Enter speed");
                              gotoxy(32, 12);
                              cprintf("(1-10) : ");
                              do
                              {
											get_string(speed_str,41,12,2,1,0,0);
                              	speed = atoi(speed_str);
                              }
                              while ((speed < 1) || (speed > 10));
                              textcolor(YELLOW);
                              textbackground(BLUE);
                              gotoxy(20, 19);
                              cprintf("   ");
                              gotoxy(20, 19);
                              cprintf("%d", speed);
                              erase_window(30,10,47,13);
                              draw_area();
                              draw_block();
                              break;
                  case 'D' :	if (step)
                  					step = 0;
                  				else
                              	step = 1;
                              break;
                  case 'T' :	if (next_piece)
                  					next_piece = 0;
                  				else
                              	next_piece = 1;
                              if (next_piece)
                              	draw_next;
                              else
                              {
                              	textcolor(BLACK);
                                 for(int k=0; k<=3; k++)
                                 	for(int j=0; j<=3; j++)
                                    {
                                    	gotoxy(14+(j*2), k+4);
                                       cprintf("%c%c", 219, 219);
                                    }
                                 cursor();
                              }
                              break;
                  case 'L' :  // List High Scores;
                  				break;
                  case 'R' :  // Reset High Scores;
                  				break;
                  case 'E' :	if (sound_on)
                  					sound_on = 0;
                  				else
                              	sound_on = 1;
                              break;
                  case 'H' :  // View readme file
                  				break;
               }
            }
            else // if keyboard not hit
            {
            	loose = is_loose();
               if (!loose)
               	block_to_area();
               else
               {
               	erase_block();
                  by++;
                  draw_block();
               }
            }
         }
      }
      while ((!dead) && (key != 27));
      if (dead)
      {
      	draw_window(30,10,47,13,5,"Info");
         textcolor(YELLOW);
         gotoxy(34, 11);
         cprintf("Game Over");
         gotoxy(32, 12);
         cprintf("Press any key..");
         cursor();
         pause();
         erase_window(30,10,47,13);
         draw_area();
         draw_block();
      }
      // check_high_score();
   }
   while (key != 27);
   // show_high_score;
   // fadeout;
}



void init_pieces(void)
// Function creates block structures with given shape,
// color, and size.
{
	int i, j, k;

  	for(i=0; i<7; i++)
  	{
		piece.id = i;
	 	for(k=0; k<=3; k++)
		for(j=0; j<=3; j++)
			proto[i].obj[j][k] = 0;
	 	switch(i)
    	{
			case 0 : proto[i].clr = 3;
						proto[i].totx = 1;
						proto[i].toty = 1;
						for(k=0; k<=1; k++)
						  for(j=0; j<=1; j++)
							 proto[i].obj[j][k] = 1;
						break;
			case 1 : proto[i].clr = 4;
						proto[i].totx = 0;
						proto[i].toty = 3;
						for(k=0; k<=3; k++)
						  proto[i].obj[0][k] = 1;
						break;
			case 2 : proto[i].clr = 7;
						proto[i].totx = 2;
						proto[i].toty = 1;
						proto[i].obj[1][0] = 1;
						for(j=0; j<=2; j++)
						  proto[i].obj[j][1] = 1;
						break;
			case 3 : proto[i].clr = 14;
						proto[i].totx = 1;
						proto[i].toty = 2;
						proto[i].obj[0][2] = 1;
						for(k=0; k<=2; k++)
						  proto[i].obj[1][k] = 1;
						break;
			case 4 : proto[i].clr = 13;
						proto[i].totx = 1;
						proto[i].toty = 2;
						proto[i].obj[1][2] = 1;
						for(k=0; k<=2; k++)
						  proto[i].obj[0][k] = 1;
						break;
         case 5 :	proto[i].clr = 9;
         		   proto[i].totx = 2;
                  proto[i].toty = 1;
                  for(j=0; j<=1; j++)
                  {
                  	proto[i].obj[j][0] = 1;
                     proto[i].obj[j+1][1] = 1;
                  }
                  break;
         case 6 : proto[i].clr = 10;
         			proto[i].totx = 2;
                  proto[i].toty = 1;
                  for(j=0; j<=1; j++)
                  {
                  	proto[i].obj[j+1][0] = 1;
                     proto[i].obj[j][1] = 1;
                  }

      }
  	}
}


void draw_screen(void)
// Function draws the main program screen.
{
	clear();
   textcolor(DARKGRAY);
   textbackground(BLACK);
   gotoxy(40, 25);
   cprintf("(c) 1998 Black Lotus Software");
   draw_window(10,2,70,23,1,"Block Cruncher");
   textcolor(DARKGRAY);
   textbackground(BLUE);
   for(int k=3; k<=22; k++)
   {
   	gotoxy(28, k);
      cprintf("%c%c", 177, 178);
      gotoxy(50, k);
      cprintf("%c%c", 178, 177);
   }
   textcolor(WHITE);
   textbackground(BLACK);
	for(int k=4; k<=7; k++)
   	for(int j=15; j<=22; j++)
      {
      	gotoxy(j, k);
         cprintf(" ");
      }
   textbackground(BLUE);
   gotoxy(14, 8);
   cprintf("Next Piece");
   gotoxy(55, 4);
   cprintf("Right - Hmm..");
   gotoxy(55, 5);
   cprintf("Left - Uhh..");
   gotoxy(55, 6);
   cprintf("Up - Rotate");
   gotoxy(55, 7);
   cprintf("Down - Drop");
   gotoxy(55, 9);
   cprintf("P - Pause");
   gotoxy(55, 10);
   cprintf("N - New Game");
   gotoxy(55, 11);
   cprintf("S - Speed");
   gotoxy(55, 12);
   cprintf("D - Step/Drop");
   gotoxy(55, 13);
   cprintf("T - Next Piece");
   gotoxy(55, 14);
   cprintf("L - High Score");
   gotoxy(61, 15);
   cprintf("List");
	gotoxy(55, 16);
   cprintf("R - Reset High");
   gotoxy(60, 17);
   cprintf("Scores");
   gotoxy(55, 18);
   cprintf("E - Sound Eff.");
   gotoxy(55, 21);
   cprintf("Esc - Quit");
   gotoxy(12, 19);
   cprintf("Speed : ");
   gotoxy(12, 21);
   cprintf("Points : ");
   textcolor(BLACK);
   for(int k=3; k<=22; k++)
   	for(int j=30; j<=49; j++)
      {
      	gotoxy(j, k);
         cprintf("%c", 219);
      }
   cursor();
}


void draw_title(void)
// Function draws the splash title window, waits for user
// input, and erases title window.
{
	draw_window(30,8,47,15,4,"Info");
   textcolor(YELLOW);
   gotoxy(32,9);
   cprintf("%s", prog_name);
   gotoxy(37,10);
   cprintf("%s", ver_num);
   gotoxy(32,12);
   cprintf("All coding and");
   gotoxy(33,13);
   cprintf("graphics  by");
   gotoxy(34,14);
   cprintf("Jon Hyland");
   cursor();
   pause();
   erase_window(30,8,47,15);
}


void game_reset(void)
// Function resets all game variables and propares for
// new game.
{
	randomize();
   points = 0;
   speed = 1;
   dead = 0;
   loose = 0;
   first = 1;
   for(int k=0; k<=19; k++)
   	for(int j=0; j<=9; j++)
      {
      	scr.obj[j][k] = 0;
         scr.clr[j][k] = 0;
      }
   textcolor(WHITE);
   textbackground(BLACK);
   for(int k=3; k<=22; k++)
   	for(int j=30; j<=49; j++)
      {
      	gotoxy(j, k);
         cprintf(" ");
      }
   textcolor(YELLOW);
   textbackground(BLUE);
   gotoxy(18, 14);
   cprintf("    ");
   gotoxy(18, 20);
   cprintf("   ");
   gotoxy(21, 21);
   cprintf("%d", points);
   gotoxy(20, 19);
   cprintf("%d", speed);
   cursor();
}


void flip_block(void)
// Function takes current block and flips it 90* right.
{
   Piece_struct new_pc;

   new_pc.clr = piece.clr;
   for(int k=0; k<=3; k++)
   	for(int j=0; j<=3; j++)
      	new_pc.obj[j][k] = 0;
   new_pc.totx = piece.toty;
   new_pc.toty = piece.totx;
   for(int k=0; k<=new_pc.toty; k++)
   	for(int j=0; j<=new_pc.totx; j++)
      	new_pc.obj[j][k] = piece.obj[new_pc.toty-k][j];
	piece = new_pc;
 }


void draw_block(void)
// Function draw the current block in the playing
// screen at its location.
{
   textcolor(piece.clr);
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	gotoxy(((bx+j)*2)+30, by+k+3);
            cprintf("%c%c", 219, 219);
         }
   cursor();
}


void erase_block(void)
// Function erases current block at curent location from
// playing screen.
{
	textcolor(BLACK);
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	gotoxy(((bx+j)*2)+30, by+k+3);
            cprintf("%c%c", 219, 219);
         }
   cursor();
}


void draw_area(void)
// Function refreshes playing area by drawing all objects
// in playing screen.  Doesnt draw current block.
{
	for(int k=1; k<=20; k++)
   {
   	gotoxy(30, k+2);
      for(int j=1; j<=10; j++)
      {
      	textcolor(scr.clr[j][k]);
         cprintf("%c%c", 219, 219);
		}
   	cursor();
   }
}


void draw_next(void)
// Draws the next piece in next piece area.
{
	for(int k=0; k<=3; k++)
   	for(int j=0; j<=3; j++)
      {
      	textcolor(next.clr);
         gotoxy(14+(j*2), k+4);
         cprintf("%c%c", 219, 219);
      }
   cursor();
}


void new_block(void)
// Copies next piece to new current piece, creates next
// piece.  If first block in game, current piece is random.
{
	if (first)
   {
   	next = proto[random(7)];
      first = 0;
   }
   piece = next;
   next = proto[random(7)];
   bx = 5 - int(piece.totx/2);
   by = 1;
   draw_block();
   for(int k=0; k<=3; k++)
   	for(int j=0; j<=3; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+(j-1)][by+(k-1)])
            	dead = 1;
	if (next_piece)
   	draw_next();
}


void wait_time_key(void)
{
	switch (speed)
   {
   	case 1  : deltot = 75;
   	case 2  : deltot = 50;
   	case 3  : deltot = 40;
   	case 4  : deltot = 32;
   	case 5  : deltot = 23;
   	case 6  : deltot = 18;
   	case 7  : deltot = 13;
   	case 8  : deltot = 9;
   	case 9  : deltot = 7;
   	case 10 : deltot = 5;
   }
	while ((delay < 0) && (!kbhit()))
   {
   	delay(10);
      del--;
   }
   if (del < 0)
   	del = deltot;
}


int is_loose(void)
{
	int lse=1;

   for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+(j-1)][by+(k-1)+1])
            	lse = 0;
   if (by >= (20-(piece.toty-1)))
   	lse = 0;
   if (sound_on)
   {
   	//sound(100);
      //delay(1);
      //nosound();
   }
	return(lse);
}


int bad_move(void)
{
	int bad=0;

   for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+(j-1)][by+(k-1)])
            	bad = 1;
   if (by > (20-(piece.toty-1)))
   	bad = 1;
   if (bx > (10-(piece.totx-1)))
   	bad = 1;
   return(bad);
}


void block_to_area(void)
{
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	scr.obj[bx+(j-1)][by+(k-1)] = piece.obj[j][k];
            scr.clr[bx+(j-1)][by+(k-1)] = piece.clr;
         }
}


void line_check(void)
{
	int solid, times=0, newsp;

   for(int k=0; k<=19; k++)
   {
   	solid = 1;
      for(int j=0; j<=9; j++)
      	if (!piece.obj[j][k])
         	solid = 0;
      if (solid)
      {
      	times++;
         for(int i=k; i<=1; i--)
         	for(int j=0; j<=9; j++)
            {
            	scr.obj[j][i] = scr.obj[j][i-1];
               scr.clr[j][i] = scr.clr[j][i-1];
            }
         for(int j=0; j<=9; j++)
         {
         	scr.obj[j][0] = 0;
            scr.clr[j][0] = 0;
         }
      }
   }
   if (next_piece)
   	points += int((times*(speed/3)*100)/2);
   else
   	points += int(times*(speed/3)*100);
   if (points > 5000)
   	newsp = 10;
   else if (points > 3500)
   	newsp = 9;
   else if (points > 2000)
   	newsp = 8;
   else if (points > 1200)
   	newsp = 7;
   else if (points > 750)
   	newsp = 6;
   else if (points > 500)
   	newsp = 5;
   else if (points > 250)
   	newsp = 4;
   else if (points > 100)
   	newsp = 3;
   else if (points > 50)
   	newsp = 2;
   else
     	newsp = 1;
   textcolor(YELLOW);
   textbackground(BLUE);
   if (newsp != speed)
   {
   	speed = newsp;
      gotoxy(20, 19);
      cprintf("     ");
      gotoxy(20, 19);
      cprintf("%d", speed);
   }
   gotoxy(21, 21);
   cprintf("      ");
   gotoxy(21, 21);
   cprintf("%d", points);
   cursor();
   if (times)
   {
   	for(int j=1; j<=times*5; j++)
      {
      	//if (sound_on)
         	//sound(random(250));
         delay(5);
      }
      //nosound();
      draw_area();
   }
}






