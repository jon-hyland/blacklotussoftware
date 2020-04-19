#include "dos.h"
#include "stdio.h"
#include "conio.h"
#include <stdlib.h>

screen(void)
{
  int z;
  textbackground(BLACK);
  clrscr();
  gotoxy(1,1);
  textbackground(BLACK);
  for (z=0;z<1920;++z) cprintf(" ");
  textcolor(BLACK);
  textbackground(BLACK);
  gotoxy(1,25);
  cprintf("%c", 219);
  textcolor(WHITE);
  textbackground(BLACK);
}

initwindow()
{
int j,k;
screen();
textcolor(WHITE);
for (k=1; k<=24; k++)
 {
  gotoxy(1,k);
  cprintf("%c", 186);
  gotoxy(80,k);
  cprintf("%c", 186);
 }
for (j=2; j<=79; j++)
 {
  gotoxy(j,1);
  cprintf("%c", 205);
  gotoxy(j,24);
  cprintf("%c", 205);
 }
gotoxy(1,1);
cprintf("%c",201);
gotoxy(80,1);
cprintf("%c",187);
gotoxy(1,24);
cprintf("%c",200);
gotoxy(80,24);
cprintf("%c",188);



}

begindisp()
{

initwindow();
screen();
gotoxy(20,10);
textcolor(RED);
cprintf("You are trying to access a restricted item!");
gotoxy(20,12);
cprintf("Please enter the following information:");
getch();
security();
}

main()
{
begindisp();
getch();

}
