
/*    module title: set_curs.c
 *  function names: set_cursor()
 *
 *  author: Kim J. Brand
 *  
 *  revision history:	
 *     version/--date--/by  reason--------------------------------------------
 *       1.0   10/01/84 kb  Common C Functions initial release
 *   
 *  compiled with:		 	
 *  compiled by:
 *
 *  linked with:			
 *  linked by:
 *
 *  problems: IBM PC (or compatibles) only
 *
 *  description: uses the IBM PC's interrupt function calls to turn the cursor
 *		 on or off, can also be used to change the shape of the cursor,
 *		 as the case of it being on or off is really just a matter of
 *		 defining on which raster scan line the cursor block begins;
 *		 see the PC's Technical reference manual for more details
 *
 */

#define VIDEO_INT 0x10		/* this would be 0x19 for the NEC APC III    */

#define C86			/* C86 uses a different name for int86       */
				/*  which is the name LATTICE uses           */
#ifdef C86			/* provide the following macro if C86 is used*/
#define int86(x,y,z) sysint(x,y,z)
#endif

void set_cursor(flag)
int flag;
{
	struct _sreg sreg;

	sreg.ax = 0x0100;
	sreg.cx = flag ? 0x0407 : 0x8000;

	int86(VIDEO_INT, &sreg, &sreg);
}

