#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

void cursor(void)
{
  gotoxy(1,25);
}

main()
{
  int obj[80][24];
  int x, y, ox, oy;
  int i, j, k;
  int move;
  int one = 1;

  randomize();
  clrscr();
  for(k=0; k<24; k++)
    for(j=0; j<80; j++)
      obj[j][k] = 0;
  for(i=0; i<100; i++)
  {
    do
    {
      j = random(80)+1;
      k = random(24)+1;
    }
    while (obj[j][k]);
    obj[j][k] = 1;
    gotoxy(j,k);
    printf("O");
    cursor();
  }
  do
  {
    x = random(80)+1;
    y = random(24)+1;
  }
  while (obj[x][y]);
  gotoxy(x,y);
  printf("X");
  cursor();

  do
  {
    ox = x;
    oy = y;
    move = random(4)+1;
    switch (move)
    {
      case 1 : x = x + 1; break;
      case 2 : x = x - 1; break;
      case 3 : y = y + 1; break;
      case 4 : y = y - 1; break;
    }
    if (x > 80) x = 1;
    if (x < 1) x = 80;
    if (y > 24) y = 1;
    if (y < 1) y = 24;
    if (obj[x][y])
    {
      x = ox;
      y = oy;
    }
    gotoxy(ox,oy);
    printf(" ");
    gotoxy(x,y);
    printf("X");
    cursor();
    delay(200);
  }
  while (!kbhit());
}






