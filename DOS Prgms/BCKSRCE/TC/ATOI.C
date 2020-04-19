/*  module title: atoi.c
 *  function names: int _atoi(), atoi() 
 *		    long atol()
 *		    char *itoa(), *lmod(), *ltoa()
 *		    void _itoa()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, ctype.h
 *  compiled by:
 *
 *  linked with: calc()
 *  linked by:
 *
 *  problems: none known
 *
 *  description: The functions starting with underscores are simplified 
 *		 ascii-to-integer and integer-to-ascii functions used in the
 *               calc() program; those following are more complete versions
 *		 normally available in the standard library. They are based
 *		 on functions supplied with the Ecosoft C Compiler.
 *
 *		 Depending on the compiler, you may need to #include the
 *		 character type macros. (For example, Lattice requires 
 *		 <ctype.h>.)
 *
 *		 The itoa(), ftoa(), dtoa() functions also may be accomplished
 *		 by using sprintf() instead.
 *
 */

#include <stdio.h>
#include <ctype.h>

int _atoi(ptr)			/* ascii-to-integer conversion function      */
char *ptr;			/*  named with leading _ to avoid confusion  */
{				/*  with real library function atoi          */

	char c;
	int result = 0;				/* initialize result to zero */
	int sign = 1;				/* makes assumption that     */
						/*  number is positive       */
	if (*ptr == '-') {
	     sign = -1;       			/* set sign to -1 if first   */
	     ptr++;				/*  character is minus sign  */
	}
	                			/* as we get a character out */
	while (c = *ptr++) {			/*  of string, we are also   */
						/*  testing character for    */
						/*  being true, nonzero      */

	    if (c < '0' || c > '9')		/* check to make sure that   */
		continue;			/*  digit is in range        */

	    result = result * 10 + (c - '0');	/* multiply (shift left)     */
						/*  current result by one    */
	}					/*  power of ten as we add   */
						/*  new digit                */

        return (result * sign);			/* when string ends,         */
						/*  return the result        */
}


void _itoa(ptr,n)		/* convert integer n to ascii string where   */
char *ptr;			/*  ptr points; must have enough room        */
int n;
{
	int i;				/* all-purpose counter               */
	static int decade[] = { 	/* array of powers of ten indexed    */
		10000,			/*  in reverse order                 */
		1000,
		100,
		10,
		1
	};
	char c;				/* string character being worked on  */

	if (n < 0) {			/* make n positive and place a dash  */
	    n *= -1;			/*  in front of string if began as   */
	    *ptr++ = '-';		/*  negative number                  */
	}				/* increment pointer after placing   */
					/*  minus sign                       */

	n++;				/* needed because program does not   */
					/*  go all the way down to 10**0     */
					/*  that is, biased by 1             */

	for (i = 0; i < 5; i++) {	/* function can handle only          */
					/*  numbers in the range             */
	    c = '0';			/*  -32768 <= n <= 32767, 5 digits   */

	    do {			/* fill this position with current   */
		*ptr = c++;		/*  assumption of value              */
	    }
	    while ((n -= decade[i]) > 0); /* will be right when this is neg  */

	    n += decade[i];		/* then correct for too many         */
	    ptr++;			/* subtractions and bump pointer     */

	}

	*ptr = '\0';			/* append null		             */
}


long atol(str)			/* here again, the more general case of      */
		                /*  converting a long is covered so that     */
char *str;	                /*  converting an int can be a subset        */
{
    long value = 0; 			/* a working variable                */
    int	sign = 1;			/* a place to keep track of the sign */

    if (*str == '\t' || *str == ' ')
        str++;

    if(isdigit(*str) && *str!='0' || (*str=='-' || *str=='+') && str[1]!='0') {
				/* handle decimal number cases first         */
	if(*str == '-') {	/* determine if there's a leading sign and   */
	    ++str;		/*  move string pointer past it              */
	    sign = -1;		/* adjust sign flag accordingly, this is     */
	}			/*  used for decimal numbers only            */
	else {
	    if(*str == '+')
	        str++;
	}

	while(isdigit(*str))
	    value = value * 10 + *str++ - '0';	/* accumulate it             */
    }

    else if(tolower(str[1])=='x') {	/* handle hex values here            */

	while(isdigit(*str) || (tolower(*str)>='a' && tolower(*str)<='f')) {

	    value *= 16;		/* hex decades come in powers of 16  */

	    if(isdigit(*str))
		value += *str++ -'0';
	    else
		value += tolower(*str++) - 'a' + 10;
	}
    }
    else if(isdigit(str[1])) {		/* handle octal values here          */

	while(isdigit(*str)) {
	    value<<=3;			/* octal digits come in powers of    */
					/*  eight; multiplying by eight is   */
	    value+=*str++ - '0';	/*  same as shifting left by 3       */
	}
    }
    return (sign * value);		/* if none of the conversion specs   */
}					/*  work, just return a zero; note   */
					/*  that this is a long zero         */

int atoi(str)				/* finally the funtion we're         */
char *str;				/* interested in		     */
{
	return (atol(str));	/* and again, notice the cast from an int    */
}				/*  to a long before invoking atol           */


	
char *lmod(str,arg,modn)		/* this function is called by ltoa  */
					/*  to convert a numeric value arg  */
char *str;				/*  in base modn into a string at   */
long arg;				/*  str; notice that it is recursive*/
int modn;
{
	long	temp2;
	int	temp1;

	temp1 = arg % modn;
	temp2 = arg / modn;
	if(temp2)
	    str=lmod(str,temp2,modn);
	*str++ = (temp1 > 9) ? (temp1 + 'a' - 10) : (temp1 + '0');
	return (str);
}

char *ltoa(str,arg)			/* this function is included because */
					/*  the more general case of convert-*/
char *str;				/*  ing a long to an ascii string    */
long arg;				/*  satisfies that for converting an */
					/*  int                              */
{

	char *rtn=str;

	if(arg < 0) {			/* if value is less than zero, just  */
	    arg = -arg;			/*  flip its sign                    */
	    *str++ = '-';		/*  and prepend a minus sign         */
	    if(arg < 0) {
	        strcpy(str,"2147483648");	/* still negative means it's */
		return (rtn);			/*  too big a number to be   */
	    }					/*  signed, so give it all   */
	}					/*  we got                   */
	str = lmod(str,arg,10);
	*str = '\0';			/* tack on a null                    */
	return (rtn);
}

char *itoa(str,arg)		/* the actual function that would be called  */
				/*  to convert an integer function into an   */
char *str;			/*  ascii string at str                      */
int arg;
{
	return (ltoa(str,(long)arg));	/* note its integer argument is cast */
					/*  to a long before being passed to */
					/*  ltoa                             */
}

