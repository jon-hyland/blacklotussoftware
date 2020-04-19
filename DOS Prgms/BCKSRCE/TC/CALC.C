/*  module title: calc.c
 *  function name: main() for demo
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
 *  linked with: void _atoi(), _itoa(), get(), move(), say()
 *  linked by:
 *
 *  problems:
 *
 *  description: a four-function integer calculator to demonstrate the use
 *		 of console input/output and ascii-integer-ascii conversion
 */

#include <stdio.h>

main()					/* this is the whole program         */
{
	int c;				/* a character holder that can take  */
					/*  on the value of EOF (-1)         */
	int n;				/* all-purpose counters              */
	int i;
	int number[6];			/* space for 6 numbers plus          */
	int answer;			/*  an answer                	     */
	char string[6][10];
	char result[10];		/* numbers represented as ascii      */
					/*  character strings, 6 each of 8+1 */
					/*  characters long; 1 is for        */
					/*  the null; result is the answer   */
	
	void say();
	void get();
	void move();
	void _itoa();
	int _atoi();

	say("\nCOMMON C FUNCTIONS");		/* a little vanity           */
	say("\n4 FUNCTION CALCULATOR\n");

	for (;;) {				/* this means forever        */
	    
	    answer = 0;				/* initialize answer to zero */
						/*  every time through loop  */
	    for (n = 0; n < 6; n++) {
		putchar(':');			/* tells user when new       */
						/*  numbers are expected     */

		get(string[n]);			/* returns ascii version     */
		            			/*  of the number            */
						/* an entry with a null      */

		if (string[n][0] == 0) 		/* a null first character    */
		    break;			/*  signals the person is    */
						/*  done entering numbers    */
	    }
		
	    for (i = 0; i < n; i++)  		/* for number of strings     */
		number[i] = _atoi(string[i]);	/* note that atoi gets the   */
						/*  address of the string    */

	    putchar('?');			/* tells user to enter       */
						/*  an operator              */
	
	    switch (c = getchar()) {
	
		case '*':			/* multiply                  */
		    answer = number[0] * number[1];
		    _itoa(result, answer);
		    break;

		case '-':			/* subtract                  */
		    answer = number[0] - number[1];
		    _itoa(result, answer);
		    break;

		case '+':			/* add                       */
		    for (i = 0; i < n; i++)
		        answer += number[i];
		    _itoa(result, answer);
		    break;

		case '/':			/* divide                    */
		    answer = number[0] / number[1];
		    _itoa(result, answer);
		    break;

	 	case EOF:
		    exit(0);			/* the way you leave         */

		default:			/* anything else             */
		    move(result, "BAD DATA");
		    break;
	    }

	    putchar('=');			/* only ascii strings may be */
	    say(result);			/*  passed to say()          */
	    say("\n\n");			/*  one at a time            */

	}
}

