{$R-}    {Range checking off}
{$B-}    {Boolean complete evaluation off}
{$S-}    {Stack checking off}
{$I-}    {I/O checking off}
{$N-}    {No numeric coprocessor}
{$V-}    {Var-String Checking off}

{
==============================================================
Random number generator

Released to public domain by Marc Perkel * No Right Reserved
417-866-1222

This program generates 31 bit random numbers and does a darn good
job of it. Included here is a program that tests the randomness of
the numbers it generates.

A computer can't actually generate random numbers. The idea is to
generate numbers with an even distribution starting with a seed. To
help in the process, you want to take advantage of every random
event you can.

The formula came out of a book which suggested a bit shift method of
generating numbers. It said that for a 31 bit shift that 8 values
were tested that worked very good. I use all 8 of them.

I not only start with the dos timer but access it regularly to help
increase the randomness. System variations like file access,
processor speed variations ect make the timer not syncronous with
the program.

The SHUFFLE routine should be called in the keyboard idle loop. This
takes advantage of pressing keys as random events.

==============================================================
}


Program Rand;

Const
  RandBit : Array[0..7] of LongInt
            = ($40,$80,$100,$4000,$80000,$2000000,$4000000,$20000000);

Var
  LastRandom  : LongInt;
  RandMask    : LongInt;
  DosTimer    : LongInt absolute 0:$46C;


Procedure Randomize;
begin
   if ((LastRandom and 1) <> 0) xor ((LastRandom and RandMask) <> 0)
      then LastRandom := LastRandom + $80000000;
   LastRandom := LastRandom + DosTimer;
   LastRandom := LastRandom shr 1;
end;


Procedure Shuffle;
var X : Byte;
begin
   X := LastRandom and 7;
   RandMask := RandBit[X];
   for X := 1 to ((DosTimer + X) and $1F) + 23 do Randomize;
end;


Function Random : LongInt;
begin
   Shuffle;
   Random := LastRandom;
end;


Procedure TestRandom;
Var
   Counter : Array [0..255] of LongInt;
   X       : LongInt;
   SumSq   : LongInt;

Const
   Loops   : LongInt = 8192;

{ Uses sum of squares method }

begin
   Writeln;
   Write('Computing ',Loops,' Random Numbers ... ');
   SumSq := 0;
   for X := 0 to 255 do Counter[X] := 0;
   for X := 1 to Loops do inc(Counter[Random and $FF]);
   for X := 0 to 255 do SumSq := SumSq + (Counter[X] * Counter[X]);
   Writeln;
   Writeln;
   X := Loops div 256;
   Writeln('Random Factor: ',(X * X * 256 * 100 div SumSq));
   Writeln;
   Writeln('Good random factors are from 90 - 99.');
   Writeln;
end;


begin
   TestRandom;
end.
