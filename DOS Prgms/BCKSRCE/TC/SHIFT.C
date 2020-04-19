/*  module title: shift.c
 *  function name: int *shl_string()
 *		   void *shr_string()
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
 *  linked with: int scan()
 *  linked by:
 *
 *  problems:
 *
 *  description: shifts a string left and right in memory, into spaces on the 
 *		 left or into oblivion on the right; for left shift, if 
 *		 not enough room, function returns a nonzero result; 
 *               fill on the right (or left) with the insert character
 *		 and stop shifting when the limit character is reached
 */

#include <stdio.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

int shl_string(s,insert,limit)		/* shifts string left if can into    */
char *s;				/*  leading spaces and returns TRUE, */
char insert;				/*  else returns FALSE               */
char limit;
{
	char c;

	if (*s++ != ' ')		/* for shift left, must be at    */
	    return FALSE ;		/*  least one space on the left  */

	while ((c = *s) != limit) { 	/* as long as do not                 */
	    *(s - 1) = c;		/*  reach limit character, move      */
	    s++;			/*  the character left one step      */
	}
	
	*(s - 1) = insert;		/* slip in the insert character now  */
					/*  that there's room                */
	return TRUE ;
}


void shr_string(s,limit)		/* pass a pointer to the original    */
char *s;				/*  string; limit can be flag        */
char limit;				/*  character or end-of-string null  */
{
	char c;				/* an all-purpose character variable */
	char temp = ' ';		/*  initialized with space; fill     */
					/*  character later used to move     */
					/*  characters found                 */
	while ((c = *s++) != limit) {
	    *(s - 1) = temp;
	    temp = c;
	}
}

