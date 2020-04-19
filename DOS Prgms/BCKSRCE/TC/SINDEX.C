
/*    module title: sindex.c
 *  function names: int sindex()
 *
 *  author: Kim J. Brand
 *  
 *  revision history:	
 *     version/--date--/by  reason--------------------------------------------
 *       1.0   10/01/84 kb  Common C Functions initial release
 *   
 *  compiled with:
 *  compiled by:
 *
 *  linked with: int scan()
 *  linked by:
 *
 *  problems:
 *
 *  description: returns the integer location of a given character in the
 *		 string argument or -1 on return  
 *
 */

int sindex(ptr,c)		/* locate the position of a specified        */
char *ptr;			/*  character inside a string                */
int c;
{
	int n = 0;
	int length;

	length = strlen(ptr);		/* find length of string             */

	while (*ptr != c && *ptr++)
	   n++;

	return ((length == n) ? -1 : n);
}
