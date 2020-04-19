/*  module title: amort.c
 *  function names: void amort()
 *		    main() for demo 
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *    version/--date--/by reason--------------------------------------------
 *      1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h
 *  compiled by:
 *
 *  linked with: int inchar()
 *		 char *center()
 *  linked by:
 *
 *  problems:   reformatting of output is required for amounts over
 *              $999999.99 because float field width is specified as %9.2
 *
 *  description:  amortizes a principal amount over the number of periods
 *                specified at a periodic interest rate (the interest   
 *		  rate charged per period); sends output to console or
 *		  printer; sends form feeds if printer and pauses at each 
 *		  page if console
 */

#include <stdio.h>

#define PRNTR_PAGE 56		/* leaves room for the MARGIN		     */
#define CONSOLE_PAGE 19
#define EJECT '\f'		/* may be printer dependent                  */
#define START 9			/* number of line from top of page at        */
				/*  which to start                           */
#define MARGIN 5		/*  top and bottom margins                   */

#define DEMO

#ifdef DEMO
				/* demonstration main for amort()            */
main()				/* this main sets up the number of           */
{				/*  periods, payment per each, principal,    */
	double pmt_period;	/*  periodic interest rate, and starting     */
	int no_periods;		/*  period for the report (does not have to  */
	double principal;	/*  be the first)                            */

	double ppr;		/* periodic percentage rate: the interest    */
				/*  charged per each period                  */
	int start_period;
	int io_device;		/* user selects console or printer           */

	void amort();

	/* watch out for some compilers that do not flush non-newline       */
	/* terminated string to the screen; you may need to add fflush()s   */
	/* after the printf()s if this happens 				    */

	printf("\nEnter the number of periods --> ");
	scanf("%d", &no_periods);

	printf("\nEnter the payment per period --> ");
	scanf("%lf", &pmt_period);

	printf("\nEnter the principal amount --> ");
	scanf("%lf", &principal);

	printf("\nEnter the periodic interest rate --> ");
	scanf("%lf", &ppr);

	printf("\nEnter the starting period --> ");
	scanf("%d", &start_period);

	printf("\nSend output to console (0) or printer (1) --> ");
	scanf("%d", &io_device);

						/* let amort function do */
						/*  all the work         */

	amort(pmt_period, no_periods, principal, ppr, start_period, io_device);

}

#endif


void amort(pmt_period, no_periods, principal, ppr, start_period, io_device)
double pmt_period;
int no_periods;
double principal;
double ppr;
int start_period;
int io_device;
{
	int pmt;			/* a temporary payment number        */
	double interest;		/* periodic interest                 */
	double amortized;		/* amount of the loan amortized      */
					/*  per each payment                 */
	int pmt_no = start_period;	/* payment to start with             */
	double balance = principal;     /* what is left                      */
	double tot_interest = 0.0;	/* accumulated interest              */
	int lines = START;		/* number of lines used up with      */
					/*  heading before first line        */
					/*  of calculated report             */
	FILE *fp;			/* I/O stream where output goes      */

	FILE *fopen();
	char *center();

	if (io_device)			/* these special file names do not   */
	    fp = fopen("PRN", "w");	/*  cause file to be created, just   */
	else				/*  I/O channel to be opened         */
	    fp = stdout;

	if (io_device)			/* you may want to check for failure */
	    fputc(EJECT, fp);		/* start new page                    */

	fprintf(fp, "\n%s\n", center("Loan Amortization Table",56));

	fprintf(fp, "\n\t    Payment per Period = $%10.2f", pmt_period);
	fprintf(fp, "\n\t    Number of Periods  =  %10d", no_periods);
	fprintf(fp, "\n\t    Principal Amount   = $%10.2f", principal);
	fprintf(fp, "\n\t    Periodic Interest  =  %10.4f", ppr);
	fprintf(fp, "\n\t    Starting Period    =  %10d\n", start_period);

	/* figure where we are in amortization table based on when we were   */
	/*  told to start displaying the figures                             */

	for(pmt = 1; pmt < pmt_no; pmt++) {
	    tot_interest += (interest = balance * ppr);
	    balance -= pmt_period - interest;
        }

	while (balance != 0) {		/* loop continues until the          */
					/*  balance due is calculated        */
					/*  to be or set to zero, when       */
					/*  no_periods is counted down to 0  */
					
					/* print header			     */
	    fprintf(fp, "\n                  Appl'd to             Prnc'pl   Accum");
	    fprintf(fp, "\n Period  Payment  Principal  Interest   Balance  Interest\n\n");

	    do {		/* do for each line on the page up           */
				/*  to the max on the page, then start over  */
				/*  by printing a form feed and a new heading*/
				/*  by escaping to the outer while           */

	        tot_interest += (interest = balance * ppr);

	        amortized = pmt_period - interest;

	     	if (balance - amortized < 0 || pmt_no == no_periods) {
		    pmt_period = balance + interest;
		    amortized = balance;
		    balance = 0;
		}
		else
		    balance -= amortized;
						/* print all data here       */
		fprintf(fp, " %5d", pmt_no);
		fprintf(fp, " %9.2f  %9.2f %9.2f %9.2f %9.2f\n",
			pmt_period,amortized,interest,balance,tot_interest);

		++pmt_no;			/* increment payment number  */

	    } while (lines++ < (io_device ? PRNTR_PAGE-MARGIN : CONSOLE_PAGE)
				 && balance != 0);

	    if(io_device)
		fputc(EJECT, fp);
	    else {
		fprintf(fp, "\nPress return to continue...");
		fflush(fp);			/* ensure message prints     */
		inchar();			/* just want to stop         */
						/*  until a key is pressed,  */
						/*  then erase the line      */
		printf("\r                           \n");
	    }

	    if(io_device)
	        for (lines = 0; lines < MARGIN; lines++)/* offset from       */
		    fputc('\n',fp);			/*  the bottom       */
	    else
		lines = 0;

	}  /* end of while on number of periods */

	fclose(fp);

}

