/*  module title: adv.c
 *  function name: char *adv()
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
 *  linked with: int scan()
 *  linked by:
 *
 *  problems:
 *
 *  description: moves a pointer to a string up to the first non-white-space
 *		 character therein
 */


char *adv(string)	/* pointer to a string is incremented to first     */
char *string;		/*  non-white-space character; note: because the   */
{			/*  parameter is a copy, the actual pointer is not */
                        /*  changed                                        */

	while (isspace(*string))
		string++;

	return (string);
}

