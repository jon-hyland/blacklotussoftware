#include <stdio.h>
#include <math.h>

#include <conio.h>

float str2float(char *str)
{
  float val = 0;
  int   j;
  int   dec = 0;
  int   place = 0;

  for(j=0; str[j] != '\n'; j++) {
    if ((str[j] >= '0') && (str[j] <= '9')) {
      if (!dec) {
	val = (pow(10,place) * val) + str[j]-48;
	place++;
      }
      else {
	val = val + (str[j]-48) / pow(10,place);
	place++;
      }
    }
    if (str[j] == '.') {
      dec = 1;
      place = 1;
    }
  }
  return(val);
}

main()
{
  int *string;
  float num;
  char junk;


  printf("Enter string : ");
  scanf("%f", &string);
  num = str2float(string);
  printf("%f", num);
  junk = getch();
}






