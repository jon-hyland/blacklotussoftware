/*  module title: scan.c
 *  function names: void reprint(), scan(), toggle_attributes(), update()
 *		    int compare_mask()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h, ctype.h, scan.h
 *  compiled by:
 *
 *  linked with: int inchar(), sindex()
 *		 char *adv(), *shl_string(), *shr_string()
 *		 void place()
 *  linked by:
 *
 *  problems:  The high frequency of console I/O demanded by this function
 *	       requires the use of the nonportable I/O functions:
 *
 *		     place()		set_cursor()
 *		     bump()		inchar()
 *		     outchar()		at_say()
 *
 * 	       The program will probably work with little or no modification
 *	       as long as the target machine includes I/O interrupt services 
 *	       similar to those of the IBM PC. (The program was developed on
 *	       an NEC APC-III.)
 *
 *	       Right-justified fields should not be given masks that contain
 *	       special characters ('/' or '-') or masks with a combination
 *	       of types ('999XXAA') because the input string is shifted left
 *	       with each new entry and the input verification always fails.
 *
 *  description: implements a form of the dBASE II command:
 *
 *		     @ x,y say 'string' get 'variable' picture 'mask'
 *
 *	         can produce a data entry screen with prompts, 
 *		 highlighted windows with various entry options,
 *		 and context-sensitive help
 */

#include <stdio.h>
#include <ctype.h>
#include "scan.h"

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define C86 				/* to permit use of nonstandard      */
					/*  library functions that           */
					/*  give access to the interrupt     */
					/*  system and BIOS calls            */
				
#define OTHER				/* option uses standard library      */
					/*  memory allocation                */

#ifdef OTHER

#define getmem(x) malloc(x)		/* getmem is complemented by rlsmem  */
					/*  for LATTICE C. C86 and most other*/
					 /* C compilers use malloc and free  */

#endif

#ifdef C86				/* memory allocation method called   */

#define int86(x,y,z) sysint(x,y,z) 	/* other changes for going to C86    */
#define intdos(x,y) sysint21(x,y)	/*  note: C86 requires -us flag for  */
#define atol(x) atoi(x)			/*  compiling this and other modules */
					/*  that use it                      */
#endif


struct _data *data;			/* pointer to array of temporary     */
					/*  structures used to hold data     */

int scan(ptr)  				/* the scan function                 */
struct _scan ptr[];
{
	static char space[80];		/* place to store input characters  */
	char *work_space;		/* auto pointer to input characters */

	int c;				/* local character holder, must be   */
	int temp;			/*  int so large scan codes can be   */
					/*  returned                         */

	int n;				/* counters                */
	int i;
	int j;

	int fields;			/* stores number of fields           */
	char *mask_ptr;			/* local copy of a pointer to the    */
					/*  mask string, speeds things up    */

	char *getmem();
	char *strcpy();
	int sindex();
	void at_say();
	void bump();
	void place();
	void reprint();
	void set_cursor();
	void toggle_attributes();
	void update();
	void wrt_chrs();
	int shl_string();
	void shr_string();
	void outchar();
	int inchar();
	int compare_mask();

#ifdef OTHER
	int free();
#else
	int rlsmem();
#endif

	for (i = 0; ptr[i].row != END; i++)
	    ;				/* find out how many elements are    */
					/*  in the scan structure            */
	fields = i;

	data = (struct _data *)getmem(i * sizeof(struct _data));
	if (!data) {
	    puts("getmem data failed");
    	    exit(1);
	}
	setmem(data,i * sizeof(struct _data),0);
	
					/* for each field, make a place for  */
					/*  and initialize its data structure*/
	for (i = 0; i < fields; i++) {
	    data[i].mask_chars = getmem(ptr[i].width+1);
	    data[i].entry_chars = getmem(ptr[i].width+1);
	    if (!data[i].mask_chars || !data[i].entry_chars) {
		puts("getmem mask_chars or entry_chars failed");
	 	exit(1);
	    }
	    setmem(data[i].mask_chars, ptr[i].width + 1, 0);
	    setmem(data[i].entry_chars, ptr[i].width + 1, 0);
	    data[i].attribute = FALSE;
	    data[i].field_character = '\040';
	    data[i].ring_flag = FALSE;
	    data[i].right_flag = FALSE;
	    data[i].show_flag = FALSE;
	    data[i].dot_flag = FALSE;
	    data[i].dot_yet = FALSE;
	    data[i].full_flag = FALSE;
	    data[i].data_yet = FALSE;
	    data[i].replace = FALSE;
	    data[i].max_column = 0;
	}
	
	set_cursor(0);				/* determine all the         */
	for (n = 0; n < fields; n++) {		/*  options selected and set */
	    mask_ptr = ptr[n].mask;		/*  flags for each field     */
						/* increment through the mask*/
	    i = 0;
	    while (c = *mask_ptr++) {
		switch (c) {
		    case '.':
			data[n].dot_location = i;      /* fixed characters   */
			data[n].dot_flag = TRUE;       /*  in the mask have  */
		    default:			       /*  bit 7 set as a tag*/
			c |= 0x80;
		    case '9':			       /* all special        */
		    case 'A':			       /*  characters are put*/
		    case 'X':			       /*  in local mask     */
		    case '!':
			data[n].mask_chars[i++] = c;
			++data[n].max_column;
			break;
		    
		    case '%':				/* marks the type    */
			data[n].data_type = *mask_ptr++;
			break;
		    
		    case '[':				/* indicates window  */
			data[n].attribute = TRUE;
			break;
		    
		    case '|':				/* marks the field   */
       		    	data[n].field_character = *mask_ptr++;
		    	break;
		    
		    case '*':				/* want bells        */
		    	data[n].ring_flag = TRUE;
		    	break;
		    
		    case '>':				/* right-justified   */
		    	data[n].right_flag = TRUE;
		    	break;
		    
		    case '^':				/* <cr> required     */
		    	data[n].full_flag = TRUE;
		    	break;
		    
		    case '@':				/* use default value */
		    	data[n].show_flag = TRUE;
		    	break;

		    case '<':				/* replace prompt    */
		    	data[n].replace = TRUE;		/*  with field       */
		    	break;
		}
	    }

	    data[n].cursor_col = data[n].min_column = 
		ptr[n].col + strlen(ptr[n].prompt);

	    if (data[n].replace)
	        data[n].max_column += ptr[n].col;
	    else
	        data[n].max_column += data[n].min_column;

					/* cause existing value in      */
					/*  variable to show if desired */
	    setmem(work_space = (char *)space, 80, 0);
					/* init work_space to point at space */

	    j = 0;
	    while (c = data[n].mask_chars[j])
	        data[n].entry_chars[j++] = (c & 0x80) ? c & 0x7f : '\040';

	    if (data[n].show_flag) {	/* show any pre-existing value */
		switch(data[n].data_type) {
		    case 'd':		/* a long */
			if (*(long int *)ptr[n].field != 0)
			    data[n].data_yet = TRUE;
			sprintf(work_space, "%ld", *(long int *)ptr[n].field);
			if (data[n].right_flag)
			    j = strlen(data[n].entry_chars) - strlen(work_space);
			else
			    j = 0;
			goto move_it;
			
		    case 'f':		/* a float */
			if (*(float *)ptr[n].field != 0)
			    data[n].data_yet = TRUE;
			sprintf(work_space, "%8.2f", *(float *)ptr[n].field);
			j = data[n].dot_location - sindex(work_space,'.');
			goto move_it;
			
		    case 's':		/* a string */
			if (strlen(ptr[n].field) && strcmp(ptr[n].field, data[n].entry_chars))
			    data[n].data_yet = TRUE;
                	strcpy(work_space, ptr[n].field);
			if (data[n].right_flag)
			    j = strlen(data[n].entry_chars) - strlen(work_space);
			else
			    j = 0;
			    
	move_it:        while (c = *work_space++)
			    data[n].entry_chars[j++] = c;
			break;
		}
   	    }
	    reprint(&ptr[n], n, OFF_ATTR);	/* print field contents	     */
						/* print opening prompt      */

	    if (!data[n].replace || !data[n].data_yet)
	        at_say(ptr[n].row, ptr[n].col, ptr[n].prompt, OFF_ATTR);

					/* adjust opening cursor position    */
					/* based on field contents	     */
	    if (data[n].dot_flag)
		data[n].cursor_col = data[n].min_column + data[n].dot_location;
	    else if (data[n].right_flag)
		data[n].cursor_col = data[n].max_column;
	    else if (data[n].replace && data[n].data_yet) {
		for (i = ptr[n].width - 1; data[n].entry_chars[i] == '\040'; i--)
		    ;
		data[n].cursor_col = ptr[n].col + i + 1;
		data[n].min_column = ptr[n].col;
	    }
	    else
		data[n].cursor_col = data[n].min_column;
	}

	set_cursor(1);				/* turn cursor on	     */
	n = 0;					/* set up the first          */

	toggle_attributes(ON, &ptr[n], n);
	place(ptr[n].row, data[n].cursor_col);

	while ((c = inchar()) != EOF) {
	    switch (c) {
		case UP_ARROW:				/* when move out of  */
    up:		    toggle_attributes(OFF, &ptr[n], n);	/*  field, turn off  */
		    update(&ptr[n], n);			/*  attributes       */
		    if (--n < 0)			/*  and turn on next */
			n = 0;				/*  one's           */
		    toggle_attributes(ON, &ptr[n], n);
		    place(ptr[n].row, data[n].cursor_col);
		    break;
		    
		case RETURN:
    ret:
    		case DOWN_ARROW:
    down:	    toggle_attributes(OFF, &ptr[n], n);
		    update(&ptr[n], n);
		    if (++n == fields)
			goto goback;

		    toggle_attributes(ON, &ptr[n], n);
		    place(ptr[n].row, data[n].cursor_col);
		    break;
		    
		case LEFT_ARROW:
    left:	    if (!data[n].dot_flag && !data[n].right_flag) {
			if (--data[n].cursor_col < data[n].min_column) {
			    data[n].cursor_col = data[n].min_column;
			    goto up;
			}
			if (*(data[n].mask_chars + OFFSET(n)) & 0x80)
			    --data[n].cursor_col;
			place(ptr[n].row, data[n].cursor_col);
		    }
		    break;
		    
		case RIGHT_ARROW:
    right:    	    if (!data[n].dot_flag && !data[n].right_flag) {
			if (++data[n].cursor_col >= data[n].max_column) {
			    data[n].cursor_col = data[n].min_column;
			    goto down;
			}
				/* note that fixed characters in field    */
				/*  use bit 7 as a flag	                  */
			if (*(data[n].mask_chars + OFFSET(n)) & 0x80)
			    ++data[n].cursor_col;
			place(ptr[n].row, data[n].cursor_col);
		    }
		    break;
		    
    
		case CLEAR:
    clear:	    i = 0;
		    while (c=data[n].mask_chars[i]) 
			data[n].entry_chars[i++] = (c & 0x80) ? c & 0x7f : '\040';
		    data[n].data_yet = FALSE;
		    if (data[n].dot_flag) {
		        data[n].cursor_col = data[n].min_column + data[n].dot_location;
			data[n].dot_yet = FALSE;
			strcpy(&data[n].entry_chars[data[n].dot_location - 1], "0.00");
		    }
		    else if (!data[n].right_flag) {
			if (data[n].replace)
			    data[n].cursor_col = data[n].min_column + strlen(ptr[n].prompt);
		        else
			    data[n].cursor_col = data[n].min_column;
		    }
		    reprint(&ptr[n], n, ON_ATTR);
		    if (data[n].replace)
	                at_say(ptr[n].row, ptr[n].col, ptr[n].prompt, ON_ATTR);
		    break;
		    
		case BACKUP:
		case DELETE:
		    if (!data[n].data_yet)
			break;

		    if (data[n].dot_flag) {	/* handle a f.p. number   */
		    	if (!data[n].dot_yet) {
			    shr_string(data[n].entry_chars, '.');
			    reprint(&ptr[n], n, ON_ATTR);
			}
			else {
			    if (data[n].dot_location < --data[n].cursor_col - 
					data[n].min_column) {
			        place(ptr[n].row, data[n].cursor_col);
			        outchar(data[n].field_character);
			        place(ptr[n].row, data[n].cursor_col);
			        *(data[n].entry_chars + OFFSET(n)) = '\040';
			    }
			    else {
			        data[n].dot_yet = FALSE;
			        place(ptr[n].row, (data[n].cursor_col = 
    					data[n].dot_location + data[n].min_column));
			    }
			}
		    }
		    else {			/* handle other types here */
			if (data[n].right_flag) {
			    shr_string(data[n].entry_chars, '\0');
			    reprint(&ptr[n], n, ON_ATTR);
			}
			else {
			    if (--data[n].cursor_col < data[n].min_column)
				goto clear;
			    else {
				if (*(data[n].mask_chars + OFFSET(n)) & 0x80)
				    --data[n].cursor_col;
				place(ptr[n].row, data[n].cursor_col);
				outchar(data[n].field_character);
				place(ptr[n].row, data[n].cursor_col);
				*(data[n].entry_chars + OFFSET(n)) = '\040';
			    }
			}
		    }
		    break;
		    
		case '.':			/* decimal point is special  */
		    if (data[n].dot_flag) {	/*  if in dot_flag           */
			if (!data[n].dot_yet) {		/* true field, else  */
			    data[n].dot_yet = TRUE;	/*  drop into        */
			    goto right;			/*  default case     */
			}
		    }
		    else if (data[n].data_type == 'd') {  /* cannot have     */
			if (data[n].ring_flag)		  /*  decimal point  */
			    outchar(BELL);		  /*  in int field   */
			break;
		    }
			

		default:		/* all other inputs here */
		    if (!data[n].data_yet && data[n].replace) {
			data[n].cursor_col = data[n].min_column = ptr[n].col;
			reprint(&ptr[n], n, ON_ATTR);
			data[n].data_yet = TRUE;
		    }
		    else
			data[n].data_yet = TRUE;

					/* all this work is used to 	     */
					/* place cursor correctly on screen  */
					/* and edit incoming entries         */
		    if (data[n].dot_flag) {
			if (isdigit(c) || c == '-') {
			    if (!data[n].dot_yet) {
				shl_string(data[n].entry_chars, c, '.');
				reprint(&ptr[n], n, ON_ATTR);
			    }
			    else {
				if (data[n].dot_location < OFFSET(n)) {
				    if (data[n].cursor_col < data[n].max_column) {
				    	outchar(c);
				    	*(data[n].entry_chars + OFFSET(n)) = c;
				    	data[n].cursor_col++;
				    }
				    if (data[n].cursor_col == data[n].max_column) {
					if (data[n].ring_flag)
					    outchar(BELL);
					if (!data[n].full_flag)
					    goto ret;
				    }
				}
				else {
				    bump();
				    outchar(c);
				    *(data[n].entry_chars + (++data[n].cursor_col - 
						data[n].min_column)) = c;
				    data[n].cursor_col++;
				}
			    }
			}							 
			else
			    if (data[n].ring_flag)
				outchar(BELL);
		    }
		    else {
		        if (data[n].right_flag) {
			    shl_string(data[n].entry_chars, c, '\0');
			    if (compare_mask(data[n].mask_chars, data[n].entry_chars))
			        reprint(&ptr[n], n, ON_ATTR);
			    else {
			        shr_string(data[n].entry_chars, '\0');
			        if (data[n].ring_flag)
			            outchar(BELL);
			    }
			    if (*data[n].entry_chars != '\040') {
			        if (data[n].ring_flag)
			            outchar(BELL);
			        if (data[n].full_flag)
			            goto ret;
			    }
			}
			else {
			    if (data[n].cursor_col < data[n].max_column) {
			        temp = *(data[n].entry_chars + OFFSET(n));
			        *(data[n].entry_chars + OFFSET(n)) = c;
			        if (compare_mask(data[n].mask_chars, data[n].entry_chars)) {
			            place(ptr[n].row, data[n].cursor_col);
			            outchar(*(data[n].entry_chars + OFFSET(n)));
			            data[n].cursor_col++;
			        }
			        else {
			            *(data[n].entry_chars + OFFSET(n)) = temp;
			            if (data[n].ring_flag)
			                outchar(BELL);
			        }
			        if (*(data[n].mask_chars + OFFSET(n)) & 0x80) {
				    data[n].cursor_col++;
				    bump();
				}
			    }
			    if (data[n].cursor_col >= data[n].max_column) {
			        if (data[n].ring_flag)
			            outchar(BELL);
			        if (!data[n].full_flag)
			            goto ret;
			    }
			}
		    }
		    break;
	    }
	}
					/* give back memory used      */
goback:
	for (n = 0; n < fields; n++) {

#ifdef C86
	    free((char *)data[n].mask_chars);
	    free((char *)data[n].entry_chars);
#else
	    if (rlsmem((char *)data[n].mask_chars, ptr[n].width + 1)) {
	        printf("error deallocating mask_chars, fields=%d, n=%d",fields,n);
	        exit(1);
	    }
	    if (rlsmem((char *)data[n].entry_chars, ptr[n].width + 1)) {
	        printf("error deallocating entry_chars, fields=%d, n=%d",fields,n);
	        exit(1);
	    }
#endif
	}

#ifdef C86
	free((char *)data);
#else
	if (rlsmem((char *)data, fields * sizeof(struct _data))) {
	    puts("error deallocating data");
	    exit(1);
	}
#endif

	return (c);		/* so know what happened  */
}
			    
void reprint(ptr,n,attr)	/* fills a field window with value that  */
struct _scan *ptr;		/*  has been entered into its buffer     */
int attr;
int n;
{
    int j;
    static char extra[80];

    char *strcpy();
    void at_say();
    void place();

    if (!data[n].data_yet) {			/* if no data yet */
	strcpy(extra, data[n].entry_chars);

	for (j = 0; extra[j]; j++) {
	    if (extra[j] == '\040')
		extra[j] = data[n].field_character;
	}

	if (data[n].replace)
	    at_say(ptr->row, ptr->col, extra, attr);
	else
	    at_say(ptr->row, data[n].min_column, extra, attr);
    }
    else {
	if (data[n].replace)
	    at_say(ptr->row, ptr->col, data[n].entry_chars, attr);
        else
	    at_say(ptr->row, data[n].min_column, data[n].entry_chars, attr);	
    }

    place(ptr->row, data[n].cursor_col);

}
	
int compare_mask(test,given)		/* makes sure entry is valid */
char *test;
char *given;
{
	char c;
	char obj;
	
	while (c = *test++) {
	    obj = *given++;
	    
	    if (obj == '\040')
		continue;
		
	    switch (c) {
		case '9':
		    if (!isdigit(obj) && obj != '-' && obj != '.')
		    	return (FALSE);
		    break;
		
		case 'A':
		    if (!isalpha(obj))
			return (FALSE);
		    break;
		
		case 'X':
		    if (!isprint(obj))
			return (FALSE);
		    break;

		case '!':
		    *(given - 1) = toupper(obj);
		    break;
		
	    }
	}
	return (TRUE);}
	

void toggle_attributes(flag,ptr,n)	/* adds or deletes a highlighting    */
int flag;				/*  window around an entry field      */
struct _scan *ptr;			/* puts a help line at a fixed       */
int n;					/*  location                         */
{
	struct _sreg sreg;
	int temp;
	unsigned int row, col;

	void place();
	void at_say();

    if (data[n].attribute) {			/* change attribute of      */
						/*  what is already there   */
	row = ptr->row;
	col = ptr->col;

	for (temp = data[n].max_column - col; temp; temp--, col++) {

	    place(row,col);
	
	    sreg.ax = 0x0800;		/* read character/attribute at cursor*/
	    sreg.bx = 0;

	    int86(VIDEO_INT,&sreg,&sreg);
						/* if moving into field      */
						/*  and character is space,  */
						/*  replace character with   */
						/*  field_character to       */
						/*  define th field width    */

	    if (flag && ((sreg.ax & 0x00ff) == '\040') && col >= data[n].min_column)
		sreg.ax = data[n].field_character | 0x0900;
	    else if (!flag && ((sreg.ax & 0x00ff) == data[n].field_character) && data[n].data_yet)
	        sreg.ax = '\040' | 0x0900;
	    else
		sreg.ax = (sreg.ax & 0x00ff) | 0x0900;	/* write same        */

	    sreg.bx = (flag ? ON_ATTR : OFF_ATTR);
	    sreg.cx = 1;
	
	    int86(VIDEO_INT,&sreg,&sreg);
	
	}
    }

    if (flag)					/* write new help line       */
	at_say(HELP_ROW, HELP_COL, ptr->help, ON_ATTR);
    else {
	place(HELP_ROW, HELP_COL);
        wrt_chrs('\040', strlen(ptr->help));	/* clear help line           */    
    }

}


void update(ptr,n)		/* loads destination variable with        */
struct _scan *ptr;		/*  current contents of appropriate field */
int n;
{
	long atol();
	double atof();
	char *strcpy();
	char *adv();

	switch (data[n].data_type) {
	    case 'd':
		*(long int *)ptr -> field = atol(adv(data[n].entry_chars));
		break;
	    case 'f':
	    	*(float *)ptr -> field = atof(adv(data[n].entry_chars));
	    	break;
	    case 's':
		strcpy(ptr -> field, data[n].entry_chars);
	}
}

