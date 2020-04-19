program Test

uses
 Crt;

type
 array1 = array[1..80, 1..15] of char;

var
 Entry : array1;
 InOrder : boolean;
 Date : string[8];
 DateNum : longint;
 DatFile : text;
 SwapFile : text;
 EntFound : boolean;
 Head : string[5];

procedure FindEnt1




begin
 InOrder := false;
 assign(DatFile, 'JRNL.DAT');
 assign(SwapFile, 'JRNL.SWP');
	repeat
	 reset(DatFile);

	 EntFound := false;
		repeat
		 Head := '';
			repeat
			 read(DatFile, Head);
			 if Head <> 'JRNL ' then readln(DatFile);
			until ((Head := 'JRNL ') or (Eof(DatFile)):
		 if Head := 'JRNL ' then
			begin
			 readln(DatFile, Date);
			 EntFound := true;
			end;
		until EntFound or Eof(DatFile);


	until InOrder;
