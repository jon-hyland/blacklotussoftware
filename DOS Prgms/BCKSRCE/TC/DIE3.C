#include "graphics.h"
#include "stdio.h"
#include "stdlib.h"
#include "dos.h"
#include "conio.h"

void screenfuck()
{
clrscr();
initgraph(DETECT,VGAHI,"c:\stl\util");
gotoxy(300,280);
setcolor(YELLOW);
outtext("Fuck you and die");
getch();
exit(1);
}

main()
{
screenfuck();
}
