/*  module title: window.c
 *  function name: void scroll(), window()
 *		   main() for demo
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h
 *  compiled by:
 *
 *  linked with: void blank(), place(), setmem()
 *		 int getnlin()
 *  linked by:
 *
 *  problems:  If IBM functionality is desired, the row and column addresses
 *	       must be 0,0 based instead of 1,1 based, as they are for ANSI
 *	       compatibility. If you use another terminal type, you are on your
 *	       own and should make adjustments in the place() function. If
 *	       IBM is selected, you do not need the blank function.
 *
 *  description:  This function scrolls a FIFO window area UP or DOWN,
 * 		  as defined by the upper row, left column, window width, and
 *	          max number of lines.
 *		  The function requires direct cursor addressing and takes 
 *		  advantage of the clear-to-end-of-line feature of the
 *		  terminal. Strings are passed as an array of pointers to
 *		  window (like *argv[]). After the last line is entered, the
 *		  getnlin function starts placing string pointers in the 0
 *		  array element again; intervening calls to window have 
 *		  scrolled the original up or down out of the window by then.
 */

#include <stdio.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/* #define C86 */			/* C86 calls the LATTICE function    */
					/*  int86() by sysint(); let this    */
#ifdef C86				/*  macro switch them                */
#define int86(x,y,z) sysint(x,y,z)
#else
#undef max				/* function wants to use max as a    */
					/*  variable name; LATTICE wants to  */
#endif					/*  use it as a macro                */

#define LFT_COL 30			/* left edge of window       */
#define TOP_ROW 2			/* top edge                  */
#define MAX_LINES 16			/* number of lines in window */
#define WIDTH 40			/* width of window           */

#define CLS "\033[2J"			/* terminal-dependent clear-screen   */
#define CLEOL "\033[0K"			/*  and clear-to-end-of-line         */

#define UP TRUE				/* flag tells window to scroll up    */
#define DOWN FALSE			/* flag tells window to scroll down  */

#define IBM TRUE 			/* says can use ROM-BIOS call        */
#define VIDEO_INT 0x10			/* where to call it at               */
#define ATRIB 0x07			/* the ROM-BIOS attribute to use     */

main()			/* this main exercises the window function for  */
{			/*  demonstration purposes                      */

	int n = 0;				/* begins at 0               */
	int i;					/* an all-purpose integer    */
						/*  variable                 */
	void setmem();
	void place();
	void window();
	int getnlin();
	char *malloc();

	char *line[MAX_LINES];			/* pointers to 16 lines	     */

	puts(CLS);				/* clear screen              */
	
	for (i = 0; i < MAX_LINES; i++) {	/* initialize pointer values */
	    line[i] = malloc(WIDTH + 1);	/*  to point to free space   */
	    setmem(line[i], WIDTH + 1, 0);	/* fill line with nulls      */
	}

	place(TOP_ROW - 1, LFT_COL - 1);	/* set off the box           */
	putchar('+');
	place(TOP_ROW - 1, LFT_COL + 1 + WIDTH);
	putchar('+');
	place(TOP_ROW + MAX_LINES, LFT_COL - 1);
	putchar('+');
	place(TOP_ROW + MAX_LINES, LFT_COL + 1 + WIDTH);
	putchar('+');

	while (1) {
	    place(24, 1); 			/* stay out of the way of the*/
						/*  window area demonstration*/
	    printf(CLEOL);			/* blank the input line      */
	    printf("Enter another line: ");

	    if (getnlin(line[n++], WIDTH))	/* get WIDTH # chars into    */
		break; 				/*  line[n], draw all        */

	    window(TOP_ROW, LFT_COL, WIDTH, MAX_LINES, UP, line);

	    n %= MAX_LINES;			/* creates a circular  */
						/*  buffer             */
	}
}

void window(row,col,width,max,dir,line)		/* define window by left/top */
int row,col,width,max,dir;			/*  edge, width, max lines   */
char *line[];					/*  and whether fill is      */
{						/*  top-down or bottom-up    */

	int n;					/* all-purpose integer       */
	int temp;				/* likewise a-p integer      */
	static int start = 0;			/* first time through        */
						/*  start = 0; thereafter    */
						/*  retains the last value   */
						/*  stored there, reminds user*/
						/*  where next line goes     */

#if IBM
	void scroll();
	void place();


 	scroll(dir, row, col, max, width);      /* row is fixed based on dir */
        place((dir ? row + max - 1 : row), col);
	puts(line[start]);

#else

	void place();
	void blank();


	row = (dir ? row + max - 1 : row);	/* row is fixed based on dir */

	for (temp = start, n = 0; n < max; n++) {
	    blank(row, col, width);		/* clear the line            */
	    place((dir ? row-- : row++),col);	/* position the cursor       */
	    puts(line[temp--]);			/* print the line            */
	    temp += max, temp %= max;		/* create a circular buffer  */
	}

#endif

	start++;				/* next line is advanced */
	start %= max;				/*  but not too far      */
}

#if IBM

void scroll(dir,row,col,max,width)	/* for a PC video display    */
int dir;				/*  scroll this way:         */
unsigned int row, col;
int max, width;
{
	struct {				/* structure needed for      */
	    int ax,bx,cx,dx,si,di,ds,es;	/*  system-interrupt call    */
	} sreg;

	sreg.ax = (dir ? 0x0600 : 0x0700) + 1;	/* direction gives int       */
						/*  command plus lines to    */
						/*  move                     */
	sreg.bx = ATRIB;			/* attribute on new line     */
						/* set the row/col           */
	sreg.cx = (row - 1 << 8) + col - 1;	/*  -1 because pf int call   */
						/*  positioning vs. ANSI,    */
						/* the ! subtracts an extra  */
						/*  line when moving down    */
	sreg.dx = (row - 1 + max - !dir << 8) + col + width - 1;

	int86(VIDEO_INT, &sreg, &sreg);

}

#endif
