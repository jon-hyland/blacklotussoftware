#include <conio.h>
#include <c:\bc5\jons\bls.h>

void main(void)
{
	char *new_string;

	clear();
   draw_window(30,10,50,14,1,"Enter Text");
   new_string = get_string(32,12,15,BREAK,SHOW,CASE);
	gotoxy(32,17);
   textbackground(RED);
   cprintf("%s", new_string);
}
