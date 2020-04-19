/* This program is explained on pages 29-31 */

#include <stdio.h>

main()
{
	char *s;

	if (argc > 1)
		s = argv[1];
	else
		s = "the universe";

	printf("%s %s.\n",getstring(),s);

}