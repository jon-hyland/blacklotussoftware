#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

char charset[15][10];

void main(void)
{
	FILE *infile, *outfile;
   char	temp;

   infile = fopen("C:\\PERSONAL\\COOLDRAW\\CHARSET.DAT", "rt");
   for(int k=0; k<15; k++)
   	for(int j=0; j<10; j++)
      {
      	fread(&temp, sizeof(temp), 1, infile);
         charset[k][j] = temp;
      }
   fclose(infile);
   outfile = fopen("C:\\BC5\\JONS\\CHARSET.DAT", "wb");
   fwrite(&charset, sizeof(charset), 1, outfile);
   fclose(outfile);
   for(int k=0; k<15; k++)
   	for(int j=0; j<10; j++)
      	charset[k][j] = ' ';
   outfile = fopen("C:\\BC5\\JONS\\CHARSET.DAT", "rb");
   fread(&charset, sizeof(charset), 1, outfile);
   fclose(outfile);
   clrscr();
   for(int k=0; k<15; k++)
   {
   	for(int j=0; j<10; j++)
      	printf("%c", charset[k][j]);
      printf("\n");
   }
}



