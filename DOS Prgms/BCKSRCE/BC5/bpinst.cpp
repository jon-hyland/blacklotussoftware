#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <string.h>

int main(void)
{
	unsigned 	disk_num;
	char	disk[3];
   FILE	*infile, *outfile;
   char	temp;
   char	filename[256];

	printf("Creating playlist...");
  	_dos_getdrive(&disk_num);
   disk[0] = disk_num + 'A' - 1;
   disk[1] = '\0';

   strcpy(filename, disk);
	strcat(filename, ":\\PROGRAM\\INSTALL\\INSTALL.LST");
	infile = fopen("INSTALL.LST", "rt");
   if (infile == NULL)
   {
   	printf("\nCannot open %s!\n", filename);
      exit(1);
   }
   outfile = fopen("C:\\BLKPLNT\\WINAMP\\WINAMP.M3U", "wt");
	do
   {
     	fread(&temp, sizeof(temp), 1, infile);
   	if (!feof(infile))
      	fwrite(disk, sizeof(temp), 1, outfile);
		while ((temp != 10) && (!feof(infile)))
      {
         fwrite(&temp, sizeof(temp), 1, outfile);
      	fread(&temp, sizeof(temp), 1, infile);
      }
      fwrite(&temp, sizeof(temp), 1, outfile);
   }
   while (!feof(infile));
   fclose(infile);
   fclose(outfile);
   printf(" Done.\n");
}


