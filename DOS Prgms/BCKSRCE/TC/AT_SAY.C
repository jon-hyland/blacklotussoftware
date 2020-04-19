/*    module title: at_say.c
 *  function names: void at_say()
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
 *  linked with: int scan()
 * 		 void place(), set_cursor()
 *  linked by:
 *
 *  problems: totally IBM PC-campatible machines (or nearly so like the NEC
 *	      APC III) are required due to the use of interrupt functions
 *	      required to make this function fast
 *
 *  description: the primary means of printing on the user console used
 *		 in the scan() function
 */

#include <stdio.h>

struct _sreg {int ax,bx,cx,dx,si,di,ds,es; };	/* define structure used with */
						/*  IBM PC interrupt function */
						/*  calls                     */

#define C86					/* the interrupt function     */
						/*  call is compiler dependent*/
						/* commment this line out if  */
						/*  you are using the LATTICE */
						/*  compiler, or else refer   */
						/*  to your compiler's docu-  */
						/*  mentation                 */

#ifdef C86
#define int86(x,y,z) sysint(x,y,z)
#endif

#define VIDEO_INT 0x10			/* 0x19 for NEC APC-III              */

void at_say(row,col,ptr,attr)		/* locate the cursor and say         */
unsigned int row,col,attr;		/*  something with a given attribute */
char *ptr;				/* attributes are defined in the PC  */
{					/*  BASIC and Technical Reference doc*/
	struct _sreg sreg;

	int c;

 	void place();
	void set_cursor();

    if (*ptr) {				/* only if there is something there  */
	set_cursor(0);			/* turn cursor off                   */

	place(row, col++);
        sreg.bx = attr;			/* page number is in the high order  */
	                    		/*  8 bits; this might be changed to */
	                          	/*  be a passed parameter            */
	sreg.cx = 1;			/* first character gets written with */
	sreg.ax = 0x0900 | *ptr++;	/*  attribute; the rest are easier   */
	int86(VIDEO_INT, &sreg, &sreg);

	place(row, col);		/* moves cursor one place to right   */

	while (c = *ptr++) {
	    sreg.ax = 0x0e00 | c;
	    int86(VIDEO_INT, &sreg, &sreg);
	}

	set_cursor(1);			/* turn cursor back on               */
    }
}

