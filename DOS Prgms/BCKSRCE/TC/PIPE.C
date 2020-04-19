/*  module title: pipe.c
 *  function name: main() for demo
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
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: just echos stdin to stdout; in an MS-DOS/UNIX environment the
 *		 command line can define source and destination streams; if
 *	         the flag '-b' is included on the command line, bit seven
 *		 of each character is reset
 */

#include <stdio.h>

main(argc,argv)			/* only a demonstation program		     */
int argc;			/* command line arguments supplied           */
char *argv[];			/* array of pointers to the words there      */
{
	char c;			/* the character that gets moved in/out      */
	char flag;

	if (argc > 2 || *argv[1] == '?' || (argc == 2 && *argv[1] != '-')) {
	    fputs("Usage: pipe <source >destination [-b]\n",stderr);
	    fputs("  the -b flag strips high bits during transfer",stderr);
	    exit(1); 
	}   

	flag = (*(++argv[1]) == 'b' ? 0x7f : 0xff); 	

	while ((c = getc(stdin)) != EOF) 	/* until we see end of file  */
	    putc(c & flag,stdout);		/*  just keep copying        */

}
