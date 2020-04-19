#include "stdio.h"
#include "conio.h"

init()
{

FILE *infile,*fopen();

char prompt[20],name[30],address[30],phone[20];

FILE *outfile;

clrscr();
gotoxy(10,10);

textcolor(YELLOW);
cprintf("Enter your Name >");
gets(name);
gotoxy(10,11);
cprintf("Enter your Address >");
gets(address);
gotoxy(10,12);
cprintf("Enter your Phone Number >");
gets(phone);
gotoxy(10,14);
cprintf("File will be saved as ftest.dat");

outfile = fopen("ftest.dat","w");
fprintf(outfile,"%s%s%s",name,address,phone);
fclose(outfile);
getch();
}

fileopen()
{
clrscr();
gotoxy(10,10);
printf("Enter a file for opening > ");
textcolor(YELLOW);
gets(prompt);

infile = fopen(prompt,"r");

if (infile == NULL) {
			gotoxy(10,12);
			printf("Sorry, file does not exist!");
			getch();
			}

else {
	clrscr();
	gotoxy(10,12);
	printf("This file is open for reading!");
	gotoxy(10,14);
	printf("%s\n%13s\n%13s",name,address,phone);
	fclose(infile);
	getch();
	addnum();
	}
}

}
addnum()
 {
   char name[40],address[50],phone[50];
   FILE *infile,*outfile,*fopen();

   outfile = fopen("ftest.dat","a");

main()
{
init();
}