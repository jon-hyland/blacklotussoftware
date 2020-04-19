#include <stdio.h>
#include <math.h>
main()
{
  float aval,bval,cval,ans1,ans2,ans3,ans4;
  char cont;

  clrscr();
  gotoxy (39,12);
  printf("Quadratic Equation Solver\nVersion 2.0\nBy Ben Chase\n1996 Eternal Damnation Software");
  delay(2500);
  do
  {
    do
    {
      printf("\nEnter the values for A, B, and C below.\nENTER>");
      scanf("%f,%f,%f",&aval,&bval,&cval);
      if (aval == 0)
	printf("Error, Division by 0!\n");
    }
    while (aval == 0);
    ans1 = bval + sqrt((bval*bval) - 4 * aval * cval);
    ans2 = (ans1) / (2 * aval);
    ans3 = bval - sqrt((bval * bval) - 4 * aval * cval);
    ans4 = (ans3) / (2 * aval);
    printf("Your two answers are : %f  and : %f", ans2, ans4);
    do
    {
      printf("Continue (Y/N)?");
      scanf("%c", &cont);
      cont = toupper(cont);
    }
    while ((cont != 'Y') && (cont != 'N'));
  }
  while (cont == 'Y');
  clrscr();
}
