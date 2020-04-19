#include <conio.h>
#include <string.h>
#include "c:\bc5\jons\bmp.h"

char filename[128];

void main(void)
{
	strcpy(filename, "c:\\bc5\\jons\\testbmp.bmp");
   printf("Press any key to display %s..", filename);
   getch();

   init_display();
   display_bmp(filename);
   getch();
   end_display();

	printf("Finished displaying %s.", filename);
}