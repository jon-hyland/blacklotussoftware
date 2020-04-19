/*  module title: numbers.c
 *  function name: void numbers()
 *		   main() for demo
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, math.h (if you have this header)
 *  compiled by:
 *
 *  linked with: log10() (may be part of a special math library)
 *  linked by:
 *
 *  problems:  The string placed in the buffer passed to numbers is not checked
 *	       for length, so the buffer must be longer than any potential
 *	       string. The current buffer length is 80 characters, and the 
 *	       current precision for the output is 2 decimal places. These 
 *	       digits are not spelled out but placed in front of '/100' as 
 *	       you might use on a check.
 *
 *  description: returns a pointer to a string that spells out the value of the
 *               float the function was passed, as would be used for a 
 *		 check writer; main() exits when 0 is entered as the number 
 */

#include <stdio.h>

#define DEMO


#ifdef DEMO

main()				/* a simple demonstration main()  	     */
{
    char buffer[80];		/* space for the number string wanted        */
    double n;			/* number that is converted                  */
    char num[15];
	
    void numbers();
    double atof();
    char *fgets();

    for (;;) {
	printf("\nEnter a number: ");		/* enter any number          */
						
	fgets(num, sizeof(num), stdin);		/* approved method of        */
	n = atof(num);				/*  receiving input from user*/

	if (!n)					/* a zero?		      */
		exit(0);			/* finished		      */

	setmem(buffer, 80, 0);			/* initiate buffer with nulls*/

	numbers(n, buffer);			/* pass to numbers a float   */
						/*  and a pointer to buffer  */
						/*  to put the result in     */
	puts(buffer);		 		/* print it                  */
    }
}

#endif


void numbers(value,buffer)	/* convert value into string at buffer as    */
double value;			/*  for a check writer                       */
char *buffer;
{

			/* these arrays of pointers to character strings are */
			/*  used to compose the resulting string             */

	static char *units[] = {		/* can initialize only       */
	    "",					/*  static arrays            */
	    "one ",
	    "two ",
	    "three ",
	    "four ",
	    "five ",
	    "six ",
	    "seven ",
	    "eight ",
	    "nine "
        };

	static char *teens[] = {
	    "ten ",
	    "eleven ",
	    "twelve ",
	    "thirteen ",
	    "fourteen ",
	    "fifteen ",
	    "sixteen ",
	    "seventeen ",
	    "eighteen ",
	    "nineteen "
        };

	static char *tens[] = {
	    "",
	    "",
	    "twenty ",
	    "thirty ",
	    "forty ",
	    "fifty ",
	    "sixty ",
	    "seventy ",
	    "eighty ",
	    "ninety "
        };

        static char *orders[] = {
	    "",
	    "thousand ",
	    "million "
        };

	char *ptr;			/* will be where ascii               */
	                           	/*  string is worked on              */
	int size;			/* turns into the number of digits   */
	int range;

	char *malloc();
        char *strchr();
        double log10();
	char *strcat();
	char *strncat();
	
	ptr = malloc(20);		/* make some space                   */
	if (!ptr) {
	    puts("can't allocate space for ptr");
	    exit(1);
	}

	sprintf(ptr, "%-f", value); 	/* make an ascii string appear       */
					/*  in the work space with default   */
					/*  precision                        */

	size = log10(value);	/* returns the number of digits              */
				/*  before the decimal place                 */
				/* result truncated to int by assignment     */

	range = size/3;		/* 0 if < 1000, 1 < 1,000,000                */
	size++;			/* now up to the real number of digits       */

  if (value >= 1) {		/* as long as number is > 1.0                */
    do {
	if (!(size % 3)) {	/* to check for an even 'order'              */
	    strcat(buffer, units[*ptr-'0']);
	    if (*ptr++ != '0' )  		/* puts 'hundred' into       */
		strcat(buffer, "hundred ");	/*  buffer if digit was not 0*/
	    size--;
	}

	if ((size - 1) % 3) {		/* check for more than one           */
					/*  digit in front of natural place  */
					/*  for comma because                */

	    if (*ptr == '1') {		/*  teens are handled differently    */
					/*  from other number pairs          */

	        strcat(buffer, teens[(*++ptr) - '0']);	/* have to pre-inc   */
	    }
	    else {			/* regular number pairs handled here */

	        strcat(buffer, tens[*ptr++ - '0']);
	        if (*ptr != '0')
		    strcat(buffer, units[*ptr - '0']);
	    }
	    ptr++;			/* cause had two digits              */
	    size -= 2;
	}
	else {
	    strcat(buffer, units[*ptr++ - '0']);    /* only a single digit   */
	    size--;
	}

	strcat(buffer, orders[range]);

						    /* if next range is      */
						    /*  all spaces, skip     */
	if ((*ptr | *(ptr + 1) | *(ptr + 2)) == '0') {  /* note bitwise OR   */
	    range--;
	    ptr += 3;
	    size -= 3;
	}

    }  while (range--);

    strcat(buffer, "and ");
  }
					         /* add the 'nn/100' part    */
  strncat(buffer,(strchr(ptr, '.')) + 1, 2);
  strcat(buffer, "/100");

}
