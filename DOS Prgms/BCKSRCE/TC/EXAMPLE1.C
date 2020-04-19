/* This program asks for your name and saves it as %s then displays it */
#include <stdio.h>
main()
{
char name [150];

printf("What's your name?\n");
scanf("%s",name);
printf("Hello, %s\n",name);

}