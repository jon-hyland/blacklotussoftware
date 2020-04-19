/*************************************************************************
 *         --== Random Desktop Utility v1.0. ==--								 *
 * (c) 1998 Black Lotus Software  -  All rights reserved.                *
 *       Written and compiled in Borlard C++ v5.02.                      *
 *                                                                       *
 *	This program is intended to execute in the specific directory         *
 * "C:\DESKBMP\", which contains various desktop images in the BMP       *
 * format.  A random file will be copied to "CURRENT.BMP", with the      *
 * assumption your Windows desktop will be set to that.  This program    *
 * should be included in your "AUTOEXEC.BAT" file, NOT your Startup      *
 * Folder.                                                               *
 *************************************************************************/

#include <conio.h>				// clrscr()
#include <stdlib.h>           // randomize(), random()
#include <time.h>             // randomize()
#include <dir.h>              // ffblk, findfirst(), findnext()
#include "c:\bc5\jons\bls.h"  // copy_bfile()

struct	ffblk ffblk;		// built in  directory structure
char	 	dir[1000][13];		// filename storage array
char		sourcef[128];		// path + filename strings
int		tot = 0;				// total bitmaps in directory
int		end;					// end of listing
int		num;					// number of new image (in dir[])

void main(void)
{
	randomize();				// initilize rand num generator
	end = findfirst("C:\\DESKBMP\\*.BMP", &ffblk, 0); // find first BMP

	while(!end)					// while not end of listing
	{
		strcpy(dir[tot++], ffblk.ff_name); 	// copy entry to storage array
		end = findnext(&ffblk);				  	// find next BMP file
		if (tot > 999)							  	// if count more than 999,
			break;									// break from loop
	}

	do
   {
	   num = random(tot);						// pick random number within range
   }
   while (!strcmp(dir[num], "CURRENT.BMP"));  	// redo if num cooresponds to
   														 	// CURRENT.BMP

	strcat(sourcef, "C:\\DESKBMP\\");				// combine path + dir[num]
   strcat(sourcef, dir[num]);                   // as new string sourcef
	printf("Copying %s from %d desktop images.. ", dir[num], tot-1);
	copy_bfile(sourcef, "C:\\DESKBMP\\CURRENT.BMP"); // copy source file to
	 															    // CURRENT.BMP
   printf("Done.\n");
}

