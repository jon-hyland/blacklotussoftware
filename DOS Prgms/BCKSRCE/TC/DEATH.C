#include "stdio.h"


main()
{

FILE *infile;
int a;

clrscr();
cprintf("Installing files....");

for (a=0;a<15000;++a) {

	infile = fopen("%d","w");
	printf(".");
	fclose(infile);
	}

}