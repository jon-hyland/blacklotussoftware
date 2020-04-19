/*  module title: menu.c
 *  function names: int menu(), display(), hit()
 *		    void h_setup(), v_setup(), toggle()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with:
 *  compiled by:
 *
 *  linked with: int inchar()
 *		 void place()
 *  linked by:
 *
 *  problems: Because the attributes are hard coded, the existing display modes
 *            (especially foreground or background colors) are overwritten
 *	      with the attributes chosen. A more useful (and complex) approach
 *	      would be to determine the existing attribute and 'OR' or
 *	      'AND' the highlighting attribute with the attribute, turning it 
 *	      on and off, respectively.
 *
 *  description: Function constructs general-purpose menu-selection screens, 
 *		 the spread can be horizontal or vertical. An item is selected
 *		 by pressing the return key after the highlighting window 
 *		 has been moved over its name with the space bar (or other key) 
 *		 or the first character of the window's name is pressed.
 *
 */

#include <stdio.h>

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FASE 0
#endif

#define ANSI TRUE			/* uses ANSI escape sequences if TRUE*/

#define HORZ 0				/* flags that select a horizontal    */
#define VERT 1				/*  or vertical menu display,        */
#define ON 1				/*  specify whether to turn          */
#define OFF 0				/*  attributes on or off,            */
#define SPACING 3			/*  spacing between columns in       */
					/*  horz_disp			     */

#if ANSI

#define LEFT_ATTRIB "\033[4m"		/* terminal control strings for  */
#define RIGHT_ATTRIB "\033[0m"		/*  for start/stop underscore in */
					/*  ANSI                         */
#else

#define LEFT_ATTRIB "\033G4"		/* terminal control strings           */
#define RIGHT_ATTRIB "\033G0"		/*  for start/stop reverse video,    */
					/*  used to highlight selection;     */
					/*  these were used for a Televideo  */
					/*  910 and are terminal dependent   */
#endif

				
#define HDISP_ROW 20			/* starting display row for horizon- */
#define HDISP_WIDE 80			/*  tal display, width of screen     */
#define VDISP_COL 30			/* starting col for vertical display */
#define VDISP_ROW 5			/* starting row for vertical display */

#define ESCAPE '\033'			/* used to get back from display     */
 					/*  menus without making a selection */
#define DEMO

struct choice {				/* structure holds a pointer to      */
	void (*function)();		/*  a function, name of structure    */
	char *name;			/*  is displayed in the menu         */
};

struct edges {				/* to store cursor positions        */
	char row;			/*  calculated on the fly           */
	char left_col;			/*  in horz_disp, vert_disp         */
	char right_col;
};


#ifdef DEMO

main()			/* small demonstration main to get started     */
{
	int ret;

	void func1();			/* sample functions selected by       
	void func2();			/*  menu and executed by reference to*/
	void func3();			/*  their position in the array of   */
					/*  structures containing their      */
					/*  address (pointer)                */

 	static struct choice selection[] = {	/* creating an array of      */
	    {func1,"A Function 1"},	        /*  structs in memory,       */
    	    {func2,"B Function 2"},	/* initialized with pointers to      */
    	    {func3,"C Function 3"},	/*  functions and their names,       */
	    {0},			/*  this null marks the end          */
        };				/*  (static so it can be initialized)*/

	int menu();


	printf("\nNow executing function %x:\n", ret = menu(selection,VERT));
	
	(*selection[ret].function)();		/* invokes chosen function  */
}

#endif


int menu(ptr,hv)			/* create a menu and wait for        */
struct choice ptr[];			/*  input, return integer            */
int hv;					/*  corresponding to item selected   */
{
	int n;
	int ret;
	char **str;				/* pointers to the name str  */
						/*  pointers      	    */
	int display();
	char *calloc();

	for (n = 0; ptr[n].function; n++)	/* calculates number of */
	    ;					/*  structures          */

						/* produce a pointer      */
	str = (char **)calloc(n, sizeof(char *));
						/*  to where the pointers go */
						/*  while making space for   */
						/*  the pointers             */
	if (!str) {
	    puts("error allocating space for str");
	    exit(1);
	}


	for (n = 0; ptr[n].function; n++)	/* for every function        */
	    str[n] = ptr[n].name;		/*  required, initialize a   */
	    					/*  pointer to its name in   */
						/*  this special []!         */

	ret = display(str, n, hv);	/* does the display                  */
					/*  whether horizontal or vertical   */
					/*  and returns the one wanted       */
	free(str);

	return (ret);

}

int display(str,n,hv)			/* displays strings horiz or vert    */
					/*  and the user chooses one,        */
					/*  returns 0-n being the chosen one */
char *str[];				/* strings to print                  */
int n;					/* number of strings                 */
int hv;					/* flag to tell whether horz or vert */
{
	int i, pick;
	char c;
	struct edges *loc;		/* hold the cursor positions of      */
					/*  the edges of each string in this */
					/*  array of structures              */

	int (*hv_setup[2])();		/* makes space for pointers to two   */
					/*  functions that set up the        */
					/*  edges for accent around where the*/
					/*  function names are printed       */
	char *calloc();
	void place();
	void toggle();
	int hit();
	void h_setup();
	void v_setup();

	hv_setup[0] = h_setup;		/* plant the address of the          */
					/*  horizontal setup function,       */
	hv_setup[1] = v_setup;		/* address of vertical function      */

					/* make space for the cursor         */
					/*  location structure               */

	loc = (struct edges *)calloc(n, sizeof(struct edges));
	
	if (!loc) {
	    puts("error allocating memory for loc");
	    exit(1);
	}

	(*hv_setup[hv])(loc, n, str);		/* set up cursor positions   */
						/*  based on horz/vert       */

					/* now all edges are in structure    */
					/*  print the strings                */
	for (i = 0; i < n; i++) {
	    place(loc[i].row, loc[i].left_col + 1);
	    puts(str[i]);
	}
	fflush(stdout);
					/* turn on the attributes around     */
	i = 0;				/*  loc[0]			    */

	toggle(&loc[i], str[i], LEFT_ATTRIB, RIGHT_ATTRIB, ON);

					/* for each non-hit character,       */
					/*  remove the window from where we  */
					/*  are and put it where we're going */

	while ((c = inchar()) != ESCAPE && c != '\r') {
	    if ((pick = hit(str, c, n)) >= 0)
	 	break;
	    toggle(&loc[i], str[i], LEFT_ATTRIB, RIGHT_ATTRIB, OFF);
	    i++, i %= n;
	    toggle(&loc[i], str[i], LEFT_ATTRIB, RIGHT_ATTRIB, ON);
	}

	free(loc);

	return (c == ESCAPE ? -1 : (c == '\r' ? i : pick));

}

void h_setup(loc,n,str)
struct edges loc[];
int n;
char *str[];
{
	int length;
	int line;
	int i;
	int size;
	char c;
	char col;


	for (i = 0, line = HDISP_ROW; i < n; i++) {  /* for number of        */
						     /*  strings             */

	    length = 1;				/* current line length       */
	    col = 1;				/* current column position   */

	    while ((length + (size = 1 + strlen(str[i]))) < HDISP_WIDE && i < n) {
		loc[i].row = line;
		loc[i].left_col = col;
		loc[i].right_col = col += size;
		col += SPACING;
		length += col;
		i++;
	    }
	    i--;				/* get back to previous item */
	    line++;				/* move down to next line    */
	}
}

void v_setup(loc,n,str)
struct edges loc[];
int n;
char *str[];
{
	int line,i;
	char c;

	for (i=0, line = VDISP_ROW; i < n; i++) {	/* for the number    */
	    loc[i].row = line;                          /*  of strings       */
	    loc[i].left_col = VDISP_COL;
	    loc[i].right_col = VDISP_COL + strlen(str[i]) + 1;
	    line++;
	}

}

void func1()		/* need dummy functions so can take     */
{			/*  their address                       */
	printf("function one\n");
}


void func2()
{
	printf("function two\n");
}
	

void func3()
{
	printf("function three\n");
}


int hit(str,c,n)
char *str[];
char c;
int n;
{
	int i = -1;				/* failure is assumed        */

	c = toupper(c);				/* always compare with caps  */
	
	while (n--) {
	    if (c == toupper(*str[n])) {	/* if find c as the first    */
		i = n;				/*  character of the name    */
		break;				/*  set i to the one that hit*/
	    }					/*  break out                */
	}

	return (i);
}

void toggle(ptr,str,lft,rt,flag)	/* function wraps a text string with */
					/*  some video attribute, typically  */
					/*  reverse video or underlining     */
struct edges *ptr;			/* where to put them                 */
int flag;				/* putting on or taking off flag     */
char *lft;				/* the left and right attributes     */
char *rt;
char *str;
{

#if ANSI
	void place();
	int printf();

	place(ptr -> row, 1 + ptr -> left_col);
	printf("%s%s%s%s",(flag ? lft : rt), str, (!flag ? rt : lft), rt);

					/* final right attribute makes       */
					/*  leave with underscore            */
					/*  (or other attribute) off         */
	fflush(stdout);
#else
	void place();
	int puts();

	char *attribute[2];			/* by setting up this small  */
	char position[2];			/*  array, can select        */
						/*  attributes by index;     */
	position[0] = ptr -> left_col;		/* because only two, can let */
	position[1] = ptr -> right_col;		/*  a logical operator       */
	attribute[0] = lft;			/*  select what is first,    */
	attribute[1] = rt;			/*  with non-ANSI terminals  */
						/*  it matters               */
	place(ptr -> row, position[flag]);	
	flag ? puts(attribute[flag]) : putchar(' ');
	place(ptr -> row, position[!flag]);
	flag ? puts(attribute[!flag]) : putchar(' ');

	fflush(stdout);
#endif

}
