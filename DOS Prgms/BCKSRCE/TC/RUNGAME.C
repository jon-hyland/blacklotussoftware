#include "stdio.h"
#include "conio.h"
#include "stdlib.h"
#include "dos.h"
#include "ctype.h"
#include "setjmp.h"

int totrocks=100;
int level=1;

int totcoins;
int obj[80][24];
int x, y;
char key;

void init(void)
{
  int i, j, k;

  randomize();

  totcoins = level * 5 + 5;
  for(k=1; k<=24; k++)
   for(j=1; j<=80; j++)
    obj[j][k] = 0;
  for(i=1; i<=totrocks; i++)
  {
    do
    {
      j = random(80)+1;
      k = random(24)+1;
      printf("%d", 178);
    }
    while(obj[j][k]);
    obj[j][k] = random(15)+1;
    gotoxy(j,k);
    textcolor(RED);
    printf("1");
  }
}

void main()
{
  init();

  printf("fsdgsdfgfdsgfdgdfgf");
  getch();
  printf("sdfgsdfgdhdkfgmhkm");
}







