/*   module title: getnlin.c
 *  function name: int getnlin()
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
 *  linked with: void window()
 *  linked by:
 *
 *  problems:
 *
 *  description: gets a string from stdin of up to n characters and places
 *		 characters at location indicated by ptr
 */

#include <stdio.h>

int getnlin(ptr,n)	/* get up to n characters from stdin, stop at        */
char *ptr;		/*  EOF or newline, put characters at pointer        */
int n;
{
	int c;				/* all-purpose character variable    */

	while ((c = getchar()) != '\n' && c != EOF && --n) {
	    *ptr++ = c;
	}
	
	*ptr = '\0';			/* finish with null                  */

	return (c == EOF);		/* tell parent function if program   */
					/*  aborted or reached EOF           */
}

