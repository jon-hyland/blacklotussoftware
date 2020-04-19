#include <stdio.h>
#include "c:\bc5\jons\bls.h"

void main(void)
{
	char	str1[80], str2[80];

   textbackground(BLUE);
   printf("Enter string 1 : ");
   scanf("%s", str1);
   printf("Enter string 2 : ");
   scanf("%s", str2);
   cprintf("\n%s\n%s", str1, str2);
   cprintf("\n%s", add_str(str1, str2));
}
