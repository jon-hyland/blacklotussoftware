#include <conio.h>

void main(void)
{
	char	key;

	textcolor(BLACK);
   textbackground(BLACK);
   clrscr();
   gotoxy(1, 25);
   cprintf("%c", 219);
   textcolor(WHITE);
   gotoxy(1, 1);
   cprintf("Char : ");
   gotoxy(1, 2);
   cprintf("Num  : ");
	gotoxy(1, 3);
   cprintf("Not Ext.");
   do
   {
		gotoxy(1, 25);
	  	key = getch();
		gotoxy(1, 3);
   	cprintf("Not Ext.");
      if (key == 0)
      {
      	gotoxy(1, 3);
         cprintf("Extended");
         key = getch();
      }
      gotoxy(8, 1);
      cprintf("%c", key);
      gotoxy(8, 2);
      cprintf("%d", key);
   }
   while (key != 27);
   gotoxy(1, 4);
   cprintf("Done.");
}
