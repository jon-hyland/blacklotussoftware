#include "stdio.h"
#include "conio.h"
#include "stdlib.h"
#include "dos.h"
#include "ctype.h"
#include "setjmp.h"

char fstr[79];

void logoflash(char str[])
{
  int x,
      xmax,
      color,
      y;
  char key;

  randomize();
  xmax = 80 - strlen(str);
  for (x=1; x<xmax; x++)
  {
    gotoxy(x,12);
    for (y=0; y<strlen(str); y++)
    {
      color = random(8)+8;
      textcolor(color);
      cprintf("%c", str[y]);
    }
    delay(1000);
    textcolor(BLACK);
    gotoxy(x,12);
    cprintf(str);
  }
  for (x=xmax-1; x>=1; x--)
  {
    color = random(15)+1;
    textcolor(color);
    gotoxy(x,12);
    cprintf(str);
    delay(1000);
    textcolor(BLACK);
    gotoxy(x,12);
    cprintf(str);
  }
}

void main(void)
{
  clrscr();
  printf("Enter string : ");
  scanf("%s", &fstr);
  gotoxy(1,2);
  printf(fstr);
  logoflash(fstr);
}