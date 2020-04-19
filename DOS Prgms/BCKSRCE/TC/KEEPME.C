/*  module title: keepme.c
 *  function name: int keep_me()
 *		   main() for demo
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
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: demonstration function to introduce file I/O
 *		 and handle command line arguments
 *
 */

#include <stdio.h>
#include <ctype.h>

				/* demonstration main()                      */

main(argc,argv)			/* take one parameter from command line:     */
int argc;			/* copy console characters to file specified */
char *argv[];			/* on command line                           */
{
	int count;		/* so can report number of characters saved  */
	int keep_me();

	if (argc != 2) {				/* report incorrect  */
	    puts("keepme: usage: keepme filename");	/* invocation        */
	    exit(1);
	}

	count = keep_me(argv[1]);		/* tells keep_me to use this */
						/*  file name to store data  */
	printf("\n%d characters kept\n", count);
}


int keep_me(name)		/* passed a pointer to character string as   */
char *name;			/*  file name to copy stdin keystrokes to;   */
{				/*  returns characters stored                */

	int c;				/* all-purpose character variable    */
	int count = 0;			/* returns the count of chars        */
					/*  stored; start at 0               */
	FILE *fp;			/* a pointer to data of type FILE    */
					/*  a cleverly disguised structure   */
					/*  defined in stdio.h               */
	FILE *fopen();

	fp = fopen(name, "w");		/* open file                         */

	if (!fp)			/* NULL return means trouble;        */
					/*  say so and return count = 0      */
	    printf("\nCan't open %s, returning to DOS",name);

	else {
	    printf("\nKeeping characters in %s.", name);
	    puts("\nEnter your message here:");
	
	    while ((c = getchar()) != EOF) {    /* stops at EOF, see stdio.h */
						/*  usually ctrl-Z or D      */
	  	if (!isprint(c) && c != '\n') 	/* do not store unprintable  */
		    continue;			/*  characters, except \n    */
		putc(c, fp);			/*  puts them in file        */
		count++;			/*  and increments count     */
		if (c == '\n')
		    count++;			/* putc in the w mode makes  */
						/*  two characters out \n    */
	    }					/*  a cr/lf pair is stored   */
	}
	
	fclose(fp);				/* must close file or all    */
						/*  is lost                  */
	return (count);				/* return number saved       */
}
