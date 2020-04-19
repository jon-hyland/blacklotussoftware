// This program uses a Strudent class object to record a student ID number
// and five grades.  There are three build in functions, one to enter the
// student ID num, one to add a grade to the array, and one to compute
// and display the average grade.
//
// CS270A-C : Jon, Kevin, Kelly
// Ex. 11_3_5A

#include <iostream.h>
#include <iomanip.h>

class Student
{
	private :
		int 	id_num;
   	float grade[5];
   	int	tot_grade;
   public :
   	Student(void);					// constructor
      void enter_id(void);
      void enter_grade(void);
      void comp_avg(void);
};

Student::Student(void)
{
	id_num = 0;
   for(int i=0; i<5; i++)
   	grade[i] = 0;
   tot_grade = 0;
}

void Student::enter_id(void)
{
	cout	<< "Enter the student id number : ";
   cin	>> id_num;
   cout	<< '\n';
}

void Student::enter_grade(void)
{
	if (tot_grade < 5)
   {
		cout	<< "Enter a new grade for ID#" << id_num << " : ";
      cin	>> grade[tot_grade++];
   }
   else
   	cout	<< "You cannot enter more than 5 grades.";
   cout	<< '\n';
}

void Student::comp_avg(void)
{
	float avg=0;

   for(int i=0; i<5; i++)
   	avg += grade[i];
   avg = avg / tot_grade;

   cout	<< setprecision(2) << setiosflags(ios::fixed)
   		<< "Student ID#" << id_num
         << "   Avg. Grade = " << avg
         << "\n";
}


void main(void)
{
   Student loser;
   int menu_choice;

	do
   {
   	cout	<< "1. Enter Student Id" << '\n'
      		<< "2. Enter a New Grade" << '\n'
            << "3. Compute Average" << '\n'
            << "4. Quit" << '\n'
            << endl
            << "--> ";
      cin	>> menu_choice;
      cout	<< '\n';
      switch (menu_choice)
      {
      	case 1 : loser.enter_id();
         			break;
         case 2 : loser.enter_grade();
         			break;
         case 3 : loser.comp_avg();
      }
   }
   while (menu_choice != 4);
	cout	<< "Goodbye.";
}


