#include "dos.h"
#include "stdio.h"
#include "conio.h"
#define start()

main()
{
int choice;
int i;
int cont;
const float benpass = 286343.975;
float enter_pass;

clrscr();

start()
{
	clrscr();
	gotoxy(30,8);
	textcolor(YELLOW);
	cprintf("Fortress Phone Boxing");
	gotoxy(35,10);
	textcolor(GREEN);
	cprintf("Version 2.2");
	gotoxy(28,12);
	textcolor(DARKGRAY);
	cprintf("1996 ");
	textcolor(RED);
	cprintf("Black Lotus Software");
	delay(5000);
	clrscr();
	textcolor(WHITE);
	gotoxy(15,10);
	printf("\n1: Nickel\n2: Dime\n3: Quarter\n4: Pay Phone Greenbox\n\nEnter your choice now:----->");
	scanf("%d",&choice);


switch (choice) {

	case 1:
		printf("Hit enter to simulate a Nickel...");
		getch();
		nosound();
		sound(2200 & 1700);
		delay(66);
		nosound();
		clrscr();
		gotoxy(20,10);
		printf("Return to Main Menu?");
		printf("\n1: Yes\n2: No\n --->");
		getch();
		scanf("%d",&cont);
		switch (cont)  {

		case 1:
			start();
			}





case 2:

		getch();
		printf("Hit enter to simulate a Dime...");
		getch();
		nosound();
		sound(2200 & 1700);
		delay(66);
		nosound();
		delay(66);
		sound(2200 & 1700);
		delay(66);
		nosound();
		clrscr();
		gotoxy(20,10);
		printf("Return to Main Menu?");
		printf("\n1: Yes\n2: No\n--->");
		getch();
		scanf("%d",&cont);

	      switch (cont) {
		case 1: start();
			}


case 3:

		getch();
		printf("Hit enter to simulate a Quarter...");
		getch();
		nosound();
		sound(2200 & 1700);
		delay(33);
		nosound();
		delay(33);
		sound(2200 & 1700);
		delay(33);
		nosound();
		delay(33);
		sound(2200 & 1700);
		delay(33);
		nosound();
		delay(33);
		sound(2200 & 1700);
		delay(33);
		nosound();
		delay(33);
		nosound();
		clrscr();
		gotoxy(20,10);
		printf("Return to Main Menu?");
		printf("\n1: Yes\n2: No\n --->");
		getch();
		scanf("%d",&cont);
		switch (cont)  {
		case 1:  start();
		}


case 4:

		getch();
		printf("Hit enter to send the Coin Return signal to your payphone...");
		getch();
		nosound();
		sound(2600);
		delay(90);
		nosound();
		delay(60);
		sound(1100 & 1700);
		delay(900);
		nosound();
		clrscr();
		gotoxy(20,10);
		printf("Return to Main Menu?");
		printf("\n1: Yes\n2: No\n--->");
		getch();
		scanf("%d",&cont);
		switch (cont) {
		case 1: start();
		}


};
};
}
