/*  module title: jul.c
 *  function name: unsigned int jul()
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
 *  linked with:
 *  linked by:
 *
 *  problems: Julian dates 0 through 3 are reserved for error indicators 
 *
 *  description: returns the Julian date from the date string based on a base
 *		 year given (the base year must be a leap year)
 */

#include <stdio.h>

#define MO 0
#define DAY 1
#define YR 2

#define BAD_DIGIT 0			/* return error codes                */
#define BAD_MONTH 1			/* means that the dates              */
#define BAD_DAY 2			/*  January 1, 2, 3, 4 of the base   */
#define BAD_YEAR 3			/*  year become invalid dates        */

/* #define DEMO */

#ifdef DEMO

main()				/* small main used for demonstration only  */
{
    char buff[10];		/* to enter strings from console             */
    int base;

    unsigned int jul();

    /* watch for systems that do not flush non-newline terminated strings */
    /* you may need to fflush() after each printf()                       */
 
    while(1) {
	printf("\nEnter base year: ");
	scanf("%d",&base);
	printf("\nEnter date: ");
	scanf("%s",buff);
	printf("\nJulian date = %u\n",jul(buff,base));
    }
}

#endif

unsigned int jul(date,base)		/* returns unsigned int Julian date  */
char *date;				/*  from string at date in MM-DD-YYYY*/
int base;				/*  format; Julian base year given by*/
{					/*  base; day of year returned if    */
					/*  base year same as date year      */

					/* make a lookup table for           */
					/*  the days in each month           */
					/*  indexed by the month in the year */

	static int days[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};

	char c;				/* an all-purpose character variable */
	int n = 0;			/* starting index in date string     */
	int mdy[3];			/* an array to hold ints for m-d-y   */
	unsigned int retjul;		/* becomes the returned value        */

					/* start at zero in each 'register'  */

	days[2] = 28;			/* static array is created at        */
					/*  compile time and assumed to be   */
					/*  permanent; corrects any          */
					/*  changes that may have occurred   */
					/*  to February                      */

	mdy[DAY] = mdy[MO] = mdy[YR] = 0;

	while (c = *date++) {		/* get characters from string until  */
					/*  end is reached                   */
	    if (c == '-' || c == '/') {	/* legal separators are - and /      */
		n++;			/* index to next element of date     */
		continue;
	    }

	    if (!isdigit(c))		/* cannot have nonseparators or      */ 
		return (BAD_DIGIT);	/* nondigits; if so, return now      */

	    mdy[n] = 10 * mdy[n] + (c - '0'); 	/* adds new digit to total   */
						/*  for this place           */
	}
		
	if (mdy[MO] < 1 || mdy[MO] > 12)	/* purge bad months          */
	    return (BAD_MONTH);

	/* if there are only two digits, two-digit years before (19)80       */
	/*  are assumed to be in the next century; two-digit years after the */
	/*  base year are assumed to be in this century; the translation     */
	/*  becomes (if base == 1980): 				             */
	/* 	0 - 79 = 2000 - 2079     80 - 99 = 1980 - 1999		     */

	if (mdy[YR] < 100) {			/* only two digits?          */
	    if (mdy[YR] < base - 1900)		/* prior to base year, digits*/
		mdy[YR] += 2000;		/*  are assumed to be in the */
	    else				/*  next century; 01 -> 2001 */
	        mdy[YR] += 1900;		/*  will make 84 -> 1984     */
	}
	
	if (mdy[YR] < base)			/* purge bad years           */
	    return (BAD_YEAR);

	if (mdy[YR] % 4 == 0 && mdy[YR] % 100 != 0 || mdy[YR] % 400 == 0)
	    days[2] = 29;			/* set February days to 29   */
						/*  if leap year             */

	if (mdy[DAY] < 1 || mdy[DAY] > days[mdy[MO]]) 	/* purge bad days    */
	    return (BAD_DAY);

	retjul = mdy[DAY];			/* set jul equal to days in  */
						/*  current month            */

	for (n = 1; n < mdy[MO]; n++) {		/* for every month preceding */
	    retjul += days[n];			/*  the current one, add days*/
	}

	for (n = base; n < mdy[YR]; n++) {	/* now add days from         */
						/*  preceding years          */
	    if (n % 4 == 0 && n % 100 != 0 || n % 400 == 0)
	        retjul += 366;
	    else				/* 365 or 366 based on leaps */
		retjul += 365;
	}

	return (retjul);

}

