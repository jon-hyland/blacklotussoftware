
/*    module title: blank.c
 *  function names: void blank()
 *		
 *  author: Kim J. Brand
 *  
 *  revision history:	
 *     version/--date--/by  reason--------------------------------------------
 *       1.0   10/01/84 kb  Common C Functions initial release
 *   
 *  compiled with: stdio.h
 *  compiled by:
 *
 *  linked with: void place()
 *  linked by:
 *
 *  problems:
 *
 *  description: blank() uses place() to position the cursor and write spaces 
 *	         from there for a specified width
 */

#include <stdio.h>


void blank(row,col,width)	/* start at row,col and for width places     */
int row;			/* print spaces                              */
int col;
int width;
{
	void place();

	place(row, col);

	while (width--)
	    putchar(' ');
}

