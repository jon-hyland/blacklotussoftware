#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

struct Area_struct
{
	int	cha[40][24][2];
   int	fcl[40][24][2];
   int	bcl[40][24][2];
   int	dat[40][24];
};

void main(void)
{
	Area_struct	area, junk;
	const char	filename[] = "WORMBOMB.LEV";
   FILE	*mapfile;
   char	key;
   int	num = 0;
   int	count = 0;

	randomize();
   printf("About to reset Wormbomb 2000 level database! Continue? (Y/N) : ");
   key = getch();
	key = toupper(key);
   printf("%c", key);
   if (key == 'Y')
   {
      while ((num > 25) || (num < 1))
      {
			printf("\n\n%d\n\n", num);
   		printf("\nHow many random levels? (1-25) : ");
         scanf("%d", &num);
      }
      printf("Creating %d levels...", num);
		mapfile = fopen(filename, "wb");
	   for (int i=0; i<num; i++)
      {
         for (int k=0; k<24; k++)
         	for (int j=0; j<40; j++)
            {
            	area.dat[j][k] = 0;
               for (int h=0; h<2; h++)
               {
               	area.cha[j][k][h] = random(3)+176;
                  area.fcl[j][k][h] = random(16);
                  area.bcl[j][k][h] = random(8);
               }
            }
         area.fcl[0][0][0] = 15;
         area.bcl[0][0][0] = 0;
         area.cha[0][0][0] = i + 49;
         printf("X");
      	fwrite(&area, sizeof(area), 1, mapfile);
      }
      fclose(mapfile);
      mapfile = fopen(filename, "rb");
      if (mapfile == NULL)
      {
      	printf("\nError! Cannot open file!");
         exit(1);
      }

      // correct number of levels created, but incorrect count of them.
      // feof not true even after last struct read. why?

      while (!feof(mapfile))
      {
      	fread(&junk, sizeof(junk), 1, mapfile);
         count++;
         printf("%c", junk.cha[0][0][0]);
      }
      fclose(mapfile);
      if (count != num)
      {
      	printf("\nError! %d levels found!", count);
         printf("Struct size = %d %d", sizeof(junk), sizeof(area));
         exit(2);
      }
      printf("\n%d levels created successfully.", count);
   }
}







