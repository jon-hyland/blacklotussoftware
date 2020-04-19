#include <fstream.h>		// file handling
#include <conio.h>		// cprintf(), ANSI color
#include <stdlib.h>		// exit()
#include "bls.h"			// draw_window(), erase_window()

void view_text(char filename[])
{
	const int totx = 78;
   const int toty = 250;
   fstream textfile;
	char 	text[totx][toty];
   char	cha;
   int 	offset=0, lastos=1;
	int 	lastline;
   int 	x=0, y=0;
   char	key;

   textfile.open(filename, ios::in);
   if (!textfile)
   {
   	cprintf("## ERROR : CANNOT OPEN FILE %s ##", filename);
      exit(1);
   }
   for(int k=0; k<toty; k++)
   	for(int j=0; j<totx; j++)
      	text[j][k] = ' ';
   while (textfile.peek() != EOF)
   {
   	cha = textfile.get();
		if (cha == 10)
      {
      	x = 0;
         y++;
      }
      if ((cha >= 32) && (cha <= 126)) // if key is printable char
      {
         if ((x < totx) && (y < toty))
				text[x][y] = cha;
         x++;
      }
   }
   lastline = y;
   textfile.close();
	draw_window(1,1,80,24,1,filename);
   textcolor(YELLOW);
   do
   {
   	if (offset != lastos)
      {
      	for(int k=offset; k<=offset+21; k++)
			{
				gotoxy(2, (k-offset+2));
         	for(int j=0; j<totx; j++)
               cprintf("%c", text[j][k]);
         }
         cursor();
      }
      lastos = offset;
      do
      	key = getch();
      while ((key != 27) && (key != 'H') && (key != 'P')
      	 	&& (key != 'I') && (key != 'Q'));
      switch (key)
      {
      	case 'H'	:	offset--;
         				break;
         case 'P' :	offset++;
         				break;
         case 'I'	:	offset -= 22;
         				break;
         case 'Q'	:	offset += 22;
      }
      if (offset < 0)
      	offset = 0;
      if (offset > (lastline-21))
      	offset = lastline - 21;
   }
   while (key != 27);
   erase_window(1,1,80,24);
}


void main(void)
{
   void view_text(char []);
	char filename[] = "c:\\Bc5\\jons\\viewtext.txt";

	view_text(filename);
}



