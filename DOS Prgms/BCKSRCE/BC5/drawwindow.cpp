#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

void draw_window(int x1, y1, x2, y2, backcolor; char name[])
{
	const int delay_time = 20;
   int j, k;
   float xa, xb, xinc;
   int ya, yb;
   int times;

   times = (y2 / y1+1) - int((y2-y1+1)/2);
   xinc = ((x2-x1+1)/2) / times;
   ya = int((x2-x1+1)/2+y1);
   yb = ya;
   



