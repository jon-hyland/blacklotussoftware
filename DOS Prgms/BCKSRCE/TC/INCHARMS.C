/*  module title: inchar.c
 *  function names: int inchar()
 *	     	    void outchar()
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
 *  linked with: void amort(), kidedit(), report()
 *		 int listme(), menu(), scan()
 *  linked by:
 *
 *  problems: nonportable, specifically designed for MS-DOS environment
 *	      because of its use of interrupt vector call to get/send next 
 *	      character from/to operating system
 *
 ª  descriptionº functioî avoidó uså oæ standarä librarù calì sï caî geô an
 *		 unbuffered character from the operating system; this character
 *		 provides instant response without entering a carriage return;
 *		 inchar does not echo its character, so outchar is used
 */

#include <stdio.h>

#define C86				/* de-comment this line if using C86 */

#ifdef C86
					/* LATTICE function is intdos; C86   */
#define intdos(x,y) sysint21(x,y)	/*  is sysint21; use either          */
#define int86(x,y,z) sysint(x,y,z)	/*  likewise for int86/sysint        */

#endif

struct _sreg {int ax,bx,cx,dx,si,di,ds,es;};

#define VIDEO_INT 0x19			/* IBM PC uses 0x10 for              */
					/*  video interrupt                  */


int inchar(n)				/* in MS DOS system, gets a          */
int n;					/*  character from the keyboard raw  */
{
	struct _sreg sreg;
	int c;

	sreg.ax = 0x0700;		/* get a character, wait if not ready*/
	intdos(&sreg, &sreg);	  	/*  compiler- and DOS-dependent      */

	if (c = sreg.ax&0xff) {		/* watch out for two character-      */
	    return (c);			/*  producing keystrokes             */
	}
	else {
	    sreg.ax = 0x0700;
	    intdos(&sreg,&sreg);
	    return (sreg.ax);
	}
}

void outchar(c)			/* send a character to the screen at         */
char c;				/*  current cursor location                  */
{
	struct _sreg sreg;

	sreg.bx = 0; 			/* page 0			     */
	sreg.ax = 0x0e00 + c;		/* teletype write character command  */
	int86(VIDEO_INT, &sreg, &sreg);

}

