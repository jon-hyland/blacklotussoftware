#include <stdio.h>
#include <conio.h>

main()
{
  int i, j, k;

  i = 10;
  for(k=1; k<=24; k++)
    for(j=1; j<=10; j++)
    {
      gotoxy((j*8)-7,k);
      printf("%d : %c", i, i);
      i++;
    }
  i = getch();
}

