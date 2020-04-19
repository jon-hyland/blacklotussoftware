#include <iostream.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>

int hit[80][24];
int j, k, t=0;

void main(void)
{
   randomize();

   while (t < (80 * 24)) {
      	do {
         	j = random(80);
            k = random(24); }
         while (hit[j][k]);
         textcolor(random(16));
         gotoxy(j+1, k+1);
         cprintf("X");
         hit[j][k] = 1;
         t++; }
}
