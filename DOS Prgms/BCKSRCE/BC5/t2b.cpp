#include <stdio.h>
#include <stdlib.h>
#include <iostream.h>
#include <string.h>

const	char	progname[] = "BLS Text 2 Binary";
const char	vernum[]   = "v1.0";

inline void movedown(unsigned char &byte, unsigned char amount)
{
	byte -= amount;
   if (byte < 0)
   	byte += 255;
}

int main(void)
{
   void display_info(void);
	void get_io_names(char *, char *);

	char 	inname[128], outname[128];
   FILE 	*infile, *outfile;
   char	fileinfo[7];
   float	seed;
   char	seedstr[15];
	unsigned char	iter = '\0';
	unsigned char	byte;
   unsigned	char	count;

   display_info();
   get_io_names(inname, outname);
   infile = fopen(inname, "rt");
   outfile = fopen(outname, "wb");
   if ((infile == NULL) || (outfile == NULL))
   {
   	cout	<< "Error. Cannot open file.\n\n";
      exit(1);
   }
	fread(fileinfo, 6, 1, infile);
   fread(seedstr, 5, 1, infile);
   while (iter <= 32)
   	fread(&iter, 1, 1, infile);
//   if (!strcmp(fileinfo, "BLSB2T\0"))
//   {
//   	cout	<< "Incorrect input file type.\n\n";
//      exit(2);
//   }
   cout	<< "!" << iter;

   seed = atof(seedstr);
   srand(seed);
   while (!feof(infile))
   {
		if ((iter <= 32) || (iter >= 126))
      {
      	cout	<< "Incorrect iteration byte.";
         exit(3);
      }
		fread(&byte, 1, 1, infile);
		for(count=32; count<=iter; count++)
			movedown(byte, random(255));
      fwrite(&byte, 1, 1, outfile);
      fread(&iter, 1, 1, infile);
	   while (iter <= 32)
   		fread(&iter, 1, 1, infile);
      cout	<< "!" << iter;
   }
   fclose(infile);
   fclose(outfile);
}



void display_info(void)
{
	cout	<< "--== " << progname << " - " << vernum << "==--" << endl
   		<<	"(c) 1998  Black Lotus Software" << endl
         << "All programming by Jon Hyland" << endl
         <<	"Type ""T2B /h"" for usage information." << endl << endl;
}

void get_io_names(char *inname, char *outname)
{
	cout	<< "Enter path+name of text file to decode : ";
   cin.getline(inname, 128);
   cout	<< "Enter path+name of output binary file : ";
   cin.getline(outname, 128);
}



