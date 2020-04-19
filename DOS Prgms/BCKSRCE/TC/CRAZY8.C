#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int deck[52], discard[52], hand1[52], hand2[52];
int decknum, disnum, hand1num, hand2num;

void init(void)
{
  randomize();
}

void cursor(void)
{
  gotoxy(1,25);
}

void title(void)
{
  clrscr();
  gotoxy(32,10);
  printf("- Crazy8s  v1.0 -");
  gotoxy(32,12);
  printf("Jon Hyland 3/7/96");
  cursor();
  getch();
}

void drawscreen(void)
{
  int j, k;

  clrscr();
  for(k=1; k<=24; k++)
  {
    gotoxy(1, k);
    printf("|");
    gotoxy(80, k);
    printf("|");
  }
  for(j=1; j<=80; j++)
  {
    gotoxy(j, 1);
    printf("-");
    gotoxy(j, 5);
    printf("-");
    gotoxy(j, 20);
    printf("-");
    gotoxy(j, 24);
    printf("-");
  }
  for(k=2; k<=4; k++)
  {
    gotoxy(56, k);
    printf("|");
    gotoxy(56, k+19);
    printf("|");
  }
  for(j=17; j<=28; j++)
  {
    gotoxy(j, 9);
    printf("-");
    gotoxy(j+37, 9);
    printf("-");
    gotoxy(j, 16);
    printf("-");
    gotoxy(j+37, 16);
    printf("-");
  }
  for(k=10; k<=15; k++)
  {
    gotoxy(17, k);
    printf("|");
    gotoxy(28, k);
    printf("|");
    gotoxy(54, k);
    printf("|");
    gotoxy(65, k);
    printf("|");
  }



  cursor();
  getch();
}

void shuffle(void)
{
  int j;
  int randcard, swapcard;

  for(j=0; j<52; j++)
    deck[j] = j;
  decknum = 52;
  for(j=0; j<52; j++)
    discard[j] = 0;
  disnum = 0;
  for(j=0; j<52; j++)
  {
    randcard = random(52);
    swapcard = deck[randcard];
    deck[randcard] = deck[j];
    deck[j] = swapcard;
  }
  for(j=0; j<52; j++)
  {
    hand1[j] = 0;
    hand2[j] = 0;
  }
  hand1num = 0;
  hand2num = 0;
}

void deal(void)
{
  int j;

  for(j=0; j<7; j++)
  {
    hand1[hand1num] = deck[decknum-1];
    deck[decknum-1] = 0;
    decknum -= 1;
    hand1num += 1;
    hand2[hand2num] = deck[decknum-1];
    deck[decknum-1] = 0;
    decknum -= 1;
    hand2num += 1;
  }
}

main()
{
  title();
  drawscreen();

}