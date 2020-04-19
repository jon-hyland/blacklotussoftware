                                           /*
  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
  บ                                                               บ
  บ           BMP = PROGRAM TO VIEW .BMP GRAPHICS FILES           บ
  บ                 USING REGULAR AND VESA MODES                  บ
  บ                                                               บ
  บ                  By Roger T. Stevens  3-31-96                 บ
  บ                                                               บ
  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

#include <dos.h>
#include <string.h>
#include <dir.h>
#include <stdio.h>
#include <conio.h>

#define UP_ARROW		328
#define DOWN_ARROW      336
#define LEFT_ARROW      331
#define RIGHT_ARROW     333
#define BACKSPACE         8
#define seq_out(register,val)  outport(0x3C4,val<<8 | register);
#define max(a,b)    (((a) > (b)) ? (a) : (b))
#define min(a,b)    (((a) < (b)) ? (a) : (b))

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

char directory[100][13];

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

unsigned int mode16[7], mode256[6], modehi[5];
int bytes_per_line, i, j, k, dir_index= 0, index, end, mode, d,
	color, ch1 = NULL, xres, yres, ystop, type, flag, memory_plane;
unsigned char red, green, blue, palette_data[256][3];
char temp[13];
char filename[32];
struct ffblk ffblk;
long int col,row;
FILE *read_file;
FILE *config_file;
unsigned int no_chars, old_bank, data;
char far * address;
int ix, xoffset, yoffset, xend, planes;
unsigned long int offset;

void main(void)
{
	clrscr();
	config_file = fopen("c:\\vconfig.dat","rb");
	fread(mode16,2,7,config_file);
	fread(mode256,2,6,config_file);
	fread(modehi,2,5,config_file);
	fclose(config_file);
	segread(&segregs);
	index = 0;
	end = findfirst("*.bmp",&ffblk,0);
	while(!end)
	{
		strcpy(directory[index++],ffblk.ff_name);
		end = findnext(&ffblk);
		if (index > 99)
			break;
	}
	d = 4;
	while (d < index)
		d += d;
	d--;
	d /= 2;
	while (d >= 1)
	{
		for (j=1; j<index-d; j++)
		{
			for (i=j; i>=1; i-=d)
			{
				if (strcmp(directory[i+d],directory[i]) > 0)
					break;
				strcpy(temp,directory[i]);
				strcpy(directory[i],directory[i+d]);
				strcpy(directory[i+d],temp);
			}
		}
		d /= 2;
	}
	for(;;)
	{
		type = 6;
		setMode(3);
		textbackground(1);
		textcolor(15);
		window(2,2,78,23);
		clrscr();
		gotoxy(1,1);
		putch(0xC9);
		for (i=1; i<19; i++)
		{
			if (i%15)
				putch(0xCD);
			else
				putch(0xD1);
		}
		cprintf(" Select file name with cursor arrows: ");
		for (i=12; i<30; i++)
		{
			if (i%15)
				putch(0xCD);
			else
				putch(0xD1);
		}
		putch(0xBB);
		for (i=2; i<22; i++)
		{
			for (j=1; j<79; j+=15)
			{
				gotoxy(j,i);
				if ((j==1) || (j == 76))
					putch(0xBA);
				else
					putch(0xB3);
			}
		}
		gotoxy(1,22);
		putch(0xC8);
		for (i=1; i<75; i++)
		{
			if (i%15)
				putch(0xCD);
			else
				putch(0xCF);
		}
		putch(0xBC);
		filename[0] = NULL;
		gotoxy(19,1);
		textcolor(7);
		for (i=0; i<index; i++)
		{
			gotoxy(3+(i/20)*15,(i%20)+2);
			cprintf("%s",directory[i]);
		}
		ch1 = 256;
		while ((ch1 != 0x0D) && (ch1 != 0x1B))
		{
			gotoxy(3+(dir_index/20)*15,(dir_index%20)+2);
			cprintf("%s",directory[dir_index]);
			switch(ch1)
			{
				case DOWN_ARROW:
					++dir_index;
					dir_index = dir_index % index;
					break;
				case UP_ARROW:
					--dir_index;
					if (dir_index<0)
						dir_index = index - 1;
					break;
				case RIGHT_ARROW:
					if ((dir_index + 20) < index)
						dir_index += 20;
					break;
				case LEFT_ARROW:
					if (dir_index >= 20)
						dir_index -= 20;
					break;
			}
			textbackground(7);
			textcolor(1);
			gotoxy(3+(dir_index/20)*15,(dir_index%20)+2);
			cprintf("%s",directory[dir_index]);
			textbackground(1);
			textcolor(7);
			ch1 = getch();
			if (ch1 == 0x00)
				ch1 = getch() + 256;
		}
		strcpy(filename,directory[dir_index]);
		if (ch1 == 0x1B)
			break;
		read_file = fopen(filename,"rb");
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
		if (mode == 0)
			continue;
		outregs.r_ax = 0x4F01;
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
		fclose(read_file);
	getch();
	}
}

/*
  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
  บ                                                         บ
  บ           setBank() = Sets video memory bank            บ
  บ                                                         บ
  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

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

/*
  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
  บ                                                         บ
  บ  getModeData() = Gets Super VGA data on a desired mode  บ
  บ                                                         บ
  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

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

/*
  ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
  บ                                                         บ
  บ               setMode() = Sets Video Mode               บ
  บ                                                         บ
  ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
*/

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
