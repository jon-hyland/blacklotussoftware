#include "dos.h"
#include "stdio.h"
#include "ctype.h"
#include "conio.h"

screen()
{
clrscr();
textbackground(BLACK);
clrscr();
}

cursor()
{
gotoxy(1,25);
textcolor(BLACK);
textbackground(BLACK);
cprintf("%c",219);
}

titlewindow()
{
int j,k;
screen();
textcolor(MAGENTA);
for (k=4; k<=6; k++)
 {
  gotoxy(20,k);
  cprintf("%c", 186);
  gotoxy(60,k);
  cprintf("%c", 186);
 }
for (j=20; j<=60; j++)
 {
  gotoxy(j,4);
  cprintf("%c", 205);
  gotoxy(j,6);
  cprintf("%c", 205);
 }
gotoxy(20,4);
cprintf("%c",201);
gotoxy(60,4);
cprintf("%c",187);
gotoxy(20,6);
cprintf("%c",200);
gotoxy(60,6);
cprintf("%c",188);
gotoxy(29,5);
textcolor(YELLOW);
cprintf("Loading....One moment...");
getch();
title();
}

title()
{
int x,y;
screen();
gotoxy(18,5);
textcolor(BLUE);
	for (x=7;x<=10;++x)  {
		cprintf("%c",176);
		}
	for (x=11;x<=14;++x) {
		cprintf("%c",177);
		}
	for (x=16;x<=19;++x) {
		cprintf("%c",178);
		}
textcolor(RED);
	for (x=20;x<=23;++x)  {
		cprintf("%c",176);
		}
	for (x=24;x<=27;++x) {
		cprintf("%c",177);
		}
	for (x=28;x<=31;++x) {
		cprintf("%c",178);
		}
	for (x=32;x<=35;++x) {
		cprintf("%c",177);
		}
	for (x=36;x<=39;++x) {
		cprintf("%c",176);
		}
textcolor(BLUE);
	for (x=40;x<=43;++x)  {
		cprintf("%c",176);
		}
	for (x=44;x<=47;++x) {
		cprintf("%c",177);
		}
	for (x=48;x<=51;++x) {
		cprintf("%c",178);
		}
gotoxy(18,10);
textcolor(BLUE);
	for (x=7;x<=10;++x)  {
		cprintf("%c",176);
		}
	for (x=11;x<=14;++x) {
		cprintf("%c",177);
		}
	for (x=16;x<=19;++x) {
		cprintf("%c",178);
		}
textcolor(RED);
	for (x=20;x<=23;++x)  {
		cprintf("%c",176);
		}
	for (x=24;x<=27;++x) {
		cprintf("%c",177);
		}
	for (x=28;x<=31;++x) {
		cprintf("%c",178);
		}
	for (x=32;x<=35;++x) {
		cprintf("%c",177);
		}
	for (x=36;x<=39;++x) {
		cprintf("%c",176);
		}
textcolor(BLUE);
	for (x=40;x<=43;++x)  {
		cprintf("%c",176);
		}
	for (x=44;x<=47;++x) {
		cprintf("%c",177);
		}
	for (x=48;x<=51;++x) {
		cprintf("%c",178);
		}
textcolor(YELLOW);
	for (y=6;y<=9;++y) {
		gotoxy(19,y);
		cprintf("%c",186);
		}
	for (y=6;y<=9;++y) {
		gotoxy(60,y);
		cprintf("%c",186);
		}


user();
}

user()
{
char benkey[8];
char prompt[10];
gotoxy(25,7);
textcolor(YELLOW);
cprintf("Key required to gain access!");
gotoxy(30,8);
cprintf("---------");
textcolor(RED);
cprintf("%c",238);
textcolor(BLACK);
cscanf("%c",&prompt);

	switch (prompt) {

		case :
				endprog();
		default:
				errormsg();

				}
}
endprog()
{
screen();
textcolor(YELLOW);
cprintf("Password accepted.....");
exit(1);
}

errormsg()
{
screen();
textcolor(RED);
gotoxy(20,5);
cprintf("You have entered an invalid password key");
user();
}

getch();

}



main()
{
titlewindow();

}
