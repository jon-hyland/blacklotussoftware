
/*    module title: place.c
 *  function names: void place()
 *		
 *  author: Kim J. Brand
 *  
 *  revision history:	
 *     version/--date--/by  reason--------------------------------------------
 *       1.0   10/01/84 kb  Common C Functions initial release
 *   
 *  compiled with: stdio.h
 *  compiled by:
 *
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: place() is a general-purpose cursor-positioning function  
 *		 that can be used with ANSI-type terminals (including the IBM
 *		 PC when the ANSI.SYS file has been declared in CONFIG.SYS)
 *		 and non-ANSI type terminals such as the TELEVIDEO, WYSE-50, 
 *		 etc. It can also be configured to operate with IBM PC-
 *		 compatible systems. If it is, it uses interrupt functions to
 *		 perform the cursor positioning much faster.
 */

#include <stdio.h>
#include "macros.h"		/* where we have put the definition of ROW   */
				/* and COL for use with ANSI, other terminals*/

#define VIDEO_INT 0x10		/* in case we use ROM-BIOS calls, we'll need */
				/*  to know where to call it                 */

/* #define C86 */		/* C86 uses a different name for int86       */
				/*  which is the name LATTICE uses           */
#ifdef C86			/* provide the following macro if C86 is used*/
#define int86(x,y,z) sysint(x,y,z)
#endif


#define IBM			/* if this line here, ROM-BIOS cursor        */
				/*  positioning will be used                 */
 
#define ANSI			/* if this line removed, the non-ANSI type   */
				/*  cursor-positioning scheme will be used   */

#define LEAD_IN "\033="		/* for the non-ANSI terminal we want to      */
				/*  support here, the lead-in string is an   */
				/*  escape (0x1b) followed by an equal sign  */


void place(row,col)		/* position cursor at row and column given   */
unsigned int row;
unsigned int col;
{

#ifdef IBM			/* compatibles only please...                */

	struct { int ax,bx,cx,dx,si,di,ds,es; } sreg;
	
	sreg.ax = 0x0200;			/* this is for positioning   */
						/*  the cursor               */

						/* remember to subtract one  */
						/*  because ROM-BIOS is 0,0  */
	sreg.dx = (row - 1 << 8) | col - 1;	/* set up row and column     */
	sreg.bx = 0;				/* page number               */

	int86(VIDEO_INT, &sreg, &sreg);	

#else
	int printf();

#ifdef ANSI					/* the ANSI sequence needs   */
	printf("\033[%d;%dH",row,col);		/*  row and column values in */
						/*  ascii; remember: ANSI    */
						/*  coordinates start at 1,1 */
#else	
	printf(LEAD_IN);			/* can't use puts cause it   */
						/*  adds a newline at end    */
	putchar(ROW(row));			/* these macros just adjust  */
	putchar(COL(col));			/*  the row/col base value to*/
						/*  meet the terminal's      */
#endif						/*  requirements             */
#endif						/* note nested conditionals  */
}

