#include <stdio.h>
#include <stdlib.h>

int obj[80][24];

void cursor(void)
{
  gotoxy(1,25);
}

void init(void)
{
  int i, j, k;

  randomize();
  for(k=1; k<=24; k++)
    for(j=1; j<=80; j++)
      obj[80][24] = 0;
  for(i=1; i<=100; i++)
  {
    do
    {
      j = random(80)+1;
      k = random(24)+1;
    }
    while (obj[j][k]);
    obj[j][k] = 1;
    gotoxy(j, k);
    printf("O");
  }
  do
  {
    x = random(80)+1;
    y = random(24)+1;
  }
  while (obj[x][y]);

