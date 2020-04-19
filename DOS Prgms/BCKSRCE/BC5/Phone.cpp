// This program dynamically creates a linked list durring
// execution for the purpose of keeping phone records.  All
// records must be entered manually by user.  Current record
// and user menu is displayed on screen at all times.
// Menu options include : Insert new record, delete current,
// modify current, reset all, switch to next, switch to previous.
//
// For the purpose of an overall better program, this homework
// a bit goes beyond the required elements in the book.
//
//	CS270A-C : Jon, Kelly, Kevin
//	Ex. 10.5.6a

#include <iostream.h>
#include <conio.h>
#include <ctype.h>

struct Phone_Record				// prototype of a phone record
{
   Phone_Record *prev;
	char name[25];
   char phone[12];
   Phone_Record *next;
};

void display_screen(void);
void display_record(Phone_Record const * const); 	// lock both
void create_record(Phone_Record *&);					// return pointer
void delete_record(Phone_Record *&);
void modify_record(Phone_Record *);						// dont return pointer


void main(void)					// begin program execution
{
	Phone_Record *current = NULL;  	// current record, NULL = no records
   char choice;							// user menu choice (in CAPS)

	display_screen();
   do
   {
	   display_record(current);		// update current record to screen
		gotoxy(5, 14);						// erase old menu choice
      cout << "  ";
      gotoxy(5, 14);
      choice = getch();					// get new menu choice (no CR)
   	choice = toupper(choice);		// convert to uppercase
 		cout << choice;					// output new menu choice
      switch (choice)
      {
      	case 'I' :  create_record(current);		// insert new record
         				break;
			case 'D'	:  delete_record(current);		// delete current record
         				break;
         case 'M'	: 	modify_record(current);		// modify current record
         				break;
			case 'R' :	current = NULL;				// reset record database
         				break;
			case '+' :	if (current->next)			// next record
         					current = current->next;
                     break;
         case '-' :	if (current->prev)			// previous record
         					current = current->prev;
      }
	}
   while (choice != 'X');		// repeat while choice isnt 'X'
   clrscr();						// happy ending message
   cout << "Thank you for using Phone Master 2000.";
}


void display_screen(void)
// This function draws the areas of the screen that will be
// constant throughout execution.
{
	gotoxy(1,1);
   cout 	<< "Name : \n"							// line 1
   		<< "Phone : \n"						// line 2
         << "\n"                          // line 3
			<< "\n"                          // line 4
         << "[I]nsert New Entry \n"       // line 5
         << "[D]el Current Entry \n"      // line 6
         << "[M]odify Current Entry \n"   // line 7
			<< "[R]eset Phone Index \n"		// line 8
			<< "[+] Next Entry \n"           // line 9
         << "[-] Prev Entry \n"           // line 10
         << "\n"                          // line 11
         << "[X]it From Program \n"       // line 12
         << "\n"                          // line 13
         << "--> ";                       // line 14
}


void display_record(const Phone_Record const *current)
// This function updates the record area of the screen
// by outputing the current record.
{
   gotoxy(8, 1);							// erase old areas
   cout 	<< "                        ";
   gotoxy(9, 2);
   cout 	<< "            ";
   if (current)							// if current record exists
   {
   	gotoxy(8,1);						// show new data
   	cout 	<< current->name;
   	gotoxy(9, 2);
   	cout  << current->phone;
   }
   else                            // if no record
   {
   	gotoxy(8,1);					  // show no data info
   	cout 	<< "NO ENTRIES";
   	gotoxy(9, 2);
   	cout  << "NO ENTRIES";
   }
}

void create_record(Phone_Record *&current)
// This function will get a new record from user and insert
// it into the linked list after the current record and before
// the next.  Current record is set to new record.
{
   Phone_Record *new_rec = new Phone_Record;

	if (!current)						// no records
	{
      new_rec->prev = NULL;      	// new record is unconnected
      new_rec->next = NULL;
   }
   else									// one or more records
   {
   	new_rec->prev = current;      // connect new record to either side
      new_rec->next = current->next;
		if (current->next)			// if record after current
      {
      	current->next = new_rec;	// connect either side to new record
         new_rec->next->prev = new_rec;
      }
      else								// if no record after current
      	current->next = new_rec;	// connect current record to new previous
   }
   gotoxy(8, 1);			// erase old data from screen
   cout 	<< "                        ";
	gotoxy(9, 2);
   cout 	<< "            ";
   gotoxy(8, 1);			// get new data into new record
	cin.getline(new_rec->name, 25);
   gotoxy(9, 2);
   cin.getline(new_rec->phone, 12);
	current = new_rec;	// set current to next record
}


void delete_record(Phone_Record *&current)
// This function will remove the current record from the linked
// list.  Current will be moved to the appropriate record after,
// or current becomes NULL.
{
   if ((!current->prev) && (!current->next))	// if only record
   	current = NULL;
   else							// if not only record
   {
		if (current->prev)		// if record before it
   		current->prev->next = current->next; // connect previous to next
   	if (current->next)		// if record after it
      	current->next->prev = current->prev; // connect next to previous
      if (!current->next)           // if no record after deleted,
      	current = current->prev;   // current set to previous
      else                          // if record after deleted,
      	current = current->next;	// current set to next
   }
}


void modify_record(Phone_Record *current)
// This function will re-input the data for the current
// record from the user. No other changes are made.
{
   if (current != NULL)  	// if current record exists
   {
   	gotoxy(8, 1);			// erase old data from screen
   	cout 	<< "                        ";
		gotoxy(9, 2);
   	cout 	<< "            ";
   	gotoxy(8, 1);			// get new data from user
		cin.getline(current->name, 25);
   	gotoxy(9, 2);
   	cin.getline(current->phone, 12);
   }
}

