#include <stdio.h>

void main(void)
{
	int x=1;

   switch (x)
   {
   	case 0 : x = 100;
      			break;
      case 1 : x = 0;
      			switch (x)
               {
               	case 0 : printf("You suk");
                  			break;
                  case 1 : printf("Not");
               }
   }
}


