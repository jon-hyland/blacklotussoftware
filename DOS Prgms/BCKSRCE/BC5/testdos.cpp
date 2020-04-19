#include <fstream.h>
#include <string.h>
#include <dos.h>
#include <c:\bc5\jons\bls.h>

struct High_score_struct
{
	char  name[17];
   long	points;
};


int newhs = 3;

void main(void)
{
	void reset_high_score(void);
   void list_high_score(void);

   reset_high_score();
   list_high_score();
}

void reset_high_score(void)
{
	fstream high_score;

   high_score.open("HSLIST.DAT", ios::out);
	for (int i=0; i<10; i++)
         high_score << "[EMPTY] " << (10-i) << " ";
   high_score.close();
}


void list_high_score(void)
{
	fstream high_score;
   char name[17];
   int points;

   draw_window(26,7,53,18,4,"High Score List");
   high_score.open("HSLIST.DAT", ios::in);
   for(int i=0; i<10; i++)
   {
		high_score >> name >> points;
      textcolor(YELLOW);
      textbackground(RED);
   	if (i == newhs)
      {
      	textcolor(WHITE);
         textbackground(MAGENTA);
      }
      gotoxy(28, i+8);
      cprintf("%s", name);
      for(int j=1; j<=(20-strlen(name)); j++)
      	cprintf(".");
      cprintf("%d", points);
   }
   high_score.close();
   cursor();
	pause();
}




