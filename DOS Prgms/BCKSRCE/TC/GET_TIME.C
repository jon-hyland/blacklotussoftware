
/*  module title: get_time.c
 *  function names: void get_time()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with:
 *  compiled by:
 *
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: retrieves time and date from MS-DOS via 0x21 interrupt
 *	         function call; highly DOS and compiler dependent
 */

				/* getting the time/date from the operating  */
				/*  is an environment-dependent              */
				/*  function; here are the ways LATTICE and  */
				/*  C86 give to make direct operating        */
				/*  system calls                             */

#define C86 TRUE			/* else program compiles for LATTICE */


#if C86					/* C86 calls this function sysint21 */

#define intdos(x,y) sysint21(x,y)
struct _sreg {int ax,bx,cx,dx,si,di,ds,es;};

#else					/* LATTICE call */

struct _sreg {int ax,bx,cx,dx,si,di;};

#endif

void get_time(ptr)			/* gets d-o-w, time/date from        */
{					/*  system and stores the ascii      */
					/*  info at ptr       		     */
	struct _sreg sreg;
	static char *days[] = {
	    "Sunday",
	    "Monday",
	    "Tuesday",
	    "Wednesday",
	    "Thursday",
	    "Friday",
	    "Saturday"
	};
	char *dow;
	int hour;
	int minute;
	int year;
	int month;
	int day;
	char ampm;

        sreg.ax = 0x2a00;			/* gets date from MS DOS */
        intdos(&sreg, &sreg);

        year = sreg.cx - 1900;		/* the year in two digits */
        month = sreg.dx >> 8;		/*   & the month */
        day = sreg.dx & 0xff;		/*   & date */
        dow = days[sreg.ax & 0xff];	/*   & day of week string */

        sreg.ax = 0x2c00;			/* gets time from MS DOS */
        intdos(&sreg, &sreg);

        hour = sreg.cx >> 8;
        minute = sreg.cx & 0xff;

        if (hour >= 0 && hour <= 11)	/* converts from 24- to      */
	    ampm = 'a';			/*   12-hour format and sets */
        else				/*   the meridian indicator  */
	    ampm = 'p';
	
        if (hour > 12)
	    hour -= 12;
        else if (hour==0)
	    hour = 12;			/* put in header */

        sprintf(ptr, "%s %02d/%02d/%02d   %02d:%02d%c",
		dow,month,day,year,hour,minute,ampm);
}
