#include <stdio.h>
#include <conio.h>

main()
{
 char key;

 key = 0;
 clrscr();
 gotoxy(35,10);
 printf("Chr : %c", key);
 gotoxy(35,12);
 printf("Int : %d", key);
 do
 {
   key = getch();
   if (key == 0)
   {
     gotoxy(35,14);
     printf("Extended");
     key = getch();
   }
   else
   {
     gotoxy(35,14);
     printf("        ");
   }
   gotoxy(41,10);
   printf("%c   ", key);
   gotoxy(41,12);
   printf("%d   ", key);
 }
 while (key != 27);
}



