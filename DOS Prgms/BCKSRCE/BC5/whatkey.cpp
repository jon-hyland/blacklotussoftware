#include <stdio.h>
#include <conio.h>
#include "c:\bc5\jons\bls.h"

void main(void)
{
	char	key = 0;

   clear();
   draw_window(26,8,43,18,4,"Keypressed");
   textcolor(YELLOW);
   gotoxy(30, 10);
   cprintf("Char : ");
   gotoxy(30, 11);
   cprintf("Int  : ");
   gotoxy(28, 15);
   cprintf("Hit any key..");
   gotoxy(28, 16);
   cprintf("[Esc] to quit.");
   textcolor(WHITE);
   do
   {
		cursor();
   	key = getch();
	   gotoxy(30, 13);
	   printf("Not Ext.");
      if (key == 0)							// Extended key
      {
      	key = getch();
         gotoxy(30, 13);
         cprintf("Extended");
      }
      gotoxy(37, 10);
      cprintf("    ");
      gotoxy(37, 11);
      cprintf("    ");
      gotoxy(37, 10);
      cprintf("%c", key);
      gotoxy(37, 11);
      cprintf("%d", key);
   }
   while (key != 27);
	gotoxy(30, 13);
   cprintf("  Done. ");
   cursor();
}
