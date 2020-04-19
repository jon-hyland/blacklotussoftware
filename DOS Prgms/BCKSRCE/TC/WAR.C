#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int deck[52];
int deckcard;
int hand1[52] hand2[52];
int card1 = 0, card2 = 0;
void shuffle(void);
void deal(void);

main()
{
 int j, k;

 randomize();
 clrscr();
 printf("Shuffling..");
 printf("\nDealing..");
 shuffle();
 deal();
 do
 {
   printf("\n--------------------");
   printf("\nYour total cards  : %d", card1-1);
   printf("\nTheir total cards : %d", card2-1);
   printf("\n\nYou draw a




void shuffle(void)
{
  int j, k, c;

  for(j=0; j<52; j++)
    deck[j] = j+1;
  for(j=0; j<52; j++)
  {
    do
    {
      k = random(52)+1;
    }
    while (k == j);
    c = deck[j];
    deck[j] = deck[k];
    deck[k] = c;
  }
  deckcard = 53;
}

void deal(void)
{
  int j;

  for(j=0; j<52; j++)
  {
    hand1[j] = 0;
    hand2[j] = 0;
  }
  do
  {
    hand1[card1] = deck[deckcard-1];
    card1++;
    deck[deckcard-1] = 0;
    deckcard--;
    hand2[card2] = deck[deckcard-1];
    card2++;
    deck[deckcard-1] = 0;
    deckcard--;
  }
  while (deckcard > 0);
}
