/*  module title: kidedit.c
 *  function name: main()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, ctype.h
 *  compiled by:
 *
 *  linked with: int inchar()
 *		 void say();
 *  linked by:
 *
 *  problems:
 *
 *  description: a simple screen editor for kids; displays only one
 *		 screenful, provides a border within which the cursor is
 *		 trapped, prints the window when ctrl-P is pressed, and   
 *		 clears the window when escape is pressed
 *
 */

#include <stdio.h>
#include <ctype.h>

#define CLS "\033[2J"			/* ANSI clear string                 */

#define UP_ARROW 1864			/* values returned from the          */
#define DOWN_ARROW 1872			/*  cursor-positioning arrows        */
#define LEFT_ARROW 1867			/*  on the IBM PC and NEC APC-III    */
#define RIGHT_ARROW 1869

#define DOWN "\033[1B"			/* strings to move cursor around */
#define UP "\033[1A"			/* again, ANSI escape sequences  */
#define LEFT "\033[1D"
#define RIGHT "\033[1C"
#define HOME "\033[1;1H"

#define CR '\r'
#define SPACE '\040'

#define NORTH 5				/* define size of window by          */
#define SOUTH 18			/*  its line and column borders      */
#define EAST 60
#define WEST 20

#define PRINT 0x10			/* ctrl-P to print                 */
#define CLEAR 0x1b			/* escape to clear screen          */
#define CNTRL_C 0x3			/* ctrl-C to stop                  */

char screen[SOUTH+1][EAST+2];		/* location of screen;               */
					/* extra position on right           */
					/*  is where indefectible string     */
					/*  end null is kept; null is        */
					/*  there because this extern array  */
					/*  is cleared to spaces at the start*/
main()
{
	int n;
	int c;
	int horizontal; 			/* location in screen array  */
	int vertical;
	FILE *fp;

	FILE *fopen();
	int inchar();
	void say();
	void setmem();

	fp = fopen("PRN", "w");
	if (!fp) {
	    say("Can't seem to talk to the printer...\n");
	    exit(1);
	}

	goto clear;				/* clear screen and          */
						/*  initialize array to      */
						/*  spaces at the start,     */
						/*  then rejoin the while,   */
						/*  which is in progress     */
	while ((c = inchar()) != EOF) {

	    switch (c) {

		case UP_ARROW:
   		    if (--vertical < NORTH + 1) {
			vertical = NORTH + 1;
			break;
		    }
		    say(UP);
		    break;

		case DOWN_ARROW:
down:		    if (++vertical > SOUTH - 1) {
			vertical = SOUTH - 1;
			break;
		    }
		    say(DOWN);
		    break;

		case LEFT_ARROW:
      	    	    if (--horizontal < WEST + 1) {
			horizontal = WEST + 1;
			break;
		    }
		    say(LEFT);
		    break;

		case PRINT:
		    for (n = 0; n <= SOUTH; n++) {
			fputs(screen[n], fp);
			putc('\n', fp);
		    }
		    break;

		case CR:
		    horizontal = 0;		      /* go west, young man! */
		    putchar(c);
		    for (; horizontal < WEST + 1; horizontal++)
			say(RIGHT);
		    c = DOWN_ARROW;
		    goto down;
	  	    break;

		case CLEAR:
						/* clear screen and draw     */
						/* zigzag box on screen      */
clear:		    say(CLS);

		    for (n = 0; n <= SOUTH; n++) 	      /* fill array  */
			setmem(screen[n], EAST + 1, SPACE);   /*  with spaces*/

							/* go down to top    */
							/*  of box           */

		    for (vertical = 0; vertical < NORTH; vertical++)
			say(DOWN);		/* move to left edge */

		    for (horizontal = 0; horizontal < WEST; horizontal++)
			say(RIGHT);		/* mark top of box   */

		    for (; horizontal <= EAST; horizontal++) {
			putchar('-');
			screen[vertical][horizontal] = '-';
		    }

		    putchar(CR), horizontal = 0;	/* back to left      */
		    say(DOWN), vertical++;		/*  and down one     */
							/*  over to left edge*/
 	    	    for (; horizontal < WEST; horizontal++)
			say(RIGHT);

					/* now draw left and right edges for */
					/*  height-1 lines, zigzag fashion   */

		    for (; vertical < SOUTH; vertical++) {
			putchar('|'), screen[vertical][horizontal++] = '|';

			for (; horizontal < EAST; horizontal++)
			    say(RIGHT);

			putchar('|'), screen[vertical][horizontal++] = '|';

			for (; horizontal > WEST; horizontal--)
			    say(LEFT);

			say(DOWN);
		    }
					           /* draw the bottom line   */
		    putchar(CR), horizontal = 0;

		    for (; horizontal < WEST; horizontal++)
			say(RIGHT);

		    for (; horizontal <= EAST; horizontal++) {
			putchar('-');
			screen[vertical][horizontal] = '-';
		    }
	
		    say(HOME);				/* home the cursor   */

		    for (vertical = 0; vertical < NORTH + 1; vertical++)
			say(DOWN);			/* move to left edge */
		    for (horizontal = 0; horizontal < WEST + 1; horizontal++)
			say(RIGHT);

		    break;

		default:

		    if (!isprint(c) || horizontal == EAST)
			continue;		/* don't want any other ctrl */
						/*  characters here (or del),*/
		                           	/*  also prevents            */
		                 		/*  putting character on     */
						/*  top of the border        */

		    screen[vertical][horizontal] = c;	/* put c there  */
		    putchar(c);
		                   		/* advance indexes to        */
						/*  right after char sent    */
						/*  by falling into RIGHT    */
		case RIGHT_ARROW:
       	    	    if (++horizontal > EAST) {
			horizontal = EAST;
			continue;
		    }
		    if (c == RIGHT_ARROW)	/* could get here by         */
			say(RIGHT);		/*  falling through from     */
		          			/*  the default              */
		    break;

	    }  /*  end of switch  */

	    fflush(fp);
	    fflush(stdout);

	}  /*  end of while  */
}

