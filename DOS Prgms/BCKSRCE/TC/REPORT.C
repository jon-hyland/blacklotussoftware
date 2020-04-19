/*  module title: report.c
 *  function name: void report()
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
 *  linked with: char *char_str(), int inchar()
 *  linked by:
 *
 *  problems: If the console or printer I/O streams return an error when
 *            the function is opened for writing, the function aborts with
 *	      an exit(). A total that exceeds the width of its column 
 *	      will mess up the output; choose a header string long enough.
 *
 *  description:
 *	This function decodes the first member (flag) of the structure to
 *      which the function's single parameter points and determines whether
 *      the invocation is a setup, print, or total command. Based on this
 *      information, the structure contents are used to set up page width,
 *      height, offset (from the left margin), number of rows per page, I/O
 *      device, and number of columns of printing. If the flag indicates
 *      that values should be printed, a pointer to an array of pointers to
 *      to doubles accesses values to be printed in each column. If the flag
 *      indicates the end, totals are printed at the bottom of each column.
 *
 *	Hard coded into the function are the facts that formatted conversions
 *	of numbers should be made with "%10.2f". (The System V C compiler
 *	printf() function accepts run-time-determined conversion parameters 
 *	and can be added if your compiler supports this feature.)
 *
 *	All columns are assumed to be the same width, and their associated 
 *	header strings are gauged by the header for the first column. This
 *	header must be at least 10 characters wide; if other headers are 
 *	narrower, they are right-justified within the space allowed.
 */

#include <stdio.h>			/* required because I/O selection is */
					/*  made based on a parameter passed */
struct info_block {
    int flag;				/* this flag determines how the      */
					/*  following pointer is interpreted */
    union {				/* the union supports passing        */
	struct init_block {		/*  either pointer to the init_block */
	    int io_device;		/*  structure or to the array of     */
	    int columns;		/*  doubles                          */
	    int offset;
	    int page_width;
	    int rows_per_page;
	    char **header_string;
	} *set_up;
	double *value;
    } on;
};					/* no identifier means no definition */
					/*  and keeps the structure          */
					/*  from being global                */

#define init info->on.set_up		/* these simplify lengthy            */
#define device copy->io_device		/*  data access constructions        */

#define SETUP 1				/* setup, total, and vals command    */
#define VALS 0				/*  assigned to flag that tells      */
#define TOTAL 2				/*  function information there       */

#define TERM_PAGE '\0' 			/* terminal page eject               */
#define LIST_PAGE 0xc			/* printer page eject                */
#define TERM_LINES 24
#define LIST_LINES 56

#define MAX_HEAD 132			/* maximum space allocated for       */
					/*  header string                    */

#define NUM_LENGTH 10			/* field width of numbers            */
#define COL_SPACE 3			/* space between columns             */

#define DEMO

#ifdef DEMO

main()					/* a demonstration main()            */
{
	int n;				/* all-purpose integer variable      */
	struct info_block *info;	/* pointer to structure of type      */
					/*  info_block                       */
	char *string[4];		/* array of four (uninitialized)     */
					/*  pointers to character strings    */
	double number[4];		/* likewise for four doubles         */

	void report();
	char *malloc();


	string[0] = "string 000";	/* create column titles              */
	string[1] = "string 1";
	string[2] = "string 002";
	string[3] = "string 3";

	number[0] = 234.56;		/* and data                          */
	number[1] = 876.54;
	number[2] = 753.10;
	number[3] = 468.12;
					/* make room for structures in memory*/
					/* convince compiler that what       */
					/*  malloc returns is a pointer to   */
					/*  these structure types            */

	info = (struct info_block *)malloc(sizeof(struct info_block));
	init = (struct init_block *)malloc(sizeof(struct init_block));

	if (!info || !init) {
	    puts("error allocating space for info or init");
	    exit(1);
	}

	info->flag = SETUP;			/* for setup mode            */

	init->io_device = 0;		   	/* 0=console, otherwise lst  */
	init->columns = 4;		       	/* 4 columns                 */
	init->offset = 5;		       	/* page offset of 5 columns  */
	init->page_width = 80;		       	/* console width             */
	init->rows_per_page = TERM_LINES;    	/* screen or page height     */
	init->header_string = string;       	/* address of first member   */
						/*  of array of pointers to  */
						/*  header strings           */

	report(info);		/* pass address of structure to              */
				/*  report function, this time for setup     */

	info->flag = VALS;	/* send the real values                      */

	info->on.value = number;	/* point value pointer at array  */
					/*  of doubles, which are usually*/
					/*  changed during course of     */
					/*  program                      */
	for (n = 0; n < 70; n++)
	     report(info);		/* print numbers     */

	info->flag = TOTAL;

	report(info);			/* print the totals   */

	free(init);
	free(info);
}

#endif


void report(info)		/* passed pointer to structure that contains */
struct info_block *info;	/*  setup/value/total command information    */
{
	int n;				/* all-purpose integer variable      */
	int head_length;		/* length of header                  */
	FILE *fp;
					/* the following are static so they  */
					/*  are remembered                   */
	static int max_length;		/* column width calculated from      */
					/*  first column header string,      */
	static int length_dif;		/* difference between maximum        */
					/*  column width and number field,   */
	static struct init_block *copy;	/* copy of init_block pointer        */
	static double *total;	        /* place where totals are kept,      */
					/*  accessed like an array           */
					/*  after size is determined,        */
	static char *head, *toe;	/* likewise for the head/toe strings */
	static char eject;		/* terminals & printers have unique  */
					/*  pagination commands              */
	static int rows = 3;		/* start on line 3: header, two      */
					/*  blank lines                      */

	FILE *fopen();
	char *calloc();
	char *malloc();
	char *strcat();
	char *char_str();

	if (info->flag == SETUP) {	/* check to see whether numbers      */
					/*  or setup or total command        */

	    fp = fopen((init->io_device) ? "PRN" : "CON","w");
	    if (!fp) {
		puts("error opening output stream");
		exit(1);
	    }

	    copy = init;		/* copy pointer to               */
					/*  init struct for later use;   */
					/*  assume that data is still in */
					/*  memory after setup call      */

				        /* make space for array of           */
					/*  doubles: total[], cast result so */
					/*  compiler will not complain       */

	    total = (double *)calloc(copy->columns,sizeof(double));

						/* initialize start values   */
	    for (n = 0; n < copy->columns; n++)
		total[n] = 0.0;
					/* set up eject code for pages       */

	    eject = (device) ? LIST_PAGE : TERM_PAGE;

					/* send 1 to start  */

	    putc(eject, fp);
	    				/* create 1 heading string from      */
					/*  the several received             */

	    head = malloc(MAX_HEAD);	/* assume head is not > MAX_HEAD     */
	    toe = malloc(MAX_HEAD);	/* space for the underlines          */

	    *head='\0', *toe='\0';	/* init first position of each so    */
					/*  strcat knows where to start      */

	    max_length = strlen(copy->header_string[0]);	/* biggest   */
	    length_dif = max_length - NUM_LENGTH;

					/* insert number of spaces equal     */
					/*  to offset from left              */

	    strcat(head, char_str(copy->offset, ' '));
    	    strcat(toe, char_str(copy->offset, ' '));

					/* make up a header string from the  */
					/*  pieces, and the toe string       */

	    for (n=0; n < copy->columns; n++) {
		head_length = strlen(copy->header_string[n]);

		strcat(head, char_str(max_length - head_length, ' '));
		strcat(head, copy->header_string[n]);
		strcat(head, char_str(COL_SPACE, ' '));
							
		strcat(toe, char_str(length_dif, ' '));
		strcat(toe, char_str(NUM_LENGTH, '='));
		strcat(toe, char_str(COL_SPACE, ' '));

	    }
					/* print header and two newlines,    */
					/* now on row 2, (0,1,2)             */

	    fprintf(fp, "%s\n\n", head);

	}
	else if (info->flag == TOTAL) {		/* the total command         */
	
	    fprintf(fp, "%s\n", toe);		/* mark each column with '=' */
						/*  and add margin, next line*/

	    fprintf(fp, "%s", char_str(copy->offset, ' '));

	    for (n=0; n < copy->columns; n++) {  /* the totals               */

	        fprintf(fp, "%s", char_str(length_dif,' '));
	        fprintf(fp, "%10.2f%s", total[n], char_str(COL_SPACE, ' '));
	    }
	
	    putc('\n', fp);			/* add newline at end  	     */
	    fflush(fp);
	
	    free(total);			/* don't be piggish because  */
	    free(head);				/*  you're done now          */
	    free(toe);
	    if (fp != stdout)			/* going to a real file?     */
		fclose(fp);			/* close it 		     */

	}
	else {			/* print another line of numbers        */

	    if (rows++ == copy->rows_per_page) {	/* eject when get    */
	    	                          		/*  too many lines;  */
		if (!device)	{			/*  if console, pause*/
		    fprintf(fp, "Press any key to continue");
		    fflush(fp);
		    inchar();				/* stop until a      */
							/*  key pressed,     */
							/*  then erase it    */
		    fprintf(fp, "\r                         \n");
		}
    	        putc(eject, fp);
		rows = 3;				/* and print header  */
	         					/*  plus 2 newlines  */
	    	fprintf(fp, "%s\n\n", head);
	    }
					/* print the numbers here     */

	    fprintf(fp, "%s", char_str(copy->offset, ' '));
	    for (n = 0; n < copy->columns; n++) {

	        fprintf(fp, "%s", char_str(length_dif, ' '));
		fprintf(fp, "%10.2f%s", info->on.value[n], char_str(COL_SPACE, ' '));
	        total[n] += info->on.value[n];
	    }

	    putc('\n', fp);			/* add newline at end  	     */

	}
}

