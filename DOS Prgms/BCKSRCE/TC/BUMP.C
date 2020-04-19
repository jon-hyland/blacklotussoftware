
/*    module title: bump.c
 *  function names: void bump()
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
 *  description: if ANSI defined, use the ANSI function for cursor forward;
 *		 else use the IBM PC (and comaptibles) ROM-BIOS read cursor/
 *		 position cursor functions
 *
 */

#include <stdio.h>

struct _sreg {int ax,bx,cx,dx,si,di,ds,es; };	/* interrupt function call   */
						/*  structure used by LATTICE*/
						/*  and C86                  */

#define ANSI			/* remove for ROM-BIOS functions             */

#define C86					/* the interrupt function     *//
			 			/*  call is compiler dependent*
			 			/* commment this line out if  */
						/* you are using the LATTICE  */
						/*  compiler, or else refer   */
						/* to your compiler's docu-   */
						/* mentation                  */
#ifdef C86
#define int86(x,y,z) sysint(x,y,z)
#endif

#define VIDEO_INT 0x10			/* 0x19 for NEC APC-III              */

void bump()				/* move cursor forward one place     */
{
#ifdef ANSI

	printf("\003[1C");		/* easy if ANSI			     */

#else

	struct _sreg sreg;

	sreg.ax = 0x0300;		/* read cursor position command      */
	sreg.bx = 0;			/* page number                       */

	int86(VIDEO_INT, &sreg,&sreg);

	sreg.dx++;			/* bump column number in dl by one   */
	sreg.ax = 0x0200;		/* set cursor position command       */

	int86(VIDEO_INT, &sreg, &sreg);

#endif
}

