#include <iostream.h>
#include <conio.h>
#include <ctype.h>

struct Phone_Record
{
   Phone_Record *prev;
	char name[25];
   char phone[12];
   Phone_Record *next;
};

void display_screen(void);
void display_record(Phone_Record const * const); // lock both
void create_record(Phone_Record *);

void main(void)
{
	Phone_Record *current = NULL;  // cannot be NULL unless no records
   char choice;

	display_screen();
   do
   {
   	gotoxy(5, 14);
      cin >> choice;
   	choice = toupper(choice);
      switch (choice)
      {
      	case 'A' :  create_record(current);
                   	break;

			case '+' :	if (current->next)
         					current = current->next;
         				display_record(current);
                     break;
         case '-' :	if (current->prev)
         					current = current->prev;
	        				display_record(current);
      }
	}
   while (choice != 'X');
}

void display_screen(void)
{
	gotoxy(1,1);
   cout 	<< "Name : \n"							// line 1
   		<< "Phone : \n"						// line 2
         << "\n"                          // line 3
			<< "\n"                          // line 4
         << "[A]dd New Entry \n"          // line 5
         << "[D]el Current Entry \n"      // line 6
         << "[I]nsert After Current \n"  // line 7
         << "[M]odify Current Entry \n"   // line 8
			<< "[+] Next Entry \n"           // line 9
         << "[-] Prev Entry \n"           // line 10
         << "\n"                          // line 11
         << "[X]it From Program \n"       // line 12
         << "\n"                          // line 13
         << "--> ";                       // line 14
}


void display_record(const Phone_Record const *current)
{
   gotoxy(8, 1);
   cout 	<< "                        "
        	<< "\n            ";
   gotoxy(8,1);
   cout 	<< current->name;
   gotoxy(8, 2);
   cout  << current->phone;
}

void create_record(Phone_Record *current)
{
   Phone_Record *new_rec = new Phone_Record;

	if (!current)				// no records
	{
      new_rec->prev = NULL;
      new_rec->next = NULL;
   }
   else							// one or more records
   {
   	new_rec->prev = current;
      new_rec->next = current->next;
   }
   gotoxy(8, 1);
   cout 	<< "                        "
        	<< "\n            ";
   gotoxy(8, 1);
	cin.ignore(25, '\n');
   cin.getline(new_rec->name, 25);
   gotoxy(9, 2);
   cin.getline(new_rec->phone, 12);
	current = new_rec;
}



