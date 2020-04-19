/*   module title: setmem.c
 *  function name: void setmem()
 *
 *  author: Kim J. Brand
 *
 *  revision history:
 *     version/--date--/by reason--------------------------------------------
 *       1.0   10/01/84 kb Common C Functions initial release
 *
 *  compiled with: 
 *  compiled by:
 *
 *  linked with: kidedit.c
 *  linked by:
 *
 *  problems:
 *
 *  description: initializes a block of memory pointed to by addr for length
 *		 given by size with val
 */


void setmem(addr,size,val)	/* fill, starting at addr, for size, with val*/
char *addr;
unsigned int size;
char val;
{
	while (size--)		/* fill up sequential bytes of memory   */
	   *addr++ = val;	/*  until size counted down to zero     */

}

