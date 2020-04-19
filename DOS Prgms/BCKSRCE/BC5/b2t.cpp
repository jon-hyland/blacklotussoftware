// --== BLS Binary 2 Text - v1.0 ==--
//  (c) 1998  Black Lotus Software
//  All promramming by Jon Hyland

#include <stdio.h>
#include <iostream.h>
#include <stdlib.h>
#include <time.h>
#include <conio.h> // getch(), REMOVE

const	char	progname[] = "BLS Binary 2 Text";
const char	vernum[]   = "v1.0";

inline void moveup(unsigned char &byte, unsigned char amount)
{
	byte += amount;
   if (byte > 254)
   	byte -= 255;
}

int main(void)
{
	void display_info(void);
   void get_io_names(char[], char[]);

	char 	inname[128], outname[128];
   FILE  *infile,	*outfile;
	//int	protect=0;
   //char	password[12];
	float	seed;
   char	seedstr[15];
   unsigned char	byte;
	unsigned char	count;
   int	col=0;

   display_info();												// display title
   get_io_names(inname, outname);							// get filenames
	infile = fopen(inname, "rb");								// open input file
   outfile = fopen(outname, "wt");							// open output file
   if ((infile == NULL) || (outfile == NULL))		  	// if file cant open,
   {
   	cout	<< "Error. Cannot open file.\n\n";			//	terminate program
      exit(1);
   }
	randomize();
   do
      seed = random(256) * (random(256)+1);				// get seed number
   while ((seed < 10000) || (seed > 99999));
   itoa(seed, seedstr, 10);  									// convert to text
   fwrite("BLSB2T", 6, 1, outfile);							// write id to outfile
   fwrite(seedstr, strlen(seedstr)+1, 1, outfile);		// write seed to outfile
   fwrite("\n", 1, 1, outfile);								// end line /w spaces
   srand(seed);													// init rand gen /w seed
   while (!feof(infile))										// while not end of infile
   {
		fread(&byte, 1, 1, infile);							// read next byte
      count = 32;
      do
      {
      	moveup(byte, random(255));
         count++;
	   }
      while ((byte < 126) || (byte > 254));
      if (count > 125)
      {
      	cout << "Error. Count reached " << count << ".\n";
         exit(2);
      }
      fwrite(&count, 1, 1, outfile);
      fwrite(&byte, 1, 1, outfile);
      col++;
      if (col > 35)
      {
      	fwrite("\n", 1, 1, outfile);
         col = 0;
      }
   }
	fclose(infile);
   fclose(outfile);
   cout	<<	"Done.\n\n";
}


void display_info(void)
{
	cout	<< "--== " << progname << " - " << vernum << "==--" << endl
   		<<	"(c) 1998  Black Lotus Software" << endl
         << "All programming by Jon Hyland" << endl
         <<	"Type ""B2T /h"" for usage information." << endl << endl;
}

void get_io_names(char *inname, char *outname)
{
	cout	<< "Enter path+name of binary file to encode : ";
   cin.getline(inname, 128);
   cout	<< "Enter path+name of encoded output text file : ";
   cin.getline(outname, 128);
}







