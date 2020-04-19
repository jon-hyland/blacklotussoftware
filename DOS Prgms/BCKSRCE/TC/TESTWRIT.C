#include "stdio.h"
#include "conio.h"

main()
{

char name[20],address[30],phone[20];

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
fprintf(outfile,"%s\n%s\n%s\n",name,address,phone);
fclose(outfile);


}
