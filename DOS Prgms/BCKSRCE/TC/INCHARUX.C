/*	module title: inchar.c (for unix)
 *  function names: int inchar(), outchar(), initch(), endch()
 *
 *  author: Kim J. Brand
 *  
 *  revision history:	
 *	 version/--date--/by  reason--------------------------------------------
 *	   1.0   10/01/84 kb  Common C Functions initial release
 *   
 *  compiled with: termio.h, fcntl.h, stdio.h
 *		   sys/types.h sys/ioctl.h for XENIX 
 *  compiled by:
 *
 *  linked with:
 *  linked by:
 *
 *  problems: may only work on Unix System V, or System III with Berkeley
 *	      4.2 enhancments...check your port specifications and the
 *	      documentation supplied with tty(4) and ioctl(2)  (this function
 *	      was designed for a MASSCOMP MC500)
 *
 *	      if compiling under XENIX, include the command line argument
 *	      -DXENIX when compiling this module 
 *
 *  description: inchar() and outchar() are single-character, nonbuffered
 *		 console read/write routines
 *		 initch() must be called before using these routines 
 *		 endch() must be called before exiting the program
 *
 */

#include <sys/types.h>
#include <termio.h>
#include <fcntl.h>
#include <stdio.h>

#ifdef XENIX			/* if XENIX, include ioctl header file	   */
	#include <sys/ioctl.h>
#endif

static int fd;			/* only this module knows about this fd	     */
static struct termio arg;	/* used in setting and restoring terminal's  */
				/* i/o information 			     */
static int c_cc4;		/* holds old value of c_cc[4], the EOF char  */

int initch()			/* called at beginning to initialize tty     */
{				/* properly for single char input	     */

	char termname[L_ctermid];	/* array to hold term name        */
	char *ctermid();		/* ttyname function		  */

	ctermid(termname);		/* gets terminal ttyname 	   */
	fd = open(termname, O_RDWR);	/* open the device		   */

	ioctl(fd, TCGETA, &arg);

	arg.c_lflag ^= (ECHO|ICANON);	/* turns off echo and stops  */
					/*  translation and buffering*/
	c_cc4 = arg.c_cc[4];		/* save old value of c_cc[4] */
	arg.c_cc[4] = 1;		/* sets the number of	*/
					/*  characters we want to one*/
	return(ioctl(fd, TCSETA, &arg));	/* return result from ioctl  */

}

int endch()			/* called at end of routines to reset the   */
{				/*  tty's properly	 		    */

	arg.c_lflag ^= (ECHO|ICANON);	/* returned to original state	*/
	arg.c_cc[4] = c_cc4;		/* restore old value of VEOF	*/
	ioctl(fd, TCSETA, &arg);	/* restore old parameters	*/
	close(fd);			/* close up the file	 	*/
	return(0);

}

int inchar()
{
	char buf[1];

	read(fd, buf, 1);

	return *buf;
}

int outchar(c)
{
	char buf[1];

	*buf = c;

	return(write(fd, buf, 1));
}
