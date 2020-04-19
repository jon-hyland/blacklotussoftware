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
  textbackground(BLUE);
  for (z=0;z<1920;++z) cprintf(" ");
  textcolor(BLACK);
  textbackground(BLACK);
  gotoxy(1,25);
  cprintf("%c", 219);
  textcolor(WHITE);
  textbackground(BLUE);
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
dieprompt(void)
{
char choice;
initwindow();
gotoxy(17,3);
textbackground(BLUE);
textcolor(LIGHTGRAY);
cprintf("Microsoft Scandisk - Boot Sector Failure");
gotoxy(15,6);
textcolor(LIGHTGRAY);
cprintf("Drives affected :");
gotoxy(17,8);
textcolor(YELLOW);
cprintf("Primary Master   :  C");
gotoxy(17,9);
cprintf("Host Drive       :  H");
gotoxy(7,13);
textcolor(LIGHTGRAY);
cprintf("1:  Examine Files");
gotoxy(7,14);
cprintf("2:  Format Master Drive : C");
gotoxy(7,15);
cprintf("3:  Help");
gotoxy(7,16);
cprintf("4:  Affected Files");
gotoxy(7,18);
cprintf("(1,2,3,4)? ");
cscanf("%d",&choice);

     switch (choice)  {
			case 3:
				help();
			case 4:
				filelist();

			default: format();

			}  /*switch*/







}

filelist()
{
 initwindow();
gotoxy(32,3);
textcolor(LIGHTGRAY);
cprintf("Affected Files");
gotoxy(15,6);
cprintf("The following files have been found with FATAL ERRORS:");
textcolor(YELLOW);
gotoxy(17,8);
cprintf("C:\\WINDOWS\\WINDOWS.INI");
gotoxy(17,9);
cprintf("C:\\DRVSPACE.000");
gotoxy(17,10);
cprintf("C:\\DRVSPACE.BIN");
textcolor(LIGHTGRAY);
gotoxy(17,15);
cprintf("< To return to main screen, press any key >");
cursor();
getch();
getch();
dieprompt();
}
help(void)
{
initwindow();
textcolor(WHITE);
gotoxy(27,7);
cprintf("CMOS Help");
textcolor(YELLOW);
gotoxy(38,7);
cprintf("<booterror>");
textcolor(WHITE);
gotoxy(5,11);
cprintf("     During CMOS disk detection, CMOS detected a boot sector failure");
gotoxy(4,12);
cprintf("while attempting to read the specified drive.");
gotoxy(7,14);
cprintf("   It is suggested that you examine your files to determine which files");
gotoxy(3,15);
cprintf("contain corrupted data structures.  Do not re-format before checking");
gotoxy(3,16);
cprintf("files.");
gotoxy(31,22);
textcolor(YELLOW);
cprintf("<Press any key>");
gotoxy(1,25);
getch();
getch();
dieprompt();
}

format(void)
{
int j,k;

textcolor(WHITE);
textbackground(BLACK);
clrscr();
cprintf("Proceeding with FORMAT.");
gotoxy(1,3);
cprintf("WARNING: ALL DATA ON NON-REMOVABLE DISK");
gotoxy(1,4);
cprintf("DRIVE C: WILL BE LOST!");
gotoxy(1,6);
cprintf("Verifying 368MB");
delay(1000);
gotoxy(1,6);
cprintf("Formatting 368MB");
gotoxy(1,7);
cprintf("    percent completed.");
for(j=1; j<100; j++)
 {
  gotoxy(2,7);
  cprintf("%.2d", j);
  delay(2000);
 }
gotoxy(1,7);
cprintf("Format complete.          ");
sleep(1);



hellojon();
}

screen2(void)
{
int b;
clrscr();
gotoxy(0,0);
textbackground(BLUE);
     for (b=0;b<2000;++b)  {
		cprintf(" ");
		}
}

hellojon(void)
{
int j;

textcolor(WHITE);
textbackground(BLACK);
clrscr();
textcolor(BLACK);
cprintf("%c",219);
gotoxy(1,1);
sleep(10);


 for (j=1; j<=50; j++)
  {
   sound((j*5)+100);
   delay(10);
  }
 for (j=49; j>=1; j--);
  {
   sound((j*5)+100);
   delay(10);
  }
 nosound();
 delay(150);
 for (j=1; j<=100; j++);
  {
   sound(random(250)+100);
   delay(5);
  }
 nosound();
 delay(150);
 for (j=1; j<=100; j++);
  {
   sound(random(250)+100);
   delay(5);
  }
 nosound();
 delay(150);
 for (j=1; j<=100; j++);
  {
   sound(random(250)+100);
   delay(5);
  }

 nosound();

screen2();
textcolor(YELLOW);
gotoxy(33,7);
cprintf("S");
delay(300);
gotoxy(34,7);
cprintf("u");
delay(300);
gotoxy(35,7);
cprintf("r");
delay(300);
gotoxy(36,7);
cprintf("p");
delay(300);
gotoxy(37,7);
cprintf("r");
delay(300);
gotoxy(38,7);
cprintf("i");
delay(300);
gotoxy(39,7);
cprintf("s");
delay(300);
gotoxy(40,7);
cprintf("e");
delay(300);
gotoxy(41,7);
cprintf(" ");
delay(300);
gotoxy(42,7);
textcolor(YELLOW);
cprintf("!");
delay(300);

textcolor(YELLOW);
gotoxy(1,12);
cprintf("        I bet you thought that you had accidentally formatted your hard");
cursor();
gotoxy(1,13);
sleep(1);
textcolor(YELLOW);
textbackground(BLUE);
cprintf("        drive.  Well, you were wrong.  I bet you feel awfully stupid ");
cursor();
gotoxy(1,14);
sleep(1);
textbackground(BLUE);
cprintf("        realizing now that, Ben, the Almighty Master, has once again ");
cursor();
gotoxy(1,15);
sleep(1);
textcolor(YELLOW);
textbackground(BLUE);
cprintf("        shown that he is the greatest prankster alive.");
cursor();
gotoxy(1,18);
sleep(3);
textcolor(YELLOW);
textbackground(BLUE);
cprintf("      I bet you'd like to find out how I did it.  Hit a key to find out.");
cursor();
getch();
getch();
explanation();
}

explanation(void)
{
screen();
gotoxy(5,5);
textcolor(WHITE);
cprintf("   To find all of the hidden files, type < gotcha > at the command");
gotoxy(5,6);
cprintf("   prompt.  That will give you the source code, and the hidden .bat");
gotoxy(5,7);
cprintf("   file.  After that, you must bow down to your new master, Ben.");
gotoxy(16,12);
textcolor(YELLOW);
sleep(1);
cprintf("<Hit any key to get out of this damn thing.>");
textcolor(BLUE);
textbackground(BLUE);
getch();
exit(1);
}

cursor()
{
textcolor(BLACK);
textbackground(BLACK);
gotoxy(1,25);
}
main()
{
dieprompt();
}