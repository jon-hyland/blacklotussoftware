#include "stdio.h"
#include "quadv1.c"

start()
{
quad1(3,9,7);
gotoxy(10,15);
printf(ans);
getch();
}
main()
{
start();
}
