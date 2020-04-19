#include <iostream.h>
#include <ctype.h>
#include <conio.h>	// used for getch() and kbhit()

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


void main(void)
{
	define_buildings();

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
// a match.  If found, function returns the number of
// the record in the array, else zero.
{
	cout << "";
}

