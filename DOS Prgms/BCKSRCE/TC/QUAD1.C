#include "stdio.h"
#include "conio.h"
#include "stdlib.h"
#include "dos.h"
#include "ctype.h"
#include "setjmp.h"

float quad(float a, float b, float c)
{

extern float ans1;

ans1 == (-b + sqrt((b*b)-4*a*c)/2*a);


return(ans1);

}

main()
{
float a,b,c;

clrscr();
textcolor(YELLOW);
gotoxy(10,25);
cprintf("Enter three numbers... :");
cscanf("%f%f%f",&a,&b,&c);
quad(a,b,c);
clrscr();
gotoxy(10,20);
printf("%f   %f",ans1);
getch();

}