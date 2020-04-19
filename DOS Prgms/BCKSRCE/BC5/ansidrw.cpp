#include <stdio.h>
#include <string.h>
#include <conio.h>

struct BL_map_struct
{
	char 	file_id[8];			// "BLS_MAP"
  	int 	totx;					//	ex. 80
  	int	toty;             // ex. 25
   char	huge cha[128][64];		// data characters
   int   huge fcl[128][64];		// foreground color
   int	huge bcl[128][64];		// background color
   int	huge dat[128][64];		// object data
};


class BL_map
{
   public :
   	BL_map_struct obj;
      BL_map(int = 80, int = 24);		// init constructor
      BL_map(BL_map &);						// copy constructor
      int save(char *);				// save the map to disk
      int open(char *);
      void display(int, int, int, int, int, int);
      void display_ch(int, int, int, int);
      void write(BL_map_struct &, int, int, int, int);
      void read(BL_map_struct &, int, int, int, int);
};





BL_map::BL_map(int tx, int ty)
{
   strcpy(obj.file_id, "BLS_MAP");
   obj.totx = tx;
   obj.toty = ty;
   for(int k=0; k<128; k++)
   	for(int j=0; j<250; j++)
      {
      	obj.cha[j][k] = ' ';
         obj.fcl[j][k] = 15;
         obj.bcl[j][k] = 0;
         obj.dat[j][k] = 0;
      }
}

BL_map::BL_map(BL_map &copy_map)
{
   strcpy(obj.file_id, "BLS_MAP");
   obj.totx = copy_map.obj.totx;
   obj.toty = copy_map.obj.toty;
   for(int k=0; k<128; k++)
   	for(int j=0; j<256; j++)
      {
      	obj.cha[j][k] = copy_map.obj.cha[j][k];
      	obj.fcl[j][k] = copy_map.obj.fcl[j][k];
      	obj.bcl[j][k] = copy_map.obj.bcl[j][k];
      	obj.dat[j][k] = copy_map.obj.dat[j][k];
      }
}


int BL_map::save(char *filename)
{
	FILE *write_file;
   int	did_open;

   if ((write_file = fopen(filename, "wb")) != NULL)
   {
      did_open = 1;
	   fwrite(&obj, sizeof(obj), 1, write_file);
   }
   else
   	did_open = 0;
   fclose(write_file);
   return(did_open);
}


int BL_map::open(char *filename)
{
	FILE *read_file;
   int	did_open;

   if ((read_file = fopen(filename, "rb")) != NULL)
   {
   	did_open = 1;
      fread(&obj, sizeof(obj), 1, read_file);
   }
   else
   	did_open = 0;
   fclose(read_file);
   return(did_open);
}


void BL_map::display(int xo, int yo, int x1, int y1, int x2, int y2)
{
	for(int k=y1; k<=y2; k++)
   	for(int j=x1; j<=x2; j++)
      {
     		gotoxy(j-xo, k-yo);
         textcolor(obj.fcl[j][k]);
         textbackground(obj.bcl[j][k]);
         cprintf("%c", obj.cha[j][k]);
      }
}

void BL_map::display_ch(int xo, int yo, int x, int y)
{
	textcolor(obj.fcl[x][y]);
   textbackground(obj.bcl[x][y]);
   gotoxy(x-xo, y-yo);
   cprintf("%c", obj.cha[x][y]);
}


void BL_map::write(BL_map_struct &out_map, int x1, int y1, int x2, int y2);
{
	for(int k=y1; k<=y2; k++)
   	for(int j=x1; j<=x2; j++)
      {
      	map.cha[j][k] = out_map.cha[j-x1][k-y1];
      	obj.fcl[j][k] = out_map.fcl[j-x1][k-y1];
      	obj.bcl[j][k] = out_map.bcl[j-x1][k-y1];
      	obj.dat[j][k] = out_map.dat[j-x1][k-y1];
      }
}

void BL_map::read(BL_map_struct &in_map, int x1, int y1, int x2, int y2)
{
	for(int k=y1; k<=y2; k++)
   	for(int j=x1; j<=x2; j++)
      {
      	in_map.cha[j-x1][k-y1] = obj.cha[j][k];
      	in_map.fcl[j-x1][k-y1] = obj.fcl[j][k];
      	in_map.bcl[j-x1][k-y1] = obj.bcl[j][k];
      	in_map.dat[j-x1][k-y1] = obj.dat[j][k];
      }
	in_map.totx = x2 - x1 + 1;
   in_map.toty = y2 - y1 + 1;
}




void main(void)
{
	BL_map map1, map2;

	randomize();
   for(int j=0; j<80; j++)
   	for(int k=0; k<24; k++)
      {
      	map1.obj.fcl = random(16);
         map1.obj.bcl = ranom(8);
         map1.obj.cha = random(3)+176;
         map1.obj.dat = random(3);
      }
   map1.save("c:\\bc5\\jons\\cool.bcl");
   map2.open("c:\\bc5\\jons\\cool.bcl");
   map2.display(0,0,0,0,79,23);
   getch();
}


