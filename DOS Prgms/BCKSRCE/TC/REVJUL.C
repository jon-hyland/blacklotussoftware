/*  module title: revjul.c
 *  function name: char *revjul()
 *		   main() for demo
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
 *  linked with: int twodates()
 *  linked by:
 *
 *  problems:
 *
 *  description: converts a Julian number into a date string
 *
 */

#include <stdio.h>

#define DEMO

#ifdef DEMO

main()			/* a simple demonstration main() */
{
    int jul;
    int base;

    char *revjul();

    while (1) {
	printf("\nEnter Julian date: ");
	scanf("%d", &jul);

	printf("Enter base year: ");
	scanf("%d", &base);

	printf("Date = %s\n", revjul(jul,base));
    }

}

#endif

char *revjul(jul,year)			/* returns pointer to string that  */
int jul;				/*  is calendar date for this      */
int year;				/*  Julian date in form: mm/dd/yy  */
{
					/* number of days in each month    */
					/*  indexed by the month in the year */

	static int days[] = {0,31,28,31,30,31,30,31,31,30,31,30,31};

	static char date[11];		/* a place for returned date string */
					/*  including the null, must be     */
					/*  static or will evaporate        */

	int days_year;			/* the days/year for a given year    */
	int n = 1;			/* an index into the days/month      */
	
	setmem(date, sizeof(date), 0);	/* must fill date with nulls so      */
					/*  strlen knows where date ends     */
	
	days[2] = 28;			/* fix February if changed           */

	do {				/* calculate number of days for      */
					/*  base year and all succeeding,    */
					/*  calculates leap year             */
	    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
		days_year = 366;
	    else
		days_year = 365;
	    
	    year++, jul -= days_year;		/* increment the year and    */

	} while (jul > 0);   			/*  test that does not       */
						/*  go over top              */

	year--, jul += days_year;		/* reverse the effect of     */
						/*  going too far            */
	
	if (days_year == 366)			/* if the current year is    */
	    days[2] = 29;			/*  leap, fix February       */

	do                            		/* subtract days from each   */
	    jul -= days[n++];			/*  month until jul < 0      */
	while (jul > 0);
						/* n holds month number   */
	--n, jul += days[n];			/* jul has day of month   */

	year = (year > 1999 ? year : year - 1900);

	sprintf(date, "%d/%d/%d", n, jul, year);   /* at date build string */

	return (date);				/*  that returns a pointer  */
}						/*  to the string           */
