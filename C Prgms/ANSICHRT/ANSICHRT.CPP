#include <conio.h>


void main(void)
{
	int x, y, num;
	int key;

	textcolor(WHITE);
	textbackground(BLACK);
	clrscr();
	x = 1;
	y = 1;
	for(num=1; num<=254; num++)
	{
		if ((num < 7) || (num > 13))
		{
			gotoxy(x, y);
			cprintf("%c=%d", num, num);
			x += 8;
			if (x > 78)
			{
				x = 1;
				y += 1;
			}
		}
	}
	while (kbhit())
		key = getch();
	key = getch();
}


