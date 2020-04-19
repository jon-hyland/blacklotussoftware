/* Program:  FDV Tiny BMP Viewer  
   Purpose:  Loads and shows a BMP file ( 320x200x256 ) 
   Return:   0 = failure, 1 = OK
   Compiler: Watcom C/C++ 11.0 (32bit Protected Mode - DOS4GW) 
   Author: Fabio Dalla Vecchia - 1995 (c) 
   The Smallest BMP viewer in Watcom C/C++
   OBS.: The BMP file must be a 320x200x256 image!

   To compile using Watcom C/C++ 11.0 just type:
   WCL386 TUT06

   email: fvecchia@hotmail.com
   GEC HomePage: http://www.geocities.com/SiliconValley/Bay/2966/index.htm
*/

#include <stdio.h>
#include <dos.h>
#include <mem.h>
#include <conio.h>


unsigned char *buf_tela=(unsigned char *)0x0a0000;

void fdv_modo_video(int modo)
{
   union REGS regs;
   regs.w.ax = modo;
   int386(0x10,&regs,&regs);
}


short main( void)
{
   FILE *arq_bmp;
   unsigned char pal_aux[1024], pal_ok[768];
   unsigned char *imagem, *buf_pal;
   int inic_imagem=0, i=256;

   if ((arq_bmp = fopen("tel.bmp", "rb"))==NULL) {
     printf("\nArquivo nao encontrado - File not Found\n");
     getch();
     return 0;
   }

   // le paleta e rotaciona para BIOS  (read PAL)
   fseek(arq_bmp,54,0);  // pula header inutil
   fread(pal_aux,1,1024,arq_bmp); // le paleta de 1024 bytes   
   for (short a=0; a<256; a++)
     for (short b=0; b<3; b++)
        pal_ok[a*3+b] = (pal_aux[a*4+(2-b)]) >> 2;

   // le posicao do inicio da imagem  (read image init position)
   fseek(arq_bmp,10,0);
   fread(&inic_imagem, 1, sizeof(inic_imagem), arq_bmp);

   // posiciona no inicio do BMP e le imagem de 64Kb  (read BMP)
   fseek(arq_bmp,inic_imagem,0);
   imagem = new unsigned char [64000L];
   for (int y = 199; y>=0; y--)
     for (int x=0; x<320; x++)
       imagem[y*320+x] = (unsigned char) fgetc(arq_bmp);
    
   // inicializa video e mostra paleta   (init video and shows PAL)
   fdv_modo_video(0x13);
   outp(0x03c8, 0);
   buf_pal = pal_ok;
   i=256;
   while (i--) {
	outp(0x03c9, *buf_pal++);
	outp(0x03c9, *buf_pal++);
	outp(0x03c9, *buf_pal++);
   }
 
   // mostra imagem   (shows BMP)
   memcpy(buf_tela, imagem, 64000L);

   // aguarda tecla   (wait key)
   getch();

   // Libera memoria e fecha BMP  (free image and memory)
   delete imagem;       
   fclose(arq_bmp);

   fdv_modo_video(0x03);

   return 1;
}   


