#include "graphics.h"
#include "conio.h"
#include "stdio.h"
#include "math.h"

void title()
{
initgraph(VGA,VGAHI,"c:\bt\bgi");
setbkcolor(BLACK);
clrscr();
setcolor(LIGHTGREEN);
moveto(225,200);
settextstyle(SANS_SERIF_FONT,HORIZ_DIR,3);
outtext("Mathematics Toolkit");
moveto(150,325);
settextstyle(SANS_SERIF_FONT,HORIZ_DIR,4);
setcolor(RED);
outtext("Black Lotus Software Inc.");
getch();
}

main()
{
title();
}