#include <iostream.h>
#include <ctype.h>
#include <string.h>
#include <iomanip.h>

const int totb = 3;

struct
{
	char 	name[80];
	int   rooms;
	float	sqrft;
	char	city[80];
	char	eqcode;
} building[totb];

void 	define_buildings(void);
int	search_records(void);
void	display_building(int);

void main(void)
{
	int found;

	define_buildings();
	found = search_records();
  	if (found >= 0)
		display_building(found);
   else
	  	cout << "\nNot found!!";
}


void define_buildings(void)
{
	for(int i=0; i<totb; i++)
	{
		cout << "Give info for building #" << (i+1);
		cout << "\n Building name : ";
		if (i != 0)
			cin.ignore(80, '\n');
		cin.getline(building[i].name, 80);
		cout << " City location : ";
		cin.getline(building[i].city, 80);
		cout << " Number of rooms : ";
		cin >> building[i].rooms;
		cout << " Square footage : ";
		cin >> building[i].sqrft;
		do
		{
			cout << " Earthquake code (a-f) : ";
			cin >> building[i].eqcode;
			building[i].eqcode = tolower(building[i].eqcode);
		}
		while ((building[i].eqcode < 'a') || (building[i].eqcode > 'f'));
		cout << "\n";
	}
}


int search_records(void)
// Function will prompt user for what to search by,
//	the search parameter, and searches the records for
// a match. Returns array index of first match found,
// or -1 if none found.
{
	char	search_item;
   char	search_string[80];
   int	search_int;
   float	search_float;
   char	search_char;
   int	i;

   do
   {
		cout << "\nSearch database for :"
		  	  << "\n [A] Name of building"
        	  << "\n [B] City location"
        	  << "\n [C] Number of rooms"
        	  << "\n [D] Square footage"
        	  << "\n [E] Earthquake code"
           << "\n\n>";
      cin >> search_item;
      search_item = toupper(search_item);
   }
   while ((search_item < 'A') || (search_item > 'E'));
	switch (search_item)
   {
   	case 'A' : 	cout << "\nSearch for what building name? : ";
      				cin.ignore(80, '\n');
                  cin.getline(search_string, 80);
                  for(i=0; i<totb; i++)
                  	if (!strcmp(building[i].name, search_string))
                     	return(i);
                  return(-1);

   	case 'B' : 	cout << "\nSearch for what city location? : ";
      				cin.ignore(80, '\n');
                  cin.getline(search_string, 80);
                  for(i=0; i<totb; i++)
                  	if (!strcmp(building[i].city, search_string))
                     	return(i);
                  return(-1);

      case 'C' :	cout << "\nSearch for how many rooms? : ";
      				cin >> search_int;
                  for(i=0; i<totb; i++)
                  	if (building[i].rooms == search_int)
                     	return(i);
                  return(-1);

      case 'D' :	cout << "\nSearch for what square footage? : ";
      				cin >> search_float;
                  for (i=0; i<totb; i++)
                  	if (building[i].sqrft == search_float)
                     	return(i);
                  return(-1);

      case 'E' :	do
						{
							cout << "\nSearch for what eq code? (a-f) : ";
							cin >> search_char;
							search_char = tolower(search_char);
						}
						while ((search_char < 'a') || (search_char > 'f'));
                  for (i=0; i<totb; i++)
                  	if (building[i].eqcode == search_char)
                     	return(i);
                  return(-1);
   }
}


void display_building(int index)
{
	cout	<<	"\nBuilding ID #" << (index+1)
   		<<	"\n--------------"
   		<<	"\nName... : " << building[index].name
         <<	"\nCity... : " << building[index].city
         << "\nRooms.. : " << building[index].rooms
         << setprecision(2) << setiosflags(ios::fixed)
         << "\nSqr Ft  : " << building[index].sqrft
         << "\nEq Code : " << building[index].eqcode;
}








