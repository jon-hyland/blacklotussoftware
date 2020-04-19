#include "dos.h"

main()
{
sound(1209 & 697);
getch();

nosound();
exit(1);
}