/* This program should add two numbers together after asking for them. */

#include <stdio.h>

main()
{
	int a,b,sum;

	printf("Enter two numbers:  ";
	scanf("%d %d",&a,&b);
	sum = a + b;
	printf("The sum is %d  \n",sum);

}