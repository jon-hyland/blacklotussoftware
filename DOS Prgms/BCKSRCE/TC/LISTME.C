/*  module title: listme.c
 *  function name: int list_me()
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
 *  linked with: int inchar()
 *  linked by:
 *
 *  problems: none known
 *
 *  description: simple file-listing utility to demonstrate file I/O and
 *               redirection effects; if the destination is stdout (the
 *		 console), the function pauses after each screenful to wait 
 *		 for user input; returns # of characters listed
 */

#include <stdio.h>

#define PAGE 23

main(argc,argv)		/* simple main included for demonstration            */
int argc;  		/*  purposes only; tell listme() which file to open  */
char *argv[];		/*  and where to send output			     */
{
	int count;

	int listme();

	if (argc < 2 || argc > 3) {
	    puts("\nlistme: usage: listme src [dst]");
	    exit(1);
	}

	/* if only two arguments passed, give a null string as second        */
	/* to listme(); otherwise, pass name of output file                  */
						
	count = listme(argv[1], (argc < 3) ? "" : argv[2]);

	printf("\n%d characters listed", count);

}

int listme(src, dst)		/* open src file and send to destination     */
char *src;			/*  file; the parameters are file names      */
char *dst;			/* dst is null if stdout is desired: console */
{
	int c;			/* all-purpose character variable,           */
	int count = 0;		/*  returns the number of characters         */
				/*  processed                                */
	int line = 0;		/* keeps track of number of lines sent       */

	FILE *fp_src;
	FILE *fp_dst;		/* pair of pointers to structures of         */
				/*  FILE type	         		     */

	FILE *fopen();
	int inchar();
	

	if (!(fp_src = fopen(src, "r"))) {	/* much done here:           */
	    printf("\nCan't open %s.", src);	/* open file if error; that  */
	    return (count);			/*  is, if pointer returned  */
	}					/*  is null, return          */
						/*  after printing message   */
	if (strlen(dst) == 0)
	    fp_dst = stdout;			/* way to get to            */
	else					/*  console indirectly      */
	    fp_dst = fopen(dst, "w");		/*  unless a file name is    */
						/*  used                     */
	
	if (!fp_dst) 				/* make same check on        */
	     printf("\nCan't open %s.", dst);	/*  output file as on        */
						/*  input file; error falls  */
						/*  through to fclose below  */
	else {
	    while ((c = getc(fp_src)) != EOF) {	/* if all well, copy input   */
		count++;			/*  to output while there is */
		putc(c, fp_dst);		/*  more left		     */
		if (c == '\n') {
		    count++;			/* because each \n           */
		    line++;			/*  really represents \n\r   */
		    if (fp_dst == stdout) {	/*  on output                */
			if (!(line % PAGE)) {	/*  at each page, if stdout, */
			    fprintf(fp_dst, "RETURN");
			    fflush(fp_dst);	/* ensure RETURN is written  */
						/*  to console		     */
			    inchar();		/*  pause for input          */
			    fprintf(fp_dst, "\b\b\b\b\b\b      \b\b\b\b\b\b");
			    fflush(fp_dst);
			}
		    }
		}
	    }
	}

	fclose(fp_src);				/* be sure to clean up     */

	if (fp_dst != stdout)			/* do not close stdout     */
	    fclose(fp_dst);

	return (count);

}

