#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

void clear(void)
{
  textcolor(WHITE);
  testbackground(BLACK);
  clrscr();
  textcolor(BLACK);
  gotoxy(1,25);
  printf("%c", 219);
  textcolor(WHITE);
  gotoxy(1,1);
}

void cursor(void)
{
  gotoxy(1,25);
}

void window(int x1, y1, x2, y2, color; char[25] name)
{
  int j, k;

  textcolor(WHITE);
  textbackground(color);
  for(k=y1; k<=y2; k++)
    for(j=x1; j<=x2; j++)
    {
      gotoxy(j,k);
      cprintf(" ");
    }
  gotoxy(x1,y1);
  cprintf("%c", 201);

}

void title(void)
{
}

main()
{
  clear();
  window(10,3,70,12,4,"KILL");
  int crap;
  crap = getch();
}

