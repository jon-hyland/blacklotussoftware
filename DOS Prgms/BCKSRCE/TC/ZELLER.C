/*  module title: zeller.c
 *  function name: char *zeller()
 *		   main() for demo
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, macros.h
 *  compiled by:
 *
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: produces Zeller congruence, given a pointer to the date 
 *		 string passed, in the format MM/DD/YY or MM/DD/YYYY, and 
 *		 returns a pointer to a string indicating the day of the week 
 *	         that the date falls on (the separator may also be a hyphen)
 */

#include <stdio.h>
#include "macros.h"

#define MO 0
#define DAY 1
#define YR 2

#define BAD_DIGIT 0			/* error code returned if the date   */
					/*  cannot exist                     */
#define DEMO

#ifdef DEMO

main()				/* this main for demonstration     */
{				/*  purposes only                  */

	char buff[40];			/* a place to build input  */

	char *zeller();

	printf("\nEnter date: ");
	scanf("%s",buff);

	printf("%s",zeller(buff));	/* print the day of the week for the */
}					/*  date entered                     */

#endif


char *zeller(date)		/* receive pointer to date string; return    */
char *date;			/*  pointer to day-of-week string            */
{
	char c;				/* all-purpose character variable    */
	int n = 0;			/* starting index in input string    */
	int month; 			/* temporary variables    	     */
        int year; 			/*  with obvious uses                */
	int century;
        int offset;			/* offset of year in century         */
	int mdy[3];			/* array holding the three values    */
					/*  created from input string:       */
					/*  month, day, year                 */

	static char *day[] = {		/* pointer to d-o-w string is        */
		"Sunday",		/*  returned from this initialized   */
		"Monday",		/*  array of pointers to chars       */
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday"
	};

	mdy[DAY] = mdy[MO] = mdy[YR] = 0;	/* initialize array values   */

	while(c = *date++) {		/* parse string, through to end      */

	    if(c == '-' || c == '/') {	/* legal separators are '-', '/'     */
		n++;			/* index to next element of date     */
		continue;		/* (m->d->y) when see one            */
	    }

	    if(!isdigit(c))		/* cannot have nonseparators/        */
		return (BAD_DIGIT);	/*  nondigits; return error now      */

	    mdy[n] = 10 * mdy[n] + (c - '0'); 	/* adds new digit to total   */
						/*  for this place, a very   */
	}					/*  simplified atoi() that   */
						/*  relies on ascii sequence */
		
	if(mdy[YR] < 100)
	    mdy[YR] += 1900;			/* accept 2-digit dates      */
						/*  for this century         */
	if(mdy[MO] > 2) {
	    month = mdy[MO] - 2;		/* adjust year and month     */
	    year = mdy[YR];			/*  based on February        */
	}
	else {
	    month = mdy[MO] + 10;
	    year = mdy[YR] - 1;
	}

	century = year / 100;			/* century as 2-digit number */
	offset = year % 100;			/* years into century        */
	
/*  these print statements were used for debugging
 *
 *	printf("\ncentury = %d, year = %d, offset = %d", century, year,
 *		offset);
 *	printf("\nmonth = %d, mdy[MO] = %d, mdy[DAY] = %d", month, mdy[MO],
 *		mdy[DAY]);
 */
						/* a magic formula for which */
						/*  we must give credit to   */
						/*  Zeller                   */

	n = INT((13 * month - 1) / 5) + mdy[DAY] + offset
		+ INT(offset / 4) + INT(century / 4) - 2 * century + 77;
	n = n - 7 * INT(n / 7);

	return (day[n]);		/* returns the pointer      */

}
