/*  module title: macros.c
 *  function names: main() for demo
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: stdio.h macros.h
 *  compiled by:
 *
 *  linked with:
 *  linked by:
 *
 *  problems:
 *
 *  description: a demo program for the macros brought in from the macros.h
 *		 include file
 *
 */

#include <stdio.h>
#include "macros.h"

main()
{

  	printf("\nx=%f", MIN(123.45, 678.90));
    	printf("\nx=%ld", MIN(12345l, 67890));
    	printf("\nx=%ld", MIN(67890, 12345l));
    
    	printf("\nx=%f", MAX(123.45, 678.90));
    	printf("\nx=%ld", MAX(12345l, 67890));
    	printf("\nx=%d", MAX(12345, 6789));
    
    	printf("\nx=%f", ABS(-123.45));
    	printf("\nx=%d", ABS(-12345));
    
    	printf("\nx=%d", INT(123.45));
    	printf("\nx=%f", FRAC(123.45));
    
    	printf("\nx=%f", INCH_CM(2));
    	printf("\nx=%f", CM_INCH(2));
    	printf("\nx=%f", DEG_RAD(15));
    	printf("\nx=%f", RAD_DEG(1.56));
    	printf("\nx=%f", OZ_GRMS(1.75));
    	printf("\nx=%f", GRMS_OZ(28.));
    	printf("\nx=%4.2f", HRS_DHRS(12.15));
    	printf("\nx=%4.2f", DHRS_HRS(12.50));
    	printf("\nx=%f", CRCL_AREA(12.25));
    	printf("\nx=%f", RCTNGL_AREA(3.75, 4.05));
    	printf("\nx=%f\n", TRNGL_AREA(4.14, 2.23));
}
