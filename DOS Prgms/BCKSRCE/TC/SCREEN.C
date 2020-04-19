#include "stdio.h"
#include "conio.h"
#include "stdlib.h"
#include "dos.h"
#include "ctype.h"
#include "setjmp.h"


main()
{
  int x, y;
  char c;

  c = '';
  randomize();
  clrscr();
  while (c == '')
  {
    y = random(24)+1;
    x = random(64)+1;

    gotoxy(x,y);
    textcolor(random(16)+1);
    cprintf("Fuck you and Die");
    delay(100);
    c = getch();
  }
}