/*  module title: list.c
 *  function names: main()
 *		    void banner()
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
 *  linked with: void get_time()
 *  linked by:
 *
 *  problems: if line numbers are requested, program will always indicate 
 *	      one more line than really exists in the file because the line
 *	      number is printed before the next character is retrieved
 *	      from the file
 *
 *  description: This print utility for source code prints a banner at the top
 *		 and bottom of a page, which can be seen after the listing
 *		 has been bound. Optional line numbers can be printed, but
 *		 the maximum line number provided for (by virtue of its print
 *		 spec: '%4d') is 9999.
 */

#include <stdio.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

FILE *fp_out;				/* need this (printer) to be         */
					/*  usable throughout the module     */
main(argc,argv)
int argc;
char *argv[];
{
					/* tab locations */
    static int tab[] = {
	8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128
    };
    int c;
    int i;
    int lines;  			/* TRUE means you want line numbers */
    int page;
    int on_line;  			/* line you are on      */
    int on_page;			/* page you are on      */
    int on_char;			/* character you are on */
    int to_col;
    FILE *fp_in;

    FILE *fopen();
    void banner();

    if (argc < 2) {
        printf("list: usage: list [-n] filename [filename [filename [...]]]\n");
        exit(0);
    }
	
    if (!(fp_out = fopen("PRN", "w"))) {
	printf("list: can't open printer stream\n");
	exit(1);
    }

    lines = FALSE;			/* assume do not want line numbers */

    for (i = 1; i < argc; i++) {

	if (argv[i][0] == '-') {	/* have a flag?         */
	    if (argv[i][1] == 'n')
	        lines = TRUE;		/* if right, set up     */
	    continue;			/*  test variable       */
	}

	fp_in = fopen(argv[i], "r");
	if (!fp_in) {
	    printf("list: %s can't be opened\n", argv[i]);
	    continue;
	}

	on_line = 1;			/* reset variables for this file */
	page = 1;

        putc('\f', fp_out);
	banner(1, argv[i], page);	/* first call to banner sets the */

	on_page = 4;			/*  time for entire listing      */
	on_char = 0;

	if (lines)
	    fprintf(fp_out, "%4d: ", on_line);

	while ((c = getc(fp_in)) != EOF) {
            if (c == '\t') {		       /* moving sideways with a tab */
	        to_col = tab[on_char / 8];
	        while (to_col - on_char) {
	   	    putc(' ', fp_out);
		    on_char++;
		}
	    }
	    else {			/* moving down with \n or \f         */
		if (c == '\f') {	/*  or a regular character           */
		    while (++on_page < 58)
			putc('\n', fp_out);
		}
	 	else {
		    if (c == '\n') {
		        on_char = 0;
		        on_page++;
			on_line++;
		    	putc(c, fp_out);
						         /* set up next line */
			if (lines && on_page != 58)	 /*  if on this page */
			    fprintf(fp_out, "%4d: ", on_line);
		    }
		    else {
		    	putc(c, fp_out);
		        on_char++;
		    }
		}
	        if (on_page == 58) {		/* if we reach bottom,       */
		    fputs("\n\n", fp_out);	/*  divide text from banner, */
		    banner(0, argv[i], page++);	/*  print banner; this       */
		    putc('\f', fp_out);		/*  argv parameter just takes*/
		    banner(0, argv[i], page);	/*  up space                 */
		    if (lines)
		        fprintf(fp_out, "%4d: ", on_line);    
		    on_page = 4;
		    on_char = 0;
		}
            }
	}
        while (++on_page < 61)
    	    putc('\n', fp_out);
	banner(0, argv[i], page);
    }
}

	
void banner(flag,name,page)	/* print banner at fp_out including time,    */
int flag;			/*  date, file name, and page number; fix    */
char *name;			/*  time at call flag when <> 0              */
int page;
{
	static char header[80];		/* space for header */
	static char time[40];		/* space for time/date */
	void get_time();		/* puts d-o-w, time/date at point-*/
					/*  er where it is passed points  */
	if (flag) {
	    get_time(time);
            sprintf(header, ">>>> %s   %s   page: ", name, time);
	}
	fprintf(fp_out, header);
	fprintf(fp_out, "%03d\n\n", page);

}

