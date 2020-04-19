#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <dos.h>

void cursor(void)
 {
  gotoxy(1,25);
 }

main()
 {
  long int money = 100, moneybet;
  int horsepicked, horse[11], randhorse, randmove, oldplace;
  int j, k;
  int done;

  randomize();
  clrscr();
  gotoxy(34,10);
  printf("- HorseRace -");
  gotoxy(38,12);
  printf("v1.0");
  gotoxy(35,14);
  printf("Jon Hyland");
  gotoxy(1,25);
  textcolor(BLACK);
  cprintf("%c", 219);
  cursor();
  getch();

  clrscr();
  textcolor(BLACK);
  gotoxy(1,25);
  cprintf("%c", 219);
  textcolor(WHITE);
  for (k=1; k<=10; k++)
   {
    gotoxy(1,k);
    printf("[");
    if (k < 10)
     printf("%d", k);
    else
     printf("0");
    printf(":");
    gotoxy(53,k);
    printf("]");
   }
  printf("\r\n\r\nYou have $%ld.", money);
  do
   {
    printf("\r\nWhat horse do you think will win? (1-10) : ");
    scanf("%d", &horsepicked);
   }
  while ((horsepicked < 1) || (horsepicked > 10));
  do
   {
    printf("\r\nHow much money will you bet? $");
    scanf("%ld", &moneybet);
   }
  while ((moneybet < 0) || (moneybet > money));
  printf("\r\nHit a key for race to begin...");
  getch();
  for (j=1; j<=10; j++)
   {
    horse[j] = 0;
    gotoxy(3, j);
    printf(" ");
   }
  cursor();
  done = 0;
  while (done == 0)
   {
    randhorse = random(10)+1;
    randmove = random(3)+1;
    oldplace = horse[randhorse];
    horse[randhorse] = horse[randhorse] + randmove;
    if (horse[randhorse] >= 50)
     {
      horse[randhorse] = 50;
      done = 1;
     }
    gotoxy(oldplace + 2, randhorse);
    printf(" ");
    gotoxy(horse[randhorse] + 2, randhorse);
    if (randhorse < 10)
     printf("%d", randhorse);
    else
     printf("0");
    cursor();
    delay(150);
   }









  cursor();
 }
