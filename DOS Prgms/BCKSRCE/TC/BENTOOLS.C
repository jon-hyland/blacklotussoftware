#include "stdio.h"
#include "dos.h"
#include "conio.h"
#include "math.h"
#include "ctype.h"
#include "setjmp.h"
#include "
void titlescrn()
{
textbackground(BLACK);
clrscr();
gotoxy(25,7);
textcolor(YELLOW);
cprintf("Physics and Mathematical Toolkit");
textcolor(LIGHTMAGENTA);
gotoxy(34,9);
cprintf("-");
cursor();
gotoxy(35,9);
sleep(1);
cprintf("U");
cursor();
sleep(1);
gotoxy(36,9);
cprintf("n");
cursor();
sleep(1);
gotoxy(37,9);
cprintf("r");
cursor();
sleep(1);
gotoxy(38,9);
cprintf("e");
cursor();
sleep(1);
gotoxy(39,9);
cprintf("g");
cursor();
sleep(1);
gotoxy(40,9);
cprintf("i");
cursor();
sleep(1);
gotoxy(41,9);
cprintf("s");
cursor();
sleep(1);
gotoxy(42,9);
cprintf("t");
cursor();
sleep(1);
gotoxy(43,9);
cprintf("e");
cursor();
sleep(1);
gotoxy(44,9);
cprintf("r");
cursor();
sleep(1);
gotoxy(45,9);
cprintf("e");
cursor();
sleep(1);
gotoxy(46,9);
cprintf("d");
cprintf("-");
cursor();
sleep(1);
gotoxy(35,11);
cprintf("Version 1.0");
gotoxy(31,13);
textcolor(MAGENTA);
cprintf("Blac");
textcolor(RED);
cprintf("k Lot");
textcolor(DARKGRAY);
cprintf("us Sof");
textcolor(MAGENTA);
cprintf("tware");
cursor();
getch();
menu();
}

cursor()
{

textbackground(BLACK);
textcolor(BLACK);
gotoxy(1,25);
cprintf("%c",219);
gotoxy(1,25);
textcolor(LIGHTMAGENTA);
}

menu(void)
{
int a;
textbackground(BLACK);
clrscr();

textcolor(DARKGRAY);

 gotoxy(1,1);
	for (a=1;a<=80;++a) {
	    cprintf("%c",205);
	    }

 gotoxy(1,24);
	for (a=1;a<=80;++a) {
	    cprintf("%c",205);
	    }

	for (a=1;a<=24;++a) {
	    gotoxy(1,a);
	    cprintf("%c",186);
	    }

	for (a=1;a<=24;++a) {
	    gotoxy(80,a);
	    cprintf("%c",186);
	    }
 gotoxy(1,5);
	for (a=1;a<=80;++a) {
	    cprintf("%c",205);
	    }

 gotoxy(1,1);
 cprintf("%c",201);
 gotoxy(1,24);
 cprintf("%c",200);
 gotoxy(80,1);
 cprintf("%c",187);
 gotoxy(80,24);
 cprintf("%c",188);
 gotoxy(1,5);
 cprintf("%c",204);
 gotoxy(80,5);
 cprintf("%c",185);

 gotoxy(40,5);
	for (a=5;a<=20;++a) {
		gotoxy(40,a);
		cprintf("%c",186);
		}
 gotoxy(40,5);
 cprintf("%c",203);

	for (a=30;a<=49;++a) {
		gotoxy(a,20);
		cprintf("%c",205);
		}


	for(a=20;a<=24;++a) {
		gotoxy(30,a);
		cprintf("%c",186);
		}

	for(a=20;a<=24;++a) {
		gotoxy(50,a);
		cprintf("%c",186);
		}
 gotoxy(40,20);
 cprintf("%c",202);
 gotoxy(30,20);
 cprintf("%c",201);
 gotoxy(50,20);
 cprintf("%c",187);
 gotoxy(30,24);
 cprintf("%c",202);
 gotoxy(50,24);
 cprintf("%c",202);
 menutext();

}

menutext(void)
{
int b;

textcolor(YELLOW);
gotoxy(34,3);
cprintf("Choose Section");

textcolor(LIGHTRED);
gotoxy(14,6);
cprintf("Math Analysis");
gotoxy(57,6);
cprintf("Physics");
gotoxy(33,21);
textcolor(YELLOW);
cprintf("Command");
gotoxy(41,21);
cprintf("%c",175);
gotoxy(34,23);
cprintf("<9> = Quit");
gotoxy(6,8);
cprintf("1");
gotoxy(10,8);
textcolor(WHITE);
cprintf("Quadratic Equation Solver");
gotoxy(6,10);
textcolor(YELLOW);
cprintf("2");
gotoxy(10,10);
textcolor(WHITE);
cprintf("Law of Sines");
gotoxy(6,12);
textcolor(YELLOW);
cprintf("3");
gotoxy(10,12);
textcolor(WHITE);
cprintf("Law of Cosines");
gotoxy(6,14);
textcolor(YELLOW);
cprintf("4");
gotoxy(10,14);
textcolor(WHITE);
cprintf("< Later Addition >");
gotoxy(45,8);
textcolor(YELLOW);
cprintf("5");
gotoxy(49,8);
textcolor(WHITE);
cprintf("Magnitude and Direction");
gotoxy(45,10);
textcolor(YELLOW);
cprintf("6");
gotoxy(49,10);
textcolor(WHITE);
cprintf("Vector Travel Time");
gotoxy(45,12);
textcolor(YELLOW);
cprintf("7");
gotoxy(49,12);
textcolor(WHITE);
cprintf("Distance Traveled From Target");
gotoxy(45,14);
textcolor(YELLOW);
cprintf("8");
gotoxy(49,14);
textcolor(WHITE);
cprintf("Online Help Menu");
gotoxy(45,16);
textcolor(YELLOW);
cprintf("9");
gotoxy(49,16);
textcolor(WHITE);
cprintf("Quit Mathematics Toolbox");
menucursor();
userchoice();
}

userchoice(void)
{
int choice;
textcolor(WHITE);

scanf("%d",&choice);
	switch (choice) {

		case 1:
			 quadsolve();

		case 2:
			 lawofsines();

		case 3:
			 lawofcosines();

		case 5:
			 mag_and_dir();

		case 6:
			 traveltime();

		case 7:
			 dist_traveled();

		case 8:
			 helpmenu();

		case 9:
			 endprogram();

		default: menuerror();


			}
menu();
}

menuerror()
{
menu();
}

menucursor()
{
gotoxy(43,21);
}

quadsolve()
{
long float a,b,c;
long float ans1,ans2,ans3,ans4;
submenu();
textcolor(WHITE);
textbackground(BLUE);
gotoxy(26,1);
cprintf("%c",181);
gotoxy(55,1);
cprintf("%c",198);
gotoxy(27,1);
textcolor(YELLOW);
cprintf(" Quadratic Equation Solving ");
gotoxy(18,10);
cprintf("Enter the value for A:");
gotoxy(41,10);
cscanf("%lf",&a);
gotoxy(18,11);
cprintf("Enter the value for B:");
gotoxy(41,11);
cscanf("%lf",&b);
gotoxy(18,12);
cprintf("Enter the value for C:");
gotoxy(41,12);
cscanf("%lf",&c);
ans3 = -b+(sqrt((b*b)-4*a*c));
ans4 = -b-(sqrt((b*b)-4*a*c));
ans1 = (ans3 / (2*a));
ans2 = (ans4 / (2*a));
gotoxy(18,14);
cprintf("Answer 1:  %.3f",ans1);
gotoxy(18,15);
cprintf("Answer 2:  %.3f",ans2);
gotoxy(18,18);
cprintf("< Hit enter to return to the Main Menu >");
cursor();
getch();
getch();

menu();
}

lawofsines()
{
long float a,a1,b,b1,buf1,buf2,buf3,buf4,dist,rad_ang,deg_ang;
int choice,choice2;

submenu();
gotoxy(34,1);
textcolor(WHITE);
cprintf("%c",181);
gotoxy(49,1);
cprintf("%c",198);
textcolor(YELLOW);
gotoxy(35,1);
cprintf(" Law of Sines ");
textcolor(WHITE);
gotoxy(26,8);
cprintf("---------");
gotoxy(36,8);
cprintf("=");
gotoxy(38,8);
cprintf("---------");
gotoxy(48,8);
cprintf("=");
gotoxy(50,8);
cprintf("---------");
gotoxy(28,7);
cprintf("Sin A");
gotoxy(40,7);
cprintf("Sin B");
gotoxy(52,7);
cprintf("Sin C");
gotoxy(30,9);
cprintf("a");
gotoxy(42,9);
cprintf("b");
gotoxy(54,9);
cprintf("c");
gotoxy(10,10);
textcolor(YELLOW);
gotoxy(48,10);
textcolor(WHITE);
textcolor(YELLOW);
gotoxy(18,12);
cprintf("Angle ------>");
gotoxy(32,12);
textcolor(WHITE);
cscanf("%lf",&a);
gotoxy(18,13);
textcolor(YELLOW);
cprintf("Distance --->");
gotoxy(32,13);
textcolor(WHITE);
cscanf("%lf",&a1);
gotoxy(18,15);

cprintf("1>");
textcolor(YELLOW);
gotoxy(21,15);
cprintf("Other distance");
gotoxy(18,16);
textcolor(WHITE);
cprintf("2>");
gotoxy(21,16);
textcolor(YELLOW);
cprintf("Other angle");
gotoxy(18,17);
cprintf("----> ");
textcolor(WHITE);
cscanf("%d",&choice);
       switch (choice) {

		case 1:
			gotoxy(18,19);
			textcolor(YELLOW);
			cprintf("Other Angle >");
			gotoxy(32,19);
			textcolor(WHITE);
			cscanf("%lf",&b);
			buf1 = sin(a) / a1;
			dist = abs(sin(b) / buf1);
			gotoxy(18,21);
			textcolor(YELLOW);
			cprintf("Distance >");
			textcolor(WHITE);
			gotoxy(29,21);
			cprintf("%.4lf",dist);
			gotoxy(18,23);
			textcolor(YELLOW);
			cprintf("< Hit enter to return to the Main Menu >");
			getch();
			getch();
			menu();
		case 2:
			gotoxy(18,18);
			textcolor(YELLOW);
			cprintf("Other Distance >");
			gotoxy(35,18);
			textcolor(WHITE);
			cscanf("%lf",&buf4);
			buf2 = sin(a) / a1;
			buf3 = buf2 * buf4;
			rad_ang = asin(buf3);
			deg_ang = rad_ang * 57.2958;
			gotoxy(18,20);
			textcolor(YELLOW);
			cprintf("Angle in Radians >");
			textcolor(WHITE);
			gotoxy(37,20);
			cprintf("%.4lf",rad_ang);
			gotoxy(18,21);
			textcolor(YELLOW);
			cprintf("Angle in Degrees >");
			gotoxy(37,21);
			textcolor(WHITE);
			cprintf("%.4lf",deg_ang);
			gotoxy(20,23);
			textcolor(YELLOW);
			cprintf("< Hit enter to return to the Main Menu >");
			getch();
			getch();
			menu();

		}


}




lawofcosines()
{
long float a,b,c,sas_angleC,buf1,buf2,distance_C,radangle_C,degangle_C;
int prompt;

submenu();
gotoxy(32,1);
textcolor(WHITE);
cprintf("%c",181);
gotoxy(49,1);
cprintf("%c",198);
gotoxy(33,1);
textcolor(YELLOW);
cprintf(" Law of Cosines ");
gotoxy(18,4);
textcolor(WHITE);
cprintf("1 >");
gotoxy(22,4);
textcolor(YELLOW);
cprintf("Side-Angle-Side Method");
gotoxy(18,5);
textcolor(WHITE);
cprintf("2 >");
gotoxy(22,5);
textcolor(YELLOW);
cprintf("Standard Method");
gotoxy(18,6);
cprintf("---->");
gotoxy(24,6);
textcolor(WHITE);
cscanf("%d",&prompt);

	switch (prompt) {

		case 1:
			gotoxy(18,8);
			textcolor(YELLOW);
			cprintf("Enter Distance [a] >");
			gotoxy(39,8);
			textcolor(WHITE);
			cscanf("%lf",&a);
			gotoxy(18,9);
			textcolor(YELLOW);
			cprintf("Enter Distance [b] >");
			gotoxy(39,9);
			textcolor(WHITE);
			cscanf("%lf",&b);
			gotoxy(18,10);
			textcolor(YELLOW);
			cprintf("Enter Angle [C]    >");
			gotoxy(39,10);
			textcolor(WHITE);
			cscanf("%lf",&sas_angleC);

			buf1 = (a*a) + (b*b) -  (2*a*b)*(cos(sas_angleC));
			distance_C = sqrt(buf1);
			gotoxy(18,12);
			textcolor(YELLOW);
			cprintf("Distance C >");
			gotoxy(31,12);
			cprintf("%.4lf",distance_C);
			gotoxy(20,18);
			cprintf("< Hit enter to return to the Main Menu >");
			cursor();
			getch();
			getch();
			menu();



		case 2:
			textcolor(YELLOW);
			gotoxy(18,8);
			cprintf("Enter the Value for [a] >");
			textcolor(WHITE);
			gotoxy(44,8);
			cscanf("%lf",&a);
			gotoxy(18,9);
			textcolor(YELLOW);
			cprintf("Enter the Value for [b] >");
			textcolor(WHITE);
			gotoxy(44,9);
			cscanf("%lf",&b);
			gotoxy(18,10);
			textcolor(YELLOW);
			cprintf("Enter the Value for [c] >");
			gotoxy(44,10);
			textcolor(WHITE);
			cscanf("%lf",&c);

			buf1 = ((a*a) + (b*b) - (c*c));
			buf2 = (buf1 / (2*a*b));
			radangle_C = acos(buf2);
			degangle_C = (radangle_C * 57.2958);
			gotoxy(18,12);
			textcolor(YELLOW);
			cprintf("Angle C >");
			gotoxy(28,12);
			textcolor(WHITE);
			cprintf("%.4lf",radangle_C);
			gotoxy(36,12);
			textcolor(YELLOW);
			cprintf(" Radians");
			gotoxy(28,13);
			textcolor(WHITE);
			cprintf("%.4lf",degangle_C);
			gotoxy(36,13);
			textcolor(YELLOW);
			cprintf(" Degrees");
			gotoxy(20,18);
			cprintf("< Hit enter to return to the Main Menu >");
			cursor();
			getch();
			getch();
			menu();
			}
}

mag_and_dir()
{

long float dist_a,dist_b,ans1,ans2,ang_buf;
long float distance,angle;
long float pi_ans = 3.141592654;

submenu();
textcolor(YELLOW);
textbackground(BLUE);
gotoxy(25,5);
cprintf("Magnitude and Direction Indicator");
gotoxy(25,10);
cprintf("Speed / Distance A> ");
gotoxy(45,10);
cscanf("%lf",&dist_a);
gotoxy(25,11);
cprintf("Speed / Distance B> ");
gotoxy(45,11);
cscanf("%lf",&dist_b);

ans1 = (dist_a * dist_a) + (dist_b * dist_b);
distance = sqrt(ans1);
ans2 = atan(dist_a / dist_b);
angle = (90 - (ans2 * 57.2958));
gotoxy(25,13);
cprintf("Distance >");
gotoxy(36,13);
cprintf("%.3lf",distance);
gotoxy(25,14);
cprintf("Angle    >");
gotoxy(36,14);
cprintf("%lf",angle);
gotoxy(18,18);
cprintf("   < Hit enter to return to the Main Menu >");
cursor();
getch();
getch();
menu();
}

traveltime()
{
long float velocity,time,distance;

submenu();
textcolor(WHITE);
textbackground(BLUE);
gotoxy(30,1);
cprintf("%c",181);
gotoxy(51,1);
cprintf("%c",198);
gotoxy(31,1);
textcolor(YELLOW);
cprintf(" Vector Travel Time ");
gotoxy(33,2);
textcolor(WHITE);
cprintf("  -In Minutes-");
textcolor(YELLOW);
gotoxy(30,10);
cprintf("Velocity >");
gotoxy(41,10);
cscanf("%lf",&velocity);
gotoxy(30,11);
cprintf("Distance >");
gotoxy(41,11);
cscanf("%lf",&distance);
time = ((distance / velocity) * 60);
gotoxy(30,15);
cprintf("Travel Time >");
gotoxy(45,15);
cprintf("%.2lf",time);
gotoxy(18,20);
cprintf("< Hit enter to return to the Main Menu >");
cursor();
getch();
getch();
menu();
}

dist_traveled()
{
long float time, velocity, distance;

submenu();
textcolor(WHITE);
gotoxy(20,1);
cprintf("%c",181);
gotoxy(61,1);
cprintf("%c",198);
textcolor(YELLOW);
gotoxy(21,1);
cprintf(" Distance traveled from original target ");
gotoxy(20,10);
cprintf("Velocity of Acting Force >");
textcolor(WHITE);
gotoxy(47,10);
cscanf("%lf",&velocity);
gotoxy(20,11);
textcolor(YELLOW);
cprintf("Travel Time in Minutes   >");
textcolor(WHITE);
gotoxy(47,11);
cscanf("%lf",&time);
distance = ((velocity * time) / 60);
gotoxy(20,13);
textcolor(YELLOW);
cprintf("Distance From Target     >");
gotoxy(47,13);
textcolor(WHITE);
cprintf("%.3lf",distance);
gotoxy(20,18);
textcolor(YELLOW);
cprintf("< Hit enter to return to the Main Menu >");
cursor();
getch();
getch();
menu();
}

submenu()
{
int j,k;
clrscr();
for (j=1;j<=1900;++j) {
	textcolor(BLUE);
	textbackground(BLUE);
	cprintf(" ");
	}

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

helpmenu()
{
int a,b,prompt;

submenu();
textcolor(WHITE);
gotoxy(35,1);
cprintf("%c",181);
gotoxy(47,1);
cprintf("%c",198);
gotoxy(36,1);
textcolor(YELLOW);
cprintf(" Help Menu ");
drawhelpmenu();
textcolor(WHITE);
gotoxy(18,9);
cprintf("1 >");
gotoxy(18,11);
cprintf("2 >");
gotoxy(18,13);
cprintf("3 >");
gotoxy(18,15);
cprintf("4 >");
gotoxy(44,9);
cprintf("5 >");
gotoxy(44,11);
cprintf("6 >");
gotoxy(44,13);
cprintf("7 >");
gotoxy(44,15);
cprintf("8 >");
gotoxy(22,9);
textcolor(YELLOW);
cprintf("Quadratic Solver");
gotoxy(22,11);
cprintf("Law of Sines");
gotoxy(22,13);
cprintf("Law of Cosines");
gotoxy(22,15);
cprintf("< Not Available >");
gotoxy(48,9);
cprintf("Mag. and Dir.");
gotoxy(48,11);
cprintf("Vec. Travel Time");
gotoxy(48,13);
cprintf("Distance Differ.");
gotoxy(48,15);
textcolor(LIGHTRED);
cprintf("Quit to Main Menu");
helpmenucursor();
textcolor(YELLOW);
cprintf("Choice >");
gotoxy(44,18);
textcolor(WHITE);
cscanf("%d",&prompt);
	switch (prompt) {

		case 1:
			help1();
		case 2:
			help2();
		case 3:
			help3();
		case 4:
			helpmenu();
		case 5:
			help5();
		case 6:
			help6();
		case 7:
			help7();
		case 8:
			menu();
		}
menu();
}

drawhelpmenu()
{
int a,b;

gotoxy(16,8);

for (a=0;a<=50;++a) {
		textcolor(LIGHTGREEN);
		cprintf("%c",205);
		}

gotoxy(16,17);

for (a=0;a<=50;++a) {
		textcolor(LIGHTGREEN);
		cprintf("%c",205);
		}

for (b=8;b<=17;++b)  {
		textcolor(LIGHTGREEN);
		gotoxy(15,b);
		cprintf("%c",186);
		gotoxy(66,b);
		cprintf("%c",186);
		gotoxy(41,b);
		cprintf("%c",186);
		}


for (a=17;a<=20;++a) {
		gotoxy(33,a);
		cprintf("%c",186);
		gotoxy(49,a);
		cprintf("%c",186);
		}

for (a=33;a<=49;++a) {
		gotoxy(a,20);
		cprintf("%c",205);
		}
gotoxy(15,8);
cprintf("%c",201);
gotoxy(15,17);
cprintf("%c",200);
gotoxy(66,8);
cprintf("%c",187);
gotoxy(66,17);
cprintf("%c",188);
gotoxy(41,17);
cprintf("%c",202);
gotoxy(41,8);
cprintf("%c",203);
gotoxy(33,17);
cprintf("%c",203);
gotoxy(49,17);
cprintf("%c",203);
gotoxy(33,20);
cprintf("%c",200);
gotoxy(49,20);
cprintf("%c",188);
}

helpmenucursor()
{
gotoxy(35,18);
}

help1()
{
int a;

submenu();
gotoxy(28,1);
cprintf("%c",181);
gotoxy(53,1);
cprintf("%c",198);
textcolor(YELLOW);
gotoxy(29,1);
cprintf(" Quadratic Solving Help ");
gotoxy(8,9);
textcolor(YELLOW);
cprintf("This function uses the quadratic formula to find the solutions");
gotoxy(3,10);
cprintf("   for a given equation.  A zero may not be entered for the <A> value");
gotoxy(3,11);
cprintf("   If you encounter a DIVISION BY ZERO error, or a DOMAIN error, then");
gotoxy(3,12);
cprintf("                     the equation has no solution.");
gotoxy(20,20);
textcolor(WHITE);
cprintf("< Hit any key to return to the Help Menu >");
cursor2();
getch();
getch();

helpmenu();
}

cursor2()
{
textcolor(BLUE);
textbackground(BLUE);
gotoxy(1,25);
cprintf("%c",219);
gotoxy(1,25);
}

help2()
{
int a,b;
submenu();
gotoxy(32,1);
textcolor(WHITE);
cprintf("%c",181);
gotoxy(52,1);
cprintf("%c",198);
gotoxy(33,1);
textcolor(YELLOW);
cprintf(" Law of Sines Help ");
gotoxy(8,9);
textcolor(YELLOW);
cprintf("This function solves for either an angle, or a distance.  To enable");
gotoxy(3,10);
cprintf("       this function to work, you must not enter a zero for any of the");
gotoxy(3,11);
cprintf("       distance values.  You also should not enter zero for any of the");
gotoxy(3,12);
cprintf("        values you are prompted for.  This avoids possible errors.");
gotoxy(20,18);
textcolor(WHITE);
cprintf("< Hit enter to return to the Help Menu >");
cursor2();
getch();
getch();
helpmenu();
}

help3()
{
int a,b;

submenu();
gotoxy(28,1);
cprintf("%c",181);
gotoxy(51,1);
cprintf("%c",198);
gotoxy(29,1);
textcolor(YELLOW);
cprintf(" Laws of Cosines Help ");
gotoxy(8,9);
cprintf("This function uses a formula to determine either the distance or");
gotoxy(3,10);
cprintf("    the angle in a triangle.  Do not enter zero for any of the values.");
gotoxy(3,11);
cprintf("                To do so would risk errors in your answers.");
gotoxy(20,18);
textcolor(WHITE);
cprintf("< Hit enter to return to the Help Menu >");
cursor2();
getch();
getch();
helpmenu();
}

help5()
{
submenu();
textcolor(WHITE);
gotoxy(29,1);
cprintf("%c",181);
gotoxy(50,1);
cprintf("%c",198);
textcolor(YELLOW);
gotoxy(30,1);
cprintf(" Mag. and Dir. Help ");
gotoxy(8,9);
cprintf("This function tells you the magnitude and direction that is ");
gotoxy(3,10);
cprintf("                  traveled in a particular vector.");
gotoxy(20,18);
textcolor(WHITE);
cprintf("< Hit enter to return to the Help Menu >");
cursor2();
getch();
getch();
helpmenu();
}

help6()
{
submenu();
gotoxy(28,1);
textcolor(WHITE);
cprintf("%c",181);
gotoxy(52,1);
cprintf("%c",198);
gotoxy(29,1);
textcolor(YELLOW);
cprintf(" Vec. Travel Time Help ");
gotoxy(8,9);
cprintf("This function gives you the travel time inside of a particular");
gotoxy(3,10);
cprintf("      vector.  You must first calculate the velocity, and know the");
gotoxy(3,11);
cprintf("                              distance.");
gotoxy(20,18);
textcolor(WHITE);
cprintf("< Hit enter to return to the Help Menu >");
cursor2();
getch();
getch();
helpmenu();

}

help7()
{
submenu();
gotoxy(25,1);
textcolor(WHITE);
cprintf("%c",181);
gotoxy(55,1);
cprintf("%c",198);
textcolor(YELLOW);
gotoxy(26,1);
cprintf(" Difference in Distance Help ");
gotoxy(8,9);
cprintf("This function determines the distance that you are off of your");
gotoxy(3,10);
cprintf("       target.  You must first calculate your velocity as well as");
gotoxy(3,11);
cprintf("                              your time.");
gotoxy(20,18);
textcolor(WHITE);
cprintf("< Hit enter to return to the Help Menu >");
cursor2();
getch();
getch();
helpmenu();
}


endprogram()
{
clrscr();
textcolor(WHITE);
gotoxy(28,11);
cprintf("You Have Been Using....");
cursor();
sleep(2);
clrscr();
gotoxy(30,11);
textcolor(LIGHTRED);
cprintf("Mathematics Toolbox");
cursor();
sleep(2);
textcolor(LIGHTMAGENTA);
textbackground(WHITE);
clrscr();
delay(200);
textbackground(BLACK);
clrscr();
delay(200);
textbackground(WHITE);
clrscr();
delay(200);
textbackground(BLACK);
clrscr();
delay(200);
gotoxy(32,13);
cprintf("Black Lotus Software");
gotoxy(27,13);
textcolor(YELLOW);
cprintf("1996");
cursor();
sleep(3);
gotoxy(1,24);
exit(1);
}



main()
{
titlescrn();
getch();
}

