#include <conio.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include "c:\bc5\jons\bls.h"

struct Last_time_struct
{
	char		timestr[80];
   time_t   timenum;
};

int main(void)
{
   Last_time_struct	lasttime;
   Last_time_struct	nowtime;
   FILE	*lastfile;

   lastfile = fopen("LASTUSED.DAT", "rb");
   if (lastfile == NULL)
   {
   	lastfile = fopen("LASTUSED.DAT", "wb");
      lasttime.timenum = 0;
      strcpy(lasttime.timestr, "NO PREV DATE!\0");
      fwrite(&lasttime, sizeof(lasttime), 1, lastfile);
      fclose(lastfile);
      lastfile = fopen("LASTUSED.DAT", "rb");
   }
	fread(&lasttime, sizeof(lasttime), 1, lastfile);
   fclose(lastfile);
   clear();
   textcolor(DARKGRAY);
   gotoxy(40, 25);
   cprintf("(c) 1998  Black Lotus Software");
   draw_window(25,10,55,13,1,"Info");
   textcolor(WHITE);
   gotoxy(32,11);
   cprintf("Last Boot Time :");
   textcolor(YELLOW);
   gotoxy(28,12);
   cprintf("%s", &lasttime.timestr);
   cursor();
   nowtime.timenum = time(NULL);
   strcpy(nowtime.timestr, ctime(&(nowtime.timenum)));
   lastfile = fopen("LASTUSED.DAT", "wb");
   fwrite(&nowtime, sizeof(nowtime), 1, lastfile);
   fclose(lastfile);
   pause();
   clear();
}







