/********************************************************************
 *          -= Black Lotus Software DOS Standard Unit =-            *
 ********************************************************************/

//***************** include files ****************************
#include <conio.h>
#include <string.h>
#include <dos.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <fstream.h>
#include <stdio.h>


//********** enumerated datatypes for get_string() ***********
enum lock_type {BREAK, LOCK};				// get_string const
enum hide_type {SHOW, HIDE};				// get_string const
enum conv_type {CASE, UPPER, LOWER};   // get_string const


//******************* function prototypes ********************
void clear(void);
void cursor(void);
void draw_window(int, int, int, int, int, char[]);
void erase_window(int, int, int, int);
void black_lotus_intro(void);
int  clear_buffer(void);
void pause(void);
void get_string(char[80], int, int, int, lock_type, hide_type, conv_type);
void fadeout(void);
void view_text(char []);
int  copy_bfile(char[128], char[128]);
void ansi_color_table(void);



//**************** function implementation *******************

/********************************************************************
 *	Clear v1.0                                                       *
 * (c) 1995 Black Lotus Software                                    *
 * Function clears screen and draws an invisable black box at       *
 * bottom/left screen corner. To be used with curosr() function.    *
 ********************************************************************/
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



/********************************************************************
 *	Cursor v1.0                                                      *
 * (c) 1995 Black Lotus Software                                    *
 * Function makes cursor "invisable" by moving it to bottom/left    *
 * corner.                                                          *
 * + Screen must have been cleared with clear().                    *
 ********************************************************************/
void cursor(void)
{
	gotoxy(1, 25);
}



/********************************************************************
 *	Draw Window v1.0                                                 *
 * (c) 1996 Black Lotus Software                                    *
 * Function draws a text window of a certain color and centers      *
 * the title at the top.                                            *
 * + x1, y1, x2, y2 are the four corners of the window not          *
 *   including the window shadow.                                   *
 * + bcl indicates the background color of the window.              *
 * + name is the title centered at the top of the window.           *
 * + The delay time for the window blow up can be changed by        *
 *   modifying the constant delay_time. (not really a need)         *
 ********************************************************************/
void draw_window(int x1, int y1, int x2, int y2, int bcl, char name[])
{
	const int delay_time = 20;
	int ya, yb;
	float xa, xb;
	int times, xinc;
														// begin window expansion
	times = (y2-y1+1) - int((y2-y1+1)/2);	// number of steps
	xinc = ((x2-x1+1)/2) / times;				// x increment per step
	ya = int((y2-y1+1)/2+y1);					// top window coordinate
	yb = ya;                               // bottom window coor
	xa = int((x2-x1+1)/2+x1-xinc);         // left window coor
	xb = xa;                               // right window coor
	textcolor(bcl);								// set color
	textbackground(bcl);
	for(int j=1; j<=times-1; j++)				// loop through every step except last
	{
		for(int k=ya; k<=yb; k++)           // draw window for this step..
		{
			gotoxy(xa, k);
			for(int j=xa; j<=xb; j++)
				cprintf("%c", 219);
		}
   	delay(delay_time);       				// delay for delay time
		xa -= xinc;                         // decrement right by x increment
		xb += xinc;									// increment left by x increment
		ya--;											// decrement top by y increment (1)
		yb++;											// increment bottom by y increment (1)
	}
	textcolor(WHITE);								// draw final window block..
	for(int k=y1; k<=y2; k++)
		for(int j=x1; j<=x2; j++)
		{
			gotoxy(j,k);
			cprintf(" ");
		}
	if ((x2 <= 78) && (y2 <= 23))				// if room for shadow,
	{
		textcolor(DARKGRAY);                // draw shadow around window..
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
	textcolor(WHITE);								// draw window border...
	textbackground(bcl);
	gotoxy(x1, y1);    							// top left corner
	cprintf("%c", 218);
	gotoxy(x1, y2);                        // bottom left corner
	cprintf("%c", 192);
	for(int j=x1+1; j<=x2-1; j++)				// entire top & bottom..
	{
		gotoxy(j, y1);
		cprintf("%c", 196);
		gotoxy(j, y2);
		cprintf("%c", 196);
	}
	gotoxy(int(x1+((x2-x1+1)-strlen(name))/2)-2, y1);
	cprintf("%c %s %c", 180, name, 195);	// draw window title (centered)
	gotoxy(x2, y1);								// top right corner
	cprintf("%c", 191);
	gotoxy(x2, y2);                        // bottom right corner
	cprintf("%c", 217);
	for(int k=y1+1; k<=y2-1; k++)          // entire left & right sides..
	{
		gotoxy(x1, k);
		cprintf("%c", 179);
		gotoxy(x2, k);
		cprintf("%c", 179);
	}
}



/********************************************************************
 *	Erase Window v1.0                                                *
 * (c) 1996 Black Lotus Software                                    *
 * Function erases the text window created with draw_window().      *
 * + x1, y1, x2, y2 are the four corners of the window not          *
 *   including the window shadow.                                   *
 ********************************************************************/
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



/********************************************************************
 *	Black Lotus Intro v1.0                                           *
 * (c) 1997 Black Lotus Software                                    *
 * Function displays text "Black Lotus Productions" in center       *
 * of screen, waits a second, then explodes text characters in      *
 * every direction.                                                 *
 ********************************************************************/
void black_lotus_intro(void)					// no comments here guys
{                                         // i hardly remember anyway
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
	 delay(150);
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
  delay(150*3);
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



/********************************************************************
 *	Clear Buffer v1.1                                                *
 * (c) 1994 Black Lotus Software                                    *
 * Function clears all characters from the keyboard buffer.         *
 * + Usefull before a pause of some sort, or before certain input.  *
 * + Returns 1 if chacter(s) present, 0 if not.                     *
 ********************************************************************/
int clear_buffer(void)
{
   int exist=0;

   while (kbhit())		// while key in buffer,
   {
   	getch();          // discard character from buffer
      exist = 1;        // set exist flag
   }
   return(exist);			// return flag
}



/********************************************************************
 *	Pause v1.0                                                       *
 * (c) 1998 Black Lotus Software                                    *
 * Pauses execution and waits for user action.  Clears characters   *
 * from keyboard buffer before and after for total independance.    *
 ********************************************************************/
void pause(void)
{
 	clear_buffer();		// clear the buffer to assure its ready
	getch();					// wait until there is a character, then discard
   clear_buffer();		// clear buffer again (in case of extended char)
}



/********************************************************************
 *	Get String v1.1                                                  *
 * (c) 1998 Black Lotus Software                                    *
 * Gets a string from the user and returns the pointer to it. The   *
 * input area is drawn in black and user cannot type outside of     *
 * this area.  Backspace can be used to undo typing.                *
 * + xpos and ypos specify where on the screen to begin input.      *
 * + length specifies the size of the input field (black area) as   *
 *   well as limits the maximum length of the string.               *
 * + lock specifies whether user can break from get_string() by     *
 *   pressing [Esc] (string returned would be "[BREAK]").           *
 * + hide will enable the input to be displayed as star characters, *
 *   which is usefull for passwords.                                *
 * + convert allows for all characters to be converted to upper     *
 *   or lower case.                                                 *
 *                                                                  *
 * Enumerated type declaration for get_string() :                   *
 *		enum  lock_type  {BREAK, LOCK};                               *
 *		enum  hide_type  {SHOW, HIDE};                                *
 *		enum  conv_type  {CASE, UPPER, LOWER};                        *
 ********************************************************************/
char * get_string(int xpos, int ypos, int length,
						lock_type lock, hide_type hide, conv_type convert)
{
	char 	str[80];						// array for storage of new string
   int	x=0;							// position in string
   char  key;							// input variable

	for(int i=0; i<80; i++)			// purify string with null chars
   	str[i] = '\0';
   textcolor(WHITE);             // set input area colors
   textbackground(BLACK);
	gotoxy(xpos, ypos);           // draw input area
   for(int i=0; i<length; i++)
   	cprintf(" ");
   do										// main entry loop, end [Enter] or [Esc]...
   {
   	gotoxy(x+xpos, ypos);		// move cursor to corrct position
      key = getch();					// wait for user input
      switch (key)
      {
      								// case of extended character :
      	case '\0' : key = getch();	// retrieve & discard trailing character
         				key = '\0';		// key = null char, for no action
                     break;
         							// case of backspace :
         case 8	 : str[x] = '\0';	// current space becomes null
                     cprintf(" ");  // output blank to screen
         				if (x > 0)     // if not first space,
                     {
                     	x--;        // move position back one
                        str[x] = '\0'; // current space becomes null
                        gotoxy(x+xpos, ypos); // move cursor to new position
                        cprintf(" ");  		 // output blank to screen
                     }
                     break;
										// case of Esc :
         case 27	 :	if (lock == LOCK)	// if input session is locked,
         					key = '\0';    // overwrite escape char with null char
         				break;
      }
		if ((key >= 32) && (key <= 126)) // if key is printable char
      {
			if (convert == UPPER)			// convert to upper if specified
         	key = toupper(key);
         if (convert == LOWER)         // convert to lower if specified
         	key = tolower(key);
      	str[x] = key;						// write key char to string
         if (hide == HIDE)					// if hide then print star character
         	cprintf("*");
         else
	      	cprintf("%c", str[x]);     // if not hide then print real character
         if (x < (length-1))				// if position isn't last, increment +1
         	x++;
      }
   }
   while ((key != 13) && (key != 27));	// loop until key is ENTER or ESC
   if (str[x] != '\0')						// make sure string is terminated by
   	str[x+1] = '\0';                 // null char correctly
   if (key == 27)								// if user broke from session,
   	strcpy(str, "[BREAK]\0");        // string is now "[BREAK]"
   return(str);								// return string pointer
}



/********************************************************************
 *	Fade Out v1.0                                                    *
 * (c) 1996 Black Lotus Software                                    *
 * Function blanks screen from edges to center.  Usually used at    *
 * program termination.                                             *
 ********************************************************************/
void fadeout(void)						// no comments, similar to draw_window()
{                                   // in a way.
	const float xinc = (80 / 24);
   float	xa=1, xb=80;
   int	ya=1, yb=24;

   textcolor(BLACK);
   gotoxy(2, 25);
   for(int j=1; j<=78; j++)
   	cprintf("%c", 219);
   for(int i=1; i<=12; i++)
   {
   	for(int j=1; j<=80; j++)
      {
      	gotoxy(j, ya);
         cprintf("%c", 219);
         gotoxy(j, yb);
         cprintf("%c", 219);
         cursor();
      }
   	ya++;
      yb--;
      for(int k=ya; k<=yb; k++)
      {
      	for(int j=(int(xa)); j<=(int(xa + xinc)); j++)
         {
         	gotoxy(j, k);
            cprintf("%c", 219);
            cursor();
         }
         for(int j=(int(xb - xinc)); j<=(int(xb)); j++)
         {
         	gotoxy(j, k);
            cprintf("%c", 219);
            cursor();
         }
      }
      xa += xinc;
      xb -= xinc;
      delay(15);
   }
   textcolor(WHITE);
   textbackground(BLACK);
   clrscr();
}



/********************************************************************
 *	View Text v1.0                                                   *
 * (c) 1997 Black Lotus Software                                    *
 * Functoin views the specified text file, allowing screen          *
 * scrolling, until the Esc key if pressed.                         *
 *	+ filename a string containing the path+filename of a text file. *
 * + up/down arrows scroll one line.                                *
 * + pageup/pagedown scroll one page.                               *
 ********************************************************************/
void view_text(char filename[])
{
	const int totx = 78;
   const int toty = 250;
   fstream textfile;
	char 	text[totx][toty];
   char	cha;
   int 	offset=0, lastos=1;
	int 	lastline;
   int 	x=0, y=0;
   char	key;

   textfile.open(filename, ios::in);
   if (!textfile)
   {
   	cprintf("## ERROR : CANNOT OPEN FILE %s ##", filename);
      exit(1);
   }
   for(int k=0; k<toty; k++)
   	for(int j=0; j<totx; j++)
      	text[j][k] = ' ';
   while (textfile.peek() != EOF)
   {
   	cha = textfile.get();
		if (cha == 10)
      {
      	x = 0;
         y++;
      }
      if ((cha >= 32) && (cha <= 126)) // if key is printable char
      {
         if ((x < totx) && (y < toty))
				text[x][y] = cha;
         x++;
      }
   }
   lastline = y;
   textfile.close();
	draw_window(1,1,80,24,1,filename);
   textcolor(YELLOW);
   do
   {
   	if (offset != lastos)
      {
      	for(int k=offset; k<=offset+21; k++)
			{
				gotoxy(2, (k-offset+2));
         	for(int j=0; j<totx; j++)
               cprintf("%c", text[j][k]);
         }
         cursor();
      }
      lastos = offset;
      do
      	key = getch();
      while ((key != 27) && (key != 'H') && (key != 'P')
      	 	&& (key != 'I') && (key != 'Q'));
      switch (key)
      {
      	case 'H'	:	offset--;
         				break;
         case 'P' :	offset++;
         				break;
         case 'I'	:	offset -= 22;
         				break;
         case 'Q'	:	offset += 22;
      }
      if (offset < 0)
      	offset = 0;
      if (offset > (lastline-21))
      	offset = lastline - 21;
   }
   while (key != 27);
   erase_window(1,1,80,24);
}


int  copy_bfile(char srce_path[128], char dest_path[128])
{
	FILE *source, *dest;
   unsigned char dat;

   source = fopen(srce_path, "rb");
   dest   = fopen(dest_path, "wb");
   do
   {
   	fread(&dat, 1, 1, source);
      if (!feof(source))
      	fwrite(&dat, 1, 1, dest);
   }
   while (!feof(source));
   fclose(source);
   fclose(dest);
}




/********************************************************************
 *	ANSI Color Table v1.0                                            *
 * (c) 1998 Black Lotus Software                                    *
 * A good, quick reference to the ansi color chart.  Lookup what    *
 * colors are what numbers.                                         *
 ********************************************************************/
void ansi_color_table(void)
{
	textcolor(WHITE);
   textbackground(BLACK);
   clrscr();
   for(int i=0; i<=15; i++)
   {
   	gotoxy(i*3+20, 10);
      textcolor(i);
      cprintf("%c%c", 219, 219);
      gotoxy(i*3+20, 12);
      cprintf("%d", i);
   }
 	pause();
}

