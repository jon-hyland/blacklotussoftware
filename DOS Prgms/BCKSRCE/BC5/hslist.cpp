#include <fstream.h>
#include <string.h>
#include <dos.h>
#include <c:\bc5\jons\bls.h>

struct High_score_struct
{
	char  name[17];
   long	points;
};


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

   draw_window(26,7,53,18,4,"High Score List");
}



void main(void)
{
	void reset_high_score(void);

   reset_high_score();
}