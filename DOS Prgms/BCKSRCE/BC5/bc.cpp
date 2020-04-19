#include <fstream.h>		// file handling, i/o devices
#include <conio.h>		// cprintf(), getch(), color ANSI
#include <stdlib.h>		// randomize()
#include <time.h>			// delay()
#include <dos.h>			// delay()
#include <ctype.h>		// character manip
#include "bls.h"			// standard functions library

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

struct							// high score list structure
{
	char  	name[17];
   long int	points;
} hs_list[10];


void init_pieces(void);			// function prototypes (global for easy access)
void draw_screen(void);
void draw_title(void);
void game_reset(void);
void flip_block(void);
void draw_block(int x, int y);
void erase_block(int x, int y);
void draw_area(void);
void draw_next(void);
void new_block(void);
void wait_time_key(void);
int  is_loose(void);
int  bad_move(void);
void block_to_area(void);
void line_check(void);
void write_high_score(void);
void reset_high_score(void);
void read_high_score(void);
void show_high_score(void);
void check_high_score(void);


Piece_struct 	proto[7];		// initilized as block type prototypes
Piece_struct 	piece;			// current block
Piece_struct 	next;				// next block

long int	 points; 				// total player points
int   level;						// current game level (1-10)
int  	next_piece = 1;			// next block showing?
int 	sound_on = 1;				// sound effects?
int 	step = 0;					// step / drop?
int	dead;							// game over?
int 	first;						// first piece?
int 	loose;						// piece loose?
int 	bx, by;						// current block location
int 	deltot;						// wait time based on level
int	del;							//	current place in wait time
int	new_hs;						// index 1-10 of new high score, 0=none
char	key;							// key pressed



void main(void)					// begin main program execution
{
	int j;							// a counter that needs to be here for some reason

   black_lotus_intro();			// show logo blast
	init_pieces();					// initilize prototype blocks
   draw_screen();					// draw main playing screen
   draw_title();					// show program title
   new_hs = -1;					// most recent high score is none
   do									// loop until Esc key, come here after die
   {
   	game_reset();				// reset game variables
      do								// loop until Esc or dead, come here evey move
      {
      	while((!loose) && (!dead))	// when block stops, but player not dead
         {
         	line_check();				// check for solid line, remove if exist
            new_block();				// bring current block from next block
            loose = is_loose();     //	check to see if new block is loose
            if (!loose)					// if not,
            	block_to_area();     // set current block into playing area
         }
         if (!dead)						// if player is still alive...
         {
         	wait_time_key();			// delay for set time, but break if key pr
            if (kbhit())				// if key has been pressed
            {
            	key = getch();			// get keypress to char key
               key = toupper(key);	// convert key to uppercase if possible
               switch (key)			// check key for following options
               {
               	case '\0' : key = getch(); // if key is extended char,
                                             // retrieve trailing char
                  				switch (key)	// check trailing char for options
                              {
                              	case 'H' :  // up arrow (flip)
                                 				erase_block(bx, by);
                                 			  	flip_block();
                                            	if (bad_move())
                                             	for(j=1; j<=3; j++)
                                                	flip_block();
                                             draw_block(bx, by);
                                             break;
                                 case 'K' :  // left arrow (left)
                                 				erase_block(bx, by);
                                 				bx--;
                                 				if (bad_move())
                                               	bx++;
                                             draw_block(bx, by);
                                             break;
                                 case 'M' :  // right arrow (right)
                                 				erase_block(bx, by);
                                 				bx++;
                                 				if (bad_move())
                                             	bx--;
                                             draw_block(bx, by);
                                             break;
                                 case 'P' :  // down arrow (drop/step)
                                 				if (step)         // if step true
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
                                             else			  	  // if step false
                                             {                // drop to bottom
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
                              }	// end of extended char set
                              break;
                  case 'P' : 	draw_window(30,10,47,13,2,"Info"); // [P]ause
                  				textcolor(YELLOW);
                              gotoxy(33, 11);
                              cprintf("Game Paused");
                              gotoxy(32, 12);
                              cprintf("Press any key..");
                              cursor();
										pause();
                              clear_buffer();
                              erase_window(30,10,47,13);
                              draw_area();
                              draw_block(bx, by);
                              break;
                  case 'N' :	game_reset();                    // [N]ew Game
                  				break;
                  case 'D' :	if (step)                        // [D]rop/Step
                  					step = 0;
                  				else
                              	step = 1;
                              break;
                  case 'T' :	if (next_piece)                  // [T] Next
                  					next_piece = 0;               //    Piece
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
                  case 'L' :	show_high_score();               // [L]ist
                    				break;                           // High Scores
                  case 'R' :  reset_high_score();					// [R]eset
                  				break;                           // High Scores
 						/*
                  case 'E' :	if (sound_on)							// Sound [E]ff
                  					sound_on = 0;                 // Toggle
                  				else                             // (disabled)
                              	sound_on = 1;
                              break;
               	*/
                  case 'H' :   							  				// [H]elp Doc
                  				break;
               }
            }
            else 											// if keyboard not hit
            {
            	loose = is_loose();              // check if piece is loose
               if (!loose)                      // if not,
               	block_to_area();              // send block to play area
               else										// if block is loose
               {
               	erase_block(bx, by);          // block fall one line
                  by++;
                  draw_block(bx, by);
               }
            }
         }
      }
      while ((!dead) && (key != 27));				// end of game play loop
      if (dead)											// if player died
      {
      	draw_window(30,10,47,13,5,"Info");     // show loser screen
         textcolor(YELLOW);
         gotoxy(34, 11);
         cprintf("Game Over");
         gotoxy(32, 12);
         cprintf("Press any key..");
         cursor();
         pause();                               // wait for keypress
         erase_window(30,10,47,13);             // redraw affected screen area
         draw_area();
         draw_block(bx, by);
      }
      check_high_score();								// check for new high score
   }
   while (key != 27);									// end of entire game loop
   show_high_score();									// display high score list
   fadeout();                                   // trippy screen vanish
}



void init_pieces(void)
// Function initilizes the seven block prototypes, sets color,
// shape, size, and solid area for each.
{
	int i, j, k;

  	for(i=0; i<7; i++)			// loop 7 times, one for each block prototype
  	{
		piece.id = i;										// set id num (ever used?)
	 	for(k=0; k<=3; k++) 								// reset multi-array of shape
			for(j=0; j<=3; j++)
				proto[i].obj[j][k] = 0;
	 	switch(i)
    	{
			case 0 : proto[i].clr = 11;				// set block color
						proto[i].totx = 1;            // set last x coor (0 is first)
						proto[i].toty = 1;            // set last y coor (0 is first)
						for(k=0; k<=1; k++)           // map out specific shape
						  for(j=0; j<=1; j++)
							 proto[i].obj[j][k] = 1;
						break;
			case 1 : proto[i].clr = 12;            // see above comments
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
	clear();                			// clear screen & draw  invisiable solid
   											// black square for cursor to "dissappear"
   											//	into. (move cursor there with cursor().)
   textcolor(DARKGRAY);
   textbackground(BLACK);
   gotoxy(40, 25);
   cprintf("(c) 1998 Black Lotus Software");
   draw_window(8,2,72,23,1,"Block Cruncher");	// draw main program window
   textcolor(DARKGRAY);
   textbackground(BLUE);
   for(int k=3; k<=22; k++)                   	// draw shading around
   {                                            // playing area
   	gotoxy(28, k);
      cprintf("%c%c", 177, 178);
      gotoxy(50, k);
      cprintf("%c%c", 178, 177);
   }
   textcolor(WHITE);                            // next piece area
   textbackground(BLACK);
	for(int k=4; k<=7; k++)
   	for(int j=14; j<=21; j++)
      {
      	gotoxy(j, k);
         cprintf(" ");
      }
   textbackground(BLUE);								// draw main menu
   gotoxy(13, 8);
   cprintf("Next Piece");
   gotoxy(55, 4);
   cprintf("Right - Hmm..");
   gotoxy(55, 5);
   cprintf("Left - Uhh..");
   gotoxy(55, 6);
   cprintf("Up - Rotate");
   gotoxy(55, 7);
   cprintf("Down - Drop");
   gotoxy(55, 10);
   cprintf("P - Pause");
   gotoxy(55, 11);
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
   gotoxy(55, 20);
   cprintf("Esc - Quit");
   gotoxy(11, 19);										// draw level / points area
   cprintf("Level  : ");
   gotoxy(11, 21);
   cprintf("Points : ");
   textcolor(BLACK);										// draw playing area
   for(int k=3; k<=22; k++)
   	for(int j=30; j<=49; j++)
      {
      	gotoxy(j, k);
         cprintf("%c", 219);
      }
   cursor();												// hide cursor
}


void draw_title(void)
// Function draws the splash title window, waits for user
// input, and erases title window.
{
	draw_window(30,8,47,15,4,"Info");				// draw title window
   textcolor(YELLOW);
   gotoxy(32,9);
   cprintf("%s", prog_name);                    // draw title info
   gotoxy(36,10);
   cprintf("%s", ver_num);
   gotoxy(32,12);
   cprintf("All coding and");
   gotoxy(33,13);
   cprintf("graphics  by");
   gotoxy(34,14);
   cprintf("Jon Hyland");
   cursor();
   pause();                                     // wait fot keypress
   erase_window(30,8,47,15);                    // erase title window
}


void game_reset(void)
// Function resets all game variables and propares for
// new game.  Outputs new score/level values.
{
	randomize();											// initilize random number
   points = 0;                                  // generator
   level = 1;
   dead = 0;                                    // reset game variables
   loose = 0;
   first = 1;
   for(int k=0; k<=19; k++)							// reset playing area array
   	for(int j=0; j<=9; j++)
      {
      	scr.obj[j][k] = 0;
         scr.clr[j][k] = 0;
      }
   textcolor(WHITE);
   textbackground(BLACK);
   for(int k=3; k<=22; k++)							// draw black playing area
   	for(int j=30; j<=49; j++)
      {
      	gotoxy(j, k);
         cprintf(" ");
      }
   textcolor(YELLOW);									// show new points / level
   textbackground(BLUE);
   gotoxy(20, 21);
   cprintf("%d", points);
   gotoxy(20, 19);
   cprintf("%d", level);
   cursor();
}


void flip_block(void)
// Function takes current block and flips it 90* right.
{
   Piece_struct new_pc;									// temporary piece struct

   new_pc.clr = piece.clr;								// save current block color
   for(int k=0; k<=3; k++)                      // reset new block area array
   	for(int j=0; j<=3; j++)
      	new_pc.obj[j][k] = 0;
   new_pc.totx = piece.toty;                 	// save current block size
   new_pc.toty = piece.totx;
   for(int k=0; k<=new_pc.toty; k++)				// save fliped area to new
   	for(int j=0; j<=new_pc.totx; j++)
      	new_pc.obj[j][k] = piece.obj[new_pc.toty-k][j];
	piece = new_pc;                              // rewrite current block
 }


void draw_block(int x, int y)
// Function draws the current block on the screen in the playing
// area at its location.
{
   textcolor(piece.clr);								// set text color
	for(int k=0; k<=piece.toty; k++)             // go through piece area array
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])                   // if solid element there,
         {
         	gotoxy(((x+j)*2)+30, y+k+3);        // draw it to screen
            cprintf("%c%c", 219, 219);
         }
  cursor();
}


void erase_block(int x, int y)
// Function erases current block at curent location from
// playing area.
{
	textcolor(BLACK);										// set black color
	for(int k=0; k<=piece.toty; k++)             // go through piece area array
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])                  // if solid element there,
         {
         	gotoxy(((x+j)*2)+30, y+k+3);       // erase it from screen
            cprintf("%c%c", 219, 219);
         }
   cursor();
}


void draw_area(void)
// Function refreshes playing area by drawing all objects
// in it.  Does not draw current block.
{
	for(int k=0; k<=19; k++)							// pretty self explanitory
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
	for(int k=0; k<=3; k++)								// wipe next piece area
	  	for(int j=0; j<=3; j++)
      {
			textcolor(BLACK);
      	gotoxy(14+(j*2), k+4);
         cprintf("%c%c", 219, 219);
      }
	for(int k=0; k<=3; k++)                      // draw next piece area
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
	if (first)								// if first piece in game,
   {
   	next = proto[random(7)];      // create new next piece (will be current)
      first = 0;							// set first flag to false
   }
   piece = next;							// current piece becomes next piece
   next = proto[random(7)];			// next piece is random
   bx = 5 - int(piece.totx/2);		// center current piece
   by = 0;                          // place at top
   draw_block(bx, by);					// draw it (yah baby)
   for(int k=0; k<=3; k++)				// check to see if new piece was laid
   	for(int j=0; j<=3; j++)       // over another block in playing area..
      	if (piece.obj[j][k])
         	if (scr.obj[bx+j][by+k])
            	dead = 1;            // if so, you're dead.
	if (next_piece)						// draw next piece if player wants
   	draw_next();
}


void wait_time_key(void)
// Waits for specific amount of time based on level.  If key
// is pressed, function will break, but once executed again,
// countdown will continue where left off.
{
	switch (level)						// set total delay time based on level
   {                             // (total delay used outside and must be set
   	case 1  	: 	deltot = 45;   // periodiacally)
                  break;
   	case 2  	: 	deltot = 35;
      				break;
   	case 3  	: 	deltot = 28;
						break;
   	case 4  	: 	deltot = 21;
                  break;
   	case 5  	: 	deltot = 17;
                  break;
   	case 6  	: 	deltot = 12;
                  break;
   	case 7  	: 	deltot = 9;
                  break;
   	case 8  	: 	deltot = 7;
                  break;
   	case 9  	: 	deltot = 5;
                  break;
   	case 10 	: 	deltot = 3;
   }

	while ((del > 0) && (!kbhit()))	// delay loop, break when done or key hit
   {
   	delay(18);
      del--;
   }

   if (del <= 0)							// if delay counter is finished, reset
	  	del = deltot;                 // for next time
}


int is_loose(void)
// Returns 1 if playing area element is dirrectly below a current block
// element (something under block).  0 if block is still loose.
{
	int lse=1;										// assume block is loose

   for(int k=0; k<=piece.toty; k++)       // if something under it,
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])
         	if (scr.obj[bx+j][by+k+1])
            	lse = 0;							// it isn't loose.
   if (by >= (19-piece.toty))             // if piece is at bottom,
   	lse = 0;                            // it isn't loose.
   /*
   if ((!lse) && (sound_on))					// click sound when hits
   {                                      // (disabled)
   	sound(100);
      delay(1);
      nosound();
   }
	*/
	return(lse);									// return loose flag
}


int bad_move(void)
// Returns 1 if block's current position is illegal (outside playing
// area, overlapping playing area element).  Used for block movement /
// rotation.
{
	int bad=0;										// assume location is good

   for(int k=0; k<=piece.toty; k++)			// go through piece array
   	for(int j=0; j<=piece.totx; j++)
      	if (piece.obj[j][k])             // if block solid overlaps area solid
         	if (scr.obj[bx+j][by+k])
            	bad = 1;                   // location is bad
   if (by > (19-piece.toty))					// bad if block is too far down
   	bad = 1;
   if (bx > (9-piece.totx))               // bad if block is too far right
   	bad = 1;
	if (bx < 0)                            // bad if block is too far left
   	bad = 1;
   if (by < 0)                            // bad if block is too far up
   	bad = 1;                            // (is this even possible?)
   return(bad);
}


void block_to_area(void)
// Transfers current block to grave in playing area. Used when
// block is no longer loose (dead piece).
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
// moves every layer above it down one notch, onto it.  Total number
// of solid lines this turn is counted.  Points are rewarded based on
// total solid lines, game level, and if next piece showing (half off).
{
	int solid, times=0, newsp;

   for(int k=0; k<=19; k++)				// cycle through play area
   {
   	solid = 1;                       // assume each line is solid
      for(int j=0; j<=9; j++)          // cycle through line
      	if (!scr.obj[j][k])           // if element not solid,
         	solid = 0;                 // line isn't solid
      if (solid)								// if current line is solid
      {
      	times++;								// increment solid lines counter
         for(int i=k; i>=1; i--)			// move above lines down
         	for(int j=0; j<=9; j++)
            {
            	scr.obj[j][i] = scr.obj[j][i-1];
               scr.clr[j][i] = scr.clr[j][i-1];
            }
         for(int j=0; j<=9; j++)			// top line is set to blank
         {
         	scr.obj[j][0] = 0;
            scr.clr[j][0] = 0;
         }
      }
   }
   if (next_piece)							// calc points for next piece
   	points += int((times*(level/float(3))*100)/float(2));
   else                                // calc points for no next piece
   	points += int(times*(level/float(3))*100);
   if (points > 5000)						// check points for new level break...
   	newsp = 10;
   else if (points > 35000L) // L specifies const over 32,767
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
   if (newsp > level)	              // if new level has changed,
   {
   	level = newsp;                  // set new level
      gotoxy(20, 19);                  // show new level
      cprintf("     ");
      gotoxy(20, 19);
      cprintf("%d", level);
   }
   gotoxy(20, 21);                     // print new points
   cprintf("      ");
   gotoxy(20, 21);
   cprintf("%d", points);
   cursor();
   if (times)									// if there was solid line(s)
   {
      /*
   	for(int j=1; j<=times*5; j++)		// make cool crunching sound
      {                                // (disabled)
      	if (sound_on)
         	sound(random(250));
         delay(5);
      }
      nosound();
      */
      draw_area();							// draw new playing area
   }
}

void write_high_score(void)
// This function takes the high score list structure array and
// writes it to the disk using sequential access method.
{
	fstream high_score;								// declare file interface

   high_score.open("HSFILE.DAT", ios::out);	// open (reset/create) file
   for(int i=0; i<10; i++)                   // loop 10 times
   	high_score 	<< hs_list[i].name << " "  // write data w/ deliminators
                  << hs_list[i].points << " ";
   high_score.close();								// close file
}


void reset_high_score(void)
// This function resets the high score list structure array and
// calls the write_high_score() function to save it to the disk.
{
	for(int i=0; i<10; i++)							// loop 10 times
   {
      strcpy(hs_list[i].name, "[EMPTY]");    // set the default name
      hs_list[i].points = 10-i;              // set the default points (10-1)
   }
   write_high_score();								// write data to disk
   new_hs = -1;										// no  most recent high score
}


void read_high_score(void)
// This function reads the high score list structure array from the disk.
{
	fstream high_score;								// delcare file interface

   high_score.open("HSFILE.DAT", ios::in);	// try to open existing file
   if (!high_score)									// if not,
   {
   	reset_high_score();                    // reset high score file
      high_score.open("HSFILE.DAT", ios::in);// open file again
   }
   for(int i=0; i<10; i++)							// loop 10 times, read data
   	high_score >> hs_list[i].name >> hs_list[i].points;
   high_score.close();                       // close file
}


void show_high_score(void)
// This function displays the high score list on the screen as a new
// window.
{
   read_high_score();               // read data from file
   draw_window(26,7,53,18,4,"High Score List"); // draw high score window
   for(int i=0; i<10; i++)          // loop for each high score
   {
		textcolor(YELLOW);            // set default colors
      textbackground(RED);
   	if (i == new_hs)              // if high score is most recent score,
      {
      	textcolor(WHITE);          // set recent colors
         textbackground(MAGENTA);
      }
      gotoxy(28, i+8);              // print high score in window
      cprintf("%s", hs_list[i].name);
      for(int j=1; j<=(20-strlen(hs_list[i].name)); j++)
      	cprintf(".");              // draw dots
      cprintf("%d", hs_list[i].points);
   }
   cursor();
	pause();									// wait for keypressed
   draw_area();                     // redraw affected screen areas...
   draw_block(bx, by);
   textbackground(BLUE);
   for(int k=7; k<=19; k++)         // loop for each affected line
   {
   	textcolor(DARKGRAY);          // redraw play area shading
      gotoxy(26, k);
      cprintf("  %c%c", 177, 178);
      gotoxy(50, k);
      cprintf("%c%c   ", 178, 177);
      textcolor(WHITE);
      switch (k)                   // redraw menu keys
      {
      	case 7	:	cprintf("D");	break;
         case 10	:	cprintf("P");	break;
         case 11	:	cprintf("N"); 	break;
         case 12	:	cprintf("D");	break;
         case 13	:	cprintf("T");	break;
         case 14	:	cprintf("L");	break;
         case 16	:	cprintf("R");	break;
         default	:	cprintf(" ");
      }
   }
	cursor();
}


void check_high_score(void)
// Checks the high score list to see if players points will be a new entry.
// If so, it asks the user for their name and updates the high score list
// accordingly.
{
	int pos = -1;								// insertion point 0-9, or -1 for none

   read_high_score();						// read data from disk to hs array
   for(int i=9; i>=0; i--)					// loop from bottom to top of hs array
   	if (points >= hs_list[i].points) // if points greater or equal to entry
      	pos = i;                      // insertion point is current spot
   if (pos >= 0)								// if valid insertion point (new hs)...
   {
      for(int i=9; i>pos; i--)			// push lesser entries down one
      {
      	hs_list[i].points = hs_list[i-1].points;
         strcpy(hs_list[i].name, hs_list[i-1].name);
      }
      draw_window(27,10,50,13,2,"New High Score!"); // draw input name window
      gotoxy(29,11);
      cprintf("Enter your name:");
		// get new string (see bls.h for info), copy to hs array)
		strcpy(hs_list[pos].name, get_string(29,12,17,LOCK,SHOW,CASE));
      hs_list[pos].points = points;		// set points in hs array
		write_high_score();              // write new hs array to file
   	new_hs = pos;                    // set most recent score
      erase_window(27,10,50,13);       // erase input name window
      textcolor(DARKGRAY);             // redraw affected screen areas...
      textbackground(BLUE);
      for(int k=10; k<=14; k++)
      {
      	gotoxy(27, k);
         cprintf(" %c%c", 177, 178);	// redraw playing area shading
         gotoxy(50, k);
         cprintf("%c%c ", 178, 177);
      }
      draw_area();							// redraw playing area
      draw_block(bx, by);              // redraw current block
   }
}


