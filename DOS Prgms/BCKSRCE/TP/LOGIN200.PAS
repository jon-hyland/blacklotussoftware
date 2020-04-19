program Login2000;

uses
 Crt, Std, Dos;

const
 VerNum = 'v1.0';

type
 UserRecord = record
   ID   : integer;
   Name : string[16];
   Pass : string[16];
   Sec  : integer;
  end;

var
 UFile  : file of UserRecord;
 User   : UserRecord;
 Num    : integer;
 Tot    : integer;

procedure Init;
 begin
  randomize;
  if paramstr(1) <> '' then
   assign(UFile, 'LOGIN.DAT')
  else
   begin

    assign(UFile, paramstr(1) + 'LOGIN
