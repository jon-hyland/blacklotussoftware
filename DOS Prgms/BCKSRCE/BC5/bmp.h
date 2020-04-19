// Simple Bitmap Header File
// Some routines pulled from Graphic Programmers Handbook
// Usage :
//		init_display();  -- initilize graphics mode info (VGAMODE.DAT needed)
//    display_bmp(char [128]); -- display bitmap file
//    end_display();   -- return to mode 3 (text mode)
//
//	 Note : Due to the incompatibility of C++ compilers, Borland C++ 5.02
//         will come up with 8 Ambiguous operator errors that should not
//         give you any problems.  Code should execute properly.

#include <stdio.h>
#include <dos.h>
#include <stdlib.h>


int getModeData(int mode);
void setBank(unsigned long int offset);
void setMode(int mode);

union REGS reg;
struct SREGS segregs;
struct REGPACK outregs;

struct
{
	unsigned int 	    id;
	unsigned long int	file_size;
	unsigned int		reserved[2];
	unsigned long int	image_offset;
	unsigned int		header_size,
						not_used;
	unsigned long int	xres,
						yres;
	unsigned int		no_of_planes,
						bits_per_pixel;
	unsigned long int	compression_method,
						bit_map_size,
						hor_res,
						vert_res,
						number_of_colors,
						no_significant_colors;
}   bmp_header;

struct
{
	char signature[4];
	int version;
	long int far *OEM_string;
	char capabilities[4];
	long int far *Modes;
	int memory_size;
	char reserved[236];
} info;

struct
{
	int 		ModeAttributes;
	char 		WinAAttributes;
	char 		WinBAttributes;
	int 		WinGranularity;
	int 		WinSize;
	int 		WinASegment;
	int 		WinBSegment;
	long int	WinFuncPtr;
	int			BytesPerScanLine;
	int			XResolution;
	int			YResolution;
	char		XCharSize;
	char		YCharSize;
	char		NumberOfPlanes;
	char		BitsPerPixel;
	char	    NumberOfBanks;
	char		MemoryModel;
	char		BankSize;
	char		NumberOfImagePages;
	char 		Reserved;
	char 		Filler[225];
} mode_data;

void setBank(unsigned long int);
int getModeData(int);
void setMode(int);
void init_display(void);
void display_bmp(char[128]);
void end_display(void);

unsigned int mode16[7], mode256[6], modehi[5];
int bytes_per_line, i, j, k, dir_index= 0, index, end, mode, d,
	color, ch1 = NULL, xres, yres, ystop, type, flag, memory_plane;
unsigned char red, green, blue, palette_data[256][3];
FILE *read_file;
FILE *config_file;
unsigned int no_chars, old_bank, data;
char far * address;
long int col,row;
int ix, xoffset, yoffset, xend, planes;
unsigned long int offset;
int	oldmode;


void setBank(unsigned long int offset)
{
	static int bank, old_bank;

	old_bank = reg.x.dx;
	bank = offset >> 16;
	if (bank == old_bank)
		return;
	reg.x.dx = bank;
	old_bank = bank;
	reg.x.ax = 0x4F05;
	reg.x.bx = 0;
	int86(0x10, &reg, &reg);
}


int getModeData(int mode)
{
		segread(&segregs);
		outregs.r_ax = 0x4F01;
		outregs.r_cx = mode;
		outregs.r_es = segregs.ds;
		outregs.r_di =(unsigned int) &mode_data;
		intr(0x10,&outregs);
		if ((mode_data.ModeAttributes &0x01) == 1)
			return(1);
		return(0);
}


void setMode(int mode)
{
	union REGS reg;
	if (mode > 0xFF)
	{
		reg.x.ax = 0x4F02;
		reg.x.bx = mode;
	}
	else
		reg.x.ax = mode;
	int86 (0x10,&reg,&reg);
}


void init_display(void)
{
	config_file = fopen("vgamode.dat","rb");
	if (config_file == NULL)
   {
		printf("ERROR! Cannot open VGAMODE.DAT.");
      exit(1);
   }
	fread(mode16,2,7,config_file);
	fread(mode256,2,6,config_file);
	fread(modehi,2,5,config_file);
	fclose(config_file);
	segread(&segregs);
}


void display_bmp(char filename[128])
{
      oldmode = mode;
      read_file = fopen(filename,"rb");
      if (read_file == NULL)
      {
      	printf("ERROR! Cannot open bitmap file.");
         exit(1);
      }
		fread(&bmp_header,1,54,read_file);
		xres = bmp_header.xres;
		yres = bmp_header.yres;
		mode = modehi[0];
		if (((xres > 320) || (yres > 200)) && (modehi[1] != 0))
			mode = modehi[1];
		if (((xres > 640) || (yres > 480)) && (modehi[2] != 0))
			mode = modehi[2];
		if (((xres > 800) || (yres > 600)) && (modehi[3] != 0))
			mode = modehi[3];
		if (((xres > 1024) || (yres > 768)) && (modehi[4] != 0))
			mode = modehi[4];
		if (mode != 0)
      {
			outregs.r_ax = 0x4F01;
	      if (mode != oldmode)
				outregs.r_cx = mode;
			segread(&segregs);
			outregs.r_es = segregs.ds;
			outregs.r_di = (unsigned int)&mode_data;
			intr(0x10,&outregs);
			xoffset = max (0,(mode_data.XResolution - xres)/2);
			yoffset = max(0,(mode_data.YResolution - yres)/2);
			ystop = min(yres + yoffset, mode_data.YResolution);
			setMode(mode);
			setBank(0);
			fseek(read_file,bmp_header.image_offset,SEEK_SET);
			for (row = yoffset; row <ystop; row++)
			{
				for (col=0; col < xres; col++)
				{
					blue = fgetc(read_file);
					green = fgetc(read_file);
					red = fgetc(read_file);
					switch(mode)
					{
						case 0x10D:
						case 0x110:
						case 0x113:
						case 0x116:
						case 0x119:
							data = (int)(red & 0xF8) << 7 |
								(int)(green & 0xF8) << 2 |
								(int)(blue & 0xF8) >> 3;
							offset = (ystop-row+yoffset) * mode_data.BytesPerScanLine
								+ 2 * (xoffset + col);
							setBank(offset);
							FP_SEG(address) = 0xA000;
							FP_OFF(address) =(unsigned int) offset;
							*(address++) = data & 0xFF;
							*address = data >> 8;
							break;
						case 0x10E:
						case 0x111:
						case 0x114:
						case 0x117:
						case 0x11A:
							data = (int)(red & 0xF8) << 8 |
								(int) (green & 0xFC) << 3 |
								(int)(blue & 0xF8) >> 3;
							offset = (ystop-row+yoffset) * mode_data.BytesPerScanLine
								+ 2 * (xoffset + col);
							setBank(offset);
							FP_SEG(address) = 0xA000;
							FP_OFF(address) =(unsigned int) offset;
							*(address++) = data & 0xFF;
							*address = data >> 8;
							break;
						case 0x10F:
						case 0x112:
						case 0x115:
						case 0x118:
						case 0x11B:
							offset = (ystop-row+yoffset) * mode_data.BytesPerScanLine
								+ 3 * (xoffset + col);
							setBank(offset);
							FP_SEG(address) = 0xA000;
							FP_OFF(address) =(unsigned int) offset;
							*address = blue;
							offset++;
							setBank(offset);
							FP_SEG(address) = 0xA000;
							FP_OFF(address) =(unsigned int) offset;
							*address = green;
							offset++;
							setBank(offset);
							FP_SEG(address) = 0xA000;
							FP_OFF(address) =(unsigned int) offset;
							*address = red;
					}
				}
				while (4*(col/4) < col)
				{
					fgetc(read_file);
					col++;
				}
         }
		}
		fclose(read_file);
}


void end_display(void)
{
	setMode(3);
}

