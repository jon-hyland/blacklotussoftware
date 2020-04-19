#include <fstream.h>
#include <conio.h>
#include <stdlib.h>
#include "bls.h"

const int xmax = 78;
const int ymax = 250;

void draw_page(char text[xmax][ymax])
{
 	for(int y=offset; y<(offset+22); y++)
     	for(int x=0; x<xmax; x++)
      {
      	gotoxy(x+2, y-offset+2);
         cprintf("%c", text[x][y]);
      }
	cursor();
}


void view_text(char filename[])
{
	fstream textfile;
	char text[xmax][ymax];
   int offset = 0;
   int totline=1;
	int x=0, y=0;
   char ch;



	for(int k=0; k<ymax; k++)				// reset text array
   	for(int j=0; j<xmax; j++)
      	text[j][k] = ' ';
   textfile.open(filename, ios::in);	// open text file
   if (!textfile)                      // if can't open
   {
   	cprintf("ERROR - CANNOT OPEN FILE : %s", filename);
      exit(1);									// terminate program
   }
	while (textfile.peek() != EOF)		// while not at end of file
	{
      ch = textfile.get();
      switch (ch)
      {
      	case	13	:	x = 0;				// carrige return
         				break;
         case  10 :	y++;					// next line
         				break;
      }
		if ((ch >= 32) && (ch <= 126))	// if ch is printable char
        	if ((x < xmax) && (y < ymax)) // if x,y is in screen range
         	text[x++][y] = ch;			// save ch to array, increment x
   }
   textfile.close();
   totline = y + 1;

	draw_page();
}

void main(void)
{
	void view_text(char[]);


   view_text("c:\\block\\block.txt");
}
