#include <iostream.h>
#include <stdio.h>

struct Person
{
	char 	name[12];
	char	phone[15];
   int	age;
};


void main(void)
{
   FILE *write_file;
   FILE *read_file;
	Person me, them;

   cout	<< "Name : ";
   cin.getline(me.name, 12);
   cout	<<	"Phone : ";
   cin.getline(me.phone, 15);
   cout	<< "Age : ";
   cin	>> me.age;

   write_file = fopen("c:\\bc5\\jons\\phone.dat", "wb");
   fwrite(&me, sizeof(me), 1, write_file);
   fclose(write_file);

   read_file = fopen("c:\\bc5\\jons\\phone.dat", "rb");
   fread(&them, sizeof(them), 1, read_file);
   fclose(read_file);

   cout	<<	them.name << " " << them.phone << " " << them.age;
}

