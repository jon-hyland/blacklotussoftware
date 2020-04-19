/*  module title: twodates.c
 *  function name: int two_dates()
 *		   main() for demo
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, macro.h
 *  compiled by:
 *
 *  linked with: unsigned int jul()
 *  linked by:
 *
 *  problems: won't work on dates < 1900 unless base date (1900) is changed
 *
 *  description:  calculates the days between two dates by finding the Julian
 *	          date of each (using a common base year of 1900) and 
 *		  returns the absolute value of the dates' difference; if a 
 *		  bad date is supplied, the function returns a -1
 *
 */

#include <stdio.h>
#include "macros.h"

#define BAD_DATE -1		/* an error code    */

#define DEMO


#ifdef DEMO

main()					/* a demonstration main         */
{
    char buff_1[40];		/* a place to enter date strings        */
    char buff_2[40];

    while (1) {
	printf("\nEnter date 1: ");
	scanf("%s", buff_1);

	printf("Enter date 2: ");
	scanf("%s", buff_2);

	printf("Days between dates = %d\n", twodates(buff_1, buff_2));
    }
}

#endif


int twodates(str1,str2)		/* find the days between two dates           */
char *str1;
char *str2;
{
	int jul1;
	int jul2;

	int jul();


	if ((jul1 = jul(str1, 1900)) < 4)	/* 0,1,2,3 are error codes   */
	    return (BAD_DATE);			/*  from Julian date routine */

	if ((jul2 = jul(str2, 1900)) < 4)
	    return (BAD_DATE);

	return (ABS(jul1 - jul2));		/* want just the difference  */

}
