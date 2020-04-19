#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>

char 	next_line(char *);
FILE 	*win_ini;
FILE	*new_ini;
char	fstat;

void main(void)
{
   char	line[256];
	char	wall[9];
   char	newline = 10;

   win_ini = fopen("C:\\WIN95\\WIN.INI", "rt");
	new_ini = fopen("C:\\WIN95\\WINNEW.INI", "wt");
   if ((win_ini == NULL) || (new_ini == NULL))
   {
   	printf("Error!  Cannot open .INI file.\n");
      exit(1);
   }
	do
   {
		fstat = next_line(line);
      fwrite(line, sizeof(line), 1, new_ini);
      fwrite(&newline, sizeof(newline), 1, new_ini);
   }
   while ((strcmpi(line, "[DESKTOP]")) && (fstat != EOF));
	fstat = next_line(line);
   strncpy(wall, line, 9);
   while ((strcmpi(wall, "WALLPAPER")) && (fstat != EOF))
   {
		fwrite(line, strlen(line), 1, new_ini);
      fwrite(&newline, sizeof(newline), 1, new_ini);
      fstat = next_line(line);
      strncpy(wall, line, 9);
   }
	if (fstat != EOF)
   {
	   strcpy(line, "WALLPAPER=C:\\IMAGES\\MILLER.BMP\0");
      do
      {
      	fstat = next_line(line);
	      fwrite(line, strlen(line), 1, new_ini);
   	   fwrite(&newline, sizeof(newline), 1, new_ini);
      }
      while (fstat != EOF);
   }
   else
   	printf("Error!  Unexpected end of file.\n");
   fclose(win_ini);
   fclose(new_ini);
}

char next_line(char *line)
{
   char	chr;
   char	endstr = '\0';

	for(int i=0; i<256; i++)
   	line[i] = '\0';
   fread(&chr, sizeof(chr), 1, win_ini);
   while ((chr != 10) && (chr != EOF))
   {
      strcat(line, &chr);
      fread(&chr, sizeof(chr), 1, win_ini);
   }
	strcat(line, &endstr);
   return(chr);
}


