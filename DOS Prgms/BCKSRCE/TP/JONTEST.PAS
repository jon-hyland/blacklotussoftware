program SetWallpaper;

uses
 Crt, Std, Dos;

type
 UserRecord = record
   Name : string[12];
   Pass : string[12];
   ID   : integer;
  end;

var
 UFile : file of UserRecord;
 User  : UserRecord;
