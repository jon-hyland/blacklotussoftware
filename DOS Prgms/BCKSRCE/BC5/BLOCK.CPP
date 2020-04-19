#include <fstream.h>
#include <conio.h>
#include <stdlib.h>
#include <time.h>
#include <dos.h>
#include <ctype.h>
#include "bls.h"

char prog_name[] = "Block Cruncher";		// program name
char ver_num[] = "v2.0LE";                // version number


struct {                   //	playing area structure
  int obj[10][20];
  int clr[10][20];
} scr;

struct Piece_struct			// piece structure type
{
  int id;
  int totx, toty;
  int obj[4][4];
  int clr;
};

struct
{
	char  	name[17];
   long int	points;
} hs_list[10];

void init_pieces(void);
void draw_screen(void);
void draw_title(void);
void game_reset(void);
void draw_block(int x, int y);
void erase_block(int x, int y);
void flip_block(void);
void draw_next(void);
void wait_time_key(void);
void line_check(void);
void new_block(void);
int  is_loose(void);
void block_to_area(void);
int  bad_move(void);
void draw_area(void);
void reset_high_score(void);
void show_high_score(void);
void check_high_score(void);
void ansi_color_table(void);

Piece_struct proto[7];		// initilized as block type prototypes
Piece_struct piece;			// current block
Piece_struct next;			// next block

long int	points; 					// total player points
int 	level;						// current game level (1-10)
int 	next_piece = 1;			// next block showing?
int 	sound_on = 1;				// sound effects?
int 	step = 0;					// step / drop?
int	dead;							// game over?
int 	first;						// first piece?
int 	loose;						// piece loose?
int 	bx, by;						// current block location
int 	deltot;						// wait time based on level
int	del;							//	current place in wait time
int	new_hs;						// index 1-10 if new high score, 0=none
char	key;							// key pressed

void main(void)
{
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
                              	case 'H' : 	erase_block(bx, by);  	// up arrow
                                 			  	flip_block();
                                            	if (bad_move())
                                             	for(j=1; j<=3; j++)
                                                	flip_block();
                                             draw_block(bx, by);
                                             break;
                                 case 'K' :	erase_block(bx, by);    // left arrow
                                 				bx--;
                                 				if (bad_move())
                                               	bx++;
                                             draw_block(bx, by);
                                             break;
                                 case 'M' :	erase_block(bx, by);    // right arrow
                                 				bx++;
                                 				if (bad_move())
                                             	bx--;
                                             draw_block(bx, by);
                                             break;
                                 case 'P' :	if (step)  	      // down arraw
                                 				{                 // drop 1 notch
                                             	by++;
                                                if (!bad_move())
                                                {
                                                	by--;
                                                   erase_block(bx, by);
                                                   by++;
                                                   draw_block(bx, by);
                                                   del = deltot;
                                                }
                                                else
                                                	by--;
                                             }
                                             else			  	// drop all notches
                                             {
                                             	erase_block(bx, by);
                                                do
                                                {
                                                	by++;
                                                }
                                                while (!bad_move());
                                                by--;
                                                draw_block(bx, by);
                                                del = 0;
                                             }
                                             break;
                              } // end of extended char set
                              break;
                  case 'P' : 	draw_window(30,10,47,13,2,"Info"); // [P]ause
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
                              draw_block(bx, by);
                              break;
                  case 'N' :	game_reset();                      // [N]ew Game
                  				break;
                  case 'D' :	if (step)                          // Drop/Step
                  					step = 0;
                  				else
                              	step = 1;
                              break;
                  case 'T' :	if (next_piece)                    // [T] Next
                  					next_piece = 0;                 //    Piece
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
                  case 'L' :	show_high_score();
                    				break;                             // High Scores
                  case 'R' :  reset_high_score();											  // Reset
                  				break;                             // High Scores
                  case 'E' :	if (sound_on)							  // Sound [E]ff
                  					sound_on = 0;
                  				else
                              	sound_on = 1;
                              break;
                  case 'H' :   							  				  // [H]elp Doc
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
               	erase_block(bx, by);
                  by++;
                  draw_block(bx, by);
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
         draw_block(bx, by);
      }
      check_high_score();
   }
   while (key != 27);
   show_high_score();
   fadeout();
}



/*
vars used :
Piece_struct piece
Piece_struct proto
*/
void init_pieces(Piece_struct &proto, Piece_struct &piece)
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
			case 1 : proto[i].clr = 12;
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
// Draws the main program screen.
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
   cprintf("Level  : ");
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
   gotoxy(36,10);
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
// new game.  Outputs new score/level values.
{
	randomize();
   points = 0;
   level = 1;
   dead = 0;
   loose = 0;
   first = 1;
   new_hs = 0;
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
   gotoxy(21, 19);
   cprintf("%d", level);
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


void draw_block(int x, int y)
// Function draws the current block on the screen in the playing
// area at its location.
{
   textcolor(piece.clr);
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	gotoxy(((x+j)*2)+30, y+k+3);
            cprintf("%c%c", 219, 219);
         }
  cursor();
}


void erase_block(int x, int y)
// Function erases current block at curent location from
// playing area.
{
	textcolor(BLACK);
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	gotoxy(((x+j)*2)+30, y+k+3);
            cprintf("%c%c", 219, 219);
         }
   cursor();
}


void draw_area(void)
// Function refreshes playing area by drawing all objects
// in it.  Does not draw current block.
{
	for(int k=0; k<=19; k++)
   {
   	gotoxy(30, k+3);
      for(int j=0; j<=9; j++)
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
			textcolor(BLACK);
      	gotoxy(14+(j*2), k+4);
         cprintf("%c%c", 219, 219);
      }
	for(int k=0; k<=3; k++)
	  	for(int j=0; j<=3; j++)
   	  	if (next.obj[j][k])
	      {
   	   	textcolor(next.clr);
      	   gotoxy(14+(j*2), k+4);
         	cprintf("%c%c", 219, 219);
      	}
   cursor();
}


void new_block(void)
// Copies the next piece to the new current piece, creates new next
// piece.  If first block in the game, current piece is random.
{
	if (first)
   {
  		next = proto[random(7)];
      first = 0;
   }
   piece = next;
   next = proto[random(7)];
   bx = 5 - int(piece.totx/2);
   by = 0;
   draw_block(bx, by);
   for(int k=0; k<=3; k++)
   	for(int j=0; j<=3; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+j][by+k])
            	dead = 1;
	if (next_piece)
   	draw_next();
}


void wait_time_key(void)
// Waits for specific amount of time based on level.  If key
// is pressed, function will break, but once executed again,
// countdown will continue where left off.

{
   int count=0; // remove

	switch (level)
   {
   	case 1  	: 	deltot = 37;
                  break;
   	case 2  	: 	deltot = 37;
      				break;
   	case 3  	: 	deltot = 20;
						break;
   	case 4  	: 	deltot = 16;
                  break;
   	case 5  	: 	deltot = 11;
                  break;
   	case 6  	: 	deltot = 9;
                  break;
   	case 7  	: 	deltot = 6;
                  break;
   	case 8  	: 	deltot = 4;
                  break;
   	case 9  	: 	deltot = 3;
                  break;
   	case 10 	: 	deltot = 2;
   }
	while ((del > 0) && (!kbhit()))
   {
      count++; // remove
   	delay(15);
      del--;
   }
   if (del <= 0)
	  	del = deltot;
}


int is_loose(void)
// Returns 0 if playing area element is below a current block
// element (something under block).  0 if block is still loose.
{
	int lse=1;

   for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+j][by+k+1])
            	lse = 0;
   if (by >= (19-piece.toty))
   	lse = 0;
   if ((!lse) && (sound_on))
   {
   	//sound(100);
      //delay(1);
      //nosound();
   }
	return(lse);
}


int bad_move(void)
// Returns 1 if blocks current position is illegal (outside playing
// area, overlapping playing area element).
{
	int bad=0;

   for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+j][by+k])
            	bad = 1;
   if (by > (19-piece.toty))
   	bad = 1;
   if (bx > (9-piece.totx))
   	bad = 1;
	if (bx < 0)
   	bad = 1;
   if (by < 0)
   	bad = 1;
   return(bad);
}


void block_to_area(void)
// Moves current block to playing area when not loose (dead piece).
{
	for(int k=0; k<=piece.toty; k++)
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         {
         	scr.obj[bx+j][by+k] = piece.obj[j][k];
            scr.clr[bx+j][by+k] = piece.clr;
         }
}


void line_check(void)
// Checks every playing area line for total solid.  If so,
// moves every layer above it down onto it.  Total number
// of solid lines counted in one turn.  Points determined
// by total solid lines, game level, and if next piece showing.
{
	int solid, times=0, newsp;

   for(int k=0; k<=19; k++)
   {
   	solid = 1;
      for(int j=0; j<=9; j++)
      	if (!scr.obj[j][k])
         	solid = 0;
      if (solid)
      {
      	times++;
         for(int i=k; i>=1; i--)
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
   	points += int((times*(level/float(3))*100)/float(2));
   else
   	points += int(times*(level/float(3))*100);
   if (points > 5000)
   	newsp = 10;
   else if (points > 35000) // long const over 32,767
   	newsp = 9;
   else if (points > 20000)
   	newsp = 8;
   else if (points > 12000)
   	newsp = 7;
   else if (points > 7500)
   	newsp = 6;
   else if (points > 3000)
   	newsp = 5;
   else if (points > 1500)
   	newsp = 4;
   else if (points > 500)
   	newsp = 3;
   else if (points > 250)
   	newsp = 2;
   else
     	newsp = 1;
   textcolor(YELLOW);
   textbackground(BLUE);
   if (newsp > level)
   {
   	level = newsp;
      gotoxy(21, 19);
      cprintf("     ");
      gotoxy(21, 19);
      cprintf("%d", level);
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
         //delay(5);
      }
      //nosound();
      draw_area();
   }
}

void write_high_score(void)
{
	fstream high_score;

   high_score.open("HSFILE.DAT", ios::out);
   for(int i=0; i<10; i++)
   	high_score 	<< hs_list[i].name << " "
                  << hs_list[i].points << " ";
   high_score.close();
}


void reset_high_score(void)
{
	for(int i=0; i<10; i++)
   {
      strcpy(hs_list[i].name, "[EMPTY]");
      hs_list[i].points = 10-i;
   }
   write_high_score();
}


void read_high_score(void)
{
	fstream high_score;

   high_score.open("HSFILE.DAT", ios::in);
   if (!high_score)
   {
   	reset_high_score();
      high_score.open("HSFILE.DAT", ios::in);
   }
   for(int i=0; i<10; i++)
   	high_score >> hs_list[i].name >> hs_list[i].points;
   high_score.close();
}


void show_high_score(void)
{
   read_high_score();
   draw_window(26,7,53,18,4,"High Score List");
   for(int i=0; i<10; i++)
   {
		textcolor(YELLOW);
      textbackground(RED);
   	if (i == new_hs)
      {
      	textcolor(WHITE);
         textbackground(MAGENTA);
      }
      gotoxy(28, i+8);
      cprintf("%s", hs_list[i].name);
      for(int j=1; j<=(20-strlen(hs_list[i].name)); j++)
      	cprintf(".");
      cprintf("%d", hs_list[i].points);
   }
   cursor();
	pause();
   draw_area();
   draw_block(bx, by);
   textbackground(BLUE);
   for(int k=7; k<=19; k++)
   {
   	textcolor(DARKGRAY);
      gotoxy(26, k);
      cprintf("  %c%c", 177, 178);
      gotoxy(50, k);
      cprintf("%c%c   ", 178, 177);
      textcolor(WHITE);
      switch (k)
      {
      	case 7	:	cprintf("D");	break;
         case 9	:	cprintf("P");	break;
         case 10	:	cprintf("N"); 	break;
         case 11	:	cprintf("S");	break;
         case 12	:	cprintf("D");	break;
         case 13	:	cprintf("T");	break;
         case 14	:	cprintf("L");	break;
         case 16	:	cprintf("R");	break;
         case 18	:	cprintf("E");	break;
         default	:	cprintf(" ");
      }
   }
}


void splash_hs(void)			// REMOVE ME
{
	for(int i=0; i<10; i++)
	{
		gotoxy(1, i+1);
   	cprintf("%s  %d", hs_list[i].name, hs_list[i].points);
	}
	pause();
}



void check_high_score(void)
{
	int pos = -1;

   read_high_score();
   for(int i=9; i>=0; i--)
   	if (points >= hs_list[i].points)
      	pos = i;
   if (pos >= 0)
   {
		//splash_hs();	// REMOVE
      for(int i=9; i>pos; i--)
      {
      	hs_list[i].points = hs_list[i-1].points;
         strcpy(hs_list[i].name, hs_list[i-1].name);
      }
      //splash_hs();	// REMOVE
      draw_window(27,10,50,13,2,"New High Score!");
      gotoxy(29,11);
      cprintf("Enter your name:");
		strcpy(hs_list[pos].name, get_string(29,12,17,LOCK,SHOW,CASE));
      hs_list[pos].points = points;
      //splash_hs();	// REMOVE
		write_high_score();
   	new_hs = pos;
      erase_window(27,10,50,13);
      textcolor(DARKGRAY);
      textbackground(BLUE);
      for(int k=10; k<=14; k++)
      {
      	gotoxy(27, k);
         cprintf(" %c%c", 177, 178);
         gotoxy(50, k);
         cprintf("%c%c ", 178, 177);
      }
      draw_area();
      draw_block(bx, by);
   }
}


