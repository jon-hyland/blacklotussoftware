/*  module title: saygetmv.c
 *  function names: void say(), void get(), void move()
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
 *  linked with: calc.c
 *  linked by:
 *
 *  problems:
 *
 *  description: simple input, output, and string (memory) move functions
 *
 */

#include <stdio.h>

void move(dst,src)	/* moves the characters pointed to by src            */
char *dst;	        /*  to where the destination pointer points          */
char *src;
{
	do
	    *dst++ = *src;	/* a way that does not require an            */
	while (*src++);		/*  intermediate character variable;         */
				/*  note: also moves the null if the         */
 			        /*  source string is of zero length          */
/*
 *	char c;
 *
 *	while (c=*src++)	this way, although equivalent, is
 *	    *dst++ = c;		less efficient 
 *	*dst = c;
 */

}

void say(ptr)		/* prints string pointed to by pointer, on the       */
char *ptr;		/*  stdout device, usually the console               */
{
	char c;

	while (c = *ptr++)	/* all strings in C end with a null; in this */
	    putchar(c);		/*  case, that's what stops the music        */

}

void get(ptr)			/* simple function to get a string of chars  */
char *ptr;			/*  from stdin (usually the console) and put */
{				/*  them at the address passed               */

	char c;			/* all-purpose character variable            */

	while ((c = getchar()) != '\n') /* keep getting characters until */
	    *ptr++ = c;			/*  a newline is reached         */

	*ptr = '\0';			/* remember to place the null    */

}
