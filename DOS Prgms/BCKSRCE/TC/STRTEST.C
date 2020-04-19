#include <conio.h>
#include <ctype.h>
#include <stdio.h>
#include <dos.h>

main()
{
static int a = 5;
clrscr();
struct  test {
		char name[15],address[15];
		};
struct test x1,x2;
x1.address = "297 Pollman";
x2.address = "3709 Ridgemont";
x1.name = "Ben Chase";
x2.name = "Jon Hyland";
process();
}
process(void)
{
gotoxy(10,10);
printf(x1.address);
getch();
}

