/*  module title: charstr.c
 *  function name: char *char_str()
 *		   char *center();
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
 *  linked with: void amort()
 *  linked by:
 *
 *  problems: For charstr(), lengths up to only 80 characters are supported 
 *	      because an internal static array is declared at compile time.
 *	      For center(), the maximum field width is 132 characters.
 *
 *  description: charstr() returns a pointer to a string filled with a 
 *		 given number of a specified character. center() returns a
 *		 pointer to a string in which the string argument has been
 *		 centered in a specified field width.
 */

#include <stdio.h>

/* #define DEMO */

#ifdef DEMO

main()				/* a small main used for demonstration  */
{
	int n;

	char *char_str();
	char *center();
	

	for (n = 80; n > 40; n -= 4) {
	    puts(char_str(n, '.'));
	    puts(center("hello world", n));
	}
}

#endif

char *char_str(length, c)	/* based on length and character, return a  */
int length;			/*  pointer to string for use in            */
char c;				/*  centering, offsets, etc.                */
{
	static char loc[80];		/* space enough for filled strings  */
					/* note it is static; an auto       */
					/*  would evaporate upon return     */

	char *ptr = loc;		/* make a pointer point there       */
					/*  as it is declared               */
	while (length--)
	    *ptr++ = c;			/* fill in the string to length     */

	*ptr = '\0';			/* append null                      */

	return (loc);			/* return address of string         */
}


char *center(str,width)		/* returns a pointer to the same string as   */
char *str;			/*  passed, only centered within width       */
int width;
{
	static char buf[132];		/* location of finished string */

	char *char_str();
	char *strcat();
	
	strcpy(buf, char_str((width - strlen(str)) / 2, '\040'));

	strcat(buf, str);

	return (buf);
}
